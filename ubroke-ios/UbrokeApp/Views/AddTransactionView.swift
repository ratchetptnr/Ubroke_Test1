import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var transactionManager: TransactionManager

    @State private var transactionName = ""
    @State private var amount = ""
    @State private var transactionType: TransactionEntryType = .expense
    @State private var selectedCategory = "Food & Delivery"
    @State private var transactionDate = Date()
    @State private var notes = ""

    let categories = [
        CategoryOption(name: "Food & Delivery", symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange),
        CategoryOption(name: "Rent & Housing", symbolName: "house.fill", color: .blue),
        CategoryOption(name: "Transport", symbolName: "car.fill", color: .green),
        CategoryOption(name: "Entertainment", symbolName: "tv.fill", color: .purple),
        CategoryOption(name: "Subscriptions", symbolName: "rectangle.stack.fill", color: .pink),
        CategoryOption(name: "Health & Wellness", symbolName: "heart.text.square.fill", color: .teal),
        CategoryOption(name: "Shopping", symbolName: "bag.fill", color: .indigo),
        CategoryOption(name: "Income", symbolName: "banknote.fill", color: .green),
        CategoryOption(name: "Other", symbolName: "square.grid.2x2.fill", color: .gray)
    ]

    var isFormValid: Bool {
        !transactionName.isEmpty && !amount.isEmpty && Double(amount) != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                // Transaction Details
                Section {
                    TextField("Transaction Name", text: $transactionName)

                    HStack {
                        Text("₹")
                            .foregroundStyle(.secondary)
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                } header: {
                    Text("DETAILS")
                }

                // Type, Category, Date
                Section {
                    Picker(selection: $transactionType) {
                        Label("Expense", systemImage: "minus.circle.fill")
                            .tag(TransactionEntryType.expense)
                        Label("Income", systemImage: "plus.circle.fill")
                            .tag(TransactionEntryType.income)
                    } label: {
                        HStack {
                            Text("Type")
                            Spacer()
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker(selection: $selectedCategory) {
                        ForEach(categories, id: \.name) { category in
                            Label(category.name, systemImage: category.symbolName)
                                .tag(category.name)
                        }
                    } label: {
                        HStack {
                            Text("Category")
                            Spacer()
                        }
                    }
                    
                    DatePicker("Date", selection: $transactionDate, displayedComponents: [.date])
                } header: {
                    Text("TRANSACTION")
                }

                // Notes (Optional)
                Section {
                    TextField("Add notes (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                } header: {
                    Text("NOTES")
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveTransaction()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(BrandColors.purple)
                    .disabled(!isFormValid)
                }
            }
        }
    }

    func saveTransaction() {
        guard let amountValue = Int(amount) else { return }
        
        // Find category color and symbol
        let category = categories.first(where: { $0.name == selectedCategory })
        
        let transaction = TransactionData(
            name: transactionName,
            category: selectedCategory,
            amount: transactionType == .expense ? -amountValue : amountValue,
            type: transactionType,
            date: transactionDate,
            symbolName: category?.symbolName ?? "questionmark.circle",
            color: category?.color ?? .gray
        )
        
        transactionManager.addTransaction(transaction)
        dismiss()
    }
}

#Preview {
    AddTransactionView()
        .environmentObject(TransactionManager())
}
