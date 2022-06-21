package pl.edu.pg.benchmarking.monolith.algorithm1;

import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

@Service
public class RouteService {
    private final DistanceRepository distanceRepository;
    private final PlaceRepositoryExternal placeRepositoryExternal;

    public RouteService(DistanceRepository distanceRepository, PlaceRepositoryExternal placeRepositoryExternal) {
        this.distanceRepository = distanceRepository;
        this.placeRepositoryExternal = placeRepositoryExternal;
    }

    private Double findDistance(Integer placeId1, Integer placeId2) {
        String coordinates1 = placeRepositoryExternal.findPlaceCoordinates(placeId1);
        String coordinates2 = placeRepositoryExternal.findPlaceCoordinates(placeId2);
        return distanceRepository.findDistance(coordinates1, coordinates2);
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