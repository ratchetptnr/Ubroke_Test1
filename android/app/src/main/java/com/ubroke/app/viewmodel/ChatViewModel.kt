package com.ubroke.app.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ubroke.app.data.model.ChatMessage
import com.ubroke.app.data.model.MessageRole
import com.ubroke.app.data.repository.UbrokeRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

data class ChatUiState(
    val messages: List<ChatMessage> = emptyList(),
    val isLoading: Boolean = false
)

@HiltViewModel
class ChatViewModel @Inject constructor(
    private val repository: UbrokeRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(ChatUiState())
    val uiState: StateFlow<ChatUiState> = _uiState.asStateFlow()

    private var userId: String? = null

    init {
        loadChat()
    }

    private fun loadChat() {
        viewModelScope.launch {
            val user = repository.getCurrentUserSync()
            userId = user?.id

            if (user != null) {
                // Add welcome message if no messages exist
                repository.getChatMessages(user.id).collect { messages ->
                    if (messages.isEmpty()) {
                        val welcomeMessage = ChatMessage(
                            userId = user.id,
                            role = MessageRole.ASSISTANT,
                            content = "Hi! I've analyzed your January expenses. Your biggest spend is rent (52%), followed by food delivery (18%). Ask me anything about your money!"
                        )
                        repository.sendMessage(welcomeMessage)
                    }
                    _uiState.value = _uiState.value.copy(messages = messages)
                }
            }
        }
    }

    fun sendMessage(content: String) {
        val currentUserId = userId ?: return

        viewModelScope.launch {
            // Add user message
            val userMessage = ChatMessage(
                userId = currentUserId,
                role = MessageRole.USER,
                content = content
            )
            repository.sendMessage(userMessage)

            // Show loading
            _uiState.value = _uiState.value.copy(isLoading = true)

            // Simulate AI response delay
            delay(1500)

            // Get AI response
            val document = repository.getLatestDocument(currentUserId)
            val response = repository.getAIResponse(content, document)

            // Add AI message
            val aiMessage = ChatMessage(
                userId = currentUserId,
                role = MessageRole.ASSISTANT,
                content = response
            )
            repository.sendMessage(aiMessage)

            _uiState.value = _uiState.value.copy(isLoading = false)
        }
    }
}
