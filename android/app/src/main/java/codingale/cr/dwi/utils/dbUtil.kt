package codingale.cr.dwi.utils

import android.content.Context
import codingale.cr.dwi.CounterWidget
import codingale.cr.dwi.database.DWIDatabase
import codingale.cr.dwi.database.counters.CounterEntity
import codingale.cr.dwi.database.restarts.CounterRestartEntity
import codingale.cr.dwi.database.widgets.WidgetEntity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import java.text.SimpleDateFormat
import java.util.*

object DbUtil {

    internal fun getAllCounters(context: Context): List<CounterEntity> =
        runBlocking {
            return@runBlocking withContext(Dispatchers.IO) {
                val db = DWIDatabase.getDatabase(context)
                val dao = db.counterDao()
                return@withContext dao.getAll()
            }
        }

    internal fun getCounterById(context: Context, counterId: String): CounterEntity? = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.counterDao()
            val counters = dao.findById(counterId)
            return@withContext counters.firstOrNull()
        }
    }

    internal fun restartCounter(context: Context, counter: CounterEntity) = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val restartDao = db.restartsDao()
            val dao = db.counterDao()
            val now = Date()
            val formatter = SimpleDateFormat(CounterWidget.ISO_FORMAT, Locale.US)

            // Create a new restart
            val newRestart = CounterRestartEntity(
                UUID.randomUUID().toString(),
                counter.id,
                counter.createdAt!!,
                formatter.format(now)
            )
            restartDao.insert(newRestart)

            // Update counter
            counter.createdAt = formatter.format(now)
            dao.update(counter)

            return@withContext
        }
    }

    internal fun getWidgetByWidgetId(context: Context, widgetId: String): WidgetEntity? = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.widgetDao()
            val widgets = dao.findByWidgetId(widgetId)
            return@withContext widgets.firstOrNull()
        }
    }

    internal fun insertWidget(context: Context, widget: WidgetEntity) = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.widgetDao()
            return@withContext dao.insert(widget)
        }
    }

    internal fun updateWidget(context: Context, widget: WidgetEntity) = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.widgetDao()
            return@withContext dao.update(widget)
        }
    }

    internal fun deleteWidget(context: Context, widgetId: String) = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.widgetDao()
            val widget = dao.findByWidgetId(widgetId).firstOrNull()
            if (widget != null) {
                dao.delete(widget)
            }
            return@withContext
        }
    }
}