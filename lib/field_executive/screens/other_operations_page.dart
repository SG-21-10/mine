import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class OtherOperationsPage extends StatelessWidget {
  const OtherOperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        title: const Text('Other Operations'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Other Operations\n\nAdditional features will be added here',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
