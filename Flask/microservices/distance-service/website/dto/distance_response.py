from typing import List
from website.point import Point
from static.utils import attributes


def entity_to_dto_mapper(points: List[Point], distances_list: List[float]) -> list:
    distance_response_list = list()
    for iter in range(len(distances_list)):
        point = points[iter]
        distance = distances_list[iter]
        single_distance = DistanceResponse(point.place_id_1, point.place_id_2, distance)
        distance_response_list.append(single_distance)
    return [place.as_dict() for place in distance_response_list]


class DistanceResponse:
    def __init__(self, place_id_1: int, place_id_2: int, distance: float) -> None:
        self.placeId1 = place_id_1
        self.placeId2 = place_id_2
        self.distance = distance

    def as_dict(self):
        return attributes(self)
