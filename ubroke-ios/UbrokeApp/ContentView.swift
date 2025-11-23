import SwiftUI

struct ContentView: View {
    @EnvironmentObject var transactionManager: TransactionManager
    @StateObject private var uploadViewModel = UploadViewModel()
    @State private var currentScreen: AppScreen = .onboarding
    @State private var hasCompletedOnboarding = false
    @State private var previousScreen: AppScreen = .onboarding
    @State private var startUploadWithCamera = false
    @State private var showManualEntryOnMain = false

    var body: some View {
        Group {
            switch currentScreen {
            case .onboarding:
                NavigationStack {
                    OnboardingView(
                        navigateToUpload: {
                            startUploadWithCamera = false
                            previousScreen = .onboarding
                            currentScreen = .upload
                        },
                        navigateToCamera: {
                            startUploadWithCamera = true
                            previousScreen = .onboarding
                            currentScreen = .upload
                        },
                        navigateToManual: {
                            hasCompletedOnboarding = true
                            currentScreen = .mainApp
                            // Delay slightly to ensure view is loaded before showing sheet
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showManualEntryOnMain = true
                            }
                        },
                        navigateToDashboard: {
                            hasCompletedOnboarding = true
                            currentScreen = .mainApp
                        }
                    )
                    .navigationBarHidden(true)
                }
            case .upload:
                NavigationStack {
                    UploadView(
                        navigateBack: {
                            currentScreen = previousScreen
                        },
                        navigateToProcessing: { currentScreen = .processing },
                        startWithCamera: startUploadWithCamera
                    )
                    .environmentObject(uploadViewModel)
                }
            case .processing:
                NavigationStack {
                    ProcessingView(
                        navigateToResults: {
                            hasCompletedOnboarding = true
                            currentScreen = .mainApp
                        },
                        navigateToMergeReview: {
                            currentScreen = .mergeReview
                        }
                    )
                    .environmentObject(uploadViewModel)
                }
            case .mergeReview:
                NavigationStack {
                    MergeReviewView(
                        onMerge: {
                            transactionManager.mergeDemoTransaction()
                            hasCompletedOnboarding = true
                            currentScreen = .mainApp
                        },
                        onKeepBoth: {
                            transactionManager.addDemoStatementTransaction()
                            hasCompletedOnboarding = true
                            currentScreen = .mainApp
                        }
                    )
                }
            case .mainApp:
                MainTabView(
                    navigateToUpload: {
                        startUploadWithCamera = false
                        previousScreen = .mainApp
                        currentScreen = .upload
                    },
                    showingManualEntry: $showManualEntryOnMain
                )
                .environmentObject(uploadViewModel)
            }
        }
        .animation(.easeInOut, value: currentScreen)
        .onAppear {
            // Skip onboarding if already completed
            if hasCompletedOnboarding {
                currentScreen = .mainApp
            }
        }
    }
}

enum AppScreen {
    case onboarding
    case upload
    case processing
    case mergeReview
    case mainApp
}

// Main app with custom tab bar
struct MainTabView: View {
    let navigateToUpload: () -> Void
    @Binding var showingManualEntry: Bool
    @State private var selectedTab = 0

    // Init for preview support or default usage
    init(navigateToUpload: @escaping () -> Void, showingManualEntry: Binding<Bool> = .constant(false)) {
        self.navigateToUpload = navigateToUpload
        self._showingManualEntry = showingManualEntry
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab Content
            Group {
                switch selectedTab {
                case 0:
                    HomeView(
                        navigateToUpload: navigateToUpload
                    )
                case 1:
                    ChatListView()
                default:
                    HomeView(
                        navigateToUpload: navigateToUpload
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom Tab Bar
            CustomTabBar(
                selectedTab: $selectedTab,
                navigateToUpload: navigateToUpload,
                showingManualEntry: $showingManualEntry
            )
        }
        .ignoresSafeArea(.keyboard) // Prevent tab bar from moving up with keyboard
        .sheet(isPresented: $showingManualEntry) {
            AddTransactionView()
        }
    }
}

#Preview {
    ContentView()
}

struct MergeReviewView: View {
    var onMerge: () -> Void
    var onKeepBoth: () -> Void
    
