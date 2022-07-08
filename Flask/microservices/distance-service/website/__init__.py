"""Application initialization."""
from flask import Flask
from website.distance_controller import distance_views


app = Flask(__name__)
app.config.from_object("static.config")


# Register Blueprints
app.register_blueprint(distance_views, url_prefix='/api/distance')
