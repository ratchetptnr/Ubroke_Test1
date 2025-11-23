import SwiftUI

struct WelcomeView: View {
    let navigateToProfile: () -> Void

    var body: some View {
        ZStack {
            // Solid background
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer()
                        .frame(height: 40)

                    // Logo with solid purple
                    ZStack {
                        Circle()
                            .fill(BrandColors.purple)
                            .frame(width: 80, height: 80)
                            .shadow(color: BrandColors.purple.opacity(0.3), radius: 12, x: 0, y: 6)

                        Text("U")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                    }

                    // Title
                    VStack(spacing: 8) {
                        Text("UBROKE 2.0")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(BrandColors.purple)

                        Text("Your Personal Finance Brain")
                            .font(.title3)
                            .foregroundColor(.secondary)

                        VStack(spacing: 4) {
                            Text("(Not a bank. Not a tracker.)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("(Just clarity for your money.)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 4)
                    }

                    // What we do card
                    GlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("What we do:")
                                .font(.headline)
                                .foregroundStyle(BrandColors.purple)

                            FeatureRow(icon: "checkmark.circle.fill", text: "Read your financial docs", color: BrandColors.gold)
                            FeatureRow(icon: "checkmark.circle.fill", text: "Show you where money goes", color: BrandColors.gold)
                            FeatureRow(icon: "checkmark.circle.fill", text: "Answer your money questions", color: BrandColors.gold)
                        }
                    }

                    // What we don't do card
                    GlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("What we DON'T do:")
                                .font(.headline)
                                .foregroundStyle(BrandColors.purple)

                            FeatureRow(icon: "xmark.circle.fill", text: "Ask for passwords/card info", color: BrandColors.pink)
                            FeatureRow(icon: "xmark.circle.fill", text: "Move your money around", color: BrandColors.pink)
                            FeatureRow(icon: "xmark.circle.fill", text: "Make decisions for you", color: BrandColors.pink)
                        }
                    }

                    // Continue button
                    Button(action: navigateToProfile) {
                        HStack {
                            Text("Continue")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                    }
                    .buttonStyle(.brand)
                    .padding(.top, 8)

                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 18))

            Text(text)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()
        }
    }
}

struct GlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(BrandColors.purple.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: BrandColors.purple.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    WelcomeView(navigateToProfile: {})
}
