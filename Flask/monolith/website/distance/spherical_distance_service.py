import math
from website.distance.point import Point


class SphericalDistanceService:
    def __init__(self) -> None:
        pass

    def calculate_distance_between_points(self, point1: Point, point2: Point) -> float:
        return self.calculate_distance(point1.latitude, point1.longitude,
            point2.latitude, point2.longitude)

    def calculate_distance(self, latitude1: float, longitude1: float, latitude2: float,
        longitude2: float) -> float:
        return math.acos(math.sin(math.radians(latitude1)) * math.sin(math.radians(latitude2)) + \
            math.cos(math.radians(latitude1)) * math.cos(math.radians(latitude2)) * \
            math.cos(math.radians(longitude1 - longitude2))) * 6371
