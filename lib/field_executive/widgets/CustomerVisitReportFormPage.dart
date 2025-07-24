import 'package:flutter/material.dart';

class CustomerVisitReportFormPage extends StatefulWidget {
  const CustomerVisitReportFormPage({super.key});

  @override
  State<CustomerVisitReportFormPage> createState() => _CustomerVisitReportFormPageState();
}

class _CustomerVisitReportFormPageState extends State<CustomerVisitReportFormPage> {
  // Controllers
  final customerController = TextEditingController();
  final locationController = TextEditingController();
  final presentController = TextEditingController();
  final productsController = TextEditingController();
  final reasonController = TextEditingController();
  final concernsController = TextEditingController();
  final feedbackController = TextEditingController();
  final reportByController = TextEditingController();

  // Dropdown values
  String investigation = "None";
  String rootCause = "None";
  String correctiveAction = "None";
  String recommendation = "None";

  // Date
  DateTime? visitDate;

  Future<void> _selectVisitDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: visitDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => visitDate = picked);
    }
  }

  Widget buildField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildDropdown(String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: const InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _submitReport() {
    String summary = '''
Customer: ${customerController.text}
Date of Visit: ${visitDate != null ? visitDate.toString().split(' ')[0] : 'Not selected'}
Location: ${locationController.text}
Present: ${presentController.text}
Products: ${productsController.text}
Reason: ${reasonController.text}

Concerns: ${concernsController.text}
Investigation: $investigation
Root Cause: $rootCause
Corrective Action: $correctiveAction
Recommendations: $recommendation

General Feedback: ${feedbackController.text}
Report Completed By: ${reportByController.text}
''';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Visit Report Submitted"),
        content: SingleChildScrollView(child: Text(summary)),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text("Customer Visit Report"),
        backgroundColor: const Color(0xFFA5C8D0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("INFORMATION", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildField("Customer", customerController),
            Row(
              children: [
                const Text("Date of Visit: "),
                TextButton(
                  onPressed: () => _selectVisitDate(context),
                  child: Text(
                    visitDate != null
                        ? "${visitDate!.day}/${visitDate!.month}/${visitDate!.year}"
                        : "Select Date",
                  ),
                ),
              ],
            ),
            buildField("Location", locationController),
            buildField("Present", presentController),
            buildField("Products", productsController, maxLines: 2),
            buildField("Reason for Visit", reasonController),

            const Divider(thickness: 1),
            const SizedBox(height: 8),
            const Text("QUALITY", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildField("Customer Concerns", concernsController, maxLines: 2),
            buildDropdown("Investigation", investigation, ["None", "Ongoing", "Resolved"], (val) {
              if (val != null) setState(() => investigation = val);
            }),
            buildDropdown("Root Cause", rootCause, ["None", "Product defect", "Miscommunication"], (val) {
              if (val != null) setState(() => rootCause = val);
            }),
            buildDropdown("Corrective Action", correctiveAction, ["None", "Replace batch", "Schedule meeting"], (val) {
              if (val != null) setState(() => correctiveAction = val);
            }),
            buildDropdown("Recommendations", recommendation, ["None", "Increase QA checks", "Follow-up visit"], (val) {
              if (val != null) setState(() => recommendation = val);
            }),

            const Divider(thickness: 1),
            const SizedBox(height: 8),
            const Text("GENERAL", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildField("General Feedback / Comments", feedbackController, maxLines: 2),
            buildField("Report Completed By", reportByController),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitReport,
              icon: const Icon(Icons.save),
              label: const Text("Submit Report"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA5C8D0),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