    // Data passed in (defaults for demo if needed, but better passed)
    var foundTransaction: TransactionData
    var manualTransaction: TransactionData
    
    init(onMerge: @escaping () -> Void, onKeepBoth: @escaping () -> Void, foundTransaction: TransactionData? = nil, manualTransaction: TransactionData? = nil) {
        self.onMerge = onMerge
        self.onKeepBoth = onKeepBoth
        
        // Defaults for Demo
        self.foundTransaction = foundTransaction ?? TransactionData(
            name: "Swiggy",
            category: "Food & Delivery",
            amount: -450,
            type: .expense,
            date: Date(),
            symbolName: "takeoutbag.and.cup.and.straw.fill",
            color: .orange
        )
        
        self.manualTransaction = manualTransaction ?? TransactionData(
            name: "Lunch",
            category: "Food & Delivery",
            amount: -450,
            type: .expense,
            date: Date(),
            symbolName: "takeoutbag.and.cup.and.straw.fill",
            color: .gray
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(BrandColors.purple)
                        .accessibilityHidden(true)
                    
                    Text("Potential Duplicate Found")
                        .font(.title2)
                        .fontWeight(.bold)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("We found a transaction in your statement that looks similar to one you added manually.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 20)
                .accessibilityElement(children: .combine)

                // Comparison Card
                VStack(spacing: 0) {
                    // Statement Side
                    TransactionComparisonRow(
                        title: "FROM STATEMENT",
                        transaction: foundTransaction,
                        iconName: "doc.text.fill",
                        iconColor: BrandColors.purple,
                        backgroundColor: BrandColors.purple.opacity(0.1)
                    )
                    
                    Divider()
                    
                    // Manual Side
                    TransactionComparisonRow(
                        title: "YOUR MANUAL ENTRY",
                        transaction: manualTransaction,
                        iconName: "square.and.pencil",
                        iconColor: BrandColors.pink,
                        backgroundColor: BrandColors.pink.opacity(0.1)
                    )
                }
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.separator), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Comparison between statement transaction and manual entry")

                Spacer()
                    .frame(minHeight: 20)

                // Actions
                VStack(spacing: 16) {
                    Button(action: onMerge) {
                        VStack(spacing: 4) {
                            Text("Yes, Merge")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text("Update manual entry with statement details")
                                .font(.caption)
                                .opacity(0.9)
                        }
                    }
                    .buttonStyle(.brand)
                    .accessibilityLabel("Yes, Merge. Update manual entry with statement details.")
                    .accessibilityHint("Double tap to merge transactions.")

                    Button(action: onKeepBoth) {
                        Text("No, Keep Both")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(.systemGray6))
                            .cornerRadius(16)
                    }
                    .accessibilityHint("Double tap to keep both transactions separate.")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionComparisonRow: View {
    let title: String
    let transaction: TransactionData
    let iconName: String
    let iconColor: Color
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .accessibilityAddTraits(.isHeader)
                
                Text(transaction.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(transaction.formattedAmount)
                    .font(.subheadline)
                    .foregroundColor(transaction.amountColor)
            }
            Spacer()
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(iconColor)
                .accessibilityHidden(true)
        }
        .padding(16)
        .background(backgroundColor)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(transaction.name), \(transaction.formattedAmount)")
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    var navigateToUpload: () -> Void
    @Binding var showingManualEntry: Bool
    
    // Tab items
    let tabs = [
        (icon: "house.fill", title: "Home"),
        (icon: "message.fill", title: "Ask AI")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            // Floating Capsule for Tabs
            HStack(spacing: 0) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = index
                        }
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: tabs[index].icon)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text(tabs[index].title)
                                .font(.caption2)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(selectedTab == index ? BrandColors.purple : .gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .contentShape(Rectangle())
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .padding(.leading, 20)
            .padding(.trailing, 10)
            
            // Detached Action Button
            Menu {
                Button(action: { navigateToUpload() }) {
                    Label("Upload Documents", systemImage: "doc.fill")
                }
                Button(action: { showingManualEntry = true }) {
                    Label("Add Manually", systemImage: "pencil.line")
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(BrandColors.purple)
                        .frame(width: 60, height: 60)
                        .shadow(color: BrandColors.purple.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(.trailing, 20)
        }
        .padding(.bottom, 10)
    }
}

import SwiftUI
import Charts

class HomeViewModel: ObservableObject {
    @Published var totalBalance: Int = 0
    @Published var monthlyIncome: Int = 0
    @Published var monthlyExpense: Int = 0
    @Published var spendingData: [DailySpending] = []
    @Published var recentTransactions: [TransactionData] = []
    @Published var showingAddBudget = false
    
    func refreshData(from transactions: [TransactionData]) {
        calculateTotals(from: transactions)
        prepareSpendingGraph(from: transactions)
        getRecentTransactions(from: transactions)
    }
    
    private func calculateTotals(from transactions: [TransactionData]) {
        let currentMonthTransactions = transactions.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
        
        monthlyIncome = currentMonthTransactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        monthlyExpense = currentMonthTransactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + abs($1.amount) }
            
        totalBalance = monthlyIncome - monthlyExpense
    }
    
    private func prepareSpendingGraph(from transactions: [TransactionData]) {
        // Get last 7 days
        let calendar = Calendar.current
        let today = Date()
        var data: [DailySpending] = []
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let dayTransactions = transactions.filter {
                    calendar.isDate($0.date, inSameDayAs: date) && $0.type == .expense
                }
                let total = dayTransactions.reduce(0) { $0 + abs($1.amount) }
                data.append(DailySpending(date: date, amount: total))
            }
        }
        
        spendingData = data.reversed()
    }
    
