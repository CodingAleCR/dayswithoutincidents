package codingale.cr.dwi.database.counters

import androidx.room.Dao
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update

@Dao
interface CounterDAO {
    @Query("SELECT * FROM time_counters")
    suspend fun getAll(): List<CounterEntity>

    @Query("SELECT * FROM time_counters WHERE id = :counterId")
    suspend fun findById(counterId: String): List<CounterEntity>

    @Update(onConflict = OnConflictStrategy.REPLACE)
    suspend fun update(counter: CounterEntity)
}