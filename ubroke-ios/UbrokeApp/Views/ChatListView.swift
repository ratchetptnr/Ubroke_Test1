import SwiftUI

// Chat thread model
struct ChatThread: Identifiable {
    let id = UUID()
    let title: String
    let lastMessage: String
    let date: String
    let unread: Bool
}

struct ChatListView: View {
    @State private var chatThreads = [
        ChatThread(
            title: "Food delivery spending",
            lastMessage: "You spent ₹8,500 on food delivery this month...",
            date: "Today",
            unread: true
        ),
        ChatThread(
            title: "Monthly budget planning",
            lastMessage: "Based on your income of ₹65k...",
            date: "Yesterday",
            unread: false
        ),
        ChatThread(
            title: "Subscription review",
            lastMessage: "You have 6 recurring subscriptions...",
            date: "Jan 28",
            unread: false
        )
    ]

    @State private var isShowingNewChat = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(chatThreads) { thread in
                    NavigationLink(destination: ChatView(
                        threadTitle: thread.title,
                        isNewChat: false,
                        onCreateThread: { _, _ in }
                    )) {
                        ChatThreadRow(thread: thread)
                    }
                }
                .onDelete(perform: deleteThread)
            }
            .navigationTitle("Ask AI")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isShowingNewChat = true }) {
                        Image(systemName: "plus")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
            }
            .navigationDestination(isPresented: $isShowingNewChat) {
                ChatView(
                    threadTitle: nil,
                    isNewChat: true,
                    onCreateThread: { title, message in
                        createThread(title: title, lastMessage: message)
                    }
                )
            }
        }
    }

    func deleteThread(at offsets: IndexSet) {
        chatThreads.remove(atOffsets: offsets)
    }

    func createThread(title: String, lastMessage: String) {
        let newThread = ChatThread(
            title: title,
            lastMessage: lastMessage,
            date: "Now",
            unread: false
        )
        chatThreads.insert(newThread, at: 0)
    }
}

struct ChatThreadRow: View {
    let thread: ChatThread

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 50, height: 50)

                Image(systemName: "message.fill")
                    .foregroundColor(.blue)
                    .font(.title3)
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(thread.title)
                        .font(.body)
                        .fontWeight(thread.unread ? .semibold : .regular)
                        .lineLimit(1)

                    Spacer()

                    Text(thread.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Text(thread.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            if thread.unread {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ChatListView()
}
