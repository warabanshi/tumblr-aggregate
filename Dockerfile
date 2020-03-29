FROM python:3.8.2

ENV APPDIR /srv
ENV STORE_DIR /storage

WORKDIR ${APPDIR}

RUN apt update
RUN apt install sqlite3
RUN pip3 install -U pip poetry

COPY poetry.lock pyproject.toml ${APPDIR}/
RUN poetry install -n

COPY . ${APPDIR}/

CMD ["./run.sh"]
