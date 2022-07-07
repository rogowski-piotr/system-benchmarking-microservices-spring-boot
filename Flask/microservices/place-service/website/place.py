from static.utils import attributes


class Place():
    def __init__(self, place_id: int, city: str, coordinates: str) -> None:
        self.id = place_id
        self.city = city
        self.coordinates = coordinates

    def as_dict(self) -> dict:
        return attributes(self)
