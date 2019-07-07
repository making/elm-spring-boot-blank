package xxxxxx.yyyyyy.zzzzzz;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.reactive.server.WebTestClient;

class HelloControllerTest {

    private WebTestClient testClient;

    @BeforeAll
    void setUp() throws Exception {
        this.testClient = WebTestClient.bindToController(new HelloController())
            .build();
    }

    @Test
    void hello() throws Exception {
        this.testClient.get().uri("/") //
            .exchange() //
            .expectStatus().isOk() //
            .expectBody(String.class).isEqualTo("Hello World!");
    }
}