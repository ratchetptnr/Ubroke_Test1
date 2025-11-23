package com.ubroke.app.data.repository

import com.ubroke.app.data.local.dao.ChatDao
import com.ubroke.app.data.local.dao.DocumentDao
import com.ubroke.app.data.local.dao.UserDao
import com.ubroke.app.data.model.*
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UbrokeRepository @Inject constructor(
    private val userDao: UserDao,
    private val documentDao: DocumentDao,
    private val chatDao: ChatDao
) {
    // User operations
    fun getCurrentUser(): Flow<User?> = userDao.getCurrentUser()

    suspend fun getCurrentUserSync(): User? = userDao.getCurrentUserSync()

    suspend fun createUser(user: User) = userDao.insertUser(user)

    suspend fun updateUser(user: User) = userDao.updateUser(user)

    // Document operations
    fun getDocuments(userId: String): Flow<List<UploadedDocument>> =
        documentDao.getDocumentsByUser(userId)

    suspend fun getLatestDocument(userId: String): UploadedDocument? =
        documentDao.getLatestDocument(userId)

    suspend fun saveDocument(document: UploadedDocument) =
        documentDao.insertDocument(document)

    suspend fun updateDocument(document: UploadedDocument) =
        documentDao.updateDocument(document)

    // Chat operations
    fun getChatMessages(userId: String): Flow<List<ChatMessage>> =
        chatDao.getMessagesByUser(userId)

    suspend fun sendMessage(message: ChatMessage) =
        chatDao.insertMessage(message)

    suspend fun clearChat(userId: String) =
        chatDao.clearChatHistory(userId)

    // Mock AI response for demo
    suspend fun getAIResponse(userMessage: String, context: UploadedDocument?): String {
        // This would be replaced with actual API call to AI service
        return when {
            userMessage.contains("food", ignoreCase = true) ->
                "Based on your documents, I can see your food and delivery spending. " +
                "You've spent a significant portion on food delivery services. " +
                "Consider reducing orders to save more each month."

            userMessage.contains("save", ignoreCase = true) ->
                "Looking at your expense breakdown, I can suggest a few ways to save. " +
                "Your subscriptions and food delivery are areas where small cuts can add up."

            userMessage.contains("afford", ignoreCase = true) ->
                "Let me analyze your income and expenses to give you a better picture " +
                "of what you can comfortably afford."

            else ->
                "I've analyzed your financial documents. Feel free to ask me about " +
                "specific categories like food spending, subscriptions, or how to save more."
        }
    }
}
