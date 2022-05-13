package codingale.cr.dwi.database.widgets

import androidx.room.*

@Dao
interface WidgetDAO {
    @Query("SELECT * FROM counter_widgets WHERE id = :widgetId")
    suspend fun findById(widgetId: String): List<WidgetEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(widget: WidgetEntity)

    @Update(onConflict = OnConflictStrategy.REPLACE)
    suspend fun update(widget: WidgetEntity)

    @Delete
    suspend fun delete(widget: WidgetEntity)
}