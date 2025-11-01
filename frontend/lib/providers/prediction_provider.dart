import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/prediction_response.dart';
import '../services/api_service.dart';

/// Provider for managing prediction state across the app
class PredictionProvider extends ChangeNotifier {
  // Current prediction response
  PredictionResponse? _predictionResponse;
  
  // Selected image file
  File? _selectedImage;
  
  // Loading state
  bool _isLoading = false;
  
  // Error message
  String? _errorMessage;

  // Getters
  PredictionResponse? get predictionResponse => _predictionResponse;
  File? get selectedImage => _selectedImage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasPrediction => _predictionResponse != null;

  /// Set the selected image
  void setSelectedImage(File image) {
    _selectedImage = image;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear all data and reset state
  void reset() {
    _predictionResponse = null;
    _selectedImage = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Make a prediction request
  Future<void> makePrediction(File imageFile) async {
    _isLoading = true;
    _errorMessage = null;
    _selectedImage = imageFile;
    notifyListeners();

    try {
      // Call API service
      final response = await ApiService.predictLeaf(imageFile);
      
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
