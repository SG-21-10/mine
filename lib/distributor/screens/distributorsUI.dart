// distributor_home_page.dart
import 'package:flutter/material.dart';
import 'CatalogOrdersPage.dart';
import 'Updatestock.dart';

class DistributorHomePage extends StatelessWidget {
  const DistributorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Distributor Dashboard"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildOptionCard(
              icon: Icons.shopping_bag,
              title: "Catalog & Orders",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CatalogOrdersPage())),
              ),
            buildOptionCard(
              icon: Icons.inventory,
              title: "Stock Management",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpdateStockPage())),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: const Color(0xFFA5C8D0)),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
