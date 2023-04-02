import os


HOST='0.0.0.0'
PORT=8084
DEBUG=False
PROD_ENV=True
THREAD_POOL_SIZE=3
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    pass


# dependent services URL's
place_service_url = "http://place-service:8081/api/"
# place_service_url = "http://localhost:8081/api/"
distance_service_url="http://distance-service:8082/api/"
# distance_service_url="http://localhost:8082/api/"
