import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import '../models/prediction_response.dart';
import '../services/api_service.dart';

/// Provider for managing prediction state across the app
class PredictionProvider extends ChangeNotifier {
  // Current prediction response
  PredictionResponse? _predictionResponse;
  
  // Selected image bytes
  Uint8List? _selectedImageBytes;
  
  // Selected image file name
  String? _selectedImageName;
  
  // Loading state
  bool _isLoading = false;
  
  // Error message
  String? _errorMessage;

  // Getters
  PredictionResponse? get predictionResponse => _predictionResponse;
  Uint8List? get selectedImageBytes => _selectedImageBytes;
  String? get selectedImageName => _selectedImageName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasPrediction => _predictionResponse != null;

  /// Set the selected image
  void setSelectedImage(Uint8List imageBytes, String imageName) {
    _selectedImageBytes = imageBytes;
    _selectedImageName = imageName;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear all data and reset state
  void reset() {
    _predictionResponse = null;
    _selectedImageBytes = null;
    _selectedImageName = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Make a prediction request
  Future<void> makePrediction(Uint8List imageBytes, String fileName) async {
    _isLoading = true;
    _errorMessage = null;
    _selectedImageBytes = imageBytes;
    _selectedImageName = fileName;
    notifyListeners();

    try {
      // Call API service
      final response = await ApiService.predictLeaf(imageBytes, fileName);
      
      _predictionResponse = response;
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _predictionResponse = null;
      notifyListeners();
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
