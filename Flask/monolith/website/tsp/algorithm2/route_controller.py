import json
from flask import Blueprint, request
from website.tsp.algorithm2.route_service import RouteService
from static.exceptions import *


route2_views = Blueprint('route2', __name__)
route_service = RouteService()

@route2_views.route('', methods=['GET'])
def compute_route():
    try:
        route = route_service.compute_route(request.args["id"])
        return str(json.dumps(route, separators=(',', ':'))), 200, {'Content-Type': 'application/json'}
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
