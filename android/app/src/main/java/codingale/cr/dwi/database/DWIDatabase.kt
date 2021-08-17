package codingale.cr.dwi.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = [CounterEntity::class], version = 1)
abstract class DWIDatabase : RoomDatabase() {
    abstract fun counterDao(): CounterDAO

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