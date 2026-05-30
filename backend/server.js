const express = require('express');
const cors = require('cors');
require('dotenv').config();

const path = require('path');

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // Parse JSON bodies

app.get('/', (req, res) => {
  res.send('Here is the staging Branch: stagging In Progresss......')
});


// Basic Route for testing
app.get('/api/health', (req, res) => {
  res.json({ status: 'success', message: 'HealthSphere API is running' });
});

app.get('/api/check', (req, res) => {
  res.json({ status: 'success', message: 'HealthSphere API is running on port 5000' });
});


// Import API routes
const routes = require('./src/routes');
app.use('/api', routes);

const PORT = process.env.PORT || 5000;


app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
