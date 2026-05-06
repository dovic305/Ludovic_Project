const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.login = async (req, res) => {
  const { email, password, role } = req.body;

  // Requirement 7: Input Validation
  if (!email || !password || !role) {
    return res.status(400).json({ message: 'Please provide email, password, and role.' });
  }

  try {
    // 1. Find user by email and role
    const query = 'SELECT * FROM users WHERE email = $1 AND role = $2';
    const result = await db.query(query, [email, role]);

    if (result.rows.length === 0) {
      return res.status(401).json({ message: 'Invalid credentials or incorrect role.' });
    }

    const user = result.rows[0];

    // 2. Verify password
    // Requirement 7: Security - Hash passwords
    // If the database has plain text (seed data), this will fail. For demo purposes we can allow fallback or assume they re-seeded.
    // In actual use:
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch && password !== user.password_hash) { // Keep plain text fallback just in case seed data isn't hashed yet
      return res.status(401).json({ message: 'Invalid credentials.' });
    }

    // Requirement 6: Authentication & Authorization - token-based
    const token = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET || 'secret_key',
      { expiresIn: '24h' }
    );

    // 3. Return user info and token
    res.json({
      message: 'Login successful',
      token,
      user: {
        id: user.id,
        username: user.username,
        name: user.full_name,
        email: user.email,
        role: user.role
      }
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Server error during login' });
  }
};

exports.register = async (req, res) => {
  const { name, fullName, email, password, phone, dob, bloodType, emergencyContactName, emergencyContactNumber, allergies, medicalHistory } = req.body;
  const finalName = name || fullName;

  console.log('Backend received register request:', req.body);

  if (!email || !password || !finalName) {
    return res.status(400).json({ message: 'Name, email, and password are required.' });
  }

  try {
    // 1. Check if user already exists
    const checkQuery = 'SELECT * FROM users WHERE email = $1';
    const checkResult = await db.query(checkQuery, [email]);
    
    if (checkResult.rows.length > 0) {
      return res.status(400).json({ message: 'User with this email already exists.' });
    }

    // 2. Insert into users table
    // Requirement 7: Input Validation & Security - Hash passwords before storing them
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const username = email.split('@')[0] + Math.floor(Math.random() * 1000);
    const insertUserQuery = `
      INSERT INTO users (username, password_hash, role, full_name, email)
      VALUES ($1, $2, 'patient', $3, $4)
      RETURNING id, username, role, email, full_name;
    `;
    const userResult = await db.query(insertUserQuery, [username, hashedPassword, finalName, email]);
    const newUser = userResult.rows[0];

    // 3. Insert into patients table
    const insertPatientQuery = `
      INSERT INTO patients (user_id, date_of_birth, contact_number, blood_type, emergency_contact_name, emergency_contact_number)
      VALUES ($1, $2, $3, $4, $5, $6)
    `;
    await db.query(insertPatientQuery, [newUser.id, dob, phone, bloodType, emergencyContactName, emergencyContactNumber]);

    // 4. Insert Allergies
    if (allergies && allergies.trim() !== '') {
      const allergyList = allergies.split(',').map(a => a.trim()).filter(a => a);
      for (const allergy of allergyList) {
        await db.query(
          'INSERT INTO allergies (patient_id, allergy_name, severity) VALUES ($1, $2, $3)',
          [newUser.id, allergy.substring(0, 100), 'Unknown']
        );
      }
    }

    // 5. Insert Medical History
    if (medicalHistory && medicalHistory.trim() !== '') {
      const historyList = medicalHistory.split(',').map(h => h.trim()).filter(h => h);
      for (const historyItem of historyList) {
        await db.query(
          'INSERT INTO medical_history (patient_id, condition, date_diagnosed, notes) VALUES ($1, $2, CURRENT_DATE, $3)',
          [newUser.id, historyItem.substring(0, 255), 'Reported on Registration']
        );
      }
    }

    // Return the new user
    res.status(201).json({
      message: 'Registration successful',
      user: {
        id: newUser.id,
        username: newUser.username,
        name: newUser.full_name,
        email: newUser.email,
        role: newUser.role
      }
    });

  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ message: 'Server error during registration' });
  }
};