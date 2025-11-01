import 'package:flutter/material.dart';
import '../models/prediction_response.dart';

/// Widget displaying medicinal knowledge information in a collapsible card
class KnowledgeCard extends StatefulWidget {
  final KnowledgeInfo knowledge;

  const KnowledgeCard({
    super.key,
    required this.knowledge,
  });

  @override
  State<KnowledgeCard> createState() => _KnowledgeCardState();
}

class _KnowledgeCardState extends State<KnowledgeCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Header (Always Visible)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Medicinal Knowledge',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          
          // Expandable Content
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  
                  // Medicinal Uses
                  if (widget.knowledge.medicinalUses != null)
                    _buildKnowledgeSection(
                      context,
                      'Medicinal Uses',
                      Icons.healing,
                      widget.knowledge.medicinalUses!,
                      Colors.green,
                    ),
                  
                  // Active Compounds
                  if (widget.knowledge.activeCompounds != null)
                    _buildKnowledgeSection(
                      context,
                      'Active Compounds',
                      Icons.science,
                      widget.knowledge.activeCompounds!,
                      Colors.blue,
                    ),
                  
                  // Precautions
                  if (widget.knowledge.precautions != null)
                    _buildKnowledgeSection(
                      context,
                      'Precautions',
                      Icons.warning_amber,
                      widget.knowledge.precautions!,
                      Colors.orange,
                    ),
                  
                  // Sources
                  if (widget.knowledge.sources != null)
                    _buildKnowledgeSection(
                      context,
                      'Sources',
                      Icons.library_books,
                      widget.knowledge.sources!,
                      Colors.purple,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeSection(
    BuildContext context,
    String title,
    IconData icon,
    String content,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: iconColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
