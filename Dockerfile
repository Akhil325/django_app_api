FROM python:3.7-alpine

ENV PYTHONBUFFERED 1

COPY ./Pipfile /Pipfile
COPY ./Pipfile.lock /Pipfile.lock
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
  gcc libc-dev linux-headers postgresql-dev
RUN pip install pipenv
RUN pipenv install --deploy --system
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
