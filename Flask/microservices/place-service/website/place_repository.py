import json
from typing import List, Optional
from website.place import Place


class PlaceRepository:
    def __init__(self) -> None:
        self.places = self._post_construct()

    @staticmethod
    def _post_construct() -> List[Place]:
        with open("static/coordinates.json", "r", encoding="utf8") as coordinates_file:
            places = json.load(coordinates_file)

        return [Place(place["id"], place["city"], place["coordinates"]) for place in places]

    def find_all(self) -> List[Place]:
        return self.places

    def find_by_id(self, place_id: int) -> Optional[Place]:
        for place in self.places:
            if place.id == place_id:
                return place
        return None
