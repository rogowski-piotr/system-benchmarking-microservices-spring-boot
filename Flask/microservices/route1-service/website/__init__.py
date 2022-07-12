"""Application initialization."""
from flask import Flask
from website.route_controller import route1_views


app = Flask(__name__)
app.config.from_object("static.config")


# Register Blueprints
app.register_blueprint(route1_views, url_prefix='/api/route1')
