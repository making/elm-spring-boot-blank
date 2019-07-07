package xxxxxx.yyyyyy.zzzzzz;

import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import java.util.concurrent.atomic.AtomicLong;

@Component
public class GreetingHandler {

    private static final String template = "Hello, %s!";

    private final AtomicLong counter = new AtomicLong();

    public RouterFunction<ServerResponse> routes() {
        return RouterFunctions.route()
            .GET("/greeting", this::greeting)
            .build();
    }

    public Mono<ServerResponse> greeting(ServerRequest req) {
        final String name = req.queryParam("name").orElse("World");
        return ServerResponse.ok().syncBody(new Greeting(counter.incrementAndGet(),
            String.format(template, name)));
    }
}