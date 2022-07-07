from typing import List
from website.place import Place


def entity_to_dto_mapper(places: List[Place]):
    return GetPlacesResponse(places).places


class GetPlacesResponse:
    def __init__(self, places: List[Place]) -> None:
        self.places = [place.as_dict() for place in places]
