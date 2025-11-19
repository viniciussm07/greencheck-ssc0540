# Dockerfile para ambiente de desenvolvimento
FROM python:3.11-slim

# Definir diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema necessárias para psycopg2
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copiar arquivo de dependências
COPY requirements.txt .

# Instalar dependências Python
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt

# Copiar código da aplicação
COPY . .

# Expor porta da aplicação
EXPOSE 5000

# Comando para iniciar a aplicação em modo desenvolvimento
CMD ["python", "app.py"]
