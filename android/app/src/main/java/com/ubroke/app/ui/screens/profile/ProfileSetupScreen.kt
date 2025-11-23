package com.ubroke.app.ui.screens.profile

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.ubroke.app.data.model.EmploymentType
import com.ubroke.app.data.model.FinancialGoal
import com.ubroke.app.data.model.IncomeRange

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProfileSetupScreen(
    onComplete: (IncomeRange?, EmploymentType?, FinancialGoal?) -> Unit,
    onSkip: () -> Unit
) {
    var selectedIncome by remember { mutableStateOf<IncomeRange?>(null) }
    var selectedEmployment by remember { mutableStateOf<EmploymentType?>(null) }
    var selectedGoal by remember { mutableStateOf<FinancialGoal?>(null) }

    Scaffold { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(24.dp)
        ) {
            Column(
                modifier = Modifier
                    .weight(1f)
                    .verticalScroll(rememberScrollState())
            ) {
                Text(
                    text = "Quick Profile Setup",
                    style = MaterialTheme.typography.headlineMedium,
                    fontWeight = FontWeight.Bold
                )
                Text(
                    text = "Help us personalize your experience (optional)",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )

                Spacer(modifier = Modifier.height(32.dp))

                // Question 1: Income Range
                ProfileQuestion(
                    title = "How much do you make?",
                    options = IncomeRange.entries.map { it.display },
                    selectedOption = selectedIncome?.display,
                    onOptionSelected = { display ->
                        selectedIncome = IncomeRange.entries.find { it.display == display }
                    }
                )

                Spacer(modifier = Modifier.height(24.dp))

                // Question 2: Employment Type
                ProfileQuestion(
                    title = "What's your work type?",
                    options = EmploymentType.entries.map { it.display },
                    selectedOption = selectedEmployment?.display,
                    onOptionSelected = { display ->
                        selectedEmployment = EmploymentType.entries.find { it.display == display }
                    }
                )

                Spacer(modifier = Modifier.height(24.dp))

                // Question 3: Financial Goal
                ProfileQuestion(
                    title = "What's your main goal?",
                    options = FinancialGoal.entries.map { it.display },
                    selectedOption = selectedGoal?.display,
                    onOptionSelected = { display ->
                        selectedGoal = FinancialGoal.entries.find { it.display == display }
                    }
                )
            }

            // Buttons
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                OutlinedButton(
                    onClick = onSkip,
                    modifier = Modifier.weight(1f)
                ) {
                    Text("Skip")
                }
                Button(
                    onClick = { onComplete(selectedIncome, selectedEmployment, selectedGoal) },
                    modifier = Modifier.weight(1f)
                ) {
                    Text("Let's Start")
                }
            }
        }
    }
}

@Composable
private fun ProfileQuestion(
    title: String,
    options: List<String>,
    selectedOption: String?,
    onOptionSelected: (String) -> Unit
) {
    Column {
        Text(
            text = title,
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.SemiBold
        )
        Spacer(modifier = Modifier.height(12.dp))
        Column(
            modifier = Modifier.selectableGroup()
        ) {
            options.forEach { option ->
                val selected = option == selectedOption
                Surface(
                    modifier = Modifier
                        .fillMaxWidth()
                        .selectable(
                            selected = selected,
                            onClick = { onOptionSelected(option) },
                            role = Role.RadioButton
                        ),
                    shape = MaterialTheme.shapes.medium,
                    color = if (selected)
                        MaterialTheme.colorScheme.primaryContainer
                    else
                        MaterialTheme.colorScheme.surface,
                    border = ButtonDefaults.outlinedButtonBorder
                ) {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selected,
                            onClick = null
                        )
                        Spacer(modifier = Modifier.width(12.dp))
                        Text(
                            text = option,
                            style = MaterialTheme.typography.bodyLarge
                        )
                    }
                }
                Spacer(modifier = Modifier.height(8.dp))
            }
        }
    }
}
