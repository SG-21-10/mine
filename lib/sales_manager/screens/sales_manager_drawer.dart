import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class SalesManagerDrawer extends StatelessWidget {
  const SalesManagerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryBlue),
            child: const Text('Sales Manager Panel', style: TextStyle(fontSize: 22, color: Colors.black)),
          ),
          ListTile(
            leading: const Icon(Icons.gps_fixed),
            title: const Text('Track Field Executive GPS'),
            onTap: () => Navigator.pushNamed(context, '/sales_manager/gps_tracking'),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('View Performance Reports'),
            onTap: () => Navigator.pushNamed(context, '/sales_manager/performance_reports'),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Assign Tasks'),
            onTap: () => Navigator.pushNamed(context, '/sales_manager/assign_tasks'),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Approve DVR Reports'),
            onTap: () => Navigator.pushNamed(context, '/sales_manager/approve_dvr_reports'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }
} 