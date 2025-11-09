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
                        navigateToResults: { currentScreen = .results }
                    )
                case .results:
                    ResultsView(
                        navigateToUpload: { currentScreen = .upload },
                        navigateToChat: { currentScreen = .chat }
                    )
                case .chat:
                    ChatView(
                        navigateBack: { currentScreen = .results }
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
    case results
    case chat
}

#Preview {
    ContentView()
}
