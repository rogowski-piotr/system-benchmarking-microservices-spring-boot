import re
from typing import Final
from static.utils import attributes
from website.distance.point import Point


COORDINATE_REGEX: Final[str] = "([0-9]+.[0-9]+), ([0-9]+.[0-9]+)"

class Place():
    def __init__(self, place_id: int, city: str, coordinates: str) -> None:
        self.id = place_id
        self.city = city
        self.coordinates = coordinates

    def as_dict(self) -> dict:
        return attributes(self)

    def get_point(self) -> Point:
        result = re.search(COORDINATE_REGEX, self.coordinates)
        latitude = float(result.group(1))
        longitude = float(result.group(2))
        return Point(latitude, longitude)
