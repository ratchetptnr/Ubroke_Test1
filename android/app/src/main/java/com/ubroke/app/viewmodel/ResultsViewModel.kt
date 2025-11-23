package com.ubroke.app.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ubroke.app.data.model.CategoryBreakdown
import com.ubroke.app.data.model.ExpenseCategory
import com.ubroke.app.data.repository.UbrokeRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import java.text.NumberFormat
import java.util.Locale
import javax.inject.Inject

data class ResultsUiState(
    val totalAmount: Double = 0.0,
    val totalFormatted: String = "₹0",
    val documentDate: String = "",
    val categories: List<CategoryBreakdown> = emptyList(),
    val insights: List<String> = emptyList(),
    val isLoading: Boolean = true
)

@HiltViewModel
class ResultsViewModel @Inject constructor(
    private val repository: UbrokeRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(ResultsUiState())
    val uiState: StateFlow<ResultsUiState> = _uiState.asStateFlow()

    init {
        loadResults()
    }

    private fun loadResults() {
        viewModelScope.launch {
            try {
                val user = repository.getCurrentUserSync()
                if (user != null) {
                    val document = repository.getLatestDocument(user.id)
                    if (document != null) {
                        val total = document.totalAmount ?: 0.0
                        val categories = document.categoryTotals.map { (category, amount) ->
                            CategoryBreakdown(
                                category = category,
                                amount = amount,
                                percentage = ((amount / total) * 100).toFloat(),
                                transactions = document.transactions.filter { it.category == category }
                            )
                        }.sortedByDescending { it.amount }

                        _uiState.value = ResultsUiState(
                            totalAmount = total,
                            totalFormatted = formatCurrency(total),
                            documentDate = "January 2024",
                            categories = categories,
                            insights = document.insights,
                            isLoading = false
                        )
                    }
                }
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(isLoading = false)
            }
        }
    }

    private fun formatCurrency(amount: Double): String {
        val format = NumberFormat.getCurrencyInstance(Locale("en", "IN"))
        return format.format(amount).replace(".00", "")
    }
}
