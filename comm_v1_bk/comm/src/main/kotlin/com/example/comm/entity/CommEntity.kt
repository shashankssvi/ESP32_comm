package com.example.comm.entity


import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "event")
 data class CommEntity (

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Int,
    @Column(name = "user_name")
    val userName: String,
    @Column(name = "date_time")
    val dateTime: LocalDateTime = LocalDateTime.now(),
    @Column(name = "event")
    val event : Double
)