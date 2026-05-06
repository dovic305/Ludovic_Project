const express = require('express');
const router = express.Router();
const patientController = require('../controllers/patientController');

// GET /api/patients/:id/records - Get all records for a patient
router.get('/:id/records', patientController.getPatientRecords);

// POST /api/patients/:id/prescriptions - Add a prescription
router.post('/:id/prescriptions', patientController.addPrescription);

// POST /api/patients/:id/notes - Add a note
router.post('/:id/notes', patientController.addNote);

module.exports = router;
