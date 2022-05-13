package codingale.cr.dwi.database.restarts

import androidx.room.*

@Dao
interface RestartsDAO {
    @Insert
    suspend fun insert(widget: CounterRestartEntity)
}