import SwiftUI

struct ChatView: View {
    let threadTitle: String?
    let isNewChat: Bool
    let onCreateThread: (String, String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @State private var hasCreatedThread = false

    let suggestedQuestions = [
        "Can I afford a ₹5k laptop?",
        "Should I cut any subscriptions?",
        "How much can I save?",
        "Why is my food delivery so high?"
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Messages
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        // Header
                        VStack(spacing: 8) {
                            Text("💬 Ask Me Anything About")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Your Money")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding(.top, 24)

                        // Empty state for new chat
                        if messages.isEmpty {
                            VStack(spacing: 12) {
                                Text("Start a conversation")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Ask me about your expenses, budgets, or financial goals")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                            .padding(.top, 40)
                        }

                        // Messages
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }

                        // Suggested questions (only show if no messages or just AI greeting)
                        if messages.isEmpty || (messages.count == 1 && !messages[0].isUser) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("💡 Suggested questions:")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)

                                ForEach(suggestedQuestions, id: \.self) { question in
                                    Button(action: {
                                        sendMessage(question)
                                    }) {
                                        Text(question)
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.ultraThinMaterial)
                                            )
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 8)
                        }

                        Spacer()
                            .frame(height: 100)
                    }
                }
                .onChange(of: messages.count) {
                    if let lastMessage = messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            .background(
                LinearGradient(
                    colors: [Color.blue.opacity(0.05), Color.white],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            // Input area
            VStack(spacing: 0) {
                Divider()

                HStack(spacing: 12) {
                    TextField("Type your question...", text: $messageText)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.1))
                        )

                    Button(action: {
                        sendMessage(messageText)
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(messageText.isEmpty ? .gray : .blue)
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
                .background(.ultraThinMaterial)
            }
        }
        .navigationTitle(threadTitle ?? "New Chat")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            // For existing threads, add the initial AI greeting
            if !isNewChat && messages.isEmpty {
                messages.append(ChatMessage(
                    text: "Hi! I've analyzed your January expenses. Your biggest spend is rent (52%), followed by food delivery (18%). Ask me anything about your money!",
                    isUser: false
                ))
            }
        }
    }

    func sendMessage(_ text: String) {
        guard !text.isEmpty else { return }

        // Add user message
        messages.append(ChatMessage(text: text, isUser: true))
        let userMessageText = text
        messageText = ""

        // Create thread if this is the first message in a new chat
        if isNewChat && !hasCreatedThread {
            hasCreatedThread = true
            let threadTitle = generateThreadTitle(from: userMessageText)
            onCreateThread(threadTitle, userMessageText)
        }

        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let response = """
            You spent ₹8,500 on food delivery this month (18% of total). That's higher than the 8-12% most people spend. You had 40 orders total.

            If you cut to 15 orders/month, you'd save ~₹5,000. That's ₹60k/year — enough for a vacation!

            Want tips on how?
            """
            messages.append(ChatMessage(text: response, isUser: false))
        }
    }

    func generateThreadTitle(from message: String) -> String {
        // Simple title generation based on keywords
        let lowercased = message.lowercased()

        if lowercased.contains("laptop") || lowercased.contains("afford") {
            return "Can I afford a laptop?"
        } else if lowercased.contains("subscription") {
            return "Subscription review"
        } else if lowercased.contains("save") || lowercased.contains("saving") {
            return "Savings plan"
        } else if lowercased.contains("food") || lowercased.contains("delivery") {
            return "Food delivery spending"
        } else if lowercased.contains("budget") {
            return "Budget planning"
        } else {
            // Default: use first few words of the message
            let words = message.split(separator: " ").prefix(4)
            return words.joined(separator: " ")
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser { Spacer(minLength: 60) }

            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                Text(message.isUser ? "You" : "Assistant")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                Text(message.text)
                    .font(.body)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(message.isUser ? Color.blue : Color.gray.opacity(0.15))
                    )
                    .foregroundColor(message.isUser ? .white : .primary)
            }

            if !message.isUser { Spacer(minLength: 60) }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        ChatView(threadTitle: nil, isNewChat: true, onCreateThread: { _, _ in })
    }
}
