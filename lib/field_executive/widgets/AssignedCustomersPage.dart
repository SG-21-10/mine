import 'package:flutter/material.dart';

class AssignedCustomersPage extends StatelessWidget {
  const AssignedCustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {
        "id": "CUST101",
        "name": "Dairybelle",
        "location": "Pinetown",
        "contact": "1234567890",
        "email": "dairy@example.com"
      },
      {
        "id": "CUST102",
        "name": "MilkMart",
        "location": "Durban",
        "contact": "9876543210",
        "email": "milk@example.com"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Customers"),
        backgroundColor: Color(0xFFA5C8D0),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(customer["name"] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${customer["id"]}"),
                  Text("Location: ${customer["location"]}"),
                  Text("Contact: ${customer["contact"]}"),
                  Text("Email: ${customer["email"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
