FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY . .

# Install Python dependencies (Hermes is in hermes-agent/)
WORKDIR /app/hermes-agent
RUN pip install --no-cache-dir -e .

EXPOSE 8000

# Start Hermes gateway
CMD ["sh", "-c", "cd /app/hermes-agent && hermes gateway --port ${PORT:-8000}"]
