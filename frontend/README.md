# Medicinal Leaf Classifier - Flutter Frontend

A production-ready Flutter mobile application for classifying medicinal leaves using AI with explainable AI features.

## Features

- 📸 **Image Capture/Upload**: Take photos or select from gallery
- 🤖 **AI-Powered Classification**: Connect to FastAPI backend for accurate leaf identification
- 📊 **Confidence Scoring**: View prediction confidence with visual indicators
- 🏆 **Top 3 Predictions**: See alternative predictions with probabilities
- 💊 **Medicinal Knowledge**: Detailed information about medicinal uses, active compounds, precautions, and sources
- 🔥 **Grad-CAM Visualization**: Explainable AI showing which parts of the leaf the model focused on
- 🎨 **Material 3 Design**: Clean, modern UI with light green theme
- ⚡ **State Management**: Using Provider for efficient state handling
- 🛡️ **Error Handling**: Comprehensive error handling with user-friendly messages

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── constants/
│   └── api_constants.dart            # API configuration
├── models/
│   └── prediction_response.dart      # Data models for API responses
├── providers/
│   └── prediction_provider.dart      # State management
├── screens/
│   ├── home_screen.dart              # Main landing screen
│   └── result_screen.dart            # Results display screen
├── services/
│   └── api_service.dart              # API communication
└── widgets/
    ├── prediction_card.dart          # Main prediction display
    ├── top3_predictions_card.dart    # Top 3 predictions list
    ├── knowledge_card.dart           # Medicinal knowledge display
    └── gradcam_card.dart             # Grad-CAM visualization
```

## Setup Instructions

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. **Navigate to the frontend directory**:
   ```bash
   cd frontend
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Update API endpoint** (if needed):
   Open `lib/constants/api_constants.dart` and update the `baseUrl` if your backend is deployed elsewhere.

4. **Run the app**:
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21
- Add camera and storage permissions to `android/app/src/main/AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.CAMERA" />
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  ```

#### iOS
- Minimum iOS version: 12.0
- Add permissions to `ios/Runner/Info.plist`:
  ```xml
  <key>NSCameraUsageDescription</key>
  <string>This app needs camera access to capture leaf images</string>
  <key>NSPhotoLibraryUsageDescription</key>
  <string>This app needs photo library access to select leaf images</string>
  ```

## API Integration

The app connects to a FastAPI backend at:
```
https://trimodal-xai-backend-production.up.railway.app/predict
```

### Request Format
- Method: `POST`
- Content-Type: `multipart/form-data`
- Field: `file` (image file)

### Response Format
```json
{
  "predicted_class": "string",
  "confidence": 0.95,
  "top3": [
    {"class": "string", "probability": 0.95},
    {"class": "string", "probability": 0.03},
    {"class": "string", "probability": 0.02}
  ],
  "knowledge": {
    "Medicinal Uses": "string",
    "Active Compounds": "string",
    "Precautions": "string",
    "Sources": "string"
  },
  "gradcam_image_base64": "base64_encoded_image_string"
}
```

## Dependencies

### Production
- `provider`: ^6.1.1 - State management
- `flutter_hooks`: ^0.20.3 - Alternative state management
- `http`: ^1.1.0 - HTTP requests
- `image_picker`: ^1.0.4 - Image selection
- `path_provider`: ^2.1.1 - File system paths

### Development
- `flutter_test`: Testing framework
- `flutter_lints`: ^3.0.0 - Linting rules

## Usage

1. **Launch the app**: Open the app to see the home screen with app description
2. **Capture/Select image**: 
   - Tap "Take Photo" to capture with camera
   - Tap "Choose from Gallery" to select existing image
3. **Wait for prediction**: Loading indicator shows while processing
4. **View results**: 
   - See predicted class and confidence
   - Explore top 3 predictions
   - Read medicinal knowledge (expandable)
   - View Grad-CAM explanation (expandable)
5. **Analyze another**: Tap "Analyze Another Leaf" to start over

## Key Features Explained

### State Management
Uses Provider pattern for clean separation of concerns:
- `PredictionProvider`: Manages prediction state, loading states, and errors

### Error Handling
Comprehensive error handling for:
- Network errors
- Timeout errors
- Invalid responses
- Socket exceptions

All errors display user-friendly messages in dialog boxes.

### UI Components

#### Home Screen
- App branding and description
- Feature highlights
- Image capture/selection buttons

#### Result Screen
- Uploaded image preview
- Prediction card with confidence meter
- Top 3 predictions with visual progress bars
- Collapsible medicinal knowledge section
- Collapsible Grad-CAM visualization with explanation

### Reusable Widgets
- `PredictionCard`: Displays main prediction with confidence
- `Top3PredictionsCard`: Shows alternative predictions
- `KnowledgeCard`: Expandable medicinal information
- `GradcamCard`: Expandable Grad-CAM visualization

## Customization

### Theme
Edit `main.dart` to customize colors:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.green, // Change to your preferred color
  brightness: Brightness.light,
),
```

### API Endpoint
Edit `lib/constants/api_constants.dart`:
```dart
static const String baseUrl = 'YOUR_API_URL';
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

### Common Issues

1. **Image picker not working**:
   - Ensure permissions are added to AndroidManifest.xml / Info.plist
   - Restart the app after adding permissions

2. **Network errors**:
   - Check internet connection
   - Verify backend URL is correct
   - Check if backend is running

3. **Base64 decode error**:
   - Ensure backend returns valid base64 string
   - Check response format matches expected structure

## Contributing

Feel free to submit issues and enhancement requests!

## License

See LICENSE file for details.

## Author

Developed for the TriModal XAI Medicinal Leaf Classification project.
