package pl.edu.pg.benchmarking.math.dto;

import pl.edu.pg.benchmarking.math.entity.Point;

import java.util.List;
import java.util.function.Function;
import java.util.logging.Logger;

public class DistanceRequest {

    private static final Logger LOG = Logger.getLogger(DistanceRequest.class.getName());

    private Double point1CoordinateX;

    private Double point1CoordinateY;

    private Double point2CoordinateX;

    private Double point2CoordinateY;

    public Double getPoint1CoordinateX() {
        return point1CoordinateX;
    }

    public Double getPoint1CoordinateY() {
        return point1CoordinateY;
    }

    public Double getPoint2CoordinateX() {
        return point2CoordinateX;
    }

    public Double getPoint2CoordinateY() {
        return point2CoordinateY;
    }

    public void setPoint1CoordinateX(Double point1CoordinateX) {
        this.point1CoordinateX = point1CoordinateX;
    }

    public void setPoint1CoordinateY(Double point1CoordinateY) {
        this.point1CoordinateY = point1CoordinateY;
    }

    public void setPoint2CoordinateX(Double point2CoordinateX) {
        this.point2CoordinateX = point2CoordinateX;
    }

    public void setPoint2CoordinateY(Double point2CoordinateY) {
        this.point2CoordinateY = point2CoordinateY;
    }

    public static Function<DistanceRequest, List<Point>> dtoToEntityMapper() {
        return request -> List.of(
                new Point(request.point1CoordinateX, request.point1CoordinateY),
                new Point(request.point2CoordinateX, request.point2CoordinateY)
        );
    }

}
