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
    return PredictionResponse(
      predictedClass: json['predicted_class'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      top3: (json['top3'] as List)
          .map((item) => Top3Prediction.fromJson(item))
          .toList(),
      knowledge: KnowledgeInfo.fromJson(json['knowledge']),
      gradcamImageBase64: json['gradcam_image_base64'] as String,
    );
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
    return Top3Prediction(
      className: json['class'] as String,
      probability: (json['probability'] as num).toDouble(),
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
    return KnowledgeInfo(
      medicinalUses: json['Medicinal Uses'] as String?,
      activeCompounds: json['Active Compounds'] as String?,
      precautions: json['Precautions'] as String?,
      sources: json['Sources'] as String?,
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
