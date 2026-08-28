FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/NousResearch/hermes-agent.git

WORKDIR /app/hermes-agent
RUN pip install --no-cache-dir -e .

COPY config.yaml /app/config.yaml

# ✅ เพิ่มบรรทัดนี้:
ENV HERMES_CONFIG=/app/config.yaml

CMD ["sh", "-c", "WEBHOOK_PORT=${PORT:-10000} hermes gateway run"]
