import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../constants/api_constants.dart';
import '../models/prediction_response.dart';

/// Service class for handling API requests to the FastAPI backend
class ApiService {
  /// Sends an image to the backend for prediction
  /// 
  /// [imageBytes] - The image file bytes to classify
  /// [fileName] - The name of the file
  /// 
  /// Returns a [PredictionResponse] object containing:
  /// - predicted_class: The predicted leaf type
  /// - confidence: Confidence score (0-1)
  /// - top3: Top 3 predictions with their probabilities
  /// - knowledge: Medicinal information about the leaf
  /// - gradcam_image_base64: Grad-CAM visualization as base64 string
  /// 
  /// Throws an [Exception] if the request fails or returns an error
  static Future<PredictionResponse> predictLeaf(
    Uint8List imageBytes,
    String fileName,
  ) async {
    try {
      print('🔄 Starting prediction request...');
      print('📁 File name: $fileName');
      print('📦 Image size: ${imageBytes.length} bytes');
      
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.predictUrl),
      );

      print('🌐 API URL: ${ApiConstants.predictUrl}');

      // Determine content type from file extension
      MediaType contentType = MediaType('image', 'jpeg'); // default
      if (fileName.toLowerCase().endsWith('.png')) {
        contentType = MediaType('image', 'png');
      } else if (fileName.toLowerCase().endsWith('.jpg') || 
                 fileName.toLowerCase().endsWith('.jpeg')) {
        contentType = MediaType('image', 'jpeg');
      }

      print('📸 Content-Type: ${contentType.mimeType}');

      // Add image file to request from bytes (works on web and mobile)
      var multipartFile = http.MultipartFile.fromBytes(
        ApiConstants.imageFieldName,
        imageBytes,
        filename: fileName,
        contentType: contentType,
      );
      request.files.add(multipartFile);

      print('📤 Sending request to backend...');

      // Send request with timeout
      var streamedResponse = await request.send().timeout(
        ApiConstants.requestTimeout,
        onTimeout: () {
          print('❌ Request timeout');
          throw Exception('Request timeout. Please check your connection.');
        },
      );

      print('📥 Received response with status: ${streamedResponse.statusCode}');

      // Get response
      var response = await http.Response.fromStream(streamedResponse);

      // Check if request was successful
      if (response.statusCode == 200) {
        print('✅ Success! Parsing response...');
        print('📄 Response body length: ${response.body.length}');
        
        // Parse JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        print('✅ JSON parsed successfully');
        print('🎯 Predicted class: ${jsonResponse['predicted_class']}');
        
        // Convert to PredictionResponse model
        return PredictionResponse.fromJson(jsonResponse);
      } else {
        print('❌ Error response: ${response.statusCode}');
        print('📄 Error body: ${response.body}');
        // Handle error response
        throw Exception(
          'Failed to get prediction. Status: ${response.statusCode}\nMessage: ${response.body}',
        );
      }
    } on FormatException catch (e) {
      print('❌ Format exception: $e');
      throw Exception(
        'Invalid response from server. Please try again.',
      );
    } on http.ClientException catch (e) {
      print('❌ Client exception: $e');
      throw Exception(
        'Network error. Please try again.',
      );
    } catch (e) {
      print('❌ Unknown error: $e');
      throw Exception('Error: ${e.toString()}');
    }
  }

  /// Test connectivity to the backend
  static Future<bool> testConnection() async {
    try {
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl),
      ).timeout(const Duration(seconds: 5));
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