    private func getRecentTransactions(from transactions: [TransactionData]) {
        recentTransactions = Array(transactions.prefix(5))
    }
}

struct DailySpending: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Int
    
    var dayLabel: String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }
}
import SwiftUI
import Charts

struct HomeView: View {
    @EnvironmentObject var transactionManager: TransactionManager
    @StateObject private var viewModel = HomeViewModel()
    let navigateToUpload: () -> Void
    // selectedTab binding removed
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header & Balance
                    VStack(spacing: 8) {
                        Text("Total Balance")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text("₹\(viewModel.totalBalance.formatted())")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(BrandColors.purple)
                        
                        HStack(spacing: 24) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundStyle(.green)
                                Text("₹\(viewModel.monthlyIncome.formatted())")
                                    .fontWeight(.medium)
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundStyle(.red)
                                Text("₹\(viewModel.monthlyExpense.formatted())")
                                    .fontWeight(.medium)
                            }
                        }
                        .font(.subheadline)
                        .padding(.top, 4)
                    }
                    .padding(.top, 20)
                    
                    // Upcoming Payments
                    if !transactionManager.upcomingPayments.isEmpty {
                        UpcomingPaymentsRow(payments: transactionManager.upcomingPayments)
                            .padding(.bottom, 8)
                    }
                    
                    // Budget Pulse
                    if let mainBudget = transactionManager.budgets.first {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Budget Pulse")
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    // Show budget list sheet (future)
                                }) {
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                            
                            BudgetPulseCard(budget: mainBudget)
                                .padding(.horizontal)
                        }
                    } else {
                        // Empty State / CTA
                        Button(action: {
                            viewModel.showingAddBudget = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(BrandColors.purple)
                                VStack(alignment: .leading) {
                                    Text("Set a Budget")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("Track your spending limits")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                    
                    // Spending Graph
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Spending This Week")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(viewModel.spendingData) { item in
                                BarMark(
                                    x: .value("Day", item.dayLabel),
                                    y: .value("Amount", item.amount)
                                )
                                .foregroundStyle(BrandColors.purple.gradient)
                                .cornerRadius(4)
                            }
                        }
                        .frame(height: 180)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Transactions")
                                .font(.headline)
                            Spacer()
                            NavigationLink(destination: TransactionsView()) {
                                Text("View All")
                                    .font(.subheadline)
                                    .foregroundStyle(BrandColors.purple)
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            ForEach(viewModel.recentTransactions) { transaction in
                                TransactionRow(transaction: transaction)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                
                                if transaction.id != viewModel.recentTransactions.last?.id {
                                    Divider()
                                        .padding(.leading, 60)
                                }
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                    }
                }
                .padding(.bottom, 100) // Space for tab bar
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Good Morning")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.refreshData(from: transactionManager.transactions)
            }
            .onChange(of: transactionManager.transactions.count) { _ in
                viewModel.refreshData(from: transactionManager.transactions)
            }
            .sheet(isPresented: $viewModel.showingAddBudget) {
                AddBudgetView()
            }
        }
    }
}

