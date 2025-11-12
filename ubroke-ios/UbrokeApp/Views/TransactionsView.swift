import SwiftUI

struct TransactionsView: View {
    let transactions = [
        // Today
        TransactionData(name: "Swiggy Order", category: "Food & Delivery", amount: -450, type: .debit, date: Date(), symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
        TransactionData(name: "Salary Credit", category: "Income", amount: 85000, type: .credit, date: Date(), symbolName: "banknote.fill", color: .green),
        TransactionData(name: "Uber Trip", category: "Transport", amount: -180, type: .debit, date: Date().addingTimeInterval(-3600), symbolName: "car.fill", color: .green),

        // Yesterday
        TransactionData(name: "Netflix Subscription", category: "Subscriptions", amount: -799, type: .debit, date: Date().addingTimeInterval(-86400), symbolName: "rectangle.stack.fill", color: .pink),
        TransactionData(name: "Zomato Order", category: "Food & Delivery", amount: -680, type: .debit, date: Date().addingTimeInterval(-90000), symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
        TransactionData(name: "Freelance Payment", category: "Income", amount: 15000, type: .credit, date: Date().addingTimeInterval(-100000), symbolName: "banknote.fill", color: .green),

        // This Week
        TransactionData(name: "Rent Payment", category: "Rent & Housing", amount: -25000, type: .debit, date: Date().addingTimeInterval(-172800), symbolName: "house.fill", color: .blue),
        TransactionData(name: "Electricity Bill", category: "Rent & Housing", amount: -1200, type: .debit, date: Date().addingTimeInterval(-259200), symbolName: "bolt.fill", color: .blue),
        TransactionData(name: "Grocery Shopping", category: "Food & Delivery", amount: -3500, type: .debit, date: Date().addingTimeInterval(-345600), symbolName: "cart.fill", color: .orange),
        TransactionData(name: "Gym Membership", category: "Health & Wellness", amount: -1500, type: .debit, date: Date().addingTimeInterval(-432000), symbolName: "figure.run", color: .teal),

        // Earlier
        TransactionData(name: "PlayStation Game", category: "Entertainment", amount: -2499, type: .debit, date: Date().addingTimeInterval(-604800), symbolName: "gamecontroller.fill", color: .purple),
        TransactionData(name: "Coffee Shop", category: "Food & Delivery", amount: -250, type: .debit, date: Date().addingTimeInterval(-691200), symbolName: "cup.and.saucer.fill", color: .orange),
        TransactionData(name: "Phone Bill", category: "Subscriptions", amount: -599, type: .debit, date: Date().addingTimeInterval(-777600), symbolName: "iphone", color: .pink),
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedTransactions.keys.sorted(by: { sortSections($0, $1) }), id: \.self) { section in
                    Section(header: Text(section)) {
                        ForEach(groupedTransactions[section] ?? []) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    var groupedTransactions: [String: [TransactionData]] {
        Dictionary(grouping: transactions) { transaction in
            let calendar = Calendar.current
            let now = Date()

            if calendar.isDateInToday(transaction.date) {
                return "Today"
            } else if calendar.isDateInYesterday(transaction.date) {
                return "Yesterday"
            } else if calendar.isDate(transaction.date, equalTo: now, toGranularity: .weekOfYear) {
                return "This Week"
            } else {
                return "Earlier"
            }
        }
    }

    func sortSections(_ section1: String, _ section2: String) -> Bool {
        let order = ["Today", "Yesterday", "This Week", "Earlier"]
        guard let index1 = order.firstIndex(of: section1),
              let index2 = order.firstIndex(of: section2) else {
            return false
        }
        return index1 < index2
    }
}

struct TransactionData: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let amount: Int
    let type: TransactionType
    let date: Date
    let symbolName: String
    let color: Color

    enum TransactionType {
        case credit
        case debit
    }

    var formattedAmount: String {
        let prefix = type == .credit ? "+" : "-"
        return "\(prefix)₹\(abs(amount).formatted())"
    }

    var amountColor: Color {
        type == .credit ? .green : .red
    }

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TransactionRow: View {
    let transaction: TransactionData

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(transaction.color.opacity(0.15))
                    .frame(width: 44, height: 44)

                Image(systemName: transaction.symbolName)
                    .font(.system(size: 18))
                    .foregroundColor(transaction.color)
            }

            // Transaction details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name)
                    .font(.body)
                    .fontWeight(.medium)

                HStack(spacing: 4) {
                    Text(transaction.category)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("•")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(transaction.formattedTime)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            // Amount
            Text(transaction.formattedAmount)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(transaction.amountColor)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TransactionsView()
}
