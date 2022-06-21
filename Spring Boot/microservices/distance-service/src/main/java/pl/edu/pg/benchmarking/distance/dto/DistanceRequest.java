package pl.edu.pg.benchmarking.distance.dto;

import lombok.Getter;
import lombok.Setter;
import pl.edu.pg.benchmarking.distance.Point;

import java.util.List;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Getter
@Setter
public class DistanceRequest {
    private static final Pattern COORDINATE_REGEX = Pattern.compile("([0-9]+.[0-9]+), ([0-9]+.[0-9]+)");

    private String coordinate1;

    private String coordinate2;

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

    public static Function<DistanceRequest, List<Point>> dtoToEntityMapper() {
        return request -> List.of(
                new Point(request.parseToLatitude(request.getCoordinate1()), request.parseToLongitude(request.getCoordinate1())),
                new Point(request.parseToLatitude(request.getCoordinate2()), request.parseToLongitude(request.getCoordinate2()))
        );
    }

}
