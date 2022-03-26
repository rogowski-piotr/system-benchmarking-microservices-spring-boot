package pl.edu.pg.benchmarking.place;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@Repository
public class PlaceRepository {

    private final Logger LOG = Logger.getLogger(this.getClass().getName());

    private List<Place> places;

    public List<Place> getPlaces() {
        return places;
    }

    public Optional<Place> findById(Integer id) {
        return places.stream().filter(place -> place.getId().equals(id)).findFirst();
    }

    @PostConstruct
    public void postConstruct() {
        try {
            Reader reader = Files.newBufferedReader(Paths.get("coordinates.json"));
            places = new Gson().fromJson(reader, new TypeToken<List<Place>>() {}.getType());
            reader.close();

        } catch (Exception ex) {
            LOG.severe("Can not read json file with cities coordinates");
        }
    }

}
