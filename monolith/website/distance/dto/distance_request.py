import re
from typing import List, Final
from website.distance.point import Point


COORDINATE_REGEX: Final[str] = "([0-9]+.[0-9]+), ([0-9]+.[0-9]+)"


def dto_to_entity_mapper(request: dict) -> List[Point]:
    return DistanceRequest(request).points


class DistanceRequest:
    def __init__(self, request: dict) -> None:
        self.coordinate1 = request["coordinate1"]
        self.coordinate2 = request["coordinate2"]
        self.points = [
            Point(self.parse_to_latitude(self.coordinate1), self.parse_to_longitude(self.coordinate1)),
            Point(self.parse_to_latitude(self.coordinate2), self.parse_to_longitude(self.coordinate2))
        ]

    def parse_to_latitude(self, coordinate: str) -> float:
        result = re.search(COORDINATE_REGEX, coordinate)
        return float(result.group(1))

    def parse_to_longitude(self, coordinate: str) -> float:
        result = re.search(COORDINATE_REGEX, coordinate)
        return float(result.group(2))
