"""Application initialization."""
from flask import Flask
from .place_controller import place_views


app = Flask(__name__)
app.config.from_object("website.config")


# Register Blueprints
app.register_blueprint(place_views, url_prefix='/api/places')
