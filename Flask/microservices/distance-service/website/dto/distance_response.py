from static.utils import attributes


def entity_to_dto_mapper(distance: float):
    return DistanceResponse(distance)


class DistanceResponse:
    def __init__(self, distance: float) -> None:
        self.distance = distance

    def as_dict(self):
        return attributes(self) 