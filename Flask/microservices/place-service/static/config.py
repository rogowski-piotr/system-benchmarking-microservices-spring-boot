import os


HOST='0.0.0.0'
PORT=8081
DEBUG=False
ENV="production"
FLASK_ENV="development"
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    pass