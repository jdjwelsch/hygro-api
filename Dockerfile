FROM arm32v7/python:3.8-buster

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-armhf /tini
RUN chmod +x /tini

RUN apt update -qy && apt install -qy pigpio

WORKDIR /app
COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY api.py DHT22.py start.sh ./

CMD ["/tini", "--", "./start.sh"]
