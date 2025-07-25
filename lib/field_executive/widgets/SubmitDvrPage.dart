import 'package:flutter/material.dart';

class SubmitDvrPage extends StatefulWidget {
  const SubmitDvrPage({super.key});

  @override
  State<SubmitDvrPage> createState() => _SubmitDvrPageState();
}

class _SubmitDvrPageState extends State<SubmitDvrPage> {
  final feedbackController = TextEditingController();
  final locationController = TextEditingController();
  final executiveId = "101";

  void _submit() {
    String summary = '''
Executive ID: $executiveId
Location: ${locationController.text}
Feedback: ${feedbackController.text}
''';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("DVR Submitted"),
        content: Text(summary),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit DVR"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Executive ID: $executiveId", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Current Location",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Customer Feedback",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text("Submit DVR"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
            )
          ],
        ),
      ),
    );
  }
}
