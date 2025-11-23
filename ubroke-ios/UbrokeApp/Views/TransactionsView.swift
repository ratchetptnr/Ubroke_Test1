import SwiftUI

struct TransactionsView: View {
    @EnvironmentObject var transactionManager: TransactionManager
    @StateObject private var viewModel = TransactionViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if transactionManager.transactions.isEmpty {
                    ContentUnavailableView(
                        "No transactions yet",
                        systemImage: "list.bullet.clipboard",
                        description: Text("Add your first expense manually or upload a statement to get started.")
                    )
                    .overlay(alignment: .bottom) {
                        VStack(spacing: 16) {
                            Button(action: { viewModel.showingAddTransaction = true }) {
                                Label("Add Expense", systemImage: "plus")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                            }
                            .buttonStyle(.borderedProminent)
                            
                            // Demo Helper
                            Button("Load Demo Data") {
                                transactionManager.loadDemoData()
                            }
                            .font(.subheadline)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                    }
                } else {
                    List {
                        // Date Selector
                        Section {
                            Button(action: { viewModel.showingDatePicker = true }) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(BrandColors.purple)
                                    Text(viewModel.headerTitle)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }

                        // Transactions
                        let groupedTransactions = viewModel.transactionsForDisplay(from: transactionManager.transactions)
                        if groupedTransactions.isEmpty {
                            ContentUnavailableView(
                                "No transactions",
                                systemImage: "magnifyingglass",
                                description: Text("No transactions found for this \(viewModel.viewMode == .month ? "month" : "day").")
                            )
                        } else {
                            ForEach(groupedTransactions.keys.sorted(by: viewModel.sortDaySections), id: \.self) { section in
                                Section(header: Text(section)) {
                                    ForEach(groupedTransactions[section] ?? []) { transaction in
                                        TransactionRow(transaction: transaction)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { viewModel.showingAddTransaction = true }) {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingDatePicker) {
                TransactionDatePickerView(
                    selectedDate: $viewModel.selectedDate,
                    viewMode: $viewModel.viewMode
                )
            }
            .sheet(isPresented: $viewModel.showingAddTransaction) {
                AddTransactionView()
            }
        }
    }
}

struct TransactionRow: View {
    let transaction: TransactionData

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: transaction.symbolName)
                .font(.title3)
                .foregroundColor(transaction.color)
                .frame(width: 40, height: 40)
                .background(transaction.color.opacity(0.15))
                .clipShape(Circle())

            // Transaction details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(1)

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
                    
                    if transaction.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.caption)
                            .foregroundColor(BrandColors.gold)
                    }
                }
            }

            Spacer()

            // Amount
            Text(transaction.formattedAmount)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(transaction.amountColor)
                .layoutPriority(1)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(transaction.name), \(transaction.formattedAmount), \(transaction.category)")
    }
}

struct TransactionDatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var viewMode: TransactionViewMode
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()
                
                VStack(spacing: 12) {
                    Button(action: {
                        viewMode = .day
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("View Transactions for \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(BrandColors.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        viewMode = .month
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("View Whole Month (\(selectedDate.formatted(.dateTime.month(.wide))))")
                        }
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    TransactionsView()
        .environmentObject(TransactionManager())
}

// MARK: - ViewModel

enum TransactionViewMode {
    case month
    case day
}

class TransactionViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var viewMode: TransactionViewMode = .month
    @Published var showingDatePicker = false
    @Published var showingAddTransaction = false
    
    // MARK: - Presentation Logic
    
    var headerTitle: String {
        switch viewMode {
        case .month:
            return selectedDate.formatted(.dateTime.month(.wide).year())
        case .day:
            return selectedDate.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    var currentMonthKey: String {
        selectedDate.formatted(.dateTime.month(.wide).year())
    }
    
    var formattedMonth: String {
        selectedDate.formatted(.dateTime.month(.wide).year())
    }
    
    func transactionsForDisplay(from transactions: [TransactionData]) -> [String: [TransactionData]] {
        switch viewMode {
        case .month:
            return groupedByDayInCurrentMonth(from: transactions)
        case .day:
            let dayTransactions = transactions.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
            return dayTransactions.isEmpty ? [:] : ["Transactions": dayTransactions]
        }
    }
    
    func currentMonthTransactions(from transactions: [TransactionData]) -> [TransactionData] {
        groupedByMonth(from: transactions)[currentMonthKey] ?? []
    }
    
    func availableMonths(from transactions: [TransactionData]) -> [String] {
        let grouped = groupedByMonth(from: transactions)
        return Array(grouped.keys.sorted().reversed())
    }
    
    func groupedByMonth(from transactions: [TransactionData]) -> [String: [TransactionData]] {
        Dictionary(grouping: transactions) { transaction in
            transaction.date.formatted(.dateTime.month(.wide).year())
        }
    }
    
    func groupedByDayInCurrentMonth(from transactions: [TransactionData]) -> [String: [TransactionData]] {
        let currentTransactions = currentMonthTransactions(from: transactions)
        return Dictionary(grouping: currentTransactions) { transaction in
            let calendar = Calendar.current
            if calendar.isDateInToday(transaction.date) {
                return "Today"
            } else if calendar.isDateInYesterday(transaction.date) {
                return "Yesterday"
            } else if calendar.isDate(transaction.date, equalTo: Date(), toGranularity: .weekOfYear) {
                return "This Week"
            } else {
                return transaction.date.formatted(.dateTime.weekday(.wide).month().day())
            }
        }
    }
    
    func sortDaySections(_ section1: String, _ section2: String) -> Bool {
        let recentOrder = ["Today", "Yesterday", "This Week", "Transactions"]
        
        if let index1 = recentOrder.firstIndex(of: section1),
           let index2 = recentOrder.firstIndex(of: section2) {
            return index1 < index2
        }
        
        if recentOrder.contains(section1) { return true }
        if recentOrder.contains(section2) { return false }
        
        return section1 > section2
    }
}
