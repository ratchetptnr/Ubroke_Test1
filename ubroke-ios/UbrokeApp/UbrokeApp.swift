import SwiftUI

@main
struct UbrokeApp: App {
    @StateObject private var transactionManager = TransactionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionManager)
        }
    }
}

class TransactionManager: ObservableObject {
    @Published var transactions: [TransactionData] = []
    @Published var budgets: [Budget] = []
    @Published var upcomingPayments: [RecurringPayment] = []

    // Demo Data
    func loadDemoData() {
        transactions = [
            // November 2024 - Recent transactions
            TransactionData(name: "Swiggy Order", category: "Food & Delivery", amount: -450, type: .expense, date: Date(), symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
            TransactionData(name: "Salary Credit", category: "Income", amount: 85000, type: .income, date: Date(), symbolName: "banknote.fill", color: .green),
            TransactionData(name: "Uber Trip", category: "Transport", amount: -180, type: .expense, date: Date().addingTimeInterval(-3600), symbolName: "car.fill", color: .green),
            TransactionData(name: "Netflix Subscription", category: "Subscriptions", amount: -799, type: .expense, date: Date().addingTimeInterval(-86400), symbolName: "rectangle.stack.fill", color: .pink),
            TransactionData(name: "Zomato Order", category: "Food & Delivery", amount: -680, type: .expense, date: Date().addingTimeInterval(-90000), symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
            TransactionData(name: "Rent Payment", category: "Rent & Housing", amount: -25000, type: .expense, date: Date().addingTimeInterval(-172800), symbolName: "house.fill", color: .blue),
            TransactionData(name: "Gym Membership", category: "Health & Wellness", amount: -1500, type: .expense, date: Date().addingTimeInterval(-345600), symbolName: "figure.run", color: .teal),
        ]
        
        // Demo Budgets
        budgets = [
            Budget(name: "Monthly Spending", amount: 40000, period: .monthly, category: nil, spent: 28609),
            Budget(name: "Food & Dining", amount: 10000, period: .monthly, category: "Food & Delivery", spent: 8500)
        ]
        
        // Demo Upcoming Payments
        upcomingPayments = [
            RecurringPayment(name: "Netflix", amount: 799, dueDate: Date().addingTimeInterval(86400), symbolName: "rectangle.stack.fill", color: .pink), // Tomorrow
            RecurringPayment(name: "Internet Bill", amount: 1200, dueDate: Date().addingTimeInterval(86400 * 5), symbolName: "wifi", color: .blue), // In 5 days
            RecurringPayment(name: "Spotify", amount: 119, dueDate: Date().addingTimeInterval(86400 * 12), symbolName: "music.note", color: .green) // In 12 days
        ]
    }

    func addTransaction(_ transaction: TransactionData) {
        transactions.insert(transaction, at: 0)
        recalculateBudgets()
    }
    
    func addBudget(_ budget: Budget) {
        budgets.append(budget)
        recalculateBudgets()
    }
    
    func recalculateBudgets() {
        // Simple recalculation based on current transactions
        // In a real app, this would be more complex date filtering
        for i in 0..<budgets.count {
            var totalSpent = 0
            let budget = budgets[i]
            
            let relevantTransactions = transactions.filter { transaction in
                // Filter by category if specified
                if let category = budget.category, transaction.category != category {
                    return false
                }
                // Only count expenses
                return transaction.type == .expense
            }
            
            totalSpent = relevantTransactions.reduce(0) { $0 + abs($1.amount) }
            budgets[i] = Budget(name: budget.name, amount: budget.amount, period: budget.period, category: budget.category, spent: totalSpent)
        }
    }
    
    // Demo: Simulate merging the found transaction with the existing manual one
    func mergeDemoTransaction() {
        // Find the manual transaction (assuming it's the one named "Lunch" or similar from demo)
        // For simplicity, we'll just add the "Verified" transaction at the top
        let verifiedTransaction = TransactionData(
            name: "Swiggy",
            category: "Food & Delivery",
            amount: -450,
            type: .expense,
            date: Date(),
            symbolName: "takeoutbag.and.cup.and.straw.fill",
            color: .orange,
            isVerified: true
        )
        addTransaction(verifiedTransaction)
    }
    
    // Demo: Add the statement transaction as a separate entry
    func addDemoStatementTransaction() {
        let statementTransaction = TransactionData(
            name: "Swiggy",
            category: "Food & Delivery",
            amount: -450,
            type: .expense,
            date: Date(),
            symbolName: "takeoutbag.and.cup.and.straw.fill",
            color: .orange,
            isVerified: true
        )
        addTransaction(statementTransaction)
    }
}

// MARK: - Shared Models

struct TransactionData: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let amount: Int
    let type: TransactionEntryType
    let date: Date
    let symbolName: String
    let color: Color
    var isVerified: Bool = false

    var formattedAmount: String {
        let prefix = type == .income ? "+" : "-"
        return "\(prefix)₹\(abs(amount).formatted())"
    }

    var amountColor: Color {
        type == .income ? .green : .red
    }

    var formattedTime: String {
        date.formatted(date: .omitted, time: .shortened)
    }
}

enum TransactionEntryType {
    case income
    case expense
}

struct CategoryOption: Identifiable {
    let id = UUID()
    let name: String
    let symbolName: String
    let color: Color
}

struct Budget: Identifiable {
    let id = UUID()
    let name: String
    let amount: Int
    let period: BudgetPeriod
    let category: String? // nil means "All Spending"
    var spent: Int = 0 // Calculated dynamically usually, but stored for demo simplicity
    
    var progress: Double {
        guard amount > 0 else { return 0 }
        return Double(spent) / Double(amount)
    }
    
    var remaining: Int {
        amount - spent
    }
    
    var statusColor: Color {
        if progress >= 1.0 { return .red }
        if progress >= 0.8 { return .orange }
        return .green
    }
}

enum BudgetPeriod: String, CaseIterable, Identifiable {
    case weekly = "Weekly"
    case monthly = "Monthly"
    
    var id: String { self.rawValue }
}

struct RecurringPayment: Identifiable {
    let id = UUID()
    let name: String
    let amount: Int
    let dueDate: Date
    let symbolName: String
    let color: Color
    
    var daysUntilDue: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: dueDate))
        return components.day ?? 0
    }
    
    var dueString: String {
        if daysUntilDue == 0 { return "Today" }
        if daysUntilDue == 1 { return "Tomorrow" }
        return "in \(daysUntilDue) days"
    }
}
