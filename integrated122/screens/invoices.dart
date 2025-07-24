import 'package:app/modules/admin/controllers/invoices.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../widgets/invoice_list.dart';
import '../widgets/invoice_form.dart';
import 'admin_drawer.dart';

class AdminInvoicesScreen extends StatefulWidget {
  const AdminInvoicesScreen({super.key});

  @override
  State<AdminInvoicesScreen> createState() => _AdminInvoicesScreenState();
}

class _AdminInvoicesScreenState extends State<AdminInvoicesScreen> {
  late AdminInvoicesController controller;
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    controller = AdminInvoicesController();
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
              'Invoices',
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
    double totalDue = controller.invoices.fold(0, (sum, inv) => sum + inv.totalDue);
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
                'Total Invoices',
                controller.invoices.length.toString(),
                Icons.receipt_long,
                AppColors.darkBlue,
              ),
              buildStatCard(
                'Total Due',
                totalDue.toStringAsFixed(2),
                Icons.currency_rupee_rounded,
                AppColors.darkBlue,
              ),
              buildStatCard(
                'Filtered',
                controller.filteredInvoices.length.toString(),
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
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: InvoiceForm(controller: controller),
    );
  }

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InvoiceList(controller: controller),
    );
  }
}
