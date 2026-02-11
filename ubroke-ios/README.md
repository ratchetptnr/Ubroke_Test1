# Ubroke 2.0 - Native iOS App (Demo)

A **native iOS demo app** built with SwiftUI for the Ubroke 2.0 MVP - a personal finance AI app for Gen Z.

## 🎯 What's Built

This is a **fully functional demo app** showcasing the complete user journey with native iOS 18+ design patterns.

### ✨ Features

- ✅ **Native SwiftUI** - Modern iOS development
- ✅ **iOS 18+ Design** - Liquid glass (frosted glass) effects throughout
- ✅ **Native Components** - Out-of-the-box Apple UI patterns
- ✅ **Complete Flow** - All 6 screens connected
- ✅ **Smooth Animations** - Native iOS transitions
- ✅ **Dummy Data** - Perfect for demos

## 📱 Screens Implemented

### 1. Welcome Screen
- Liquid glass cards with frosted material
- Trust-building messaging
- Feature highlights with SF Symbols icons
- Native button styling

### 2. Profile Setup
- Native iOS wheel pickers
- 3-question onboarding flow
- Income range selection
- Work type and goals
- Skip option available

### 3. Upload Screen
- Document picker interface
- Camera and file browser buttons
- Drag & drop visual indicator
- Info cards with native materials

### 4. Processing Screen
- Native ProgressView with smooth animations
- Step-by-step status tracking
- Auto-transitions through states:
  - 0% → 25% → 50% → 75% → 100%
  - Completion with stats preview
  - Auto-navigate to results

### 5. Results Dashboard
- Expense breakdown by category
- Native progress bars for each category
- Color-coded spending alerts
- Interactive category rows
- Insights with bullet points
- Call-to-action buttons

### 6. Chat Interface
- Native iOS message bubbles
- ScrollViewReader for auto-scroll
- Suggested questions as pills
- Text input with send button
- Simulated AI responses (1-second delay)

## 🎨 Design Elements

### Native iOS Components Used:

- **Materials**: `.ultraThinMaterial` for liquid glass effect
- **SF Symbols**: All icons from SF Symbols library
- **Native Pickers**: iOS wheel-style pickers
- **ProgressView**: Native circular and linear progress
- **NavigationStack**: Modern iOS navigation
- **Gradients**: LinearGradient backgrounds
- **Animations**: Native spring and easeInOut

### Color Scheme:

- Primary: System Blue
- Accent Colors: Category-specific (Orange, Purple, Pink, etc.)
- Background: Blue gradient to white
- Glass Cards: Ultra-thin material with shadows

## 🚀 How to Run

### Requirements

- **Xcode 15+** (for iOS 18 support)
- **macOS Ventura+**
- **iOS 18+ Simulator or Device**

### Steps

1. **Open in Xcode**
   ```bash
   cd ubroke-ios
   open UbrokeApp.xcodeproj
   ```

2. **Select Target**
   - Choose "UbrokeApp" scheme
   - Select iPhone 15 Pro simulator (or any iOS 18+ device)

3. **Build and Run**
   - Press `Cmd + R` or click the Play button
   - App will launch in simulator

## 📂 Project Structure

```
ubroke-ios/
├── UbrokeApp/
│   ├── UbrokeApp.swift          # App entry point
│   ├── ContentView.swift        # Navigation coordinator
│   ├── Views/
│   │   ├── WelcomeView.swift    # Welcome screen
│   │   ├── ProfileView.swift    # Profile setup
│   │   ├── UploadView.swift     # Document upload
│   │   ├── ProcessingView.swift # Processing animation
│   │   ├── ResultsView.swift    # Expense dashboard
│   │   └── ChatView.swift       # AI chat interface
│   └── Info.plist               # App configuration
└── UbrokeApp.xcodeproj/         # Xcode project file
```

## 🎬 User Flow

```
Welcome
  ↓
Profile Setup (skippable)
  ↓
Upload Document (tap anywhere to proceed)
  ↓
Processing (auto-animates for 4 seconds)
  ↓
Results Dashboard
  ↓
Chat Interface (tap suggested questions or type)
```

