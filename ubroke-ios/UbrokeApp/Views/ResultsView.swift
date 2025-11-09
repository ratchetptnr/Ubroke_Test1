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

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Ubroke")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(spacing: 20) {
                        // Total amount card
                        GlassCard {
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
                                    .padding(.vertical, 8)

                                VStack(spacing: 8) {
                                    Text("Total Analyzed")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Text("₹47,500")
                                        .font(.system(size: 42, weight: .bold))
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue.opacity(0.1))
                                )
                            }
                        }
                        .padding(.horizontal)

                        // Categories card
                        GlassCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("📈 BY CATEGORY")
                                    .font(.headline)

                                ForEach(categories) { category in
                                    CategoryRow(category: category)
                                }
                            }
                        }
                        .padding(.horizontal)

                        // Insights card
                        GlassCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("💡 INSIGHTS")
                                    .font(.headline)

                                InsightRow(text: "Your top spend: Rent (52%)")
                                InsightRow(text: "Food delivery is 18% of your total spend — high! 🔴")
                                InsightRow(text: "You have 6 recurring costs (subscriptions, gym, etc.)")
                            }
                        }
                        .padding(.horizontal)

                        // Action buttons
                        HStack(spacing: 12) {
                            Button(action: navigateToUpload) {
                                VStack(spacing: 8) {
                                    Image(systemName: "arrow.up.doc.fill")
                                        .font(.title2)
                                    Text("Upload More")
                                        .font(.subheadline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.ultraThinMaterial)
                                )
                                .foregroundColor(.blue)
                            }

                            Button(action: navigateToChat) {
                                VStack(spacing: 8) {
                                    Image(systemName: "message.fill")
                                        .font(.title2)
                                    Text("Ask AI")
                                        .font(.subheadline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)

                        Spacer()
                            .frame(height: 40)
                    }
                    .padding(.top)
                }
            }
        }
        .navigationBarHidden(true)
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

struct CategoryRow: View {
    let category: CategoryData

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(category.emoji)
                    .font(.title3)

                Text(category.name)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                Text("₹\(category.amount.formatted())")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            HStack(spacing: 8) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 8)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(category.color)
                            .frame(width: geometry.size.width * CGFloat(category.percentage) / 100, height: 8)
                    }
                }
                .frame(height: 8)

                Text("\(category.percentage)%")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 40, alignment: .trailing)
            }

            if category.alert {
                Text("High spending 🔴")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 32)
            }
        }
    }
}

struct InsightRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.caption)
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ResultsView(navigateToUpload: {}, navigateToChat: {})
}
