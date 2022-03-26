package pl.edu.pg.benchmarking.place;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.logging.Logger;

@RestController
@RequestMapping("api/places")
public class PlaceController {

    private final Logger LOG = Logger.getLogger(this.getClass().getName());

    private PlaceRepository placeRepository;

    @Autowired
    public PlaceController(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    @GetMapping
    public ResponseEntity<Iterable<Place>> getAllPlaces() {
        LOG.info("GET all");
        List<Place> resultList = placeRepository.getPlaces();
        return resultList.isEmpty()
                ? ResponseEntity.noContent().build()
                : ResponseEntity.ok(resultList);
    }

}
