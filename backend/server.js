const express = require('express');
const cors = require('cors');
require('dotenv').config();

const path = require('path');

const app = express();

// Middleware
// Update CORS to allow requests from the frontend client URL
const corsOptions = {
  origin: process.env.CLIENT_URL || 'http://localhost:3000',
  credentials: true,
};
app.use(cors(corsOptions));
app.use(express.json()); // Parse JSON bodies

// Basic Route for testing
app.get('/api/health', (req, res) => {
  res.json({ status: 'success', message: 'HealthSphere API is running' });
});

// Import API routes
const routes = require('./src/routes');
app.use('/api', routes);

// Serve static files in production
if (process.env.NODE_ENV === 'production') {
  // Set static folder
  app.use(express.static(path.join(__dirname, '../healthsphere/build')));

  app.get('/*', (req, res) => {
    res.sendFile(path.resolve(__dirname, '..', 'healthsphere', 'build', 'index.html'));
  });
}

const PORT = process.env.PORT || 5000;


app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
