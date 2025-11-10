import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/prediction_provider.dart';
import 'result_screen.dart';

/// Home screen with app introduction and image upload functionality
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicinal Leaf Classifier',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const HomeContent(),
            if (predictionProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const LoadingView(),
              ),
          ],
        ),
      ),
    );
  }
}

/// Main content of the home screen
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            // App Icon/Logo
            Icon(
              Icons.eco,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            
            const SizedBox(height: 24),
            
            // App Title
            Text(
              'Medicinal Leaf Classifier',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Description
            Text(
              'Identify medicinal leaves using advanced AI technology with explainable AI features. Upload or capture a photo to get instant identification and detailed medicinal information.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Features Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem(
                      context,
                      Icons.photo_camera,
                      'AI-Powered Classification',
                      'Advanced deep learning model for accurate leaf identification',
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      context,
                      Icons.local_hospital,
                      'Medicinal Information',
                      'Comprehensive medicinal uses and active compounds',
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      context,
                      Icons.insights,
                      'Explainable AI',
                      'Grad-CAM visualization shows what the AI focuses on',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Upload Buttons
            const UploadButtons(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Upload buttons widget
class UploadButtons extends StatelessWidget {
  const UploadButtons({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final predictionProvider = Provider.of<PredictionProvider>(
      context,
      listen: false,
    );

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        // Read image as bytes (works on web and mobile)
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        final String fileName = pickedFile.name;
        
        // Make prediction
        try {
          await predictionProvider.makePrediction(imageBytes, fileName);
          
          print('🔍 After prediction:');
          print('   - hasPrediction: ${predictionProvider.hasPrediction}');
          print('   - hasError: ${predictionProvider.hasError}');
          print('   - predictionResponse: ${predictionProvider.predictionResponse}');
          print('   - context.mounted: ${context.mounted}');
          
          // Check context first
          if (!context.mounted) {
            print('⚠️ Context not mounted, cannot navigate');
            return;
          }
          
          // Only navigate if prediction was successful
          if (predictionProvider.hasPrediction) {
            print('🚀 Navigating to ResultScreen...');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResultScreen(),
              ),
            );
          } else if (predictionProvider.hasError) {
            print('❌ Has error, showing dialog');
            // Show error if prediction failed
            _showErrorDialog(context, predictionProvider.errorMessage ?? 'Unknown error');
          } else {
            print('⚠️ No prediction and no error - unexpected state');
          }
        } catch (e) {
          // Show error dialog for prediction failures
          if (context.mounted) {
            _showErrorDialog(context, e.toString());
          }
        }
      }
    } catch (e) {
      // Show error dialog for image picker failures
      if (context.mounted) {
        _showErrorDialog(context, 'Failed to load image: ${e.toString()}');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
            const SizedBox(width: 8),
            const Text('Error'),
          ],
        ),
        content: Text(
          errorMessage.replaceFirst('Exception: ', ''),
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Camera Button
        ElevatedButton.icon(
          onPressed: () => _pickImage(context, ImageSource.camera),
          icon: const Icon(Icons.camera_alt, size: 24),
          label: const Text(
            'Take Photo',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Gallery Button
        OutlinedButton.icon(
          onPressed: () => _pickImage(context, ImageSource.gallery),
          icon: const Icon(Icons.photo_library, size: 24),
          label: const Text(
            'Choose from Gallery',
            style: TextStyle(fontSize: 16),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ],
    );
  }
}

/// Loading view shown during prediction
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Analyzing leaf...',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while our AI identifies the leaf',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
