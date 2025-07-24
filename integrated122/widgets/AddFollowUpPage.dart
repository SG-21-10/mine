import 'package:flutter/material.dart';

class AddFollowUpPage extends StatefulWidget {
  const AddFollowUpPage({super.key});

  @override
  State<AddFollowUpPage> createState() => _AddFollowUpPageState();
}

class _AddFollowUpPageState extends State<AddFollowUpPage> {
  final customerNameController = TextEditingController();
  final feedbackController = TextEditingController();
  DateTime? selectedDate;
  final executiveId = "101";

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _submitFollowUp() {
    String summary = '''
Executive ID: $executiveId
Customer Name: ${customerNameController.text}
Feedback: ${feedbackController.text}
Next Follow-Up Date: ${selectedDate != null ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}" : "Not selected"}
''';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Follow-Up Scheduled"),
        content: Text(summary),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Follow-Up"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Executive ID: $executiveId", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: customerNameController,
              decoration: const InputDecoration(
                labelText: "Customer Name",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Feedback",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Next Follow-Up Date: "),
                TextButton(
                  onPressed: () => _pickDate(context),
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Select Date",
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitFollowUp,
              icon: const Icon(Icons.add_task),
              label: const Text("Add Follow-Up"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
            ),
          ],
        ),
      ),
    );
  }
}
