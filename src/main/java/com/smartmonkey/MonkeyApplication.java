package com.smartmonkey;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@EnableAutoConfiguration
@ComponentScan("com.smartmonkey")
public class MonkeyApplication {
    public static void main(String[] args) {
        SpringApplication.run(MonkeyApplication.class, args);
    }
}