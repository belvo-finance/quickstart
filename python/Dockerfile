FROM python:3.8-alpine

ENV PYTHONPATH=/opt/belvo
ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /opt/requirements.txt

RUN apk add --no-cache --virtual .build-deps \
    gcc \
    make \
    python3-dev \
 && pip install --no-cache-dir --disable-pip-version-check -r /opt/requirements.txt \
 && apk del .build-deps \
 && rm -rf /opt/belvo/requirements.txt

COPY . /opt/belvo/

WORKDIR /opt/belvo/

EXPOSE 5000

ENV FLASK_APP server.py

CMD ["flask", "run", "--host=0.0.0.0"]
