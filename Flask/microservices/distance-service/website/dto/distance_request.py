import re
from typing import List
# from static.utils import attributes
from website.point import Point


def entity_to_dto_mapper(request: dict) -> List[Point]:
    return DistanceRequest(request).points


class DistanceRequest:
    def __init__(self, request: dict) -> None:
        self.regex = "([0-9]+.[0-9]+), ([0-9]+.[0-9]+)"
        self.coordinate1 = request["coordinate1"]
        self.coordinate2 = request["coordinate2"]
        self.points = [
            Point(self.parse_to_latitude(self.coordinate1), self.parse_to_longitude(self.coordinate1)),
            Point(self.parse_to_latitude(self.coordinate2), self.parse_to_longitude(self.coordinate2))
        ]

    def parse_to_latitude(self, coordinate: str) -> float:
        result = re.search(self.regex, coordinate)
        return float(result.group(1))

    def parse_to_longitude(self, coordinate: str) -> str:
        result = re.search(self.regex, coordinate)
        return float(result.group(2))
