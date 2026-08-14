# Leelajani Ayur Care CRM — Render deployment

## Fastest deployment

1. Create a GitHub repository named `leelajani-ayur-care-crm`.
2. Upload the contents of this folder to the repository root.
3. In Render, choose **New → Blueprint** and connect the GitHub repository.
4. Render will read `render.yaml` and create:
   - `leelajani-ayur-care` web service
   - `leelajani-crm-db` PostgreSQL database
5. Approve the deployment.
6. Your public address will be:
   `https://leelajani-ayur-care.onrender.com`

## Important

The Render Free web service is suitable for testing/demo use and may spin down when idle.
The Render Free PostgreSQL database is temporary: it expires after 30 days and has no backups. Do not enter real patient records until a persistent paid database is configured.

## First login

- admin / admin123
- doctor / doctor123
- frontoffice / front123

Change these passwords before any real use.
