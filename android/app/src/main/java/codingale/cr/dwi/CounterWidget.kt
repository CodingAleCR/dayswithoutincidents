package codingale.cr.dwi

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import android.widget.RemoteViews
import codingale.cr.dwi.utils.DbUtil
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.TimeUnit

class CounterWidget : AppWidgetProvider() {
    companion object {
        const val RESET_ACTION = "codingale.cr.dwi.RESET_COUNTER"
        const val ISO_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        internal fun deleteAppWidget(
            context: Context,
            appWidgetId: Int
        ) {
            try {
                DbUtil.deleteWidget(context, appWidgetId.toString())
            } catch (e: Exception) {
                Log.e("WIDGET-DWI", "updateAppWidget: $e")
            }
        }

        internal fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            try {
                // Default configuration
                val defaultTitle = context.getString(R.string.app_title)
                val now = Date()
                val formatter = SimpleDateFormat(ISO_FORMAT, Locale.US)

                val widget = DbUtil.getWidgetById(context, appWidgetId.toString())
                val counter = if (widget != null) {
                    DbUtil.getCounterById(context, widget.counterId)
                } else {
                    DbUtil.getAllCounters(context).firstOrNull()
                }

                // Set defaults
                var title = defaultTitle
                var incidentIsoString = formatter.format(now)
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

                val pendingFlags: Int = when {
                    Build.VERSION.SDK_INT >= Build.VERSION_CODES.M -> PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                    else -> PendingIntent.FLAG_UPDATE_CURRENT
                }
                val pendingIntent =
                    PendingIntent.getBroadcast(
                        context,
                        0,
                        resetIntent,
                        pendingFlags,
                    )
                views.setOnClickPendingIntent(R.id.button, pendingIntent)

                // Instruct the widget manager to update the widget
                appWidgetManager.updateAppWidget(appWidgetId, views)
            } catch (e: Exception) {
                Log.e("WIDGET-DWI", "updateAppWidget: $e")
            }
        }
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null) {
            super.onReceive(context, intent)
            return
        }

        if (intent?.action == RESET_ACTION) {
            val manager = AppWidgetManager.getInstance(context)

            val widgetId = intent.getIntExtra(
                AppWidgetManager.EXTRA_APPWIDGET_ID,
                AppWidgetManager.INVALID_APPWIDGET_ID
            )

            // Updates counter in storage
            val counter = DbUtil.getAllCounters(context).firstOrNull()

            if (counter != null) {
                DbUtil.restartCounter(context, counter)
            }

            // Updates widget
            updateAppWidget(context, manager, widgetId)
        }

        super.onReceive(context, intent)
    }

    override fun onDeleted(context: Context?, appWidgetIds: IntArray?) {
        if (appWidgetIds == null || context == null) {
            super.onDeleted(context, appWidgetIds)
            return
        }

        for (appWidgetId in appWidgetIds) {
            deleteAppWidget(context, appWidgetId)
        }

        super.onDeleted(context, appWidgetIds)
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
        super.onEnabled(context)
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
        super.onDisabled(context)
    }
}