from static.utils import attributes


class GetDistanceDtoRequest:
    def __init__(self, placeId1: int, placeId2: int, coordinates1: str, coordinates2: str) -> None:
        self.placeId1 = placeId1
        self.placeId2 = placeId2
        self.coordinates1 = coordinates1
        self.coordinates2 = coordinates2
    
    def as_dict(self) -> dict:
        return attributes(self)
