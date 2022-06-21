package pl.edu.pg.benchmarking.distance;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import pl.edu.pg.benchmarking.distance.dto.DistanceRequest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class DistanceServiceApplicationTests {

	@Autowired
	private TestRestTemplate template;

	@Test
	public void checkPostDistanceEndpoint() {
		DistanceRequest requestObject = new DistanceRequest();
		requestObject.setCoordinate1("54.367, 18.633");
		requestObject.setCoordinate2("50.05, 19.95");

		ResponseEntity<String> result = template.postForEntity("/api/distance", requestObject, String.class);

		assertEquals(HttpStatus.OK, result.getStatusCode());
		assertEquals(result.getBody(), "{\"distance\":488.3210410490973}");
	}

}
