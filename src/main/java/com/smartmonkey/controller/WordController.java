package com.smartmonkey.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/world")
public class WordController {


    @GetMapping("/hello")
    public String hello() {
        return "hello";
    }
}
