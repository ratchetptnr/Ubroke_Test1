import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @State private var currentPage = 0
    let navigateToUpload: () -> Void
    let navigateToCamera: () -> Void
    let navigateToManual: () -> Void
    let navigateToDashboard: () -> Void

    let totalPages = 6

    var body: some View {
        ZStack {
            // Solid background
            Color(.systemBackground)
                .ignoresSafeArea()
            
            // Main content
            TabView(selection: $currentPage) {
                // Page 1: Welcome to Ubroke
                OnboardingPageView(
                    imageName: "face.smiling.fill",
                    title: "Welcome to Ubroke",
                    subtitle: "Turning your bills into money insights instantly.",
                    footer: "Built by Gen Z, for Gen Z"
                )
                .tag(0)

                // Page 2: Snap a bill
                OnboardingPageView(
                    imageName: "doc.text.viewfinder",
                    title: "Snap a bill",
                    subtitle: "Snap a bill, receipt, or screen.\nOne photo does the job."
                )
                .tag(1)

                // Page 3: AI does the heavy lifting
                OnboardingPageView(
                    imageName: "wand.and.stars",
                    title: "AI does the heavy lifting.",
                    subtitle: "We scan your photos, pick out totals, dates, and amounts, and more. So you don't have to."
                )
                .tag(2)

                // Page 4: You stay in control
                OnboardingPageView(
                    imageName: "checklist",
                    title: "You stay in control.",
                    subtitle: "Review what AI finds. Confirm or edit in seconds. Your money, your say."
                )
                .tag(3)

                // Page 5: See where your money goes
                OnboardingPageView(
                    imageName: "chart.bar.doc.horizontal.fill",
                    title: "See where your money goes.",
                    subtitle: "All your expenses, neatly organized. Stay on top of your money effortlessly."
                )
                .tag(4)

                // Page 6: Ready to take control (Auth + Choice)
                OnboardingFinalView(
                    navigateToUpload: navigateToUpload,
                    navigateToCamera: navigateToCamera,
                    navigateToManual: navigateToManual,
                    navigateToDashboard: navigateToDashboard
                )
                .tag(5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)
            
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
                                .fontWeight(.medium)
                                .foregroundColor(BrandColors.purple)
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
                            Capsule()
                                .fill(currentPage == index ? BrandColors.purple : BrandColors.purple.opacity(0.25))
                                .frame(width: currentPage == index ? 24 : 8, height: 8)
                                .animation(.spring(response: 0.3), value: currentPage)
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
                                    .font(.headline)
                                }
                                .buttonStyle(.brandOutline)
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
                                .font(.headline)
                            }
                            .buttonStyle(.brand)
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
            
            // Image with solid purple background
            ZStack {
                Circle()
                    .fill(BrandColors.purple.opacity(0.1))
                    .frame(width: 220, height: 220)
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 140, maxHeight: 140)
                    .foregroundStyle(BrandColors.purple)
            }
            .padding(.bottom, 40)
            
            Spacer()
                .frame(minHeight: 32, maxHeight: 48)
            
            // Text content
            VStack(spacing: 12) {
                Text(title)
                    .font(.largeTitle)
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
                        .fontWeight(.medium)
                        .foregroundStyle(BrandColors.purple)
                        .padding(.top, 8)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(minHeight: 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingFinalView: View {
    var navigateToUpload: () -> Void
    var navigateToCamera: () -> Void
    var navigateToManual: () -> Void
    var navigateToDashboard: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Icon with solid purple background
            ZStack {
                Circle()
                    .fill(BrandColors.purple.opacity(0.1))
                    .frame(width: 160, height: 160)
                
                Image(systemName: "door.left.hand.open")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundStyle(BrandColors.purple)
            }
            .padding(.bottom, 32)
            
            // Title
            Text("Ready to take control of\nyour spending?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            
            // Auth Buttons
            VStack(spacing: 12) {
                // Continue with Apple
                SignInWithAppleButton(.continue) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                    case .success(_):
                        navigateToDashboard()
                    case .failure(let error):
                        print("Sign in failed: \(error.localizedDescription)")
                    }
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(height: 50)
                .cornerRadius(12)
                
                // Continue with Google (Placeholder button)
                Button(action: navigateToDashboard) {
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
                Button(action: navigateToDashboard) {
                    Text("Log in")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.brandOutline)
            }
            .padding(.horizontal, 20)
            
            // Privacy note with gold lock icon
            HStack(spacing: 4) {
                Image(systemName: "lock.shield.fill")
                    .font(.caption)
                    .foregroundColor(BrandColors.gold)
                
                Text("Your photos are processed securely.\nOnly expense data is saved.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.center)
            .padding(.top, 16)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView(
        navigateToUpload: {},
        navigateToCamera: {},
        navigateToManual: {},
        navigateToDashboard: {}
    )
}
