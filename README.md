# greencheck-ssc0540

Repositório do projeto GreenCheck para a disciplina SSC0540

## Descrição

Sistema de monitoramento de projetos sustentáveis desenvolvido com Flask e PostgreSQL.

## Estrutura do Projeto

```
greencheck-ssc0540/
├── app.py                      # Aplicação Flask
├── requirements.txt            # Dependências Python
├── schema.sql                  # Schema do banco de dados
├── dados.sql                   # Dados de exemplo
├── Dockerfile                  # Dockerfile para desenvolvimento
├── Dockerfile.prod             # Dockerfile para produção
├── docker-compose.yml          # Configuração Docker para desenvolvimento
├── docker-compose.prod.yml     # Configuração Docker para produção
└── README.md                   # Este arquivo
```

## Pré-requisitos

- Docker (versão 20.10 ou superior)
- Docker Compose (versão 2.0 ou superior)

## Ambiente de Desenvolvimento

### Como rodar

1. Clone o repositório:
```bash
git clone https://github.com/viniciussm07/greencheck-ssc0540.git
cd greencheck-ssc0540
```

2. Inicie os containers:
```bash
docker-compose up -d
```

3. Verifique se os containers estão rodando:
```bash
docker-compose ps
```

4. Acesse a aplicação:
- API: http://localhost:5000
- Health check: http://localhost:5000/health
- Lista de usuários: http://localhost:5000/users

### Comandos úteis (Desenvolvimento)

```bash
# Iniciar os containers
docker-compose up -d

# Ver logs da aplicação
docker-compose logs -f app

# Ver logs do banco de dados
docker-compose logs -f db

# Parar os containers
docker-compose down

# Parar e remover volumes (apaga os dados)
docker-compose down -v

# Reconstruir as imagens
docker-compose build

# Reiniciar um serviço específico
docker-compose restart app

# Acessar o shell da aplicação
docker-compose exec app /bin/bash

# Acessar o PostgreSQL
docker-compose exec db psql -U postgres -d greencheck
```

### Características do Ambiente de Desenvolvimento

- Hot reload habilitado (alterações no código são refletidas automaticamente)
- Debug mode ativado
- Volumes montados para desenvolvimento em tempo real
- Logs detalhados
- Portas expostas: 5000 (Flask) e 5432 (PostgreSQL)

## Ambiente de Produção

### Como rodar

1. Configure as variáveis de ambiente (recomendado criar um arquivo `.env`):
```bash
# .env
DB_PASSWORD=sua_senha_segura_aqui
```

2. Inicie os containers de produção:
```bash
docker-compose -f docker-compose.prod.yml up -d
```

3. Verifique se os containers estão rodando:
```bash
docker-compose -f docker-compose.prod.yml ps
```

4. Acesse a aplicação:
- API: http://localhost:5000

### Comandos úteis (Produção)

```bash
# Iniciar os containers
docker-compose -f docker-compose.prod.yml up -d

# Ver logs
docker-compose -f docker-compose.prod.yml logs -f

# Parar os containers
docker-compose -f docker-compose.prod.yml down

# Reconstruir as imagens
docker-compose -f docker-compose.prod.yml build

# Ver status dos containers
docker-compose -f docker-compose.prod.yml ps
```

### Características do Ambiente de Produção

- Gunicorn como servidor WSGI (4 workers)
- Usuário não-root para maior segurança
- Restart automático em caso de falha
- Debug mode desabilitado
- Volumes persistentes para dados
- Senha do banco configurável via variável de ambiente

## Banco de Dados

### Schema

O banco de dados possui três tabelas principais:

- **users**: Cadastro de usuários
- **projects**: Projetos sustentáveis
- **metrics**: Métricas ambientais dos projetos

### Dados de Exemplo

Os arquivos `schema.sql` e `dados.sql` são executados automaticamente na primeira inicialização do banco de dados, criando as tabelas e inserindo dados de exemplo.

### Acessar o banco de dados

```bash
# Desenvolvimento
docker-compose exec db psql -U postgres -d greencheck

# Produção
docker-compose -f docker-compose.prod.yml exec db psql -U postgres -d greencheck
```

### Queries úteis

```sql
-- Listar todos os usuários
SELECT * FROM users;

-- Listar todos os projetos
SELECT * FROM projects;

-- Listar métricas com informações do projeto
SELECT p.name, m.metric_type, m.value, m.unit
FROM metrics m
JOIN projects p ON m.project_id = p.id;
```

## API Endpoints

### GET /
Página inicial da API
```json
{
  "message": "Welcome to GreenCheck API",
  "status": "running"
}
```

### GET /health
Verifica o status da aplicação e conexão com o banco de dados
```json
{
  "status": "healthy",
  "database": "connected"
}
```

### GET /users
Retorna lista de usuários cadastrados
```json
{
  "users": [
    {
      "id": 1,
      "name": "João Silva",
      "email": "joao.silva@example.com",
      "created_at": "2024-01-01T00:00:00"
    }
  ],
  "count": 1
}
```

## Troubleshooting

### Porta já em uso

Se você receber erro dizendo que a porta 5000 ou 5432 já está em uso:

```bash
# Verificar processos usando a porta
lsof -i :5000
lsof -i :5432

# Ou mudar as portas no docker-compose.yml
```

### Problemas de conexão com o banco de dados

Aguarde alguns segundos após iniciar os containers para o banco de dados ficar pronto. O healthcheck garante que a aplicação só inicie após o banco estar disponível.

### Limpar tudo e recomeçar

```bash
# Desenvolvimento
docker-compose down -v
docker-compose up -d

# Produção
docker-compose -f docker-compose.prod.yml down -v
docker-compose -f docker-compose.prod.yml up -d
```

## Desenvolvimento

### Adicionar novas dependências

1. Adicione a dependência em `requirements.txt`
2. Reconstrua a imagem:
```bash
docker-compose build app
docker-compose up -d
```

### Modificar o schema do banco

1. Edite o arquivo `schema.sql`
2. Remova o volume do banco:
```bash
docker-compose down -v
```
3. Recrie os containers:
```bash
docker-compose up -d
```

## Licença

Este projeto foi desenvolvido para fins educacionais na disciplina SSC0540.
