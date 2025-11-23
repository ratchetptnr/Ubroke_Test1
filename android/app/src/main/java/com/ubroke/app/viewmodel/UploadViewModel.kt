package com.ubroke.app.viewmodel

import android.content.Context
import android.net.Uri
import androidx.core.content.FileProvider
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ubroke.app.data.model.*
import com.ubroke.app.data.repository.UbrokeRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import java.io.File
import javax.inject.Inject

data class UploadUiState(
    val isLoading: Boolean = false,
    val isUploaded: Boolean = false,
    val error: String? = null,
    val progress: Int = 0
)

@HiltViewModel
class UploadViewModel @Inject constructor(
    private val repository: UbrokeRepository,
    @ApplicationContext private val context: Context
) : ViewModel() {

    private val _uiState = MutableStateFlow(UploadUiState())
    val uiState: StateFlow<UploadUiState> = _uiState.asStateFlow()

    private var tempImageUri: Uri? = null

    fun prepareCameraCapture(): Uri? {
        val photoFile = File(context.cacheDir, "temp_photo_${System.currentTimeMillis()}.jpg")
        tempImageUri = FileProvider.getUriForFile(
            context,
            "${context.packageName}.fileprovider",
            photoFile
        )
        return tempImageUri
    }

    fun processCameraCapture() {
        tempImageUri?.let { uri ->
            uploadDocument(uri)
        }
    }

    fun uploadDocument(uri: Uri) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(
                isLoading = true,
                error = null
            )

            try {
                // Validate file
                val mimeType = context.contentResolver.getType(uri)
                if (mimeType !in listOf("application/pdf", "image/jpeg", "image/png")) {
                    _uiState.value = _uiState.value.copy(
                        isLoading = false,
                        error = "File type not supported. Please use PDF, JPG, or PNG."
                    )
                    return@launch
                }

                // Get current user
                val user = repository.getCurrentUserSync() ?: run {
                    val newUser = User()
                    repository.createUser(newUser)
                    newUser
                }

                // Simulate parsing process
                delay(1500)

                // Create mock parsed document
                val document = createMockParsedDocument(user.id, uri.toString())
                repository.saveDocument(document)

                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    isUploaded = true
                )

            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    error = "Failed to process document: ${e.message}"
                )
            }
        }
    }

    private fun createMockParsedDocument(userId: String, filePath: String): UploadedDocument {
        val transactions = listOf(
            Transaction("1", "2024-01-28", 25000.0, "Landlord", ExpenseCategory.RENT_HOUSING, true),
            Transaction("2", "2024-01-27", 450.0, "Zomato", ExpenseCategory.FOOD_DELIVERY),
            Transaction("3", "2024-01-26", 280.0, "Swiggy", ExpenseCategory.FOOD_DELIVERY),
            Transaction("4", "2024-01-25", 520.0, "Zomato", ExpenseCategory.FOOD_DELIVERY),
            Transaction("5", "2024-01-24", 1200.0, "Restaurant", ExpenseCategory.FOOD_DELIVERY),
            Transaction("6", "2024-01-23", 380.0, "Zomato", ExpenseCategory.FOOD_DELIVERY),
            Transaction("7", "2024-01-22", 199.0, "Netflix", ExpenseCategory.SUBSCRIPTIONS, true),
            Transaction("8", "2024-01-21", 119.0, "Spotify", ExpenseCategory.SUBSCRIPTIONS, true),
            Transaction("9", "2024-01-20", 999.0, "Amazon Prime", ExpenseCategory.SUBSCRIPTIONS, true),
            Transaction("10", "2024-01-19", 1500.0, "Gym", ExpenseCategory.HEALTH_WELLNESS, true),
            Transaction("11", "2024-01-18", 2000.0, "Uber", ExpenseCategory.TRANSPORT),
            Transaction("12", "2024-01-17", 1500.0, "PVR", ExpenseCategory.ENTERTAINMENT),
            Transaction("13", "2024-01-16", 2700.0, "Gaming", ExpenseCategory.ENTERTAINMENT),
            Transaction("14", "2024-01-15", 2500.0, "Other", ExpenseCategory.OTHER)
        )

        val categoryTotals = mapOf(
            ExpenseCategory.RENT_HOUSING to 25000.0,
            ExpenseCategory.FOOD_DELIVERY to 8500.0,
            ExpenseCategory.ENTERTAINMENT to 4200.0,
            ExpenseCategory.SUBSCRIPTIONS to 3800.0,
            ExpenseCategory.TRANSPORT to 2000.0,
            ExpenseCategory.HEALTH_WELLNESS to 1500.0,
            ExpenseCategory.OTHER to 2500.0
        )

        val insights = listOf(
            "Your top spend: Rent (52%)",
            "Food delivery is 18% of your total spend - that's high!",
            "You have 6 recurring costs (subscriptions, gym, etc.)"
        )

        return UploadedDocument(
            userId = userId,
            filePath = filePath,
            originalFilename = "January_2024.pdf",
            fileType = "PDF",
            parseStatus = ParseStatus.COMPLETED,
            parseDurationMs = 1500,
            totalAmount = 47500.0,
            transactions = transactions,
            categoryTotals = categoryTotals,
            insights = insights
        )
    }
}
