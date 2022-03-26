package pl.edu.pg.benchmarking.math.dto;

import pl.edu.pg.benchmarking.math.entity.Point;

import java.util.List;
import java.util.function.Function;
import java.util.logging.Logger;

public class DistanceRequest {

    private static final Logger LOG = Logger.getLogger(DistanceRequest.class.getName());

    private Integer point1CoordinateX;

    private Integer point1CoordinateY;

    private Integer point2CoordinateX;

    private Integer point2CoordinateY;

    public Integer getPoint1CoordinateX() {
        return point1CoordinateX;
    }

    public Integer getPoint1CoordinateY() {
        return point1CoordinateY;
    }

    public Integer getPoint2CoordinateX() {
        return point2CoordinateX;
    }

    public Integer getPoint2CoordinateY() {
        return point2CoordinateY;
    }

    public void setPoint1CoordinateX(Integer point1CoordinateX) {
        this.point1CoordinateX = point1CoordinateX;
    }

    public void setPoint1CoordinateY(Integer point1CoordinateY) {
        this.point1CoordinateY = point1CoordinateY;
    }

    public void setPoint2CoordinateX(Integer point2CoordinateX) {
        this.point2CoordinateX = point2CoordinateX;
    }

    public void setPoint2CoordinateY(Integer point2CoordinateY) {
        this.point2CoordinateY = point2CoordinateY;
    }

    public static Function<DistanceRequest, List<Point>> dtoToEntityMapper() {
        return request -> List.of(
                new Point(request.point1CoordinateX, request.point1CoordinateY),
                new Point(request.point2CoordinateX, request.point2CoordinateY)
        );
    }

}
