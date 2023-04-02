from website.place_repository import PlaceRepository
import website.dto.get_place_response as place_response
import website.dto.get_places_response as places_response
from flask import Blueprint, jsonify, request
from static.utils import parse_str_to_list


place_views = Blueprint('place', __name__)
place_repository = PlaceRepository()


@place_views.route('/all', methods=['GET'])
def get_all_places() -> dict:
    places = place_repository.find_all()
    dto = places_response.entity_to_dto_mapper(places)
    return jsonify(dto)


@place_views.route('/<int:place_id>', methods=['GET'])
def get_single_place(place_id: int) -> dict:
    place = place_repository.find_by_id(place_id)
    if not place:
        return "Bad request - Place of given id does not exist", 404
    dto = place_response.entity_to_dto_mapper(place)
    return jsonify(dto.as_dict())

@place_views.route('', methods=['GET'])
def get_places() -> dict:
    ids_param = parse_str_to_list(request.args["ids"])
    result_list = place_repository.find_by_ids(ids_param)
    dto = places_response.entity_to_dto_mapper(result_list)
    return jsonify(dto)
