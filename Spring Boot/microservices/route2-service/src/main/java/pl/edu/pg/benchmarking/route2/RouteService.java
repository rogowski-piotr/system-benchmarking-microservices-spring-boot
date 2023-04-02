package pl.edu.pg.benchmarking.route2;

import org.springframework.stereotype.Service;
import pl.edu.pg.benchmarking.route2.distance.DistanceRepository;
import pl.edu.pg.benchmarking.route2.place.PlaceRepository;
import pl.edu.pg.benchmarking.route2.distance.DistanceRepository.PlacesPair;
import pl.edu.pg.benchmarking.route2.place.PlaceDto.GetPlaceDtoResponse;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RouteService {
    private final DistanceRepository distanceRepository;
    private final PlaceRepository placeRepository;
    private Map<PlacesPair, Double> placesDistanceMap = new HashMap<>();

    public RouteService(DistanceRepository distanceRepository, PlaceRepository placeRepository) {
        this.distanceRepository = distanceRepository;
        this.placeRepository = placeRepository;
    }

    private double findDistance(int placeId1, int placeId2) {
        PlacesPair keyPair = new PlacesPair(placeId1, placeId2);
        return placesDistanceMap.get(keyPair);
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
        List<GetPlaceDtoResponse> placesCoordinates = placeRepository.findPlacesCoordinates(places);
        this.placesDistanceMap = distanceRepository.findDistances(placesCoordinates);

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