import SwiftUI

struct ContentView: View {
    @State private var currentScreen: AppScreen = .onboarding

    var body: some View {
        NavigationStack {
            Group {
                switch currentScreen {
                case .onboarding:
                    OnboardingView(navigateToUpload: {
                        currentScreen = .upload
                    })
                    .navigationBarHidden(true)
                case .upload:
                    UploadView(
                        navigateBack: { currentScreen = .onboarding },
                        navigateToProcessing: { currentScreen = .processing }
                    )
                case .processing:
                    ProcessingView(
                        navigateToResults: { currentScreen = .mainApp }
                    )
                case .mainApp:
                    MainTabView(
                        navigateToUpload: { currentScreen = .upload }
                    )
                }
            }
            .animation(.easeInOut, value: currentScreen)
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
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
