package codingale.cr.dwi

import android.annotation.SuppressLint
import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import codingale.cr.dwi.database.counters.CounterEntity
import codingale.cr.dwi.database.widgets.WidgetEntity
import codingale.cr.dwi.databinding.ActivityWidgetConfigurationBinding
import codingale.cr.dwi.utils.DbUtil
import kotlinx.android.synthetic.main.activity_widget_configuration.*
import java.util.*

class WidgetConfigurationActivity : AppCompatActivity(), CustomAdapter.ClickListener {

    var appWidgetId = AppWidgetManager.INVALID_APPWIDGET_ID
    lateinit var counters: List<CounterEntity>

    @SuppressLint("NotifyDataSetChanged")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setResult(Activity.RESULT_CANCELED)

        val binding = ActivityWidgetConfigurationBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Find the widget id from the intent.
        appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        // If this activity was started with an intent without an app widget ID, finish with an error.
        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        // Setup UI & Counter list.
        counters = DbUtil.getAllCounters(this)
        val adapter = CustomAdapter(counters, this)
        rv_counters.layoutManager = LinearLayoutManager(this)
        rv_counters.adapter = adapter
    }

    override fun onItemClick(position: Int, v: View?) {
        try {
            Log.d("TAG", "clicked: $position")
            val selectedCounter = counters[position]
            Log.d("TAG", "selected: $selectedCounter")
            val currentWidget = DbUtil.getWidgetByWidgetId(this, appWidgetId.toString())

            if (currentWidget == null) {
                val newWidget =
                    WidgetEntity(
                        UUID.randomUUID().toString(),
                        selectedCounter.id,
                        appWidgetId.toString()
                    )
                Log.d("TAG", "onItemClick: $newWidget")
                DbUtil.insertWidget(
                    this,
                    newWidget
                )
            } else {
                currentWidget.counterId = selectedCounter.id

                DbUtil.updateWidget(this, currentWidget)
            }

            // It is the responsibility of the configuration activity to update the app widget
            val appWidgetManager = AppWidgetManager.getInstance(this)
            CounterWidget.updateAppWidget(this, appWidgetManager, appWidgetId)

            // Make sure we pass back the original appWidgetId
            val resultValue = Intent()
            resultValue.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
            setResult(RESULT_OK, resultValue)
            finish()
        } catch (e: Exception) {
            Log.e("WIDGET-DWI", "updateAppWidget: $e")
        }
    }
}

class CustomAdapter(
    private val dataSet: List<CounterEntity>,
    private val onClickListener: ClickListener?
) :
    RecyclerView.Adapter<CustomAdapter.ViewHolder>() {

    /**
     * Provide a reference to the type of views that you are using
     * (custom ViewHolder).
     */
    class ViewHolder(view: View) : RecyclerView.ViewHolder(view), View.OnClickListener {
        val textView: TextView
        var onItemSelected: ClickListener? = null

        init {
            // Define click listener for the ViewHolder's View.
            textView = view.findViewById(android.R.id.text1)
            itemView.setOnClickListener(this)
        }

        override fun onClick(v: View?) {
            onItemSelected?.onItemClick(adapterPosition, v)
        }
    }

    // Create new views (invoked by the layout manager)
    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): ViewHolder {
        // Create a new view, which defines the UI of the list item
        val view = LayoutInflater.from(viewGroup.context)
            .inflate(android.R.layout.simple_list_item_2, viewGroup, false)

        return ViewHolder(view)
    }

    // Replace the contents of a view (invoked by the layout manager)
    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {

        // Get element from your dataset at this position and replace the
        // contents of the view with that element
        viewHolder.textView.text = dataSet[position].title
        viewHolder.onItemSelected = onClickListener
    }

    // Return the size of your dataset (invoked by the layout manager)
    override fun getItemCount() = dataSet.size

    interface ClickListener {
        fun onItemClick(position: Int, v: View?)
    }
}

