import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_constants.dart';
import '../models/prediction_response.dart';

/// Service class for handling API requests to the FastAPI backend
class ApiService {
  /// Sends an image to the backend for prediction
  /// 
  /// [imageFile] - The image file to classify
  /// 
  /// Returns a [PredictionResponse] object containing:
  /// - predicted_class: The predicted leaf type
  /// - confidence: Confidence score (0-1)
  /// - top3: Top 3 predictions with their probabilities
  /// - knowledge: Medicinal information about the leaf
  /// - gradcam_image_base64: Grad-CAM visualization as base64 string
  /// 
  /// Throws an [Exception] if the request fails or returns an error
  static Future<PredictionResponse> predictLeaf(File imageFile) async {
    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.predictUrl),
      );

      // Add image file to request
      var multipartFile = await http.MultipartFile.fromPath(
        ApiConstants.imageFieldName,
        imageFile.path,
      );
      request.files.add(multipartFile);

      // Send request with timeout
      var streamedResponse = await request.send().timeout(
        ApiConstants.requestTimeout,
        onTimeout: () {
          throw Exception('Request timeout. Please check your connection.');
        },
      );

      // Get response
      var response = await http.Response.fromStream(streamedResponse);

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        // Convert to PredictionResponse model
        return PredictionResponse.fromJson(jsonResponse);
      } else {
        // Handle error response
        throw Exception(
          'Failed to get prediction. Status: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception(
        'No internet connection. Please check your network.',
      );
    } on http.ClientException {
      throw Exception(
        'Network error. Please try again.',
      );
    } on FormatException {
      throw Exception(
        'Invalid response from server. Please try again.',
      );
    } catch (e) {
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
