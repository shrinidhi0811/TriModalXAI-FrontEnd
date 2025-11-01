import 'package:flutter/material.dart';
import '../models/prediction_response.dart';

/// Widget displaying top 3 predictions with probabilities
class Top3PredictionsCard extends StatelessWidget {
  final List<Top3Prediction> predictions;

  const Top3PredictionsCard({
    super.key,
    required this.predictions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Top 3 Predictions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Predictions List
            ...predictions.asMap().entries.map((entry) {
              int index = entry.key;
              Top3Prediction prediction = entry.value;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildPredictionItem(
                  context,
                  index + 1,
                  prediction.className,
                  prediction.probability,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionItem(
    BuildContext context,
    int rank,
    String className,
    double probability,
  ) {
    // Medal colors for top 3
    Color rankColor = rank == 1
        ? Colors.amber
        : rank == 2
            ? Colors.grey[400]!
            : Colors.brown[300]!;

    return Row(
      children: [
        // Rank Badge
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: rankColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Class Name and Probability
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                className,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: probability,
                        minHeight: 8,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${(probability * 100).toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
