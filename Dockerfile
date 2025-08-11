FROM python:3.9-alpine3.13
LABEL maintainer="Frank Caicedo"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN apk add --update --no-cache postgresql-client build-base postgresql-dev musl-dev \
    && python -m venv /py \
    && /py/bin/pip install --upgrade pip \
    && /py/bin/pip install -r /tmp/requirements.txt \
    && if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi \
    && rm -rf /tmp/requirements.txt /tmp/requirements.dev.txt \
    && apk del build-base postgresql-dev musl-dev \
    && adduser -D -H -u 1000 django-user \
    && chown -R django-user:django-user /app

ENV PATH="/py/bin:$PATH"

USER django-user
