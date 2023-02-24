import website.dto.distance_request as distance_request
import website.dto.distance_response as distance_response
from website.spherical_distance_service import SphericalDistanceService
from flask import Blueprint, request, jsonify


distance_views = Blueprint('distance', __name__)
distance_service = SphericalDistanceService()


@distance_views.route('', methods=['POST'])
def calculate_distance() -> dict:
    points = distance_request.dto_to_entity_mapper(request.json)
    distances_mapped = map(lambda points_pair: distance_service.calculate_distance(points_pair), points)
    distances_list = list(distances_mapped)
    dto = distance_response.entity_to_dto_mapper(points, distances_list)
    return jsonify(dto)
