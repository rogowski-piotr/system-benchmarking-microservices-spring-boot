import imp
from website.route_repository import RouteRepository
from flask import Blueprint, request, jsonify
from website.route_service import RouteService
from static.exceptions import *


route1_views = Blueprint('route1', __name__)
route_repository = RouteRepository()
route_service = RouteService()

@route1_views.route('/', methods=['GET'], strict_slashes=False)
def compute_route():
    try:
        route = route_service.compute_route(request.args["id"])
        return jsonify(route), 200
    except KeyError:
        return "Bad request - accepted request parameters are: \"id\"", 400
    except ParseArguments:
        return f"Bad request - cannot parse provided arguments {request.args['id']}", 400
    except PlaceNotFound as e:
        return f"Bad request - {e.message}", 400
    except PlaceServiceNotWorking:
        return "Place service is not available", 500
    except DistanceServiceNotWorking:
        return "Distance service is not available", 500
    except Exception as e:
        return f"An unknown exception has occured: {e.message}", 500
