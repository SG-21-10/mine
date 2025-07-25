import 'package:flutter/material.dart';

class GetProductDetailsPage extends StatelessWidget {
  const GetProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Product Details"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: productIdController,
              decoration: const InputDecoration(
                labelText: "Enter Product ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // call API or fetch mock data
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
              child: const Text("Fetch Product Info"),
            ),
          ],
        ),
      ),
    );
  }
}
