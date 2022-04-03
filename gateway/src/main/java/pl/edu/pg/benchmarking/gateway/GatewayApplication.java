package pl.edu.pg.benchmarking.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class GatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(GatewayApplication.class, args);
	}

	@Bean
	public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
		return builder.routes()
				.route("places", r -> r.host("localhost:8080")
						.and().path("/api/places", "/api/places/{id}")
						.uri("http://localhost:8081"))

				.route("distance", r -> r.host("localhost:8080")
						.and().path("/api/distance")
						.uri("http://localhost:8082"))

				.route("route1", r -> r.host("localhost:8080")
						.and().path("/api/route1")
						.uri("http://localhost:8083"))

				.route("route2", r -> r.host("localhost:8080")
						.and().path("/api/route2")
						.uri("http://localhost:8084"))
				.build();
	}

}