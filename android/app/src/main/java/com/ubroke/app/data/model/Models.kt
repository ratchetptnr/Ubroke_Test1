package com.ubroke.app.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import androidx.room.TypeConverters
import com.ubroke.app.data.local.database.Converters
import java.util.UUID

enum class IncomeRange(val display: String) {
    RANGE_0_2L("₹0-2 LPA"),
    RANGE_2_5L("₹2-5 LPA"),
    RANGE_5_10L("₹5-10 LPA"),
    RANGE_10_20L("₹10-20 LPA"),
    RANGE_20_PLUS("₹20+ LPA")
}

enum class EmploymentType(val display: String) {
    SALARIED("Salaried"),
    FREELANCER("Freelancer"),
    STUDENT("Student"),
    MULTIPLE("Multiple income sources")
}

enum class FinancialGoal(val display: String) {
    UNDERSTAND_SPENDING("Understand my spending"),
    SAVE_MORE("Save more money"),
    BETTER_DECISIONS("Make better financial decisions"),
    PLAN_SOMETHING("Plan for something specific")
}

enum class ParseStatus {
    PENDING,
    PROCESSING,
    COMPLETED,
    FAILED
}

enum class ExpenseCategory(val display: String, val emoji: String) {
    RENT_HOUSING("Rent & Housing", "🏠"),
    FOOD_DELIVERY("Food & Delivery", "🍕"),
    ENTERTAINMENT("Entertainment", "🎮"),
    SUBSCRIPTIONS("Subscriptions", "📱"),
    TRANSPORT("Transport", "🚗"),
    HEALTH_WELLNESS("Health & Wellness", "💊"),
    OTHER("Other", "📦")
}

@Entity(tableName = "users")
data class User(
    @PrimaryKey
    val id: String = UUID.randomUUID().toString(),
    val email: String? = null,
    val incomeRange: IncomeRange? = null,
    val employmentType: EmploymentType? = null,
    val primaryGoal: FinancialGoal? = null,
    val createdAt: Long = System.currentTimeMillis(),
    val updatedAt: Long = System.currentTimeMillis()
)

@Entity(tableName = "documents")
@TypeConverters(Converters::class)
data class UploadedDocument(
    @PrimaryKey
    val id: String = UUID.randomUUID().toString(),
    val userId: String,
    val filePath: String,
    val originalFilename: String,
    val fileType: String,
    val parseStatus: ParseStatus = ParseStatus.PENDING,
    val parseDurationMs: Long? = null,
    val totalAmount: Double? = null,
    val transactions: List<Transaction> = emptyList(),
    val categoryTotals: Map<ExpenseCategory, Double> = emptyMap(),
    val insights: List<String> = emptyList(),
    val createdAt: Long = System.currentTimeMillis(),
    val updatedAt: Long = System.currentTimeMillis()
)

data class Transaction(
    val id: String = UUID.randomUUID().toString(),
    val date: String,
    val amount: Double,
    val vendor: String,
    val category: ExpenseCategory,
    val isRecurring: Boolean = false
)

@Entity(tableName = "chat_messages")
data class ChatMessage(
    @PrimaryKey
    val id: String = UUID.randomUUID().toString(),
    val userId: String,
    val role: MessageRole,
    val content: String,
    val timestamp: Long = System.currentTimeMillis()
)

enum class MessageRole {
    USER,
    ASSISTANT
}

data class CategoryBreakdown(
    val category: ExpenseCategory,
    val amount: Double,
    val percentage: Float,
    val transactions: List<Transaction> = emptyList()
)

data class Insight(
    val message: String,
    val type: InsightType
)

enum class InsightType {
    INFO,
    WARNING,
    ALERT,
    SUCCESS
}
