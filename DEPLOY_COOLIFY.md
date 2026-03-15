# Deploy do Fixelo via Git + Coolify

Este guia usa deploy por Git no Coolify com o arquivo `docker-compose.coolify.yml`.

## 1. Preparar repositório Git

1. Confirme que os arquivos abaixo estao versionados:
   - `Dockerfile`
   - `docker-compose.coolify.yml`
   - `.dockerignore`
2. Faça push para a branch de deploy (exemplo: `main`).

## 2. Criar recurso no Coolify

1. Em **Project > New Resource > Docker Compose**.
2. Selecione seu repositório Git e branch.
3. Em **Compose File**, informe: `docker-compose.coolify.yml`.
4. Defina build pack como Docker Compose (nao Nixpacks).

## 3. Variaveis de ambiente (obrigatorias)

Cadastre no Coolify (Environment Variables):

- `POSTGRES_PASSWORD`
- `NEXTAUTH_SECRET`
- `NEXT_PUBLIC_APP_URL` (ex.: `https://app.seudominio.com`)
- `STRIPE_SECRET_KEY`
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`
- `STRIPE_WEBHOOK_SECRET`
- `SMTP_HOST`
- `SMTP_PORT`
- `SMTP_USER`
- `SMTP_PASSWORD`
- `SMTP_FROM`

Variaveis com default no compose:

- `POSTGRES_USER` (default `fixelo`)
- `POSTGRES_DB` (default `fixelo_prod`)

Variaveis opcionais:

- `TWILIO_ACCOUNT_SID`
- `TWILIO_AUTH_TOKEN`
- `TWILIO_PHONE_NUMBER`
- `NEXT_PUBLIC_VAPID_PUBLIC_KEY`
- `VAPID_PRIVATE_KEY`
- `NEXT_PUBLIC_GOOGLE_MAPS_API_KEY`

## 4. Porta e dominio

1. No service `web`, use porta interna `3000`.
2. Configure o dominio no Coolify apontando para o service `web`.
3. Ative HTTPS no proprio Coolify.

## 5. Comando pos-deploy (migracoes)

No Coolify, configure **Post-deployment command** para o service `web`:

```bash
npx prisma migrate deploy --schema=packages/database/prisma/schema.prisma
```

Se quiser seed inicial (apenas primeira vez), rode manualmente no terminal do container `web`:

```bash
npx prisma db seed --schema=packages/database/prisma/schema.prisma
```

## 6. Health check

A aplicacao expoe:

- `GET /api/health`

Use esse endpoint como health check no Coolify.

## 7. Fluxo de deploy continuo pelo Git

1. Commit e push para a branch configurada.
2. Coolify detecta o push e inicia build/deploy automaticamente.
3. Valide status do deploy e logs do service `web`.

## 8. Opcional: usar PostgreSQL gerenciado

Se preferir banco gerenciado (Neon, Supabase, RDS):

1. Remova o service `db` no `docker-compose.coolify.yml`.
2. Defina `DATABASE_URL` diretamente no service `web` via Coolify.
3. Mantenha o post-deploy de migracoes igual.
