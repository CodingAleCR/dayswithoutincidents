package codingale.cr.dwi.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import codingale.cr.dwi.database.counters.CounterDAO
import codingale.cr.dwi.database.counters.CounterEntity
import codingale.cr.dwi.database.restarts.CounterRestartEntity
import codingale.cr.dwi.database.restarts.RestartsDAO
import codingale.cr.dwi.database.widgets.WidgetDAO
import codingale.cr.dwi.database.widgets.WidgetEntity

@Database(
    entities = [CounterEntity::class, CounterRestartEntity::class, WidgetEntity::class],
    version = 3
)
abstract class DWIDatabase : RoomDatabase() {
    abstract fun counterDao(): CounterDAO
    abstract fun widgetDao(): WidgetDAO
    abstract fun restartsDao(): RestartsDAO

    companion object {
        // Singleton prevents multiple instances of database opening at the
        // same time.
        @Volatile
        private var INSTANCE: DWIDatabase? = null

        fun getDatabase(context: Context): DWIDatabase {
            // if the INSTANCE is not null, then return it,
            // if it is, then create the database
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    DWIDatabase::class.java,
                    DATABASE_NAME
                )
                    .enableMultiInstanceInvalidation()
                    .build()
                INSTANCE = instance
                // return instance
                instance
            }
        }
    }
}