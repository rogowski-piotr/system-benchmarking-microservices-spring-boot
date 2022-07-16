"""Application initialization."""
from flask import Flask
from website.tsp.algorithm1.route_controller import route1_views
from website.tsp.algorithm2.route_controller import route2_views
from website.distance.distance_controller import distance_views
from website.place.place_controller import place_views


app = Flask(__name__)
app.config.from_object("static.config")


# Register Blueprints
app.register_blueprint(route1_views, url_prefix='/api/route1')
app.register_blueprint(route2_views, url_prefix='/api/route2')
app.register_blueprint(distance_views, url_prefix='/api/distance')
app.register_blueprint(place_views, url_prefix='/api/places')