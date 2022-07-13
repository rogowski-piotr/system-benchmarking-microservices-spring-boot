from static.utils import attributes


class Point():
    def __init__(self, latitude: float, longitude: float) -> None:
        self.latitude = latitude
        self.longitude = longitude

    def as_dict(self) -> dict:
        return attributes(self)

    def __str__(self) -> str:
        return f"{self.latitude} {self.longitude}"
