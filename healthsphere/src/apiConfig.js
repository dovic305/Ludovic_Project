/**
 * API Configuration
 * Centralizes the backend URL for easy switching between development and production.
 */

// In development, we use localhost:5000. 
// In production (Render), we use relative paths if the backend serves the frontend, 
// or the actual production URL.
const API_URL = process.env.NODE_ENV === 'production' 
  ? '' // Relative path for production
  : 'http://localhost:5000';

export default API_URL;
