import 'package:flutter/material.dart';

class CheckStockPage extends StatelessWidget {
  const CheckStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final skuController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Stock"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: skuController,
              decoration: const InputDecoration(labelText: "Enter SKU or Product ID", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // API to check availability
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
              child: const Text("Check Availability"),
            ),
          ],
        ),
      ),
    );
  }
}
