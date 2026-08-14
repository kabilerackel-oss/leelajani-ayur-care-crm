# Leelajani Ayur Care CRM — Production Edition

## Stack
- Node.js + Express API
- PostgreSQL 16
- JWT authentication + bcrypt password hashing
- Helmet, CORS and login rate limiting
- Role-based API authorization
- Appointment conflict engine with room/therapist/leave checks
- Audit logging
- CSV exports and reporting endpoints
- Responsive web UI served by the Node server

## Quick start
1. Install Node.js 20+ and Docker Desktop.
2. Copy `.env.example` to `.env` and set a strong `JWT_SECRET`.
3. Run `docker compose up -d` to start PostgreSQL.
4. Run `npm install`.
5. Run `npm start`.
6. Open http://localhost:3000

## Demo accounts
- admin / admin123
- doctor / doctor123
- frontoffice / front123

Change all passwords before production use.

## Production deployment
Use a managed PostgreSQL instance, HTTPS reverse proxy, a long random JWT secret, restricted CORS, automated encrypted backups, monitoring, and a private network for the database. The app is structured so PostgreSQL can be hosted on AWS RDS, Azure Database for PostgreSQL, Google Cloud SQL, Supabase, Neon, or another PostgreSQL provider.
