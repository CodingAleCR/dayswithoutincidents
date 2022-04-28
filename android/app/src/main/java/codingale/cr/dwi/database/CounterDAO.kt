package codingale.cr.dwi.database

import androidx.room.Dao
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update

@Dao
interface CounterDAO {
    @Query("SELECT * FROM time_counters")
    suspend fun getAll(): List<CounterEntity>

    @Query("SELECT * FROM time_counters WHERE id = :counterId")
    suspend fun findById(counterId: String): CounterEntity

    @Update(onConflict = OnConflictStrategy.IGNORE)
    suspend fun update(counter: CounterEntity)
}