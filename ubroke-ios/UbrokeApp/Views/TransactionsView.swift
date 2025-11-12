import SwiftUI

struct TransactionsView: View {
    let transactions = [
        // November 2024 - Recent transactions
        TransactionData(name: "Swiggy Order", category: "Food & Delivery", amount: -450, type: .debit, date: Date(), symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
        TransactionData(name: "Salary Credit", category: "Income", amount: 85000, type: .credit, date: Date(), symbolName: "banknote.fill", color: .green),
        TransactionData(name: "Uber Trip", category: "Transport", amount: -180, type: .debit, date: Date().addingTimeInterval(-3600), symbolName: "car.fill", color: .green),
        TransactionData(name: "Netflix Subscription", category: "Subscriptions", amount: -799, type: .debit, date: Date().addingTimeInterval(-86400), symbolName: "rectangle.stack.fill", color: .pink),
        TransactionData(name: "Zomato Order", category: "Food & Delivery", amount: -680, type: .debit, date: Date().addingTimeInterval(-90000), symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
        TransactionData(name: "Rent Payment", category: "Rent & Housing", amount: -25000, type: .debit, date: Date().addingTimeInterval(-172800), symbolName: "house.fill", color: .blue),
        TransactionData(name: "Gym Membership", category: "Health & Wellness", amount: -1500, type: .debit, date: Date().addingTimeInterval(-345600), symbolName: "figure.run", color: .teal),

        // October 2024
        TransactionData(name: "Freelance Payment", category: "Income", amount: 15000, type: .credit, date: createDate(year: 2024, month: 10, day: 25), symbolName: "banknote.fill", color: .green),
        TransactionData(name: "PlayStation Game", category: "Entertainment", amount: -2499, type: .debit, date: createDate(year: 2024, month: 10, day: 20), symbolName: "gamecontroller.fill", color: .purple),
        TransactionData(name: "Grocery Shopping", category: "Food & Delivery", amount: -3500, type: .debit, date: createDate(year: 2024, month: 10, day: 18), symbolName: "cart.fill", color: .orange),
        TransactionData(name: "Coffee Shop", category: "Food & Delivery", amount: -250, type: .debit, date: createDate(year: 2024, month: 10, day: 15), symbolName: "cup.and.saucer.fill", color: .orange),
        TransactionData(name: "Electricity Bill", category: "Rent & Housing", amount: -1200, type: .debit, date: createDate(year: 2024, month: 10, day: 10), symbolName: "bolt.fill", color: .blue),
        TransactionData(name: "Salary Credit", category: "Income", amount: 85000, type: .credit, date: createDate(year: 2024, month: 10, day: 1), symbolName: "banknote.fill", color: .green),

        // September 2024
        TransactionData(name: "Phone Bill", category: "Subscriptions", amount: -599, type: .debit, date: createDate(year: 2024, month: 9, day: 28), symbolName: "iphone", color: .pink),
        TransactionData(name: "Restaurant Dinner", category: "Food & Delivery", amount: -1800, type: .debit, date: createDate(year: 2024, month: 9, day: 22), symbolName: "fork.knife", color: .orange),
        TransactionData(name: "Uber Trips", category: "Transport", amount: -850, type: .debit, date: createDate(year: 2024, month: 9, day: 18), symbolName: "car.fill", color: .green),
        TransactionData(name: "Movie Tickets", category: "Entertainment", amount: -600, type: .debit, date: createDate(year: 2024, month: 9, day: 15), symbolName: "tv.fill", color: .purple),
        TransactionData(name: "Gym Membership", category: "Health & Wellness", amount: -1500, type: .debit, date: createDate(year: 2024, month: 9, day: 10), symbolName: "figure.run", color: .teal),
        TransactionData(name: "Rent Payment", category: "Rent & Housing", amount: -25000, type: .debit, date: createDate(year: 2024, month: 9, day: 5), symbolName: "house.fill", color: .blue),
        TransactionData(name: "Salary Credit", category: "Income", amount: 85000, type: .credit, date: createDate(year: 2024, month: 9, day: 1), symbolName: "banknote.fill", color: .green),
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedByMonth.keys.sorted().reversed(), id: \.self) { monthKey in
                    Section(header: Text(monthKey).font(.title3).fontWeight(.semibold).foregroundColor(.primary).textCase(nil)) {
                        ForEach(groupedByDayInMonth(monthKey: monthKey).keys.sorted(by: { sortDaySections($0, $1) }), id: \.self) { daySection in
                            Section(header: Text(daySection)) {
                                ForEach(groupedByDayInMonth(monthKey: monthKey)[daySection] ?? []) { transaction in
                                    TransactionRow(transaction: transaction)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // Group transactions by month
    var groupedByMonth: [String: [TransactionData]] {
        Dictionary(grouping: transactions) { transaction in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: transaction.date)
        }
    }

    // Group transactions within a specific month by day sections
    func groupedByDayInMonth(monthKey: String) -> [String: [TransactionData]] {
        guard let monthTransactions = groupedByMonth[monthKey] else {
            return [:]
        }

        return Dictionary(grouping: monthTransactions) { transaction in
            let calendar = Calendar.current
            let now = Date()

            if calendar.isDateInToday(transaction.date) {
                return "Today"
            } else if calendar.isDateInYesterday(transaction.date) {
                return "Yesterday"
            } else if calendar.isDate(transaction.date, equalTo: now, toGranularity: .weekOfYear) {
                return "This Week"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: transaction.date)
            }
        }
    }

    func sortDaySections(_ section1: String, _ section2: String) -> Bool {
        let recentOrder = ["Today", "Yesterday", "This Week"]

        // If both are in the recent order list
        if let index1 = recentOrder.firstIndex(of: section1),
           let index2 = recentOrder.firstIndex(of: section2) {
            return index1 < index2
        }

        // If only section1 is recent
        if recentOrder.contains(section1) {
            return true
        }

        // If only section2 is recent
        if recentOrder.contains(section2) {
            return false
        }

        // Both are date strings, sort in reverse chronological order
        return section1 > section2
    }
}

// Helper function to create dates
func createDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = 12
    return Calendar.current.date(from: components) ?? Date()
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
