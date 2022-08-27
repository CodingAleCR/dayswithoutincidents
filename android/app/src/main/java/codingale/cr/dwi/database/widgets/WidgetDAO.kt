package codingale.cr.dwi.database.widgets

import androidx.room.*

@Dao
interface WidgetDAO {
    @Query("SELECT * FROM counter_widgets WHERE id = :id")
    suspend fun findById(id: String): List<WidgetEntity>

    @Query("SELECT * FROM counter_widgets WHERE widget_id = :widgetId")
    suspend fun findByWidgetId(widgetId: String): List<WidgetEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(widget: WidgetEntity)

    @Update(onConflict = OnConflictStrategy.REPLACE)
    suspend fun update(widget: WidgetEntity)

    @Delete
    suspend fun delete(widget: WidgetEntity)
}