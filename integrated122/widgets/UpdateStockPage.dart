import 'package:flutter/material.dart';

class UpdateStockPage extends StatelessWidget {
  const UpdateStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productIdController = TextEditingController();
    final newStockController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Stock"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: productIdController,
              decoration: const InputDecoration(labelText: "Product ID", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newStockController,
              decoration: const InputDecoration(labelText: "New Stock Quantity", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
              child: const Text("Update Stock"),
            ),
          ],
        ),
      ),
    );
  }
}
