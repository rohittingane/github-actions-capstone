FROM python:3.12-slim
WORKDIR /app

# Day 49 (DevSecOps): Update all system packages to pull in the latest
# security patches for the base OS (fixes many CVEs found by Trivy,
# e.g. in openssl, util-linux, perl, etc.)
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]


