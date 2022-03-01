FROM python:3.9.9-slim-bullseye

MAINTAINER italo.anjos <italo.anjos@m2center.com.br>

LABEL teste="teste1"

RUN apt update -y && apt-get install -y \
    gunicorn

WORKDIR /deploy_ci
COPY deploy_ci .
COPY ./docker/start.sh start.sh
COPY ./requirements.txt requirements.txt

RUN python -m pip install --upgrade pip \
    && python -m pip install --require-hashes -r requirements.txt

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000
EXPOSE 5000

CMD ["./start.sh"]
