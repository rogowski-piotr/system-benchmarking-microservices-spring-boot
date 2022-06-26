package pl.edu.pg.benchmarking.monolith.tsp.algorithm1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.pg.benchmarking.monolith.distance.SphericalDistanceService;
import pl.edu.pg.benchmarking.monolith.place.Place;
import pl.edu.pg.benchmarking.monolith.place.PlaceService;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

@Service
public class RouteService {
    private final PlaceService placeService;
    private final SphericalDistanceService distanceService;

    @Autowired
    public RouteService(PlaceService placeService, SphericalDistanceService distanceService) {
        this.placeService = placeService;
        this.distanceService = distanceService;
    }

    private Double findDistance(Integer placeId1, Integer placeId2) {
        Place place1 = placeService.getPlace(placeId1).get();
        Place place2 = placeService.getPlace(placeId2).get();
        return distanceService.calculateDistanceBetweenPoints(
                place1.getPoint(),
                place2.getPoint());
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