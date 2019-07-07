package xxxxxx.yyyyyy.zzzzzz;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.util.UriComponentsBuilder;

import static org.springframework.http.HttpStatus.SEE_OTHER;

@Controller
public class WelcomeController {

    @GetMapping(path = "/")
    public ResponseEntity welcome(UriComponentsBuilder builder) {
        return ResponseEntity.status(SEE_OTHER)
            .location(builder.path("index.html").build().toUri())
            .build();
    }
}
