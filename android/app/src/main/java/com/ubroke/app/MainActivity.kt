package com.ubroke.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.lifecycle.lifecycleScope
import androidx.navigation.compose.rememberNavController
import com.ubroke.app.data.model.User
import com.ubroke.app.data.repository.UbrokeRepository
import com.ubroke.app.ui.navigation.UbrokeNavGraph
import com.ubroke.app.ui.theme.UbrokeTheme
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject

@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    @Inject
    lateinit var repository: UbrokeRepository

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        setContent {
            UbrokeTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()

                    UbrokeNavGraph(
                        navController = navController,
                        onProfileComplete = { income, employment, goal ->
                            lifecycleScope.launch {
                                val existingUser = repository.getCurrentUserSync()
                                if (existingUser != null) {
                                    repository.updateUser(
                                        existingUser.copy(
                                            incomeRange = income,
                                            employmentType = employment,
                                            primaryGoal = goal,
                                            updatedAt = System.currentTimeMillis()
                                        )
                                    )
                                } else {
                                    repository.createUser(
                                        User(
                                            incomeRange = income,
                                            employmentType = employment,
                                            primaryGoal = goal
                                        )
                                    )
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}
