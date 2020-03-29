FROM python:3.8.2-alpine

ENV APPDIR /srv
ENV STORE_DIR /storage

WORKDIR ${APPDIR}

RUN apk update
RUN apk add sqlite gcc musl-dev libffi-dev openssl-dev bash
RUN pip3 install -U pip poetry

COPY poetry.lock pyproject.toml ${APPDIR}/
RUN poetry install -n

COPY . ${APPDIR}/

CMD ["./run.sh"]
