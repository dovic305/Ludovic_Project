const express = require('express');
const cors = require('cors');
require('dotenv').config();
const path = require('path');

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // Parse JSON bodies

// API Status routes
app.get('/api/health', (req, res) => {
  res.json({ status: 'success', message: 'HealthSphere API is running' });
});

// Import API routes
const routes = require('./src/routes');
app.use('/api', routes);

// Serve static assets in production
if (process.env.NODE_ENV === 'production') {
  // Set static folder
  app.use(express.static(path.join(__dirname, '../healthsphere/build')));

  app.get('*', (req, res) => {
    res.sendFile(path.resolve(__dirname, '../healthsphere', 'build', 'index.html'));
  });
} else {
  app.get('/', (req, res) => {
    res.send('HealthSphere API is running (Development Mode)');
  });
}

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
