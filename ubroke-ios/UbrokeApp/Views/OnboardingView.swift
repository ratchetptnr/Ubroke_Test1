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
            VStack {
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
                                .font(.system(size: 17))
                                .foregroundColor(.blue)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                        }
                    }
                    .padding(.top, 50)
                }

                Spacer()

                // Page indicators and navigation buttons at bottom
                VStack(spacing: 20) {
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
                        HStack(spacing: 16) {
                            // Back button
                            if currentPage > 0 {
                                Button(action: {
                                    withAnimation {
                                        currentPage -= 1
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Back")
                                    }
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(Color.white)
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
                                HStack {
                                    Text("Next")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.blue)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                }
                .padding(.bottom, 40)
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
        VStack(spacing: 30) {
            Spacer()

            // Image - Try to load from Assets
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
            } else {
                // Fallback placeholder
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
                    .foregroundColor(.gray.opacity(0.3))
            }

            Spacer()

            // Text content
            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 40)

                if let footer = footer {
                    Text(footer)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
            }
            .padding(.bottom, 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct OnboardingFinalPage: View {
    let navigateToUpload: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            // Door image
            if let uiImage = UIImage(named: "onboarding-6") {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
            } else {
                // Fallback placeholder
                Image(systemName: "door.left.hand.open")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280, maxHeight: 280)
                    .foregroundColor(.gray.opacity(0.3))
            }

            Spacer()

            // Title
            Text("Ready to take control of\nyour spending?")
                .font(.system(size: 28, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 40)

            // Buttons
            VStack(spacing: 12) {
                // Continue with Apple
                Button(action: navigateToUpload) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .font(.system(size: 20))
                        Text("Continue with Apple")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                // Continue with Google
                Button(action: navigateToUpload) {
                    HStack {
                        Image(systemName: "g.circle.fill")
                            .font(.system(size: 20))
                        Text("Continue with Google")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }

                // Log in
                Button(action: navigateToUpload) {
                    Text("Log in")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 40)

            // Privacy note
            Text("Your photos are processed securely.\nOnly expense data is saved.")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                .padding(.bottom, 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    OnboardingView(navigateToUpload: {})
}
