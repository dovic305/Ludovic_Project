const express = require('express');
const router = express.Router();
const patientRoutes = require('./patientRoutes');
const authRoutes = require('./authRoutes');
const doctorRoutes = require('./doctorRoutes');
const adminRoutes = require('./adminRoutes');
const appointmentRoutes = require('./appointmentRoutes');

// Mount routes
router.use('/patients', patientRoutes);
router.use('/auth', authRoutes);
router.use('/doctors', doctorRoutes);
router.use('/admin', adminRoutes);
router.use('/appointments', appointmentRoutes);

module.exports = router;
