package codingale.cr.dwi.ui.main

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import codingale.cr.dwi.R
import codingale.cr.dwi.SettingsActivity
import kotlinx.android.synthetic.main.fragment_main.*
import org.joda.time.DateTime
import org.joda.time.Days

class MainFragment : Fragment() {

    companion object {
        fun newInstance() = MainFragment()
    }

    private lateinit var viewModel: MainViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return inflater.inflate(R.layout.fragment_main, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)

        viewModel.lastIncident().observe(this, Observer {
            val days = Days.daysBetween(it.toLocalDate(), DateTime.now().toLocalDate()).days
            field_dwi.text = String.format(getString(R.string.days), days)
        })

        viewModel.title().observe(this, Observer {
            label_title.text = it
        })
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        btn_reset.setOnClickListener { resetIncidents() }

        btn_settings.setOnClickListener { toSettings() }
    }

    private fun toSettings() {
        val intent = Intent(context, SettingsActivity::class.java)
        startActivity(intent)
    }

    private fun resetIncidents() {
        viewModel.resetIncident()
    }

}
