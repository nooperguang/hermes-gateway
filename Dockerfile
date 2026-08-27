FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone Hermes from GitHub
RUN git clone https://github.com/NousResearch/hermes-agent.git

WORKDIR /app/hermes-agent
RUN pip install --no-cache-dir -e .

# Run gateway with WEBHOOK_PORT set to Render's PORT env var
CMD ["sh", "-c", "WEBHOOK_PORT=${PORT:-10000} hermes gateway run"]
