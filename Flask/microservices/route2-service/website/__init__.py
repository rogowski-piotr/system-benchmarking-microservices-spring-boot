"""Application initialization."""
from flask import Flask
from website.route_controller import route2_views


app = Flask(__name__)
app.config.from_object("static.config")


# Register Blueprints
app.register_blueprint(route2_views, url_prefix='/api/route2')
