# 📱 Android Development & Testing Guide

## ✅ Setup Complete!

Your Flutter app is now ready for Android development and testing!

---

## 🔧 What Has Been Fixed & Configured

### 1. **Main.dart Error - FIXED ✅**
- Fixed the `CardTheme` type error by adding `const` keyword
- App now compiles without errors

### 2. **Android Platform Files - CREATED ✅**
- Complete Android project structure created
- Gradle build files configured
- MainActivity.kt created
- AndroidManifest.xml with all required permissions

### 3. **Permissions Added - CONFIGURED ✅**

#### Android Permissions (`android/app/src/main/AndroidManifest.xml`):
```xml
✅ INTERNET - To connect to your FastAPI backend
✅ CAMERA - To capture leaf photos
✅ READ_EXTERNAL_STORAGE - To access gallery
✅ WRITE_EXTERNAL_STORAGE - To save images (Android 12 and below)
✅ READ_MEDIA_IMAGES - For Android 13+ gallery access
```

#### iOS Permissions (`ios/Runner/Info.plist`):
```xml
✅ NSCameraUsageDescription - Camera access
✅ NSPhotoLibraryUsageDescription - Gallery access
✅ NSPhotoLibraryAddUsageDescription - Save photos
```

---

## 💻 Testing on Your Laptop (Android Emulator)

### **Option 1: Using Android Studio (Recommended)**

#### Step 1: Install Android Studio
1. Download from: https://developer.android.com/studio
2. Install Android Studio
3. During installation, make sure to install:
   - Android SDK
   - Android SDK Platform
   - Android Virtual Device (AVD)

#### Step 2: Set Up Environment Variables
Add to your System Environment Variables:
```
ANDROID_HOME = C:\Users\YourUsername\AppData\Local\Android\Sdk
```
Add to PATH:
```
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\tools
%ANDROID_HOME%\tools\bin
```

#### Step 3: Create Virtual Device (Emulator)
1. Open Android Studio
2. Click "More Actions" → "Virtual Device Manager"
3. Click "Create Device"
4. Select a device (e.g., Pixel 7)
5. Download a system image (e.g., Android 13 - Tiramisu)
6. Click "Finish"

#### Step 4: Run Flutter App on Emulator
```powershell
cd frontend

# Start the emulator
flutter emulators --launch <emulator_name>

# Or start from Android Studio AVD Manager

# Run your app
flutter run
```

### **Option 2: Using Visual Studio Code**

#### Step 1: Install VS Code Extensions
1. Install "Flutter" extension
2. Install "Dart" extension

#### Step 2: Select Device
1. Click on device selector in bottom-right corner
2. Select your Android emulator
3. Press F5 or click "Run" → "Start Debugging"

---

## 📱 Testing on Your Phone (Physical Device)

### **Step 1: Enable Developer Options on Your Phone**
1. Go to **Settings** → **About Phone**
2. Tap **Build Number** 7 times
3. You'll see "You are now a developer!"

### **Step 2: Enable USB Debugging**
1. Go to **Settings** → **Developer Options**
2. Enable **USB Debugging**
3. Enable **Install via USB** (if available)

### **Step 3: Connect Your Phone**
1. Connect phone to laptop via USB cable
2. On phone, tap **"Allow USB Debugging"** when prompted
3. Select **"File Transfer (MTP)"** or **"PTP"** mode

### **Step 4: Verify Connection**
```powershell
cd frontend
flutter devices
```

You should see your phone listed like:
```
SM G991B (mobile) • R5CR30XXXXX • android-arm64 • Android 13 (API 33)
```

### **Step 5: Run App on Your Phone**
```powershell
cd frontend
flutter run
```

The app will install and launch on your phone automatically!

---

## 🚀 Quick Commands Reference

### Check Flutter Installation
```powershell
flutter doctor -v
```
This shows what's installed and what's missing.

### List Available Devices
```powershell
cd frontend
flutter devices
```

### Run App (Auto-selects device if only one connected)
```powershell
cd frontend
flutter run
```

### Run on Specific Device
```powershell
cd frontend
flutter run -d <device-id>
```

### Run in Release Mode (Faster, Optimized)
```powershell
cd frontend
flutter run --release
```

### Hot Reload (While App is Running)
Press `r` in terminal to hot reload changes

### Hot Restart (While App is Running)
Press `R` in terminal to hot restart

### Build APK for Sharing
```powershell
cd frontend
flutter build apk --release
```
APK location: `frontend\build\app\outputs\flutter-apk\app-release.apk`

### Install APK on Phone
```powershell
cd frontend\build\app\outputs\flutter-apk
adb install app-release.apk
```

