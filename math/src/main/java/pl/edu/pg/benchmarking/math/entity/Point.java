package pl.edu.pg.benchmarking.math.entity;

public class Point {

    private Double latitude;
    private Double longitude;

    public Point(Double latitude, Double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    @Override
    public String toString() {
        return String.format("X: %f\tY:%f", this.latitude, this.longitude);
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

}
