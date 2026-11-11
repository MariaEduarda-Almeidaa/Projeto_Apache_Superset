import os

# Chave e banco de metadados vêm do docker-compose.yml (uso local/demonstração).
SECRET_KEY = os.environ["SUPERSET_SECRET_KEY"]
SQLALCHEMY_DATABASE_URI = os.environ["SQLALCHEMY_DATABASE_URI"]
