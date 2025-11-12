import SwiftUI

struct ResultsView: View {
    let navigateToUpload: () -> Void

    let categories = [
        CategoryData(name: "Rent & Housing", amount: 25000, percentage: 52, symbolName: "house.fill", color: .blue, alert: false),
        CategoryData(name: "Food & Delivery", amount: 8500, percentage: 18, symbolName: "takeoutbag.and.cup.and.straw.fill", color: .orange, alert: true),
        CategoryData(name: "Entertainment", amount: 4200, percentage: 9, symbolName: "tv.fill", color: .purple, alert: false),
        CategoryData(name: "Subscriptions", amount: 3800, percentage: 8, symbolName: "rectangle.stack.fill", color: .pink, alert: false),
        CategoryData(name: "Transport", amount: 2000, percentage: 4, symbolName: "car.fill", color: .green, alert: false),
        CategoryData(name: "Health & Wellness", amount: 1500, percentage: 3, symbolName: "heart.text.square.fill", color: .teal, alert: false),
        CategoryData(name: "Other", amount: 2500, percentage: 6, symbolName: "square.grid.2x2.fill", color: .gray, alert: false)
    ]

    var body: some View {
        NavigationStack {
            List {
                // Total Section
                Section {
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Total Spent")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text("₹47,500")
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                            }

                            Spacer()
                        }

                        HStack {
                            Text("January 2024")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                }

                // Categories Section
                Section(header: Text("BY CATEGORY")) {
                    ForEach(categories) { category in
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
        }
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
