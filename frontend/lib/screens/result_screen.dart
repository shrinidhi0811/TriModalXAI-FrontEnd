import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prediction_provider.dart';
import '../widgets/prediction_card.dart';
import '../widgets/top3_predictions_card.dart';
import '../widgets/knowledge_card.dart';
import '../widgets/gradcam_card.dart';

/// Results screen displaying prediction results and analysis
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);
    final prediction = predictionProvider.predictionResponse;
    final selectedImageBytes = predictionProvider.selectedImageBytes;

    // Handle case where no prediction is available
    if (prediction == null || selectedImageBytes == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: const Center(
          child: Text('No prediction available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analysis Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // Share or Info button can be added here
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: 'About Results',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Uploaded Image
              _buildUploadedImage(context, selectedImageBytes),
              
              const SizedBox(height: 20),
              
              // Main Prediction Card
              PredictionCard(
                predictedClass: prediction.predictedClass,
                confidence: prediction.confidence,
              ),
              
              const SizedBox(height: 16),
              
              // Top 3 Predictions
              Top3PredictionsCard(predictions: prediction.top3),
              
              const SizedBox(height: 16),
              
              // Medicinal Knowledge
              if (prediction.knowledge.hasData)
                KnowledgeCard(knowledge: prediction.knowledge),
              
              if (prediction.knowledge.hasData)
                const SizedBox(height: 16),
              
              // Grad-CAM Visualization
              GradcamCard(
                gradcamBase64: prediction.gradcamImageBase64,
              ),
              
              const SizedBox(height: 24),
              
              // Analyze Another Button
              _buildAnalyzeAnotherButton(context),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedImage(BuildContext context, Uint8List imageBytes) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.memory(
              imageBytes,
              fit: BoxFit.cover,
            ),
          ),
          
          // Label
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Uploaded Image',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyzeAnotherButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Reset provider and go back
        Provider.of<PredictionProvider>(context, listen: false).reset();
        Navigator.pop(context);
      },
      icon: const Icon(Icons.refresh),
      label: const Text(
        'Analyze Another Leaf',
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: const Size(double.infinity, 56),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info, color: Colors.blue),
            SizedBox(width: 8),
            Text('About Results'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Understanding Your Results:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              Text('• Prediction: The most likely leaf identification'),
              SizedBox(height: 8),
              Text('• Confidence: How certain the AI is (higher is better)'),
              SizedBox(height: 8),
              Text('• Top 3: Alternative possibilities with probabilities'),
              SizedBox(height: 8),
              Text('• Knowledge: Medicinal information from verified sources'),
              SizedBox(height: 8),
              Text('• Grad-CAM: Visual explanation showing which parts of the leaf the AI focused on'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
