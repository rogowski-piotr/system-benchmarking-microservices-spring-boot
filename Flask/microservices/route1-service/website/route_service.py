from collections import ChainMap
from website.place.place_repository import PlaceRepository
from website.distance.distance_repository import DistanceRepository
from static.utils import parse_str_to_list


class RouteService:
    def __init__(self) -> None:
        self.distance_repository = DistanceRepository()
        self.place_repository = PlaceRepository()
        self.places_distance_map = ChainMap()

    def find_distance(self, place_id1: int, place_id2: int) -> float:
        key_pair = (place_id1, place_id2)
        return self.places_distance_map.get(key_pair)

    def find_closest_neighbour(self, place_start: int, places: list) -> int:
        closest_neighbour_id = None
        closest_neighbour_distance = None

        for place_id in places:
            if closest_neighbour_id == None:
                closest_neighbour_id = place_id
                closest_neighbour_distance = self.find_distance(place_start, place_id)
            else:
                distance = self.find_distance(place_start, place_id)
                if distance < closest_neighbour_distance:
                    closest_neighbour_id = place_id
                    closest_neighbour_distance = distance

        return closest_neighbour_id

    def compute_route(self, ids: str) -> list:
        places_coordinates = self.place_repository.find_places_coordinates(ids)
        self.places_distance_map = self.distance_repository.find_distances(places_coordinates)
        
        places = parse_str_to_list(ids)
        current_place = places[0]
        places_amount = len(places)
        visited_places: list = []
        visited_places.append(current_place)
        places = places[1:]        

        for _ in range(1, places_amount):
            current_place = self.find_closest_neighbour(current_place, places)
            visited_places.append(current_place)
            places.remove(current_place)
        
        return visited_places
