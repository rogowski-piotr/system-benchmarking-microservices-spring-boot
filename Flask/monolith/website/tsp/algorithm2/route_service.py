from typing import List
from website.place.place import Place
from website.place.place_service import PlaceService
from website.distance.spherical_distance_service import SphericalDistanceService
from static.utils import parse_str_to_list


class RouteService:
    def __init__(self) -> None:
        self.place_service = PlaceService()
        self.distance_service = SphericalDistanceService()

    def find_distance(self, place_id1: int, place_id2: int) -> float:
        place1: Place = self.place_service.get_place(place_id1)
        place2: Place = self.place_service.get_place(place_id2)
        return self.distance_service.calculate_distance_between_points(
            place1.get_point(), place2.get_point())

    def compute_permutation_recursive_list(self, elements: List[int]) -> List[List[int]]:
        return self.compute_permutation_recursive(len(elements), elements, [])

    def compute_permutation_recursive(self, n: int, elements: List[int],
        list_of_permutations: List[List[int]]) -> List[List[int]]:

        if n == 1:
            list_of_permutations.append(list(elements))
        else:
            for i in range(0, n-1):
                list_of_permutations = self.compute_permutation_recursive(n - 1, elements, list_of_permutations)
                if n % 2 == 0:
                    elements = self.swap(elements, i, n-1)
                else:
                    elements = self.swap(elements, 0, n-1)
            list_of_permutations = self.compute_permutation_recursive(n - 1, elements, list_of_permutations)

        return list_of_permutations

    def swap(self, input: List[int], a: int, b: int) -> List[int]:
        tmp = input[a]
        input[a] = input[b]
        input[b] = tmp
        return input

    def compute_route(self, id: str) -> List[int]:
        places = parse_str_to_list(id)
        list_of_permutations = self.compute_permutation_recursive_list(places[1:])

        for permutation in list_of_permutations:
            permutation.insert(0, places[0])
            permutation.append(places[0])

        shortest_way = None
        shortest_distance = None

        for single_permutation_list in list_of_permutations:
            distance = 0

            for i in range(0, len(single_permutation_list) - 1):
                place_id1 = single_permutation_list[i]
                place_id2 = single_permutation_list[i + 1]
                distance += self.find_distance(place_id1, place_id2)

            if (shortest_distance is None) or (shortest_distance > distance):
                shortest_distance = distance
                shortest_way = single_permutation_list

        return shortest_way
