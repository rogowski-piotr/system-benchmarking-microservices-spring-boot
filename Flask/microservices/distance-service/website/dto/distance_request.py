import re
from typing import List, Final
from website.point import Point


COORDINATE_REGEX: Final[str] = "([0-9]+.[0-9]+), ([0-9]+.[0-9]+)"


def dto_to_entity_mapper(request: list) -> List[Point]:
    mapped_result = map(lambda places_element: DistanceRequest(places_element).to_point(), request)
    return list(mapped_result)


class DistanceRequest:
    def __init__(self, request_single_place: dict) -> None:
        self.place_id_1 = request_single_place["placeId1"]
        self.place_id_2 = request_single_place["placeId2"]
        self.coordinates_1 = request_single_place["coordinates1"]
        self.coordinates_2 = request_single_place["coordinates2"]

    def parse_to_latitude(self, coordinate: str) -> float:
        result = re.search(COORDINATE_REGEX, coordinate)
        return float(result.group(1))

    def parse_to_longitude(self, coordinate: str) -> float:
        result = re.search(COORDINATE_REGEX, coordinate)
        return float(result.group(2))

    def to_point(self) -> Point:
        return Point(
            self.place_id_1,
            self.place_id_2,
            self.parse_to_latitude(self.coordinates_1),
            self.parse_to_latitude(self.coordinates_2),
            self.parse_to_longitude(self.coordinates_1),
            self.parse_to_longitude(self.coordinates_2)
        )
