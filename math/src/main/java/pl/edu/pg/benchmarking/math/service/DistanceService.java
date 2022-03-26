package pl.edu.pg.benchmarking.math.service;

import org.springframework.stereotype.Service;

@Service
public class DistanceService {

    public double calculateDistance(double x1, double y1, double x2, double y2) {
        return Math.sqrt(Math.pow(Math.abs(x1 - x2), 2)
                + Math.pow(Math.abs(y1 - y2), 2));
    }

}
