/**
 * API Configuration
 * Centralizes the backend URL for easy switching between development and production.
 *
 * In production (Render), set the REACT_APP_API_URL environment variable
 * in the Render dashboard (frontend static site → Environment tab) to your
 * backend service URL, e.g. https://healthsphere-app-1.onrender.com
 *
 * In development, falls back to http://localhost:5000
 */
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000';

export default API_URL;
