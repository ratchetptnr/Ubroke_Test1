import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    let navigateToUpload: () -> Void

    let totalPages = 6

    var body: some View {
        ZStack {
            // Main content
            TabView(selection: $currentPage) {
                // Page 1: Welcome to Ubroke
                OnboardingPageView(
                    imageName: "onboarding-1",
                    title: "Welcome to Ubroke",
                    subtitle: "Turning your bills into money insights instantly.",
                    footer: "Built by Gen Z, for Gen Z"
                )
                .tag(0)

                // Page 2: Snap a bill
                OnboardingPageView(
                    imageName: "onboarding-2",
                    title: "Snap a bill",
                    subtitle: "Snap a bill, receipt, or screen.\nOne photo does the job."
                )
                .tag(1)

                // Page 3: AI does the heavy lifting
                OnboardingPageView(
                    imageName: "onboarding-3",
                    title: "AI does the heavy lifting.",
                    subtitle: "We scan your photo, pick out totals, dates, and amounts, and more. So you don't have to."
                )
                .tag(2)

                // Page 4: You stay in control
                OnboardingPageView(
                    imageName: "onboarding-4",
                    title: "You stay in control.",
                    subtitle: "Review what AI finds. Confirm or edit in seconds. Your money, your say."
                )
                .tag(3)

                // Page 5: See where your money goes
                OnboardingPageView(
                    imageName: "onboarding-5",
                    title: "See where your money goes.",
                    subtitle: "All your expenses, neatly organized. Stay on top of your money effortlessly."
                )
                .tag(4)

                // Page 6: Get Started (Final screen)
                OnboardingFinalPage(navigateToUpload: navigateToUpload)
                    .tag(5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            // Navigation controls overlay
            VStack(spacing: 0) {
                // Skip button at top right
                if currentPage < totalPages - 1 {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                currentPage = totalPages - 1
                            }
                        }) {
                            Text("Skip")
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 60)
                } else {
                    Spacer()
                        .frame(height: 60)
                }

                Spacer()

                // Page indicators and navigation buttons at bottom
                VStack(spacing: 24) {
                    // Custom page indicators
                    HStack(spacing: 8) {
                        ForEach(0..<totalPages, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }

                    // Next and Back buttons
                    if currentPage < totalPages - 1 {
                        HStack(spacing: 12) {
                            // Back button
                            if currentPage > 0 {
                                Button(action: {
                                    withAnimation {
                                        currentPage -= 1
                                    }
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "chevron.left")
                                        Text("Back")
                                    }
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue, lineWidth: 1.5)
                                    )
                                }
                            }

                            // Next button
                            Button(action: {
                                withAnimation {
                                    currentPage += 1
                                }
                            }) {
                                HStack(spacing: 4) {
                                    Text("Next")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    var footer: String? = nil

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(minHeight: 60)

            // Image
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
                    .foregroundColor(.gray.opacity(0.3))
            }

            Spacer()
                .frame(minHeight: 32, maxHeight: 48)

            // Text content
            VStack(spacing: 12) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)

                if let footer = footer {
                    Text(footer)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
                .frame(minHeight: 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct OnboardingFinalPage: View {
    let navigateToUpload: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(minHeight: 60)

            // Door image
            if let uiImage = UIImage(named: "onboarding-6") {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
            } else {
                Image(systemName: "door.left.hand.open")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
                    .foregroundColor(.gray.opacity(0.3))
            }

            Spacer()
                .frame(minHeight: 32, maxHeight: 48)

            // Title
            Text("Ready to take control of\nyour spending?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 20)

            Spacer()
                .frame(height: 32)

            // Buttons
            VStack(spacing: 12) {
                // Continue with Apple
                Button(action: navigateToUpload) {
                    HStack(spacing: 8) {
                        Image(systemName: "apple.logo")
                            .font(.body)
                        Text("Continue with Apple")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                // Continue with Google
                Button(action: navigateToUpload) {
                    HStack(spacing: 8) {
                        Image(systemName: "g.circle.fill")
                            .font(.body)
                        Text("Continue with Google")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.systemBackground))
                    .foregroundColor(.primary)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.separator), lineWidth: 1)
                    )
                }

                // Log in
                Button(action: navigateToUpload) {
                    Text("Log in")
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.systemBackground))
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.separator), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 20)

            // Privacy note
            Text("Your photos are processed securely.\nOnly expense data is saved.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, 16)

            Spacer()
                .frame(minHeight: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    OnboardingView(navigateToUpload: {})
}
