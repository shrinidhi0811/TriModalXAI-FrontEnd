import 'dart:convert';
import 'dart:typed_data';

/// Model class representing the prediction response from the backend
class PredictionResponse {
  final String predictedClass;
  final double confidence;
  final List<Top3Prediction> top3;
  final KnowledgeInfo knowledge;
  final String gradcamImageBase64;

  PredictionResponse({
    required this.predictedClass,
    required this.confidence,
    required this.top3,
    required this.knowledge,
    required this.gradcamImageBase64,
  });

  /// Create PredictionResponse from JSON
  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing PredictionResponse from JSON...');
    print('📋 JSON keys: ${json.keys.toList()}');
    
    try {
      // Parse predicted class
      final predictedClass = json['predicted_class'] as String? ?? 'Unknown';
      print('✅ Predicted class: $predictedClass');
      
      // Parse confidence with null safety
      final confidenceValue = json['confidence'];
      final confidence = confidenceValue != null 
          ? (confidenceValue is num ? confidenceValue.toDouble() : 0.0)
          : 0.0;
      print('✅ Confidence: $confidence');
      
      // Parse top3 predictions
      final top3List = json['top3'] as List? ?? [];
      final top3 = top3List
          .map((item) => Top3Prediction.fromJson(item as Map<String, dynamic>))
          .toList();
      print('✅ Top3 count: ${top3.length}');
      
      // Parse knowledge
      final knowledgeData = json['knowledge'] as Map<String, dynamic>? ?? {};
      final knowledge = KnowledgeInfo.fromJson(knowledgeData);
      print('✅ Knowledge parsed');
      
      // Parse Grad-CAM image
      final gradcamImageBase64 = json['gradcam_image_base64'] as String? ?? '';
      print('✅ Grad-CAM image length: ${gradcamImageBase64.length}');
      
      return PredictionResponse(
        predictedClass: predictedClass,
        confidence: confidence,
        top3: top3,
        knowledge: knowledge,
        gradcamImageBase64: gradcamImageBase64,
      );
    } catch (e, stackTrace) {
      print('❌ Error parsing PredictionResponse: $e');
      print('📚 Stack trace: $stackTrace');
      print('📄 JSON data: $json');
      rethrow;
    }
  }

  /// Convert PredictionResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'predicted_class': predictedClass,
      'confidence': confidence,
      'top3': top3.map((item) => item.toJson()).toList(),
      'knowledge': knowledge.toJson(),
      'gradcam_image_base64': gradcamImageBase64,
    };
  }

  /// Decode the base64 Grad-CAM image to bytes
  Uint8List getGradcamImageBytes() {
    return base64Decode(gradcamImageBase64);
  }
}

/// Model for top-3 prediction items
class Top3Prediction {
  final String className;
  final double probability;

  Top3Prediction({
    required this.className,
    required this.probability,
  });

  factory Top3Prediction.fromJson(Map<String, dynamic> json) {
    // Parse class name with null safety
    final className = json['class'] as String? ?? 'Unknown';
    
    // Parse probability/confidence with null safety
    // Backend uses 'confidence' but we internally call it 'probability'
    final probabilityValue = json['probability'] ?? json['confidence'];
    final probability = probabilityValue != null
        ? (probabilityValue is num ? probabilityValue.toDouble() : 0.0)
        : 0.0;
    
    return Top3Prediction(
      className: className,
      probability: probability,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'class': className,
      'probability': probability,
    };
  }
}

/// Model for medicinal knowledge information
class KnowledgeInfo {
  final String? medicinalUses;
  final String? activeCompounds;
  final String? precautions;
  final String? sources;

  KnowledgeInfo({
    this.medicinalUses,
    this.activeCompounds,
    this.precautions,
    this.sources,
  });

  factory KnowledgeInfo.fromJson(Map<String, dynamic> json) {
    // Helper function to convert List or String to String
    String? _parseField(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      if (value is List) {
        // Join list items with bullet points
        return value.map((item) => '• $item').join('\n');
      }
      return value.toString();
    }
    
    return KnowledgeInfo(
      medicinalUses: _parseField(json['Medicinal Uses']),
      activeCompounds: _parseField(json['Active Compounds']),
      precautions: _parseField(json['Precautions']),
      sources: _parseField(json['Sources']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Medicinal Uses': medicinalUses,
      'Active Compounds': activeCompounds,
      'Precautions': precautions,
      'Sources': sources,
    };
  }

  /// Check if knowledge data is available
  bool get hasData {
    return medicinalUses != null ||
        activeCompounds != null ||
        precautions != null ||
        sources != null;
  }
}
