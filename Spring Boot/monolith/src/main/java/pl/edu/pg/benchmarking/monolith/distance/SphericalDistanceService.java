package pl.edu.pg.benchmarking.monolith.distance;

import org.springframework.stereotype.Service;

@Service
public class SphericalDistanceService {

    public double calculateDistanceBetweenPoints(Point point1, Point point2) {
        return calculateDistance(
                point1.getLatitude(), point1.getLongitude(),
                point2.getLatitude(), point2.getLongitude());
    }

    private double calculateDistance(double latitude1, double longitude1, double latitude2, double longitude2) {
        return Math.acos(
                Math.sin(Math.toRadians(latitude1)) * Math.sin(Math.toRadians(latitude2))
                        + Math.cos(Math.toRadians(latitude1)) * Math.cos(Math.toRadians(latitude2)) * Math.cos(Math.toRadians(longitude1 - longitude2))
        ) * 6371;
    }
}