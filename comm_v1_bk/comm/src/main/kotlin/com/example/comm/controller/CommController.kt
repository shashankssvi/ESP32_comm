package com.example.comm.controller

import com.example.comm.entity.CommEntity
import com.example.comm.service.CommService
import com.example.comm.service.EventDto
import org.hibernate.mapping.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/meravajan")
class CommController(private var commService: CommService) {

    @GetMapping("/get/{userName}")
    fun getData(@PathVariable userName: String): CommEntity {
        return commService.getData(userName)
    }

    @PostMapping("/add")
    fun postData(@RequestBody requestBody: CommEntity): EventDto {
        return commService.postData(requestBody)
    }

    @PutMapping("/{userName}/{value}")
    fun putData(@PathVariable value: Double,@PathVariable userName: String): Int {
        return commService.putData(userName,value)
    }
}