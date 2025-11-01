/// API Configuration Constants
class ApiConstants {
  // Backend API URL
  static const String baseUrl = 
      'https://trimodal-xai-backend-production.up.railway.app';
  
  static const String predictEndpoint = '/predict';
  
  // Full predict URL
  static const String predictUrl = '$baseUrl$predictEndpoint';
  
  // Request timeout duration
  static const Duration requestTimeout = Duration(seconds: 30);
  
  // Multipart form field name for image upload
  static const String imageFieldName = 'file';
}
