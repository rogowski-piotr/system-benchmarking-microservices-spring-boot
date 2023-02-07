package pl.edu.pg.benchmarking.distance.dto;

import lombok.Getter;
import pl.edu.pg.benchmarking.distance.Point;

import java.util.List;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DistanceRequest {

    private static final Pattern COORDINATE_REGEX = Pattern.compile("([0-9]+.[0-9]+), ([0-9]+.[0-9]+)");

    @Getter
    private int placeId1;

    @Getter
    private int placeId2;

    @Getter
    private String coordinates1;

    @Getter
    private String coordinates2;

    private Double parseToLatitude(String coordinate) {
        Matcher matcher = COORDINATE_REGEX.matcher(coordinate);
        matcher.matches();
        return Double.valueOf(matcher.group(1));
    }

    private Double parseToLongitude(String coordinate) {
        Matcher matcher = COORDINATE_REGEX.matcher(coordinate);
        matcher.matches();
        return Double.valueOf(matcher.group(2));
    }

    public static Function<List<DistanceRequest>, List<Point>> dtoToEntityMapper() {
        return request -> request.stream()
                .map(el -> new Point(
                        el.getPlaceId1(), el.getPlaceId2(),
                        el.parseToLatitude(el.getCoordinates1()), el.parseToLongitude(el.getCoordinates1()),
                        el.parseToLatitude(el.getCoordinates2()), el.parseToLongitude(el.getCoordinates2())
                )).toList();
    }

}
