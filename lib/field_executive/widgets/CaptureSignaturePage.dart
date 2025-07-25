import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CaptureSignaturePage extends StatefulWidget {
  const CaptureSignaturePage({super.key});

  @override
  State<CaptureSignaturePage> createState() => _CaptureSignaturePageState();
}

class _CaptureSignaturePageState extends State<CaptureSignaturePage> {
  final orderIdController = TextEditingController();
  final signatureController = TextEditingController(); // For base64

  String message = '';

  Future<void> submitSignature() async {
    final response = await http.post(
      Uri.parse("https://yourapi.com/api/orders/signature"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "orderId": int.tryParse(orderIdController.text),
        "signature": signatureController.text,
      }),
    );

    setState(() => message = response.statusCode == 200 ? "Submitted!" : "Failed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Signature"), backgroundColor: const Color(0xFFA5C8D0)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: orderIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Order ID", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: signatureController,
              decoration: const InputDecoration(labelText: "Signature (base64)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: submitSignature,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
              child: const Text("Submit Signature"),
            ),
            if (message.isNotEmpty) Text(message, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
