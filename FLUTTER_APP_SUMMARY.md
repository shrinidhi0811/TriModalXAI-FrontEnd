# 🌿 Medicinal Leaf Classifier - Complete Flutter App

## ✅ Project Successfully Created!

I've built a complete, production-ready Flutter mobile application for your Medicinal Leaf Classifier project.

---

## 📁 Project Structure

```
frontend/
├── lib/
│   ├── main.dart                           # App entry point with Material 3 theme
│   ├── constants/
│   │   └── api_constants.dart             # API endpoint configuration
│   ├── models/
│   │   └── prediction_response.dart       # Data models for API responses
│   ├── providers/
│   │   └── prediction_provider.dart       # State management (Provider pattern)
│   ├── screens/
│   │   ├── home_screen.dart               # Landing page with upload options
│   │   └── result_screen.dart             # Results display with all features
│   ├── services/
│   │   └── api_service.dart               # FastAPI backend communication
│   └── widgets/
│       ├── prediction_card.dart           # Main prediction display widget
│       ├── top3_predictions_card.dart     # Top 3 predictions with progress bars
│       ├── knowledge_card.dart            # Collapsible medicinal info
│       └── gradcam_card.dart              # Grad-CAM visualization widget
├── pubspec.yaml                            # Dependencies & configuration
├── analysis_options.yaml                   # Linting rules
├── .gitignore                              # Git ignore rules
└── README.md                               # Comprehensive documentation
```

---

## 🎨 Features Implemented

### 1. **Home Screen**
- ✅ Beautiful Material 3 design with light green theme
- ✅ App branding and description
- ✅ Feature highlights (AI Classification, Medicinal Info, Explainable AI)
- ✅ Two upload options:
  - 📷 "Take Photo" - Camera capture
  - 🖼️ "Choose from Gallery" - Image picker

### 2. **API Integration**
- ✅ Connects to: `https://trimodal-xai-backend-production.up.railway.app/predict`
- ✅ Handles multipart/form-data image upload
- ✅ Parses JSON response with all fields:
  - `predicted_class`
  - `confidence`
  - `top3` predictions
  - `knowledge` (medicinal information)
  - `gradcam_image_base64`

### 3. **Loading State**
- ✅ Elegant loading indicator while processing
- ✅ "Analyzing leaf..." message
- ✅ Non-blocking UI

### 4. **Results Screen**
- ✅ **Uploaded Image Preview** - Shows the original image
- ✅ **Prediction Card**:
  - Predicted class name
  - Confidence percentage with color-coded indicator
  - Visual progress bar (Green: High, Orange: Medium, Red: Low)
  - Gradient background
  
- ✅ **Top 3 Predictions**:
  - Ranked list with medal colors (🥇🥈🥉)
  - Progress bars for each prediction
  - Probability percentages
  
- ✅ **Medicinal Knowledge** (Collapsible):
  - 💊 Medicinal Uses
  - 🔬 Active Compounds
  - ⚠️ Precautions
  - 📚 Sources
  - Color-coded sections with icons
  
- ✅ **Grad-CAM Visualization** (Collapsible):
  - Base64 decoded heatmap image
  - Explanation of what Grad-CAM shows
  - Color legend (Low/Medium/High importance)
  
- ✅ **"Analyze Another Leaf"** button to reset

### 5. **Error Handling**
- ✅ Network timeout errors
- ✅ No internet connection detection
- ✅ Invalid server responses
- ✅ User-friendly error dialogs
- ✅ Socket exceptions

### 6. **State Management**
- ✅ Provider pattern for clean architecture
- ✅ Separation of concerns
- ✅ Reactive UI updates

---

## 📦 Dependencies Installed

### Core
- `flutter` - Framework
- `provider: ^6.1.1` - State management
- `flutter_hooks: ^0.20.3` - Alternative state hooks

### Networking
- `http: ^1.1.0` - HTTP requests to FastAPI backend

### Media
- `image_picker: ^1.0.4` - Camera & gallery access

### Utilities
- `path_provider: ^2.1.1` - File system access
- `cupertino_icons: ^1.0.6` - iOS-style icons

### Development
- `flutter_lints: ^3.0.0` - Code quality
- `flutter_launcher_icons: ^0.13.1` - Custom icons
- `flutter_native_splash: ^2.3.5` - Splash screen

---

## 🚀 How to Run

### 1. **Navigate to Frontend Directory**
```bash
cd frontend
```

### 2. **Check Available Devices**
```bash
flutter devices
```

### 3. **Run the App**
```bash
# Run on connected device/emulator
flutter run

# Or run in release mode for better performance
flutter run --release
```

---

## 📱 Platform Setup

### **Android**
Add these permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<manifest>
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.INTERNET" />
    
    <application>
        <!-- ... existing code ... -->
    </application>
