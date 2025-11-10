import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// API Configuration Constants
class ApiConstants {
  // Get the appropriate base URL based on the platform
  static String get baseUrl {
    if (kIsWeb) {
      // Web browser - use localhost
      return 'http://localhost:8000';
    } else if (Platform.isAndroid) {
      // Android emulator - use special IP that maps to host machine
      return 'http://10.0.2.2:8000';
    } else if (Platform.isIOS) {
      // iOS simulator - use localhost
      return 'http://localhost:8000';
    } else {
      // Desktop or other platforms
      return 'http://localhost:8000';
    }
  }
  
  // For physical devices, you need to use your computer's IP address
  // Find your IP: Windows -> ipconfig, Mac/Linux -> ifconfig
  // Then uncomment and use this instead:
  // static const String baseUrl = 'http://192.168.1.XXX:8000';
  
  static const String predictEndpoint = '/predict';
  
  // Full predict URL
  static String get predictUrl => '$baseUrl$predictEndpoint';
  
  // Request timeout duration - increased for AI model inference
  static const Duration requestTimeout = Duration(seconds: 120);
  
  // Multipart form field name for image upload
  static const String imageFieldName = 'file';
}
