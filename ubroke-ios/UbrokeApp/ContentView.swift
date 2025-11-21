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
    @State private var showingManualEntry = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                // Home Tab
                Tab("Home", systemImage: "house.fill", value: 0) {
                    ResultsView(navigateToUpload: navigateToUpload)
                }

                // Transactions Tab
                Tab("Transactions", systemImage: "list.bullet.rectangle.fill", value: 1) {
                    TransactionsView()
                }

                // Ask AI Tab
                Tab("Ask AI", systemImage: "message.fill", value: 2) {
                    ChatListView()
                }
            }

            // Floating Add button with Menu
            Menu {
                Button(action: { navigateToUpload() }) {
                    Label("Upload Documents", systemImage: "doc.fill")
                }
                Button(action: { showingManualEntry = true }) {
                    Label("Add Manually", systemImage: "pencil.line")
                }
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .padding(.trailing, 20)
            .padding(.bottom, 2)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .sheet(isPresented: $showingManualEntry) {
            AddTransactionView()
        }
    }
}

#Preview {
    ContentView()
}
