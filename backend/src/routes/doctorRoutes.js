const express = require('express');
const router = express.Router();
const doctorController = require('../controllers/doctorController');

// GET /api/doctors/:id/appointments
router.get('/:id/appointments', doctorController.getAppointments);

// GET /api/doctors/:id/patients
router.get('/:id/patients', doctorController.getPatients);

module.exports = router;
