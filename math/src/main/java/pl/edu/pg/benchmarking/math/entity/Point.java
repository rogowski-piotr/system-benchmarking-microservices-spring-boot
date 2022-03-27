package pl.edu.pg.benchmarking.math.entity;

public class Point {

    private Double coordinateX;
    private Double coordinateY;

    public Point(Double coordinateX, Double coordinateY) {
        this.coordinateX = coordinateX;
        this.coordinateY = coordinateY;
    }

    @Override
    public String toString() {
        return String.format("X: %d\tY:%d", this.coordinateX, this.coordinateY);
    }

    public Double getCoordinateX() {
        return coordinateX;
    }

    public void setCoordinateX(Double coordinateX) {
        this.coordinateX = coordinateX;
    }

    public Double getCoordinateY() {
        return coordinateY;
    }

    public void setCoordinateY(Double coordinateY) {
        this.coordinateY = coordinateY;
    }

}
