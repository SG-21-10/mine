import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final userIdController = TextEditingController(text: '101');
  List<String> notifications = [];
  String statusMessage = '';
  Color statusColor = Colors.green;

  Future<void> fetchNotifications() async {
    final userId = int.tryParse(userIdController.text);

    if (userId == null) {
      setState(() {
        statusMessage = "Invalid User ID";
        statusColor = Colors.red;
        notifications = [];
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("https://yourapi.com/api/notifications"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final fetched = data["notifications"];

        setState(() {
          notifications = List<String>.from(fetched ?? []);
          statusMessage = "✅ Notifications loaded!";
          statusColor = Colors.green;
        });
      } else {
        setState(() {
          statusMessage = "❌ Failed to load notifications (Status ${response.statusCode})";
          statusColor = Colors.red;
          notifications = [];
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "⚠️ Error: ${e.toString()}";
        statusColor = Colors.red;
        notifications = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: userIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "User ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: fetchNotifications,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA5C8D0),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("Get Notifications"),
            ),
            const SizedBox(height: 16),
            if (statusMessage.isNotEmpty)
              Text(statusMessage,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Expanded(
              child: notifications.isEmpty
                  ? const Center(child: Text("No notifications to show."))
                  : ListView.separated(
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (_, i) => ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(notifications[i]),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
