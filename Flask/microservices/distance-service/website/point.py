from static.utils import attributes


class Point():
    def __init__(self, place_id_1: int, place_id_2: int, latitude_1: float, latitude_2: float, longitude_1: float, longitude_2: float) -> None:
        self.place_id_1 = place_id_1
        self.place_id_2 = place_id_2
        self.latitude_1 = latitude_1
        self.latitude_2 = latitude_2
        self.longitude_1 = longitude_1
        self.longitude_2 = longitude_2

    def as_dict(self) -> dict:
        return attributes(self)
