package com.ubroke.app.data.local.database

import androidx.room.TypeConverter
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.ubroke.app.data.model.*

class Converters {
    private val gson = Gson()

    @TypeConverter
    fun fromIncomeRange(value: IncomeRange?): String? = value?.name

    @TypeConverter
    fun toIncomeRange(value: String?): IncomeRange? = value?.let { IncomeRange.valueOf(it) }

    @TypeConverter
    fun fromEmploymentType(value: EmploymentType?): String? = value?.name

    @TypeConverter
    fun toEmploymentType(value: String?): EmploymentType? = value?.let { EmploymentType.valueOf(it) }

    @TypeConverter
    fun fromFinancialGoal(value: FinancialGoal?): String? = value?.name

    @TypeConverter
    fun toFinancialGoal(value: String?): FinancialGoal? = value?.let { FinancialGoal.valueOf(it) }

    @TypeConverter
    fun fromParseStatus(value: ParseStatus): String = value.name

    @TypeConverter
    fun toParseStatus(value: String): ParseStatus = ParseStatus.valueOf(value)

    @TypeConverter
    fun fromMessageRole(value: MessageRole): String = value.name

    @TypeConverter
    fun toMessageRole(value: String): MessageRole = MessageRole.valueOf(value)

    @TypeConverter
    fun fromTransactionList(value: List<Transaction>): String = gson.toJson(value)

    @TypeConverter
    fun toTransactionList(value: String): List<Transaction> {
        val type = object : TypeToken<List<Transaction>>() {}.type
        return gson.fromJson(value, type) ?: emptyList()
    }

    @TypeConverter
    fun fromCategoryTotals(value: Map<ExpenseCategory, Double>): String = gson.toJson(value)

    @TypeConverter
    fun toCategoryTotals(value: String): Map<ExpenseCategory, Double> {
        val type = object : TypeToken<Map<ExpenseCategory, Double>>() {}.type
        return gson.fromJson(value, type) ?: emptyMap()
    }

    @TypeConverter
    fun fromStringList(value: List<String>): String = gson.toJson(value)

    @TypeConverter
    fun toStringList(value: String): List<String> {
        val type = object : TypeToken<List<String>>() {}.type
        return gson.fromJson(value, type) ?: emptyList()
    }
}
