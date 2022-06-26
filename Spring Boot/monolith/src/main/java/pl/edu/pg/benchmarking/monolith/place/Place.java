package pl.edu.pg.benchmarking.monolith.place;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import pl.edu.pg.benchmarking.monolith.distance.Point;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Getter
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class Place {

    private Integer id;

    private String city;

    private String coordinates;

    public Point getPoint() {
        Pattern pattern = Pattern.compile("(?<latitude>\\d+\\.?\\d*),\\s{1}(?<longitude>\\d+\\.?\\d*)");
        Matcher matcher = pattern.matcher(this.coordinates);
        matcher.find();
        Double latitude = Double.valueOf(matcher.group("latitude"));
        Double longitude = Double.valueOf(matcher.group("longitude"));
        return new Point(latitude, longitude);
    }

}