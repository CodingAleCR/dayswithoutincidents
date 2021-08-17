package codingale.cr.dwi.database

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "time_counters")
data class CounterEntity (
    @PrimaryKey val id: String,
    @ColumnInfo(name = "title") var title: String?,
    @ColumnInfo(name = "created_at") var createdAt: String?
)