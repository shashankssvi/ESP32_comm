package com.example.comm.repo

import com.example.comm.entity.CommEntity
import jakarta.transaction.Transactional
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param

interface CommRepository : JpaRepository<CommEntity,Int>{

    @Modifying
    @Transactional
    @Query("update CommEntity e set e.event =:value where e.userName =:userName")
    fun setDataByUserName(@Param("userName") userName:String,@Param("value") value: Double): Int

    @Query("select e from CommEntity e where e.userName =:userName")
    fun getDataByUserName(@Param("userName") userName:String): CommEntity
}