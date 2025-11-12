import SwiftUI

struct ResultsView: View {
    let navigateToUpload: () -> Void

    @State private var selectedDate = Date()
    @State private var showingMonthPicker = false

    // Sample data for multiple months
    let monthlyData: [String: MonthData] = [
        "2024-11": MonthData(
            total: 47500,
            categories: [
                CategoryData(name: "Rent & Housing", amount: 25000, percentage: 52, symbolName: "house.fill", color: .blue, alert: false),
                CategoryData(name: "Food & Delivery", amount: 8500, percentage: 18, symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange, alert: true),
                CategoryData(name: "Entertainment", amount: 4200, percentage: 9, symbolName: "tv.fill", color: .purple, alert: false),
                CategoryData(name: "Subscriptions", amount: 3800, percentage: 8, symbolName: "rectangle.stack.fill", color: .pink, alert: false),
                CategoryData(name: "Transport", amount: 2000, percentage: 4, symbolName: "car.fill", color: .green, alert: false),
                CategoryData(name: "Health & Wellness", amount: 1500, percentage: 3, symbolName: "heart.text.square.fill", color: .teal, alert: false),
                CategoryData(name: "Other", amount: 2500, percentage: 6, symbolName: "square.grid.2x2.fill", color: .gray, alert: false)
            ]
        ),
        "2024-10": MonthData(
            total: 52300,
            categories: [
                CategoryData(name: "Rent & Housing", amount: 25000, percentage: 48, symbolName: "house.fill", color: .blue, alert: false),
                CategoryData(name: "Food & Delivery", amount: 12000, percentage: 23, symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange, alert: true),
                CategoryData(name: "Entertainment", amount: 6300, percentage: 12, symbolName: "tv.fill", color: .purple, alert: false),
                CategoryData(name: "Subscriptions", amount: 3800, percentage: 7, symbolName: "rectangle.stack.fill", color: .pink, alert: false),
                CategoryData(name: "Transport", amount: 2500, percentage: 5, symbolName: "car.fill", color: .green, alert: false),
                CategoryData(name: "Health & Wellness", amount: 1200, percentage: 2, symbolName: "heart.text.square.fill", color: .teal, alert: false),
                CategoryData(name: "Other", amount: 1500, percentage: 3, symbolName: "square.grid.2x2.fill", color: .gray, alert: false)
            ]
        ),
        "2024-09": MonthData(
            total: 43200,
            categories: [
                CategoryData(name: "Rent & Housing", amount: 25000, percentage: 58, symbolName: "house.fill", color: .blue, alert: false),
                CategoryData(name: "Food & Delivery", amount: 6500, percentage: 15, symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange, alert: false),
                CategoryData(name: "Entertainment", amount: 3200, percentage: 7, symbolName: "tv.fill", color: .purple, alert: false),
                CategoryData(name: "Subscriptions", amount: 3800, percentage: 9, symbolName: "rectangle.stack.fill", color: .pink, alert: false),
                CategoryData(name: "Transport", amount: 1800, percentage: 4, symbolName: "car.fill", color: .green, alert: false),
                CategoryData(name: "Health & Wellness", amount: 1400, percentage: 3, symbolName: "heart.text.square.fill", color: .teal, alert: false),
                CategoryData(name: "Other", amount: 1500, percentage: 4, symbolName: "square.grid.2x2.fill", color: .gray, alert: false)
            ]
        )
    ]

    var currentMonthKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: selectedDate)
    }

    var currentMonthData: MonthData {
        monthlyData[currentMonthKey] ?? MonthData(total: 0, categories: [])
    }

    var formattedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    var body: some View {
        NavigationStack {
            List {
                // Month Selector
                Section {
                    Button(action: { showingMonthPicker = true }) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                            Text(formattedMonth)
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                // Total Section
                Section {
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Total Spent")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text("₹\(currentMonthData.total.formatted())")
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                            }

                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                }

                // Categories Section
                Section(header: Text("BY CATEGORY")) {
                    ForEach(currentMonthData.categories) { category in
                        CategoryListRow(category: category)
                    }
                }

                // Insights Section
                Section(header: Text("INSIGHTS")) {
                    VStack(alignment: .leading, spacing: 12) {
                        InsightRow(text: "Your top spend: Rent (52%)")
                        InsightRow(text: "Food delivery is 18% of your total spend — high!", isAlert: true)
                        InsightRow(text: "You have 6 recurring costs (subscriptions, gym, etc.)")
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Ubroke")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: navigateToUpload) {
                        Image(systemName: "plus")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showingMonthPicker) {
                MonthPickerView(selectedDate: $selectedDate, availableMonths: Array(monthlyData.keys.sorted().reversed()))
            }
        }
    }
}

struct MonthData {
    let total: Int
    let categories: [CategoryData]
}

struct MonthPickerView: View {
    @Binding var selectedDate: Date
    let availableMonths: [String]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(availableMonths, id: \.self) { monthKey in
                    Button(action: {
                        if let date = dateFromKey(monthKey) {
                            selectedDate = date
                            dismiss()
                        }
                    }) {
                        HStack {
                            Text(formattedMonthFromKey(monthKey))
                                .foregroundColor(.primary)
                            Spacer()
                            if isSameMonth(monthKey: monthKey, date: selectedDate) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Month")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    func dateFromKey(_ key: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.date(from: key)
    }

    func formattedMonthFromKey(_ key: String) -> String {
        guard let date = dateFromKey(key) else { return key }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    func isSameMonth(monthKey: String, date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: date) == monthKey
    }
}

struct CategoryData: Identifiable {
    let id = UUID()
    let name: String
    let amount: Int
    let percentage: Int
    let symbolName: String
    let color: Color
    let alert: Bool
}

struct CategoryListRow: View {
    let category: CategoryData

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                HStack(spacing: 12) {
                    Image(systemName: category.symbolName)
                        .font(.title2)
                        .foregroundColor(category.color)
                        .frame(width: 28, height: 28)

                    Text(category.name)
                        .font(.body)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("₹\(category.amount.formatted())")
                        .font(.body)
                        .fontWeight(.semibold)

                    Text("\(category.percentage)%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(category.color)
                        .frame(width: geometry.size.width * CGFloat(category.percentage) / 100, height: 6)
                }
            }
            .frame(height: 6)

            if category.alert {
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text("High spending")
                        .font(.caption)
                        .foregroundColor(.orange)
                    Spacer()
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct InsightRow: View {
    let text: String
    var isAlert: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: isAlert ? "exclamationmark.triangle.fill" : "lightbulb.fill")
                .font(.caption)
                .foregroundColor(isAlert ? .orange : .yellow)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ResultsView(navigateToUpload: {})
}
