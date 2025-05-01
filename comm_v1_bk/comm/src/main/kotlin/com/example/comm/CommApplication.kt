package com.example.comm

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class CommApplication

fun main(args: Array<String>) {
	runApplication<CommApplication>(*args)
}
