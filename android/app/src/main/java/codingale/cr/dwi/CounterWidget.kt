package codingale.cr.dwi

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.TimeUnit

class CounterWidget : AppWidgetProvider() {
    companion object {
        const val SHARED_PREFERENCES_NAME = "FlutterSharedPreferences"
        const val PREFIX = "flutter"
        const val TITLE = "title"
        const val LAST_INCIDENT = "last_incident"
        const val RESET_ACTION = "codingale.cr.dwi.RESET_COUNTER"
        const val ISO_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        val manager = AppWidgetManager.getInstance(context)
        context?.let {
            if (intent?.action == RESET_ACTION) {
                val widgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
                val prefs = context.getSharedPreferences(SHARED_PREFERENCES_NAME, 0)
                val editor = prefs.edit()
                val now = Date()
                val formatter = SimpleDateFormat(ISO_FORMAT, Locale.US)

                editor.putString("$PREFIX.$LAST_INCIDENT", formatter.format(now))
                editor.apply()

                updateAppWidget(context, manager, widgetId)
            }
        }
        super.onReceive(context, intent)
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
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

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val prefs = context.getSharedPreferences(SHARED_PREFERENCES_NAME, 0)
        val defaultTitle = context.getString(R.string.app_title)
        val now = Date()
        val formatter = SimpleDateFormat(ISO_FORMAT, Locale.US)

        val title = prefs.getString("$PREFIX.$TITLE", defaultTitle)
        val incidentIsoString = prefs.getString("$PREFIX.$LAST_INCIDENT", formatter.format(now))
        val incidentDate = formatter.parse(incidentIsoString)

        val diff: Long = now.time - incidentDate.time
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

        val pendingIntent = PendingIntent.getBroadcast(context, 0, resetIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        views.setOnClickPendingIntent(R.id.button, pendingIntent)

        // Instruct the widget manager to update the widget
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}