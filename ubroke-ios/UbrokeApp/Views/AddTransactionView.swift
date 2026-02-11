import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss

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

                // Transaction Type
                Section {
                    Picker("Type", selection: $transactionType) {
                        Text("Expense").tag(TransactionEntryType.expense)
                        Text("Income").tag(TransactionEntryType.income)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("TYPE")
                }

                // Category
                Section {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.name) { category in
                            HStack {
                                Image(systemName: category.symbolName)
                                    .foregroundColor(category.color)
                                Text(category.name)
                            }
                            .tag(category.name)
                        }
                    }
                } header: {
                    Text("CATEGORY")
                }

                // Date
                Section {
                    DatePicker("Date", selection: $transactionDate, displayedComponents: [.date])
                } header: {
                    Text("DATE")
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
                    .disabled(!isFormValid)
                }
            }
        }
    }

    func saveTransaction() {
        // In a real app, this would save to a data store
        // For now, just dismiss the sheet
        dismiss()
    }
}

enum TransactionEntryType {
    case income
    case expense
}

struct CategoryOption {
    let name: String
    let symbolName: String
    let color: Color
}

#Preview {
    AddTransactionView()
}
