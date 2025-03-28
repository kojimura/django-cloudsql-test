# Django + Cloud SQL on Cloud Run

This is a test project for deploying a Django app on Cloud Run and connecting it to Cloud SQL (PostgreSQL).

## 🔧 Setup Steps

### 1. Project Structure

project/ ├── sqltest/ # Django project root │ ├── manage.py │ └── sqltest/ # Django main module │ ├── settings.py │ └── ... ├── requirements.txt ├── Dockerfile └── README.md

### 2. Environment Variables (set in Cloud Run)

- `DB_NAME`: PostgreSQL database name
- `DB_USER`: Database username
- `DB_PASS`: Database password
- `INSTANCE_CONNECTION_NAME`: Format: `project:region:instance`
- `ALLOWED_HOSTS`: Django allowed hosts (use `*` during development)

### 3. Cloud Build & Deploy to Cloud Run

```bash
gcloud builds submit --tag gcr.io/PROJECT-ID/django-sqltest

gcloud run deploy django-sqltest \
  --image gcr.io/PROJECT-ID/django-sqltest \
  --add-cloudsql-instances=PROJECT-ID:REGION:INSTANCE-NAME \
  --update-env-vars INSTANCE_CONNECTION_NAME="...",DB_USER="...",DB_PASS="...",DB_NAME="...",ALLOWED_HOSTS="*" \
  --platform managed \
  --region REGION \
  --allow-unauthenticated

