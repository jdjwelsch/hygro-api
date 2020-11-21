import DHT22
import pigpio
import time
from fastapi import FastAPI


class Hygro:
    def __init__(self):
        pi = pigpio.pi()
        self.sensor = DHT22.sensor(pi, 2, LED=16, power=8)
        self.last_read = 0

    @property
    def temperature(self):
        self.update_state()
        return self.sensor.temperature()

    @property
    def humidity(self):
        self.update_state()
        return self.sensor.humidity()

    def update_state(self):
        now = time.time()
        time_diff = now - self.last_read
        if time_diff > 5:
            self.last_read = now
            self.sensor.trigger()
            time.sleep(0.2)


sensor = Hygro()
app = FastAPI()


@app.get('/temperature')
def read_temp() -> float:
    return {'temperature': sensor.temperature}


@app.get('/humidity')
def read_temp() -> float:
    return {'humidity': sensor.humidity}