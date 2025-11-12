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

    var body: some View {
        NavigationStack {
            List {
                ForEach(chatThreads) { thread in
                    NavigationLink(destination: ChatView(threadTitle: thread.title)) {
                        ChatThreadRow(thread: thread)
                    }
                }
                .onDelete(perform: deleteThread)
            }
            .navigationTitle("Ask AI")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: startNewChat) {
                        Image(systemName: "plus")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }

    func deleteThread(at offsets: IndexSet) {
        chatThreads.remove(atOffsets: offsets)
    }

    func startNewChat() {
        let newThread = ChatThread(
            title: "New conversation",
            lastMessage: "Start asking questions about your finances...",
            date: "Now",
            unread: true
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
