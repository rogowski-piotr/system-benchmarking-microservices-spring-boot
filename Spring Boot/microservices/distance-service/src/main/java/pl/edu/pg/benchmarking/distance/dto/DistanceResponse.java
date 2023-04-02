package pl.edu.pg.benchmarking.distance.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import pl.edu.pg.benchmarking.distance.Point;

import java.util.LinkedList;
import java.util.List;
import java.util.function.BiFunction;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class DistanceResponse {

    private int placeId1;

    private int placeId2;

    private double distance;

    public static BiFunction<List<Point>, List<Double>, List<DistanceResponse>> entityToDtoMapper() {
        return (points, distances) -> {
            List<DistanceResponse> distanceResponseList = new LinkedList<>();
            for (int iter = 0; iter < points.size(); iter++) {
                distanceResponseList.add(
                        new DistanceResponse(points.get(iter).getPlaceId1(), points.get(iter).getPlaceId2(), distances.get(iter)));
            }
            return distanceResponseList;
        };
    }
}
