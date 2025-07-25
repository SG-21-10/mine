// browse_catalog_page.dart
import 'package:flutter/material.dart';

class BrowseCatalogPage extends StatelessWidget {
  const BrowseCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Product Catalog"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Fetched Products:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text("Product ID: 1"), subtitle: Text("Name: Water Tank")),
                  ListTile(title: Text("Product ID: 2"), subtitle: Text("Name: Solar Panel")),
                  ListTile(title: Text("Product ID: 3"), subtitle: Text("Name: Pipe Set")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}