package com.example.comm.service

import com.example.comm.entity.CommEntity
import com.example.comm.repo.CommRepository
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
@Transactional
class CommService(private val commRepository: CommRepository) {

    private fun CommEntity.toDto(): EventDto {
        return EventDto(
            userName = this.userName,
            id = this.id,
            event = this.event,
            dateTime = this.dateTime,
        )
    }

    fun postData(commEntity: CommEntity): EventDto {
        val data: CommEntity = commRepository.save(commEntity)
        return data.toDto()
    }

    fun putData(userName:String,value: Double): Int {
        val data = commRepository.setDataByUserName(userName = userName, value = value)
        return data
    }

    fun getData(userName: String): CommEntity {
        val data = commRepository.getDataByUserName(userName)
        return data
    }
}

data class EventDto(
    var id : Int,
    var userName:String,
    var dateTime: LocalDateTime,
    var event: Double
)