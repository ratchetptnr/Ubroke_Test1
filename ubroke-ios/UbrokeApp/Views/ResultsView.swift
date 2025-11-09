import SwiftUI

enum SortOption: String, CaseIterable {
    case amount = "Amount"
    case percentage = "Percentage"
    case name = "Name"
}

struct ResultsView: View {
    let navigateToUpload: () -> Void
    @State private var selectedSort: SortOption = .amount

    let allCategories = [
        CategoryData(name: "Rent & Housing", amount: 25000, percentage: 52, emoji: "🏠", color: .blue, alert: false),
        CategoryData(name: "Food & Delivery", amount: 8500, percentage: 18, emoji: "🍕", color: .orange, alert: true),
        CategoryData(name: "Entertainment", amount: 4200, percentage: 9, emoji: "🎮", color: .purple, alert: false),
        CategoryData(name: "Subscriptions", amount: 3800, percentage: 8, emoji: "📱", color: .pink, alert: false),
        CategoryData(name: "Transport", amount: 2000, percentage: 4, emoji: "🚗", color: .green, alert: false),
        CategoryData(name: "Health & Wellness", amount: 1500, percentage: 3, emoji: "💊", color: .teal, alert: false),
        CategoryData(name: "Other", amount: 2500, percentage: 6, emoji: "📦", color: .gray, alert: false)
    ]

    var sortedCategories: [CategoryData] {
        switch selectedSort {
        case .amount:
            return allCategories.sorted { $0.amount > $1.amount }
        case .percentage:
            return allCategories.sorted { $0.percentage > $1.percentage }
        case .name:
            return allCategories.sorted { $0.name < $1.name }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                // Total Section
                Section {
                    VStack(spacing: 12) {
                        HStack {
                            Text("📊 Your Expense Breakdown")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }

                        Text("January 2024")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Divider()
                            .padding(.vertical, 4)

                        VStack(spacing: 4) {
                            Text("Total Analyzed")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("₹47,500")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                    }
                    .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                }

                // Categories Section
                Section(header:
                    HStack {
                        Text("BY CATEGORY")
                        Spacer()
                        Text("Sorted by: \(selectedSort.rawValue)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .textCase(.none)
                    }
                ) {
                    ForEach(sortedCategories) { category in
                        CategoryListRow(category: category)
                    }
                }

                // Insights Section
                Section(header: Text("INSIGHTS")) {
                    VStack(alignment: .leading, spacing: 12) {
                        InsightRow(text: "Your top spend: Rent (52%)")
                        InsightRow(text: "Food delivery is 18% of your total spend — high! 🔴")
                        InsightRow(text: "You have 6 recurring costs (subscriptions, gym, etc.)")
                    }
                    .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(
                LinearGradient(
                    colors: [Color.blue.opacity(0.05), Color.white],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationTitle("Ubroke")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Sort by", selection: $selectedSort) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                HStack {
                                    Text(option.rawValue)
                                    if selectedSort == option {
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .tag(option)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.up.arrow.down")
                            Text("Sort")
                                .font(.subheadline)
                        }
                        .foregroundColor(.blue)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: navigateToUpload) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct CategoryData: Identifiable {
    let id = UUID()
    let name: String
    let amount: Int
    let percentage: Int
    let emoji: String
    let color: Color
    let alert: Bool
}

struct CategoryListRow: View {
    let category: CategoryData

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                HStack(spacing: 12) {
                    Text(category.emoji)
                        .font(.title2)

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

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "lightbulb.fill")
                .font(.caption)
                .foregroundColor(.yellow)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ResultsView(navigateToUpload: {})
}
