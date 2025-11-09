import SwiftUI

struct ResultsView: View {
    let navigateToUpload: () -> Void
    let navigateToChat: () -> Void

    let categories = [
        CategoryData(name: "Rent & Housing", amount: 25000, percentage: 52, emoji: "🏠", color: .blue, alert: false),
        CategoryData(name: "Food & Delivery", amount: 8500, percentage: 18, emoji: "🍕", color: .orange, alert: true),
        CategoryData(name: "Entertainment", amount: 4200, percentage: 9, emoji: "🎮", color: .purple, alert: false),
        CategoryData(name: "Subscriptions", amount: 3800, percentage: 8, emoji: "📱", color: .pink, alert: false),
        CategoryData(name: "Transport", amount: 2000, percentage: 4, emoji: "🚗", color: .green, alert: false),
        CategoryData(name: "Health & Wellness", amount: 1500, percentage: 3, emoji: "💊", color: .teal, alert: false),
        CategoryData(name: "Other", amount: 2500, percentage: 6, emoji: "📦", color: .gray, alert: false)
    ]

    var totalAmount: Int {
        categories.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Ubroke")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))

            // List with Settings-style layout
            List {
                // Total Amount & Segmented Bar Section (like iPhone Storage)
                Section {
                    VStack(spacing: 16) {
                        // Title and date
                        VStack(spacing: 4) {
                            HStack {
                                Text("Your Spending")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                            }

                            HStack {
                                Text("January 2024")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }

                        // Total amount
                        HStack {
                            Text("Total")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("₹\(totalAmount.formatted())")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }

                        // Segmented progress bar (like iPhone Storage)
                        SegmentedProgressBar(categories: categories)
                            .frame(height: 20)
                            .cornerRadius(10)

                        // Color legend
                        VStack(spacing: 8) {
                            ForEach(categories) { category in
                                HStack(spacing: 12) {
                                    // Color indicator
                                    Circle()
                                        .fill(category.color)
                                        .frame(width: 12, height: 12)

                                    // Category name
                                    Text(category.emoji + " " + category.name)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)

                                    Spacer()

                                    // Amount and percentage
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text("₹\(category.amount.formatted())")
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Text("\(category.percentage)%")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }

                // Detailed Breakdown Section
                Section(header: Text("DETAILED BREAKDOWN")) {
                    ForEach(categories) { category in
                        CategoryDetailRow(category: category)
                    }
                }

                // Insights Section
                Section(header: Text("INSIGHTS")) {
                    VStack(alignment: .leading, spacing: 12) {
                        InsightRow(text: "Your top spend: Rent (52%)")
                        InsightRow(text: "Food delivery is 18% of your total spend — high! 🔴")
                        InsightRow(text: "You have 6 recurring costs (subscriptions, gym, etc.)")
                    }
                    .padding(.vertical, 4)
                }

                // Action Buttons Section
                Section {
                    HStack(spacing: 12) {
                        Button(action: navigateToUpload) {
                            HStack {
                                Image(systemName: "arrow.up.doc.fill")
                                    .font(.title3)
                                Text("Upload More")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        }
                        .buttonStyle(.plain)

                        Button(action: navigateToChat) {
                            HStack {
                                Image(systemName: "message.fill")
                                    .font(.title3)
                                Text("Ask AI")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
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
        }
        .navigationBarHidden(true)
    }
}

// Segmented progress bar (like iPhone Storage bar)
struct SegmentedProgressBar: View {
    let categories: [CategoryData]

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(categories) { category in
                    Rectangle()
                        .fill(category.color)
                        .frame(width: geometry.size.width * CGFloat(category.percentage) / 100)
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

// Detailed row for the breakdown section
struct CategoryDetailRow: View {
    let category: CategoryData

    var body: some View {
        VStack(spacing: 0) {
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
                .padding(.top, 8)
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
    ResultsView(navigateToUpload: {}, navigateToChat: {})
}