#Preview {
    HomeView(navigateToUpload: {})
        .environmentObject(TransactionManager())
}

struct BudgetPulseCard: View {
    let budget: Budget
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(budget.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(budget.category ?? "All Spending")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text("\(Int(budget.progress * 100))%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(budget.statusColor)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.systemGray5))
                        .frame(height: 12)
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(budget.statusColor)
                        .frame(width: min(CGFloat(budget.progress) * geometry.size.width, geometry.size.width), height: 12)
                }
            }
            .frame(height: 12)
            
            HStack {
                Text("₹\(budget.spent.formatted()) spent")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("₹\(budget.remaining.formatted()) left")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct AddBudgetView: View {
    @EnvironmentObject var transactionManager: TransactionManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var amountString = ""
    @State private var selectedPeriod: BudgetPeriod = .monthly
    @State private var selectedCategory: String = "All Spending"
    
    let categories = ["All Spending", "Food & Delivery", "Transport", "Entertainment", "Shopping", "Health & Wellness", "Rent & Housing", "Subscriptions"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("BUDGET DETAILS")) {
                    TextField("Budget Name (e.g., Monthly Limit)", text: $name)
                    
                    HStack {
                        Text("₹")
                        TextField("Amount", text: $amountString)
                            .keyboardType(.numberPad)
                    }
                    
                    Picker("Period", selection: $selectedPeriod) {
                        ForEach(BudgetPeriod.allCases) { period in
                            Text(period.rawValue).tag(period)
                        }
                    }
                }
                
                Section(header: Text("CATEGORY")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                }
            }
            .navigationTitle("New Budget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBudget()
                    }
                    .disabled(name.isEmpty || amountString.isEmpty)
                    .fontWeight(.semibold)
                    .foregroundColor(BrandColors.purple)
                }
            }
        }
    }
    
    private func saveBudget() {
        guard let amount = Int(amountString) else { return }
        
        let category = selectedCategory == "All Spending" ? nil : selectedCategory
        let newBudget = Budget(name: name, amount: amount, period: selectedPeriod, category: category)
        
        transactionManager.addBudget(newBudget)
        dismiss()
    }
}

struct UpcomingPaymentsRow: View {
    let payments: [RecurringPayment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming Bills")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(payments) { payment in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(payment.color.opacity(0.1))
                                    .frame(width: 40, height: 40)
                                Image(systemName: payment.symbolName)
                                    .foregroundColor(payment.color)
                                    .font(.system(size: 18))
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(payment.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Text(payment.dueString)
                                    .font(.caption)
                                    .foregroundColor(payment.daysUntilDue <= 3 ? .red : .secondary)
                            }
                            
                            Spacer()
                            
                            Text("₹\(payment.amount)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .padding(12)
                        .frame(width: 240)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
