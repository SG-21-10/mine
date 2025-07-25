import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SyncOfflinePage extends StatefulWidget {
  const SyncOfflinePage({super.key});

  @override
  State<SyncOfflinePage> createState() => _SyncOfflinePageState();
}

class _SyncOfflinePageState extends State<SyncOfflinePage> {
  final executiveIdController = TextEditingController(text: '101');
  final offlineDataController = TextEditingController(); // Should contain valid JSON

  String message = '';
  Color messageColor = Colors.green;

  Future<void> syncData() async {
    try {
      final parsedId = int.tryParse(executiveIdController.text);
      final parsedData = jsonDecode(offlineDataController.text);

      if (parsedId == null) {
        setState(() {
          message = "Invalid Executive ID.";
          messageColor = Colors.red;
        });
        return;
      }

      final response = await http.post(
        Uri.parse("https://yourapi.com/api/field-executive/sync-offline"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "executiveId": parsedId,
          "data": parsedData,
        }),
      );

      setState(() {
        if (response.statusCode == 200) {
          message = "✅ Data synced successfully!";
          messageColor = Colors.green;
        } else {
          message = "❌ Failed to sync. Status: ${response.statusCode}";
          messageColor = Colors.red;
        }
      });
    } catch (e) {
      setState(() {
        message = "⚠️ Error: ${e.toString()}";
        messageColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sync Offline Data"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: executiveIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Executive ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: offlineDataController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Offline Data (as JSON List or Map)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: syncData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA5C8D0),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text("Sync Now"),
            ),
            const SizedBox(height: 12),
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(color: messageColor, fontSize: 14, fontWeight: FontWeight.w500),
              ),
          ],
        ),
      ),
    );
  }
}