---

## 🐛 Troubleshooting

### **Problem: "No devices found"**
**Solution:**
```powershell
# Check if adb sees your device
adb devices

# If not listed, restart adb
adb kill-server
adb start-server
adb devices
```

### **Problem: "USB Debugging not working"**
**Solution:**
1. Revoke USB debugging authorizations (Developer Options)
2. Disconnect and reconnect phone
3. Re-authorize computer

### **Problem: "Flutter doctor shows Android issues"**
**Solution:**
```powershell
# Accept Android licenses
flutter doctor --android-licenses

# Press 'y' for all
```

### **Problem: "Gradle build failed"**
**Solution:**
```powershell
cd frontend\android
.\gradlew clean

cd ..
flutter clean
flutter pub get
flutter run
```

### **Problem: "Camera/Gallery not working on phone"**
**Solution:**
1. Make sure you added permissions to AndroidManifest.xml (✅ Already done!)
2. Uninstall app from phone
3. Reinstall: `flutter run`
4. Grant permissions when prompted

### **Problem: "App is slow on emulator"**
**Solution:**
1. Enable hardware acceleration in BIOS (Intel VT-x / AMD-V)
2. Use a newer system image (Android 11+)
3. Increase emulator RAM in AVD settings
4. Or test on physical device (much faster!)

---

## 📊 System Requirements

### For Android Emulator:
- **RAM:** Minimum 8GB (16GB recommended)
- **Disk Space:** 10GB free space
- **Processor:** Intel i5 or better with virtualization support
- **OS:** Windows 10/11 64-bit

### For Physical Device Testing:
- **Phone:** Android 5.0 (API 21) or higher
- **USB Cable:** Data transfer capable (not just charging)
- **USB Drivers:** Usually auto-installed with Android Studio

---

## 🎯 Testing Your App

### **Test Camera Functionality:**
1. Launch app
2. Tap "Take Photo"
3. Grant camera permission if asked
4. Capture a leaf image
5. Wait for prediction results

### **Test Gallery Functionality:**
1. Launch app
2. Tap "Choose from Gallery"
3. Grant storage permission if asked
4. Select a leaf image
5. Wait for prediction results

### **Test API Connection:**
- Make sure your laptop/phone has internet
- App will connect to: `https://trimodal-xai-backend-production.up.railway.app/predict`
- If it fails, check backend is running

### **Test Error Handling:**
1. Turn off WiFi → Should show connection error
2. Select invalid image → Should handle gracefully

---

## 📦 Project Structure (Android Specific)

```
frontend/
├── android/                          # Android native code
│   ├── app/
│   │   ├── src/
│   │   │   └── main/
│   │   │       ├── AndroidManifest.xml    # ✅ Permissions configured
│   │   │       └── kotlin/                # MainActivity
│   │   └── build.gradle.kts               # App-level build config
│   ├── build.gradle.kts                   # Project-level build config
│   └── settings.gradle.kts                # Project settings
├── ios/                                    # iOS native code
│   └── Runner/
│       └── Info.plist                      # ✅ Permissions configured
└── lib/                                    # ✅ Your Flutter code
```

---

## ✨ You're All Set!

### Quick Start:
```powershell
# 1. Check everything is ready
flutter doctor

# 2. Navigate to project
cd frontend

# 3. Connect phone OR start emulator

# 4. Run app
flutter run
```

### Common Workflow:
1. **Start developing:** `flutter run`
2. **Make code changes:** Save files
3. **Hot reload:** Press `r` in terminal
4. **See changes:** Instantly on device/emulator
5. **Build APK:** `flutter build apk --release` when done

---

## 📱 Sharing Your App (APK)

To share the app with others:

```powershell
cd frontend
flutter build apk --release
```

APK location: `frontend\build\app\outputs\flutter-apk\app-release.apk`

Send this APK file to anyone with an Android phone!
They can install it directly (may need to enable "Install from Unknown Sources").

---

## 🎓 Learning Resources

- Flutter Docs: https://docs.flutter.dev/
- Android Developer Guide: https://developer.android.com/
- Flutter YouTube: https://www.youtube.com/c/flutterdev
- Flutter Samples: https://flutter.github.io/samples/

---

## 🆘 Need Help?

### Check Flutter Setup
```powershell
flutter doctor -v
```

### Get Logs
```powershell
cd frontend
flutter run --verbose
```

### Clear Everything and Restart
```powershell
cd frontend
flutter clean
flutter pub get
flutter run
```

---

**Happy Testing! 🚀🌿**

Your Medicinal Leaf Classifier app is ready to run on both emulator and physical Android devices!
