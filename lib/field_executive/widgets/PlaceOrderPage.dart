import 'package:flutter/material.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({super.key});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final townController = TextEditingController();
  final postcodeController = TextEditingController();

  String selectedCountry = 'Canada';
  String selectedState = 'Ontario';
  String selectedDelivery = 'Free';
  String selectedPayment = 'Card';
  bool subscribe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Row: 3 sections side by side in column for mobile view
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Delivery Address
                _buildSectionTitle("DELIVERY ADDRESS"),
                _buildTextField("Email Address", emailController),
                Row(
                  children: [
                    Expanded(child: _buildTextField("First Name", firstNameController)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField("Last Name", lastNameController)),
                  ],
                ),
                _buildTextField("Telephone", phoneController),
                _buildTextField("Delivery Address", addressController),
                _buildTextField("Suburb / Town", townController),
                Row(
                  children: [
                    Expanded(child: _buildDropdown("State / Territory", selectedState, ['Ontario', 'Alberta', 'Quebec'], (val) {
                      setState(() => selectedState = val ?? '');
                    })),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField("Postcode", postcodeController)),
                  ],
                ),
                _buildDropdown("Country", selectedCountry, ['Canada', 'USA', 'India'], (val) {
                  setState(() => selectedCountry = val ?? '');
                }),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (_) {},
                    ),
                    const Text("Same billing address")
                  ],
                ),

                const SizedBox(height: 24),

                // 3. Payment Method
                _buildSectionTitle("SELECT PAYMENT METHOD"),
                _buildPaymentOption(),

                const SizedBox(height: 24),

                // Order Summary
                _buildSectionTitle("ORDER SUMMARY"),
                _buildOrderSummary(),

                Row(
                  children: [
                    Checkbox(
                      value: subscribe,
                      onChanged: (val) => setState(() => subscribe = val ?? false),
                    ),
                    const Expanded(child: Text("I'm keen for new releases and subscriber exclusives. Sign me up!")),
                  ],
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    // process order
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: const Text("PAY NOW", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
  Widget _buildPaymentOption() {
    return Column(
      children: [
        RadioListTile<String>(
          value: 'Card',
          groupValue: selectedPayment,
          onChanged: (val) => setState(() => selectedPayment = val!),
          title: const Text("Card"),
        ),
        RadioListTile<String>(
          value: 'PayPal',
          groupValue: selectedPayment,
          onChanged: (val) => setState(() => selectedPayment = val!),
          title: const Text("PayPal"),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    const subtotal = 109.00;
    const tax = 14.17;
    const total = 123.17;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summaryRow("1 x Note Sleeve, Tan", "\$109"),
            _summaryRow("Shipping to Canada", "FREE", subtitle: "Regular (5–10 business days, tracking)"),
            _summaryRow("Sales Tax", "\$14.17"),
            const Divider(),
            _summaryRow("ORDER TOTAL", "\$123.17 CAD", bold: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {String? subtitle, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
              Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
        ],
      ),
    );
  }
}
