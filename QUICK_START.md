# 🚀 Quick Start Guide - Medicinal Leaf Classifier

## ✅ EVERYTHING IS READY!

### Main.dart Error - FIXED ✓
The `CardTheme` error has been fixed. Your app now compiles without errors!

---

## 📱 HOW TO TEST ON YOUR LAPTOP (Windows)

### Option 1: Android Emulator (Requires Android Studio)

#### If you DON'T have Android Studio installed:

**1. Install Android Studio**
   - Download: https://developer.android.com/studio
   - Run installer and install everything (SDK, Emulator, etc.)
   - Takes ~10-15 minutes

**2. Create Virtual Device**
   - Open Android Studio
   - Click "More Actions" → "Virtual Device Manager"
   - Click "+" or "Create Device"
   - Choose "Pixel 7" or any device
   - Download system image (Android 13 recommended)
   - Click Finish

**3. Run Your App**
   ```powershell
   cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
   flutter run
   ```

---

### Option 2: Chrome (Web - Quick Test)

**Fastest way to test without any extra setup:**

```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter run -d chrome
```

⚠️ **Note:** Camera won't work in web version, but you can test with "Choose from Gallery"

---

## 📱 HOW TO TEST ON YOUR PHONE

### Step-by-Step for Android Phone:

**1. Enable Developer Mode**
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Enter your PIN if asked
   - You'll see "You are now a developer!"

**2. Enable USB Debugging**
   - Go to Settings → System → Developer Options
   - Turn on "USB Debugging"
   - Turn on "Install via USB" (if available)

**3. Connect Phone to Laptop**
   - Use USB cable (make sure it's a data cable, not just charging)
   - On your phone, tap "Allow USB Debugging" when prompted
   - Check "Always allow from this computer"

**4. Verify Connection**
   ```powershell
   cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
   flutter devices
   ```
   
   You should see your phone listed!

**5. Run App on Phone**
   ```powershell
   flutter run
   ```
   
   The app will install and launch on your phone! 🎉

---

## 🎯 TESTING THE APP

### What to Test:

1. **Take Photo**
   - Click "Take Photo" button
   - Grant camera permission
   - Capture a leaf image
   - See prediction results

2. **Choose from Gallery**
   - Click "Choose from Gallery"
   - Grant storage permission
   - Select a leaf image
   - See prediction results

3. **View Results**
   - Check predicted class
   - See confidence score
   - Expand "Top 3 Predictions"
   - Expand "Medicinal Knowledge"
   - Expand "AI Explanation (Grad-CAM)"

4. **Analyze Another**
   - Click "Analyze Another Leaf"
   - Try with different images

---

## 🔧 COMMON COMMANDS

### Check if everything is working:
```powershell
flutter doctor
```

### See connected devices:
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter devices
```

### Run app (auto-selects device):
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter run
```

### Run on specific device:
```powershell
flutter run -d <device-id>
```

### Hot reload (while app is running):
Press `r` in terminal

### Hot restart (while app is running):
Press `R` in terminal

### Build APK to share with friends:
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter build apk --release
```
APK will be at: `build\app\outputs\flutter-apk\app-release.apk`

---

## 🐛 TROUBLESHOOTING

### "No devices found"
```powershell
# Check if phone is connected
adb devices

# If nothing shows, restart adb
adb kill-server
adb start-server
adb devices
```

### "USB Debugging authorization failed"
1. Disconnect phone
2. On phone: Settings → Developer Options → Revoke USB debugging authorizations
3. Reconnect phone
4. Re-authorize

### "Gradle build failed"
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter clean
flutter pub get
flutter run
```

### "Camera/Gallery not working"
1. Uninstall app from phone
2. Run `flutter run` again
3. Grant permissions when asked

### App crashes or errors:
```powershell
# See detailed logs
flutter run --verbose
```

---

## 📦 WHAT'S BEEN CONFIGURED

✅ **Main.dart fixed** - No errors
✅ **Android permissions** - Camera, Storage, Internet
✅ **iOS permissions** - Camera, Photo Library
✅ **All dependencies installed** - Ready to run
✅ **Android project created** - Build files ready
✅ **iOS project created** - Build files ready

---

## 🎨 YOUR APP FEATURES

1. ✨ Beautiful Material 3 UI with green theme
2. 📷 Take photos with camera
3. 🖼️ Choose images from gallery
4. 🤖 AI prediction from FastAPI backend
5. 📊 Confidence score with visual indicator
6. 🏆 Top 3 predictions with probabilities
7. 💊 Medicinal knowledge (expandable)
8. 🔥 Grad-CAM visualization (expandable)
9. ⚡ Fast loading with progress indicator
10. 🛡️ Error handling with friendly messages

---

## 🎓 NEXT STEPS

### To test NOW (easiest):
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter run -d chrome
```

### To test on phone:
1. Enable USB Debugging (see steps above)
2. Connect phone
3. Run: `flutter run`

### To test on emulator:
1. Install Android Studio
2. Create virtual device
3. Run: `flutter run`

---

## 📞 SUPPORT

### Get help:
```powershell
flutter doctor -v     # Shows detailed setup info
flutter devices       # Lists available devices
flutter logs          # Shows runtime logs
```

### Flutter Resources:
- Docs: https://docs.flutter.dev/
- YouTube: https://www.youtube.com/c/flutterdev
- Community: https://stackoverflow.com/questions/tagged/flutter

---

## ✨ YOU'RE ALL SET!

Your Medicinal Leaf Classifier app is ready to run!

**Quickest way to test RIGHT NOW:**
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter run -d chrome
```

**Or connect your phone and run:**
```powershell
cd C:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter run
```

Happy Testing! 🌿📱
