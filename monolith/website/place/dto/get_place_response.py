from website.place.place import Place
from static.utils import attributes


def entity_to_dto_mapper(place: Place):
    return GetPlaceResponse(place.id, place.city, place.coordinates)


class GetPlaceResponse:
    def __init__(self, id: int, city: str, coordinates: str) -> None:
        self.id = id
        self.city = city
        self.coordinates = coordinates

    def as_dict(self):
        return attributes(self)