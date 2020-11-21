FROM balenalib/raspberry-pi:20201012

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-armhf /tini
RUN chmod +x /tini

RUN apt update -qy && apt install -qy pigpio python3 python3-pip

WORKDIR /app
COPY requirements.txt ./
RUN pip3 install -r requirements.txt

COPY api.py DHT22.py start.sh ./

CMD ["/tini", "--", "./start.sh"]