## 🔄 Navigation

All screens use **closure-based navigation** for clean state management:

```swift
WelcomeView(navigateToProfile: { currentScreen = .profile })
```

Navigation is controlled by `ContentView` using an enum-based approach with smooth animations.

## 💾 Dummy Data

### Processing Simulation
- 4-second animation cycle
- Progress: 0% → 25% → 50% → 75% → 100%
- Completion stats: 47 transactions, 8 categories, 6 recurring

### Results Data
- Total spend: ₹47,500
- 7 categories with percentages
- Food & Delivery flagged as high (18%)
- 3 key insights

### Chat Messages
- Pre-loaded assistant greeting
- 4 suggested questions
- Simulated response after 1 second
- Dummy financial advice text

## 🎯 iOS 18+ Features Used

1. **Liquid Glass Effects**
   - `.ultraThinMaterial` for frosted glass
   - Layered shadows and blurs
   - Native vibrancy

2. **Modern SwiftUI Patterns**
   - `NavigationStack` (iOS 16+)
   - `ScrollViewReader` for chat auto-scroll
   - State-driven UI updates

3. **SF Symbols 5**
   - All icons are native SF Symbols
   - Automatic scaling and weight adaptation

4. **Native Animations**
   - Spring animations for transitions
   - Linear progress animations
   - Smooth state changes

## 🎨 Design Philosophy

### No Custom Styling
All components use **out-of-the-box iOS patterns**:
- Native buttons (no custom shapes)
- System fonts
- Standard corner radius
- Built-in materials
- Apple's color system

### Accessibility
- Native components ensure VoiceOver support
- Dynamic Type support
- High contrast color choices
- Touch target sizes meet Apple HIG

## 📝 Key Code Patterns

### Reusable Glass Card Component
```swift
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
                    .shadow(color: .black.opacity(0.1), radius: 10)
            )
    }
}
```

### State-Based Screen Navigation
```swift
enum AppScreen {
    case welcome, profile, upload, processing, results, chat
}

@State private var currentScreen: AppScreen = .welcome
```

### Processing Animation
```swift
func startProcessing() {
    withAnimation(.linear(duration: 1.0)) {
        progress = 25
        currentStep = 2
    }
    // ... more steps
}
```

## 🚧 What's NOT Implemented (Demo Only)

Since this is a demo app for showing friends:

- ❌ No actual file picking (taps proceed to next screen)
- ❌ No real AI integration (responses are hardcoded)
- ❌ No data persistence (resets on app close)
- ❌ No backend API calls
- ❌ No user authentication
- ❌ No real document parsing

## 🎯 Perfect For

✅ Showing to friends and investors
✅ UX/UI demonstrations
✅ Flow testing and validation
✅ Design iterations
✅ User feedback sessions

## 🔜 Next Steps (For Production)

To turn this into a real app:

1. **Backend Integration**
   - Connect to actual API
   - Implement real document upload to cloud storage
   - Add AI parsing service

2. **Data Persistence**
   - Core Data or SwiftData
   - User defaults for preferences
   - Secure storage for sensitive data

3. **Authentication**
   - Sign in with Apple
   - Email/password authentication
   - Biometric authentication

4. **Real Features**
   - PHPickerViewController for actual photo picking
   - DocumentPicker for file selection
   - Claude API integration for chat

5. **Polish**
   - Error handling
   - Loading states
   - Offline support
   - Push notifications

## 📱 Target Devices

- **iOS 18.0+** required
- **Optimized for**: iPhone 14 Pro, iPhone 15 Pro
- **Orientation**: Portrait only
- **Screen sizes**: 6.1" to 6.7"

## 🎉 Demo Ready!

This app is **100% ready to show**:
- All screens work
- Smooth transitions
- Native iOS feel
- Professional appearance
- Complete user journey

Perfect for demonstrating the Ubroke concept to friends, investors, or potential users!

---

**Built with ❤️ using SwiftUI and iOS 18 native components**
