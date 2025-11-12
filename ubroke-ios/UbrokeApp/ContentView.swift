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

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            ResultsView(navigateToUpload: navigateToUpload)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            // Ask AI Tab - Shows list of chats
            ChatListView()
                .tabItem {
                    Label("Ask AI", systemImage: "message.fill")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
