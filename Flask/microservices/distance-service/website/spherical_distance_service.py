import math
from website.point import Point


class SphericalDistanceService:
    def __init__(self) -> None:
        pass

    def calculate_distance(self, point: Point) -> float:
        return math.acos(math.sin(math.radians(point.latitude_1)) * math.sin(math.radians(point.latitude_2)) + \
            math.cos(math.radians(point.latitude_1)) * math.cos(math.radians(point.latitude_2)) * \
            math.cos(math.radians(point.longitude_1 - point.longitude_2))) * 6371
