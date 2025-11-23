package com.ubroke.app.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.ubroke.app.data.model.EmploymentType
import com.ubroke.app.data.model.FinancialGoal
import com.ubroke.app.data.model.IncomeRange
import com.ubroke.app.ui.screens.chat.ChatScreen
import com.ubroke.app.ui.screens.profile.ProfileSetupScreen
import com.ubroke.app.ui.screens.results.ResultsScreen
import com.ubroke.app.ui.screens.upload.UploadScreen
import com.ubroke.app.ui.screens.welcome.WelcomeScreen

sealed class Screen(val route: String) {
    data object Welcome : Screen("welcome")
    data object ProfileSetup : Screen("profile_setup")
    data object Upload : Screen("upload")
    data object Results : Screen("results")
    data object Chat : Screen("chat")
}

@Composable
fun UbrokeNavGraph(
    navController: NavHostController,
    startDestination: String = Screen.Welcome.route,
    onProfileComplete: (IncomeRange?, EmploymentType?, FinancialGoal?) -> Unit
) {
    NavHost(
        navController = navController,
        startDestination = startDestination
    ) {
        composable(Screen.Welcome.route) {
            WelcomeScreen(
                onContinue = {
                    navController.navigate(Screen.ProfileSetup.route)
                }
            )
        }

        composable(Screen.ProfileSetup.route) {
            ProfileSetupScreen(
                onComplete = { income, employment, goal ->
                    onProfileComplete(income, employment, goal)
                    navController.navigate(Screen.Upload.route) {
                        popUpTo(Screen.Welcome.route) { inclusive = true }
                    }
                },
                onSkip = {
                    navController.navigate(Screen.Upload.route) {
                        popUpTo(Screen.Welcome.route) { inclusive = true }
                    }
                }
            )
        }

        composable(Screen.Upload.route) {
            UploadScreen(
                onDocumentUploaded = {
                    navController.navigate(Screen.Results.route) {
                        popUpTo(Screen.Upload.route) { inclusive = true }
                    }
                }
            )
        }

        composable(Screen.Results.route) {
            ResultsScreen(
                onAskAI = {
                    navController.navigate(Screen.Chat.route)
                },
                onUploadMore = {
                    navController.navigate(Screen.Upload.route)
                }
            )
        }

        composable(Screen.Chat.route) {
            ChatScreen(
                onBack = {
                    navController.popBackStack()
                }
            )
        }
    }
}
