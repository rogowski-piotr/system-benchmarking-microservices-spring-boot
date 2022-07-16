from typing import List, Optional
from website.place.place import Place
from website.place.place_repository import PlaceRepository


class PlaceService:
    def __init__(self) -> None:
        self.place_repository = PlaceRepository()

    def get_all_places(self) -> List[Place]:
        return self.place_repository.find_all()

    def get_place(self, place_id: int) -> Optional[Place]:
        return self.place_repository.find_by_id(place_id)
