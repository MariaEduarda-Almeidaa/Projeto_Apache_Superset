# Versão fixada para a demo não quebrar se a imagem "latest" mudar.
FROM apache/superset:5.0.0

USER root

# Superset >= 4.1 roda dentro de um virtualenv em /app/.venv (usa uv).
# Instalamos o driver do PostgreSQL nesse venv; se uv não existir, cai para pip.
RUN . /app/.venv/bin/activate && \
    (uv pip install --no-cache psycopg2-binary || pip install --no-cache-dir psycopg2-binary)

# Configuração do Superset (chave secreta e banco de metadados)
COPY superset_config.py /app/superset_config.py
ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

USER superset
