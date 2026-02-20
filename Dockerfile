FROM python:3.12-alpine3.19

# Criar diretório da aplicação
WORKDIR /usr/src/app

# Copiar requirements e instalar dependências
COPY requirements.txt ./
RUN apk add --no-cache --virtual .build-deps \
        build-base linux-headers python3-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps

# Copiar restante do código
COPY . .


# Expor porta e rodar com gunicorn
EXPOSE 8000
CMD ["gunicorn", "to_do.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]