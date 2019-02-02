package codingale.cr.dwi.ui.main

import android.app.Application
import android.content.SharedPreferences
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.preference.PreferenceManager
import codingale.cr.dwi.R
import codingale.cr.dwi.datasource.LAST_INCIDENT
import codingale.cr.dwi.datasource.TITLE
import org.joda.time.DateTime

class MainViewModel(application: Application) : AndroidViewModel(application),
    SharedPreferences.OnSharedPreferenceChangeListener {

    private var mLastTitle: MutableLiveData<String> = MutableLiveData()
    private var mLastIncident: MutableLiveData<DateTime> = MutableLiveData()

    private val mSharedPreferences = PreferenceManager.getDefaultSharedPreferences(getApplication())

    init {
        mSharedPreferences.registerOnSharedPreferenceChangeListener(this)
    }

    override fun onSharedPreferenceChanged(sharedPreferences: SharedPreferences?, key: String?) {
        when (key) {
            TITLE -> {
                mLastTitle.postValue(mSharedPreferences.getString(TITLE, ""))
            }
            LAST_INCIDENT -> {
                mLastIncident.postValue(lastIncidentFromPreferences())
            }
        }
    }

    fun title(): LiveData<String> {
        val title = mSharedPreferences.getString(TITLE, getApplication<Application>().getString(R.string.app_name))

        mLastTitle.postValue(title)

        return mLastTitle
    }

    fun lastIncident(): LiveData<DateTime> {
        mLastIncident.postValue(lastIncidentFromPreferences())

        return mLastIncident
    }

    fun resetIncident() {
        val lastIncident = DateTime.now()
        mSharedPreferences.edit().putString(LAST_INCIDENT, lastIncident.toString()).apply()
    }

    private fun lastIncidentFromPreferences(): DateTime {
        val lastIncidentString = mSharedPreferences.getString(LAST_INCIDENT, "")

        var lastIncident = DateTime.now()
        if (!lastIncidentString.isNullOrEmpty()) {
            lastIncident = DateTime(lastIncidentString)
        } else {
            mSharedPreferences.edit().putString(LAST_INCIDENT, lastIncident.toString()).apply()
        }

        return lastIncident
    }


    override fun onCleared() {
        mSharedPreferences.unregisterOnSharedPreferenceChangeListener(this)
        super.onCleared()
    }
}
