package pl.edu.pg.benchmarking.route2;

import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class RouteService {
    private final DistanceRepository distanceRepository;
    private final PlaceRepository placeRepository;

    public RouteService(DistanceRepository distanceRepository, PlaceRepository placeRepository) {
        this.distanceRepository = distanceRepository;
        this.placeRepository = placeRepository;
    }

    private Double findDistance(Integer placeId1, Integer placeId2) {
        String coordinates1 = placeRepository.findPlaceCoordinates(placeId1);
        String coordinates2 = placeRepository.findPlaceCoordinates(placeId2);
        return distanceRepository.findDistance(coordinates1, coordinates2);
    }

    public List<List<Integer>> computePermutationRecursive(Integer[] elements) {
        return computePermutationRecursive(elements.length, elements, new LinkedList<>());
    }

    public List<List<Integer>> computePermutationRecursive(int n, Integer[] elements, List<List<Integer>> listOfPermutations) {
        if(n == 1) listOfPermutations.add(Arrays.stream(elements).collect(Collectors.toList()));
        else {
            for(int i = 0; i < n-1; i++) {
                computePermutationRecursive(n - 1, elements, listOfPermutations);
                if(n % 2 == 0)  swap(elements, i, n-1);
                else            swap(elements, 0, n-1);
            }
            computePermutationRecursive(n - 1, elements, listOfPermutations);
        }
        return listOfPermutations;
    }

    private void swap(Integer[] input, int a, int b) {
        Integer tmp = input[a];
        input[a] = input[b];
        input[b] = tmp;
    }

    public List<Integer> computeRoute(Collection<Integer> places) {
        List<List<Integer>> listOfPermutations = computePermutationRecursive(Arrays.copyOfRange(places.toArray(new Integer[0]), 1, places.size()));

        listOfPermutations.forEach(permutationList -> {
            int indexOfFirstElement = places.iterator().next();
            permutationList.add(0, indexOfFirstElement);
            permutationList.add(indexOfFirstElement);
        });

        List<Integer> shortestWay = null;
        Double shortestDistance = null;

        for (List<Integer> singlePermutationList : listOfPermutations) {
            double distance = 0;

            for (int i = 0; i < singlePermutationList.size() - 1; i += 1) {
                int placeId1 = singlePermutationList.get(i);
                int placeId2 = singlePermutationList.get(i + 1);
                distance += findDistance(placeId1, placeId2);
            }

            if (shortestDistance == null || shortestDistance.compareTo(distance) > 0) {
                shortestDistance = distance;
                shortestWay = singlePermutationList;
            }
        }
        return shortestWay;
    }
}