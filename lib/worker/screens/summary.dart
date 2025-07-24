import './worker_drawer.dart';
import 'package:flutter/material.dart';
import '../controllers/summary.dart';
import '../widgets/summary.dart';
import '../../../constants/colors.dart';

class WorkerSummaryScreen extends StatefulWidget {
  const WorkerSummaryScreen({super.key});

  @override
  State<WorkerSummaryScreen> createState() => WorkerSummaryScreenState();
}

class WorkerSummaryScreenState extends State<WorkerSummaryScreen> {
  late WorkerSummaryController controller;
  bool isLoading = false;
  Map<String, dynamic>? summary;

  @override
  void initState() {
    super.initState();
    controller = WorkerSummaryController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSubmit() {
    setState(() {
      isLoading = true;
    });
    // Simulate local update
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
        controller.workerIdController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Summary'),
        backgroundColor: AppColors.primaryBlue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: WorkerDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.only(left: 16, right: 16),
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
                  child: TextField(
                    controller: controller.workerIdController,
                    decoration: const InputDecoration(
                      labelText: 'Worker ID',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading ? null : handleSubmit,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Fetch Summary'),
                ),
                const SizedBox(height: 24),
                if (summary != null)
                  Expanded(
                    child: ListView(
                      children: [
                        SummaryCard(summary: summary!),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
} 