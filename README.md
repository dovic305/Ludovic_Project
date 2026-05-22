# HealthSphere 🏥

A comprehensive healthcare management system featuring patient records, appointment scheduling, and administrative controls.

## 🚀 Deployment Guide

### Prerequisites
- Node.js (v18+)
- PostgreSQL Database

### 1. Environment Setup

#### Backend (`/backend`)
Create a `.env` file in the `backend` directory based on `.env.example`:
```env
PORT=5000
NODE_ENV=production
JWT_SECRET=your_secret_here
CLIENT_URL=https://your-app-domain.com
DATABASE_URL=postgres://user:password@host:port/database
```

#### Frontend (`/healthsphere`)
Create a `.env` file in the `healthsphere` directory:
```env
REACT_APP_API_URL=/api
```
*(Note: If the backend serves the frontend, using `/api` allows relative pathing which is more robust)*

### 2. Database Initialization
Run the following from the root directory:
```bash
npm run db:init
npm run db:seed
```

### 🌐 Render Deployment (Recommended)

1. **Connect your GitHub Repository**: Once connected, Render should automatically detect the `render.yaml` file.
2. **Apply Blueprint**: Render will prompt you to create the web service and the PostgreSQL database.
3. **Build Configuration**:
   - **Build Command**: `npm run build`
   - **Start Command**: `npm start`
4. **Environment Variables**: Render will fetch most from the `render.yaml`. Ensure `CLIENT_URL` is updated to your Render app URL (e.g., `https://healthsphere.onrender.com`).

### 3. Production Build & Start (Manual)
1. **Build Everything**:
   ```bash
   npm run build
   ```
2. **Start the Backend Server**:
   ```bash
   npm start
   ```

The backend is configured to serve the built frontend assets from `healthsphere/build` when `NODE_ENV=production`.


## 🛠️ Development
To run both frontend and backend in development mode:
```bash
npm install -g concurrently
npm run install:all
npm run dev
```

## 📂 Project Structure
- `/healthsphere`: React frontend application.
- `/backend`: Node.js/Express API with PostgreSQL.
