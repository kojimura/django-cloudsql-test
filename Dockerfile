FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN apt-get update && apt-get install -y gcc libpq-dev && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "sqltest.wsgi:application", "--chdir", "sqltest", "--bind", "0.0.0.0:8080"]
