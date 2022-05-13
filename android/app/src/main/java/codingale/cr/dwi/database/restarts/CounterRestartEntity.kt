package codingale.cr.dwi.database.restarts

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey
import codingale.cr.dwi.database.counters.CounterEntity

@Entity(
    tableName = "counter_restarts", foreignKeys = [ForeignKey(
        entity = CounterEntity::class,
        parentColumns = ["id"],
        childColumns = ["counter_id"],
        onDelete = ForeignKey.CASCADE, onUpdate = ForeignKey.CASCADE
    )]
)
data class CounterRestartEntity(
    @PrimaryKey @ColumnInfo(name = "id") val id: String,
    @ColumnInfo(name = "counter_id") var counterId: String,
    @ColumnInfo(name = "started_at") var startedAt: String,
    @ColumnInfo(name = "restarted_at") var restartedAt: String,
)