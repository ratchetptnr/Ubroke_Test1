# 🚀 Quick Start Guide - Ubroke iOS Demo

Get the demo app running in **under 5 minutes**.

## Prerequisites

- Mac computer
- Xcode 15 or later installed ([Download here](https://developer.apple.com/xcode/))

## Step-by-Step

### 1. Open Project
```bash
cd ubroke-ios
open UbrokeApp.xcodeproj
```

### 2. Wait for Xcode to Load
- First time may take 1-2 minutes
- Xcode will index the project

### 3. Select Simulator
- Click on the device selector (top bar, next to "UbrokeApp")
- Choose: **iPhone 15 Pro** (or any iOS 18+ device)

### 4. Run the App
- Press `Cmd + R` **OR**
- Click the ▶️ Play button

### 5. Wait for Build
- First build: ~30 seconds
- Subsequent builds: ~5 seconds

### 6. Demo is Ready! 🎉

The app will launch in the simulator and show the **Welcome Screen**.

## 📱 How to Use the Demo

### Welcome Screen
- Tap **"Continue"** to start

### Profile Setup
- Scroll through the pickers to select options
- Tap **"Let's Start"** or **"Skip"**

### Upload Screen
- Tap **anywhere** to simulate file upload
- Options: Drag & Drop area, Take Photo, or Browse

### Processing
- **Automatic!** Watch the progress animation
- Shows: 0% → 25% → 50% → 75% → 100%
- Auto-navigates to Results after 5 seconds

### Results Dashboard
- Scroll to see all expense categories
- Tap **"Ask AI"** to go to chat
- Tap **"Upload More"** to return to upload

### Chat Interface
- Tap a **suggested question** OR
- Type your own message and tap the **blue arrow**
- AI responds after 1 second

## 🔄 Restart Demo

**In Simulator:**
- Press `Cmd + R` in Xcode to rebuild
- Or swipe up and relaunch from home screen

**Reset completely:**
- In Xcode: `Product` → `Clean Build Folder` (`Cmd + Shift + K`)
- Then run again (`Cmd + R`)

## 🎯 Demo Tips

### For Best Demo Experience

1. **Use largest simulator** - iPhone 15 Pro Max for best visuals
2. **Full screen** - Press `Cmd + Ctrl + F` to make simulator full screen
3. **Hide cursor** - Press `Cmd + Shift + H` to hide Mac cursor in recordings
4. **Record screen** - Use QuickTime or built-in screen recorder

### Common Issues

**Issue**: "No simulators available"
- **Fix**: Open Xcode → Window → Devices and Simulators → Add simulator

**Issue**: Build failed
- **Fix**: Clean build folder (`Cmd + Shift + K`) and rebuild

**Issue**: Simulator is slow
- **Fix**: Close other apps, or use a smaller device (iPhone 15 instead of Pro Max)

**Issue**: App crashes
- **Fix**: Reset simulator (Device → Erase All Content and Settings)

## 📸 Recording a Demo Video

### Using Mac Screen Recording

1. Press `Cmd + Shift + 5` on Mac
2. Select "Record Selected Portion"
3. Draw around the simulator window
4. Click **Record**
5. Run through the app flow
6. Click **Stop** in menu bar when done

### Using QuickTime

1. Open QuickTime Player
2. File → New Screen Recording
3. Click record and select simulator window
4. Run through the demo
5. Stop recording

## 🎨 Customization (Optional)

### Change App Name Display
Edit `Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>Your New Name</string>
```

### Adjust Simulator
- **Rotate**: `Cmd + Left/Right Arrow`
- **Home**: `Cmd + Shift + H`
- **Screenshot**: `Cmd + S`

## 🎯 Demo Script (30 seconds)

Perfect for showing friends:

1. **Welcome** (3 sec) - "This is Ubroke, your AI finance brain"
2. **Profile** (3 sec) - "Quick setup, totally optional"
3. **Upload** (2 sec) - "Upload any financial document"
4. **Processing** (5 sec) - "AI analyzes in real-time"
5. **Results** (10 sec) - "See exactly where your money goes"
6. **Chat** (7 sec) - "Ask anything about your finances"

**Total**: ~30 seconds for full flow

## 🚨 Important Notes

- **All data is dummy** - No real uploading or AI
- **Resets on close** - Nothing is saved
- **Demo only** - Not for production use
- **iOS 18+ only** - Won't work on older iOS versions

## ✅ You're Ready!

The app is fully functional for demos. Every screen works, all transitions are smooth, and it looks 100% native.

**Enjoy showing it off! 🎉**
