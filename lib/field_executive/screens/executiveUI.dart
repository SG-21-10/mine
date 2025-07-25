// field_executive_home.dart
import 'package:flutter/material.dart';
import 'gps_tracking_page.dart';
import 'customer_visits_page.dart';
import 'order_management_page.dart';
import 'other_operations_page.dart';

class FieldExecutiveHomePage extends StatelessWidget {
  const FieldExecutiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIELD EXECUTIVE HOME'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeButton(
              title: 'GPS Tracking',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GpsTrackingPage()),
              ),
            ),
            const SizedBox(height: 20),
            HomeButton(
              title: 'Customer Visits',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomerVisitsPage()),
              ),
            ),
            const SizedBox(height: 20),
            HomeButton(
              title: 'Order Management',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderManagementPage()),
              ),
            ),
            const SizedBox(height: 20),
            HomeButton(
              title: 'Other Operations',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OtherOperationsPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HomeButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFA5C8D0),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      child: Text(title, style: const TextStyle(fontSize: 18)),
    );
  }
}
