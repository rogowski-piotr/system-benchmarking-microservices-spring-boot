import website.distance.dto.distance_request as distance_request
import website.distance.dto.distance_response as distance_response
from website.distance.spherical_distance_service import SphericalDistanceService
from flask import Blueprint, request, jsonify


distance_views = Blueprint('distance', __name__)
distance_service = SphericalDistanceService()


@distance_views.route('/', methods=['POST'], strict_slashes=False)
def calculate_distance() -> dict:
    points = distance_request.dto_to_entity_mapper(request.json)
    point1 = points[0]
    point2 = points[1]

    distance: float = distance_service.calculate_distance(
        point1.latitude, point1.longitude, point2.latitude, point2.longitude)

    dto = distance_response.entity_to_dto_mapper(distance)
    return jsonify(dto.as_dict())
