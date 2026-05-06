const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// POST /api/auth/login - Verify credentials
router.post('/login', authController.login);

// POST /api/auth/register - Register new patient
router.post('/register', authController.register);

module.exports = router;
