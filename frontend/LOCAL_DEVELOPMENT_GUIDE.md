# Local Development Guide

This guide will help you run both the backend and frontend locally on your computer.

## 🎯 Quick Start

### Step 1: Start the Backend

Navigate to the backend directory and start the FastAPI server:

```powershell
cd c:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\backend
python -m uvicorn main:app --reload --port 8000
```

You should see:
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
```

Test the backend by visiting: http://localhost:8000/docs

### Step 2: Run the Flutter App

Open a new terminal window:

```powershell
cd c:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter run
```

Select your target device when prompted.

## 📱 Platform-Specific Configuration

The app **automatically detects** your platform and uses the correct URL:

### ✅ Android Emulator (AVD)
- **URL Used**: `http://10.0.2.2:8000`
- **Setup**: Just run the emulator and `flutter run`
- **Why**: `10.0.2.2` is a special Android emulator IP that maps to `localhost` on your computer

### ✅ iOS Simulator
- **URL Used**: `http://localhost:8000`
- **Setup**: Just run the simulator and `flutter run`
- **Why**: iOS simulator shares the same network as your Mac

### ✅ Web Browser
- **URL Used**: `http://localhost:8000`
- **Setup**: Run `flutter run -d chrome` or `flutter run -d edge`
- **Note**: CORS may block requests. You need to configure CORS in your FastAPI backend

### ⚠️ Physical Android/iOS Phone
- **URL Needed**: `http://YOUR_COMPUTER_IP:8000`
- **Setup**: See "Testing on Physical Device" section below

## 🔧 Testing on Physical Device

When testing on a real phone, you need to use your computer's IP address:

### Find Your Computer's IP Address

**Windows (PowerShell):**
```powershell
ipconfig
```
Look for `IPv4 Address` under your active network adapter (WiFi or Ethernet).

Example output:
```
Wireless LAN adapter Wi-Fi:
   IPv4 Address. . . . . . . . . . . : 192.168.1.105
```

### Update API Configuration

1. Open `lib/constants/api_constants.dart`
2. Find the commented line for physical devices
3. Uncomment and update with your IP:

```dart
// For physical devices, uncomment and use your computer's IP:
static String get baseUrl {
  // Comment out the automatic detection
  return 'http://192.168.1.105:8000';  // Replace with YOUR IP
}
```

### Connect Your Phone

1. Connect phone to the **same WiFi network** as your computer
2. Enable Developer Mode and USB Debugging on your phone
3. Connect via USB cable
4. Run: `flutter devices` to verify connection
5. Run: `flutter run`

## 🚀 Development Workflow

### Hot Reload

While the app is running:
- Press `r` to hot reload (quick UI changes)
- Press `R` to hot restart (full app restart)
- Press `q` to quit

### Backend Changes

When you modify backend code:
- Uvicorn with `--reload` automatically restarts
- No action needed on frontend

### Frontend Changes

When you modify Flutter code:
- Press `r` for hot reload
- Changes appear instantly in the app

## 🐛 Troubleshooting

### "Failed to connect to server"

**Check 1**: Is the backend running?
```powershell
# Should return server info
curl http://localhost:8000
```

**Check 2**: Are you using the correct IP?
- Android Emulator: `10.0.2.2:8000` ✅
- Physical Phone: `YOUR_COMPUTER_IP:8000` (both on same WiFi)

**Check 3**: Firewall blocking?
- Windows Firewall may block port 8000
- Add an inbound rule to allow port 8000

### "Connection refused" on Physical Phone

1. Verify your computer's IP: `ipconfig`
2. Verify both devices on same WiFi
3. Test backend accessibility from phone browser: `http://YOUR_IP:8000`
4. Check Windows Firewall settings

### "CORS Error" in Web Browser

Add CORS middleware to your FastAPI backend:

```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### Backend Import Errors

```powershell
# Install dependencies
cd c:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\backend
pip install -r requirements.txt
```

### Flutter Package Errors

```powershell
# Get dependencies
cd c:\Users\SHRINIDHI\Desktop\TriModalXAI-FrontEnd\frontend
flutter pub get
```

## 🔄 Switching Between Local and Production

### Option 1: Environment Variable (Recommended)

Add this to `api_constants.dart`:

```dart
static String get baseUrl {
  // Set this in your environment or build config
  const bool useProduction = false;
  
  if (useProduction) {
    return 'https://trimodal-xai-backend-production.up.railway.app';
  }
  
  // Local development URLs (auto-detected)
  if (kIsWeb) return 'http://localhost:8000';
  if (Platform.isAndroid) return 'http://10.0.2.2:8000';
  return 'http://localhost:8000';
}
```

### Option 2: Flutter Build Flavors

Create separate configurations for dev/prod:
```powershell
flutter run --flavor dev
flutter run --flavor prod
```

## 📊 Testing the Full Flow

1. **Start Backend**: `uvicorn main:app --reload --port 8000`
2. **Start Frontend**: `flutter run`
3. **Upload Image**: Tap "Choose from Gallery" or "Take Photo"
4. **View Results**: See prediction, top 3, knowledge, and Grad-CAM

### Expected Console Output

**Frontend:**
```
[API] Uploading image: image_picker_xxx.jpg (45678 bytes)
[API] Request sent to: http://10.0.2.2:8000/predict
[API] Response status: 200
[API] Received data: {...}
[Provider] Prediction successful: Holy Basil
```

**Backend:**
```
INFO:     127.0.0.1:52431 - "POST /predict HTTP/1.1" 200 OK
```

## 🎨 Development Tips

### 1. Keep Backend Running
- Use `--reload` flag to auto-restart on code changes
- Monitor the terminal for request logs

### 2. Use Hot Reload
- Save time with instant UI updates
- Press `r` after saving Dart files

### 3. Check Logs
- Frontend: VS Code Debug Console
- Backend: Uvicorn terminal output
- Both show detailed request/response info

### 4. Test on Multiple Devices
- Start with emulator (fastest)
- Test on physical device before production
- Web browser for quick UI tweaks (beware CORS)

## 📝 Common Commands Reference

```powershell
# Backend
cd backend
python -m uvicorn main:app --reload --port 8000

# Frontend
cd frontend
flutter pub get              # Install dependencies
flutter devices              # List available devices
flutter run                  # Run on default device
flutter run -d chrome        # Run on Chrome
flutter run -d android       # Run on Android
flutter clean                # Clean build cache

# Network
ipconfig                     # Find your IP address
netstat -an | findstr :8000  # Check if port 8000 is in use
```

## ✅ Checklist

Before starting development:
- [ ] Backend dependencies installed (`pip install -r requirements.txt`)
- [ ] Frontend dependencies installed (`flutter pub get`)
- [ ] Device/emulator running (`flutter devices` shows devices)
- [ ] Port 8000 available (no other app using it)
- [ ] For physical device: same WiFi network + correct IP in code

Ready to develop! 🚀
