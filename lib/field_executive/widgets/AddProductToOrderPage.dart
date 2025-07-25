import 'package:flutter/material.dart';

class AddProductToOrderPage extends StatelessWidget {
  const AddProductToOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderIdController = TextEditingController();
    final productIdController = TextEditingController();
    final quantityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product to Order"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInput("Order ID", orderIdController),
            _buildInput("Product ID", productIdController),
            _buildInput("Quantity", quantityController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5C8D0)),
              child: const Text("Add to Order"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}
