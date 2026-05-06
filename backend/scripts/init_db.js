const db = require('../src/config/db');

const createTables = async () => {
  const queryText = `
    -- Drop tables if you want a fresh start
    DROP TABLE IF EXISTS appointments, doctor_notes, prescriptions, allergies, medical_history, patients, users CASCADE;

    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      username VARCHAR(50) UNIQUE NOT NULL,
      password_hash VARCHAR(255) NOT NULL,
      role VARCHAR(20) NOT NULL CHECK (role IN ('patient', 'doctor', 'admin')),
      full_name VARCHAR(100) NOT NULL,
      email VARCHAR(100) UNIQUE NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS patients (
      user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
      date_of_birth DATE,
      contact_number VARCHAR(20),
      blood_type VARCHAR(5),
      emergency_contact_name VARCHAR(100),
      emergency_contact_number VARCHAR(20)
    );

    CREATE TABLE IF NOT EXISTS medical_history (
      id SERIAL PRIMARY KEY,
      patient_id INTEGER REFERENCES patients(user_id) ON DELETE CASCADE,
      condition VARCHAR(255) NOT NULL,
      date_diagnosed DATE,
      notes TEXT
    );

    CREATE TABLE IF NOT EXISTS allergies (
      id SERIAL PRIMARY KEY,
      patient_id INTEGER REFERENCES patients(user_id) ON DELETE CASCADE,
      allergy_name VARCHAR(100) NOT NULL,
      severity VARCHAR(50)
    );

    CREATE TABLE IF NOT EXISTS prescriptions (
      id SERIAL PRIMARY KEY,
      patient_id INTEGER REFERENCES patients(user_id) ON DELETE CASCADE,
      doctor_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
      medication VARCHAR(100) NOT NULL,
      dosage VARCHAR(50) NOT NULL,
      frequency VARCHAR(50) NOT NULL,
      start_date DATE,
      end_date DATE
    );

    CREATE TABLE IF NOT EXISTS doctor_notes (
      id SERIAL PRIMARY KEY,
      patient_id INTEGER REFERENCES patients(user_id) ON DELETE CASCADE,
      doctor_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
      note_text TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS appointments (
      id SERIAL PRIMARY KEY,
      patient_id INTEGER REFERENCES patients(user_id) ON DELETE CASCADE,
      doctor_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
      appointment_date TIMESTAMP NOT NULL,
      status VARCHAR(20) DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'completed', 'cancelled', 'no_show'))
    );
  `;

  try {
    console.log('Connecting to database and creating tables...');
    await db.query(queryText);
    console.log('Tables created successfully!');
  } catch (err) {
    console.error('Error creating tables. Check your database connection details in .env');
    console.error(err.stack);
  } finally {
    process.exit(0);
  }
};

createTables();
