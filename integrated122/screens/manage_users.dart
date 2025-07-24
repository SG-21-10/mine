import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import '../controllers/manage_users.dart';
import '../widgets/user_form.dart';
import '../widgets/user_list.dart';
import 'admin_drawer.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => ManageUsersScreenState();
}

class ManageUsersScreenState extends State<ManageUsersScreen> {
  late AdminManageUsersController controller;
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    controller = AdminManageUsersController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: const Text(
              'Manage Users',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

            ),
            backgroundColor: AppColors.flowerBlue,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showForm = !showForm;
                    if (!showForm) {
                      controller.clearForm();
                    }
                  });
                },
                icon: Icon(
                  showForm ? Icons.list : Icons.add,
                  color: Colors.black,
                ),
                tooltip: showForm ? 'View Users' : 'Add User',
              ),
            ],
          ),
          drawer: AdminDrawer(),
          body: Column(
            children: [
              // Header with stats
              buildStatsHeader(),

              // Main content
              Expanded(
                child: (showForm || controller.isEditMode)
                    ? buildFormView()
                    : buildListView(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildStatsHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.flowerBlue.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildStatCard(
                'Total Users',
                controller.users.length.toString(),
                Icons.people,
                AppColors.darkBlue,
              ),
              buildStatCard(
                'Active',
                controller.users.where((u) => u.status == 'active').length.toString(),
                Icons.check_circle,
                AppColors.darkBlue,
              ),
              buildStatCard(
                'Inactive',
                controller.users.where((u) => u.status == 'inactive').length.toString(),
                Icons.close,
                AppColors.darkBlue,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildStatCard(
                'Suspended',
                controller.users.where((u) => u.status == 'suspended').length.toString(),
                Icons.block,
                AppColors.darkBlue,
              ),
              buildStatCard(
                'Pending',
                controller.users.where((u) => u.status == 'pending').length.toString(),
                Icons.schedule,
                AppColors.darkBlue,
              ),
              buildStatCard(
                'Filtered',
                controller.filteredUsers.length.toString(),
                Icons.filter_list,
                AppColors.darkBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.flowerBlue.withOpacity(0.15),
        border: Border.all(color: AppColors.accentBlue.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: UserForm(controller: controller),

    );
  }

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: UserList(controller: controller),
    );
  }
}
