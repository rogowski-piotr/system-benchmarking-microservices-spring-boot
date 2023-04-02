package pl.edu.pg.benchmarking.route1;

import org.springframework.stereotype.Service;
import pl.edu.pg.benchmarking.route1.distance.DistanceRepository;
import pl.edu.pg.benchmarking.route1.place.PlaceDto.GetPlaceDtoResponse;
import pl.edu.pg.benchmarking.route1.distance.DistanceRepository.PlacesPair;
import pl.edu.pg.benchmarking.route1.place.PlaceRepository;

import java.util.Collection;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

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

    private Integer findClosestNeighbor(Integer placeStart, Collection<Integer> places) {
        Integer closestNeighborId = null;
        Double closestNeighborDistance = null;

        for (Integer placeId : places) {
            if (closestNeighborId == null) {
                closestNeighborId = placeId;
                closestNeighborDistance = findDistance(placeStart, placeId);

            } else {
                Double distance = findDistance(placeStart, placeId);
                if (distance < closestNeighborDistance) {
                    closestNeighborId = placeId;
                    closestNeighborDistance = distance;
                }
            }
        }
        return closestNeighborId;
    }

    public List<Integer> computeRoute(Collection<Integer> places) {
        List<GetPlaceDtoResponse> placesCoordinates = placeRepository.findPlacesCoordinates(places);
        this.placesDistanceMap = distanceRepository.findDistances(placesCoordinates);

        Integer currentPlace = places.stream().findFirst().get();
        int placesAmount = places.size();
        List<Integer> visitedPlaces = new LinkedList<>();
        visitedPlaces.add(currentPlace);
        places.remove(currentPlace);

        for(int i = 1; i < placesAmount; i++) {
            currentPlace = findClosestNeighbor(currentPlace, places);
            visitedPlaces.add(currentPlace);
            places.remove(currentPlace);
        }
        return visitedPlaces;
    }

}