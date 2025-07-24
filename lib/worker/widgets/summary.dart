import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class SummaryCard extends StatelessWidget {
  final Map<String, dynamic> summary;
  const SummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundGray,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: summary.entries
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '${e.key}: ${e.value}',
                      style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}