</manifest>
```

### **iOS**
Add these to `ios/Runner/Info.plist`:
```xml
<dict>
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to capture leaf images for identification</string>
    
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs photo library access to select leaf images for identification</string>
    
    <!-- ... existing keys ... -->
</dict>
```

---

## 🔧 Configuration

### **Change API Endpoint**
Edit `lib/constants/api_constants.dart`:
```dart
static const String baseUrl = 'YOUR_NEW_API_URL';
```

### **Customize Theme**
Edit `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.blue, // Change to your color
  brightness: Brightness.light,
),
```

---

## 🏗️ Build for Production

### **Android APK**
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### **Android App Bundle** (For Google Play)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### **iOS**
```bash
flutter build ios --release
```
Then open `ios/Runner.xcworkspace` in Xcode to archive and upload.

---

## 🎯 Usage Flow

1. **Launch App** → Home screen with description
2. **Choose Action**:
   - Tap "Take Photo" → Opens camera
   - Tap "Choose from Gallery" → Opens image picker
3. **Select/Capture Image** → Shows loading indicator
4. **View Results**:
   - See uploaded image
   - Check prediction & confidence
   - Explore top 3 predictions
   - Expand medicinal knowledge section
   - Expand Grad-CAM explanation
5. **Analyze Another** → Returns to home screen

---

## 🎨 UI Highlights

- **Material 3 Design System** - Modern, clean interface
- **Light Green Theme** - Nature-inspired color scheme
- **Smooth Animations** - Expandable cards, transitions
- **Responsive Layout** - Works on all screen sizes
- **Intuitive Navigation** - Clear user flow
- **Visual Feedback** - Loading states, error dialogs
- **Color-Coded Confidence** - Instant visual understanding

---

## 🧪 Testing the App

### **Test with Sample Data**
1. Run the app
2. Select any leaf image from your gallery
3. The app will send it to your backend
4. Results will display automatically

### **Test Error Handling**
- Turn off internet → See connection error
- Use invalid image → See server error
- Wait for timeout → See timeout error

---

## 📊 Code Quality

- ✅ **Well-commented** - Every file has documentation
- ✅ **Modular** - Reusable widgets and services
- ✅ **Type-safe** - Proper Dart typing
- ✅ **Lint-compliant** - Follows Flutter best practices
- ✅ **Error-resilient** - Comprehensive error handling
- ✅ **Maintainable** - Clean architecture pattern

---

## 🔍 Key Files Explained

### **main.dart**
- App entry point
- Theme configuration
- Provider setup
- Material 3 theming

### **api_service.dart**
- `predictLeaf()` function - Sends image to backend
- Handles multipart form data
- Parses JSON response
- Error handling & timeouts

### **prediction_provider.dart**
- Manages app state
- Loading states
- Error messages
- Selected image & prediction data

### **home_screen.dart**
- Landing page
- Feature highlights
- Image picker integration
- Navigation to results

### **result_screen.dart**
- Displays all prediction data
- Coordinates reusable widgets
- "Analyze Another" functionality

### **Reusable Widgets**
- `PredictionCard` - Main result display
- `Top3PredictionsCard` - Alternative predictions
- `KnowledgeCard` - Medicinal information
- `GradcamCard` - AI explanation visualization

---

## 🐛 Troubleshooting

### **"Package not found" errors**
```bash
flutter clean
flutter pub get
```

### **Image picker not working**
- Ensure permissions are added to AndroidManifest.xml/Info.plist
- Restart the app after adding permissions

### **Network errors**
- Check backend URL in `api_constants.dart`
- Verify backend is running
- Test with: `curl https://trimodal-xai-backend-production.up.railway.app/`

### **Build errors**
```bash
flutter doctor -v
```
Fix any reported issues.

---

## 📚 Next Steps

### **Optional Enhancements**
1. Add app icon using `flutter_launcher_icons`
2. Add splash screen using `flutter_native_splash`
3. Implement image caching
4. Add history/favorites feature
5. Dark mode support
6. Multi-language support
7. Share results functionality
8. Offline mode with local storage

### **Publishing**
1. Update app name in `pubspec.yaml`
2. Create app icon assets
3. Update package name for Android
4. Configure signing for release builds
5. Submit to Google Play / App Store

---

## ✨ Summary

You now have a **complete, production-ready Flutter mobile app** with:
- ✅ Beautiful Material 3 UI
- ✅ Full FastAPI backend integration
- ✅ Image upload (camera/gallery)
- ✅ AI prediction results
- ✅ Top 3 alternatives
- ✅ Medicinal knowledge display
- ✅ Grad-CAM visualization
- ✅ Comprehensive error handling
- ✅ Clean architecture & code

**Ready to run!** Just execute:
```bash
cd frontend
flutter run
```

---

**Built with ❤️ for TriModal XAI Medicinal Leaf Classifier**
