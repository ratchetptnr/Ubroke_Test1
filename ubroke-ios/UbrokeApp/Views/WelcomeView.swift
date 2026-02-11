import SwiftUI

struct WelcomeView: View {
    let navigateToProfile: () -> Void

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer()
                        .frame(height: 40)

                    // Logo
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 80, height: 80)

                        Text("U")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                    }

                    // Title
                    VStack(spacing: 8) {
                        Text("UBROKE 2.0")
                            .font(.system(size: 32, weight: .bold))

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

                            FeatureRow(icon: "checkmark.circle.fill", text: "Read your financial docs", color: .green)
                            FeatureRow(icon: "checkmark.circle.fill", text: "Show you where money goes", color: .green)
                            FeatureRow(icon: "checkmark.circle.fill", text: "Answer your money questions", color: .green)
                        }
                    }

                    // What we don't do card
                    GlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("What we DON'T do:")
                                .font(.headline)

                            FeatureRow(icon: "xmark.circle.fill", text: "Ask for passwords/card info", color: .red)
                            FeatureRow(icon: "xmark.circle.fill", text: "Move your money around", color: .red)
                            FeatureRow(icon: "xmark.circle.fill", text: "Make decisions for you", color: .red)
                        }
                    }

                    // Continue button
                    Button(action: navigateToProfile) {
                        HStack {
                            Text("Continue")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
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
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
            )
    }
}

#Preview {
    WelcomeView(navigateToProfile: {})
}
