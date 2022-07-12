from pickletools import read_unicodestring1
from website.place_repository import PlaceRepository
from website.distance_repository import DistanceRepository
from static.utils import parse_str_to_list
from typing import List


class RouteService:
    def __init__(self) -> None:
        self.distance_repository = DistanceRepository()
        self.place_repository = PlaceRepository()

    def find_distance(self, place_id1: int, place_id2: int) -> float:
        coordinates1 = self.place_repository.find_place_coordinates(place_id1)
        coordinates2 = self.place_repository.find_place_coordinates(place_id2)
        return self.distance_repository.find_distance(coordinates1, coordinates2)

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
