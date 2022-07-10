import os


HOST='0.0.0.0'
PORT=8083
DEBUG=True
PROD_ENV=False
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    pass


# dependent services URL's
place_service_url = "http://localhost:8081/api/"
distance_service_url="http://localhost:8082/api/"
