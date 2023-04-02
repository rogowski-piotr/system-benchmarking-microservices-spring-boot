
class GetPlaceDtoResponse:
    def __init__(self, place_dict: dict) -> None:
        self.id = place_dict["id"]
        self.city = place_dict["city"]
        self.coordinates = place_dict["coordinates"]
