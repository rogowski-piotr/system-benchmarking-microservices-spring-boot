import os


HOST='0.0.0.0'
PORT=8082
DEBUG=False
PROD_ENV=True
THREAD_POOL_SIZE=3
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    pass
