package codingale.cr.dwi

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.AsyncTask
import android.util.Log
import android.widget.RemoteViews
import androidx.room.Room
import codingale.cr.dwi.database.CounterEntity
import codingale.cr.dwi.database.DATABASE_NAME
import codingale.cr.dwi.database.DWIDatabase
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.TimeUnit
import java.util.logging.Logger

class CounterWidget : AppWidgetProvider() {
    companion object {
        const val RESET_ACTION = "codingale.cr.dwi.RESET_COUNTER"
        const val ISO_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        context?.let {
            if (intent?.action == RESET_ACTION) {
                val manager = AppWidgetManager.getInstance(context)

                val widgetId = intent.getIntExtra(
                    AppWidgetManager.EXTRA_APPWIDGET_ID,
                    AppWidgetManager.INVALID_APPWIDGET_ID
                )

                // Updates counter in storage
                val counter = getCounter(context)

                val now = Date()
                val formatter = SimpleDateFormat(ISO_FORMAT, Locale.US)

                if (counter != null) {
                    counter.createdAt = formatter.format(now)
                    updateCounter(context, counter)
                }

                // Updates widget
                updateAppWidget(context, manager, widgetId)
            }
        }
        super.onReceive(context, intent)
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }

    private fun updateAppWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int
    ) {
        // Default configuration
        val defaultTitle = context.getString(R.string.app_title)
        val now = Date()
        val formatter = SimpleDateFormat(ISO_FORMAT, Locale.US)

        // Set defaults
        var title = defaultTitle
        var incidentIsoString = formatter.format(now)
        val counter = getCounter(context)
        if (counter != null) {
            // Update with counter information or fallback to default.
            title = counter.title ?: title
            incidentIsoString = counter.createdAt ?: incidentIsoString
        }
        val incidentDate: Date? = formatter.parse(incidentIsoString)

        val diff: Long = now.time - incidentDate!!.time
        val days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS).toInt()

        val daysString = context.resources.getQuantityString(R.plurals.counter_text, days)

        // Construct the RemoteViews object
        val views = RemoteViews(context.packageName, R.layout.counter_widget)
        views.setTextViewText(R.id.appwidget_text, "$days $daysString")
        views.setTextViewText(R.id.appwidget_title, title)

        // Set button action
        val resetIntent = Intent(context, CounterWidget::class.java)
        resetIntent.action = RESET_ACTION
        resetIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
        resetIntent.data = Uri.parse(resetIntent.toUri(Intent.URI_INTENT_SCHEME))

        val pendingIntent =
            PendingIntent.getBroadcast(context, 0, resetIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        views.setOnClickPendingIntent(R.id.button, pendingIntent)

        // Instruct the widget manager to update the widget
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }

    private fun getCounter(context: Context): CounterEntity? = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.counterDao()
            val counters = dao.getAll()
            return@withContext counters.firstOrNull()
        }
    }

    private fun updateCounter(context: Context, counter: CounterEntity) = runBlocking {
        return@runBlocking withContext(Dispatchers.IO) {
            val db = DWIDatabase.getDatabase(context)
            val dao = db.counterDao()
            dao.update(counter)
        }
    }
}