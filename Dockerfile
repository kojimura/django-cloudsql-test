FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

# psycopg2用のPostgreSQL開発ライブラリをインストール
RUN apt-get update && apt-get install -y gcc libpq-dev && \
    pip install --no-cache-dir -r requirements.txt

# プロジェクト全体をコピー
COPY . .

# Djangoのモジュールが sqltest/sqltest にあるので --chdir オプションで移動
CMD ["gunicorn", "sqltest.wsgi:application", "--chdir", "sqltest", "--bind", "0.0.0.0:8080"]
