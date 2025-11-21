import SwiftUI

struct ContentView: View {
    @State private var currentScreen: AppScreen = .onboarding
    @State private var hasCompletedOnboarding = false
    @State private var previousScreen: AppScreen = .onboarding

    var body: some View {
        Group {
            switch currentScreen {
            case .onboarding:
                NavigationStack {
                    OnboardingView(navigateToUpload: {
                        previousScreen = .onboarding
                        currentScreen = .upload
                    })
                    .navigationBarHidden(true)
                }
            case .upload:
                NavigationStack {
                    UploadView(
                        navigateBack: {
                            currentScreen = previousScreen
                        },
                        navigateToProcessing: { currentScreen = .processing }
                    )
                }
            case .processing:
                NavigationStack {
                    ProcessingView(
                        navigateToResults: {
                            hasCompletedOnboarding = true
                            currentScreen = .mainApp
                        }
                    )
                }
            case .mainApp:
                MainTabView(
                    navigateToUpload: {
                        previousScreen = .mainApp
                        currentScreen = .upload
                    }
                )
            }
        }
        .animation(.easeInOut, value: currentScreen)
        .onAppear {
            // Skip onboarding if already completed
            if hasCompletedOnboarding {
                currentScreen = .mainApp
            }
        }
    }
}

enum AppScreen {
    case onboarding
    case upload
    case processing
    case mainApp
}

// Main app with tab bar
struct MainTabView: View {
    let navigateToUpload: () -> Void
    @State private var selectedTab = 0
    @State private var showingAddOptions = false
    @State private var showingManualEntry = false

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            Tab("Home", systemImage: "house.fill", value: 0) {
                ResultsView(navigateToUpload: navigateToUpload)
            }

            // Transactions Tab
            Tab("Transactions", systemImage: "list.bullet.rectangle.fill", value: 1) {
                TransactionsView()
            }

            // Add Tab (floating style)
            Tab("Add", systemImage: "plus.circle.fill", value: 3, role: .search) {
                // This view won't actually show - we intercept it
                Color.clear
            }

            // Ask AI Tab
            Tab("Ask AI", systemImage: "message.fill", value: 2) {
                ChatListView()
            }
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == 3 {
                // Reset to previous tab and show action sheet
                selectedTab = oldValue
                showingAddOptions = true
            }
        }
        .confirmationDialog("Add Transaction", isPresented: $showingAddOptions, titleVisibility: .visible) {
            Button("Upload Documents") {
                navigateToUpload()
            }
            Button("Add Manually") {
                showingManualEntry = true
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("How would you like to add a transaction?")
        }
        .sheet(isPresented: $showingManualEntry) {
            AddTransactionView()
        }
    }
}

#Preview {
    ContentView()
}
