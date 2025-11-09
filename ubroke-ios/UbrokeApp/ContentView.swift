import SwiftUI

struct ContentView: View {
    @State private var currentScreen: AppScreen = .welcome

    var body: some View {
        NavigationStack {
            Group {
                switch currentScreen {
                case .welcome:
                    WelcomeView(navigateToProfile: {
                        currentScreen = .profile
                    })
                case .profile:
                    ProfileView(
                        navigateBack: { currentScreen = .welcome },
                        navigateToUpload: { currentScreen = .upload }
                    )
                case .upload:
                    UploadView(
                        navigateBack: { currentScreen = .profile },
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
    case welcome
    case profile
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

            // Ask AI Tab
            ChatView()
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
