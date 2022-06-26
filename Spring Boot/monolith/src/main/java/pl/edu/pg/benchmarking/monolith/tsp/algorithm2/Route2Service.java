package pl.edu.pg.benchmarking.monolith.tsp.algorithm2;

import org.springframework.stereotype.Service;
import pl.edu.pg.benchmarking.monolith.distance.SphericalDistanceService;
import pl.edu.pg.benchmarking.monolith.place.Place;
import pl.edu.pg.benchmarking.monolith.place.PlaceService;
import pl.edu.pg.benchmarking.monolith.tsp.PlaceNotFoundException;

import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class Route2Service {
    private final PlaceService placeService;
    private final SphericalDistanceService distanceService;

    public Route2Service(PlaceService placeService, SphericalDistanceService distanceService) {
        this.placeService = placeService;
        this.distanceService = distanceService;
    }

    private Double findDistance(Integer placeId1, Integer placeId2) throws PlaceNotFoundException {
        Place place1 = placeService.getPlace(placeId1).orElseThrow(PlaceNotFoundException::new);
        Place place2 = placeService.getPlace(placeId2).orElseThrow(PlaceNotFoundException::new);
        return distanceService.calculateDistanceBetweenPoints(
                place1.getPoint(),
                place2.getPoint());
    }

    public List<List<Integer>> computePermutationRecursive(Integer[] elements) {
        return computePermutationRecursive(elements.length, elements, new LinkedList<>());
    }

    public List<List<Integer>> computePermutationRecursive(int n, Integer[] elements, List<List<Integer>> listOfPermutations) {
        if (n == 1) listOfPermutations.add(Arrays.stream(elements).collect(Collectors.toList()));
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

    public List<Integer> computeRoute(Collection<Integer> places) throws PlaceNotFoundException {
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