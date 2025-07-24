import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accountant_provider.dart';
import '../theme/app_theme.dart';
import '../../constants/colors.dart';

class SendInvoiceScreen extends StatefulWidget {
  const SendInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<SendInvoiceScreen> createState() => _SendInvoiceScreenState();
}

class _SendInvoiceScreenState extends State<SendInvoiceScreen> {
  String? _selectedInvoiceId;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Send Invoice'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
        body: Container(
          color: AppColors.background,
          child: Consumer<AccountantProvider>(
            builder: (context, provider, child) {
              final invoices = provider.invoices.where((inv) => inv.status == 'draft').toList();
              
              if (invoices.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No draft invoices available',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Invoice to Send',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: invoices.length,
                        itemBuilder: (context, index) {
                          final invoice = invoices[index];
                          final isSelected = _selectedInvoiceId == invoice.id;
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              selected: isSelected,
                              selectedTileColor: AppColors.accent.withOpacity(0.3),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Text(
                                  invoice.customerName[0].toUpperCase(),
                                  style: const TextStyle(color: AppColors.textLight),
                                ),
                              ),
                              title: Text(
                                invoice.customerName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    invoice.customerEmail,
                                    style: const TextStyle(color: AppColors.textSecondary),
                                  ),
                                  Text(
                                    'Total: \$${invoice.total.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_circle, color: AppColors.success)
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedInvoiceId = isSelected ? null : invoice.id;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedInvoiceId != null && !_isLoading
                            ? _sendInvoice
                            : null,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Send Invoice'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _sendInvoice() async {
    if (_selectedInvoiceId == null) return;

    setState(() {
      _isLoading = true;
    });

    final provider = context.read<AccountantProvider>();
    final invoice = provider.getInvoiceById(_selectedInvoiceId!);

    if (invoice != null) {
      // Simulate sending email
      await Future.delayed(const Duration(seconds: 2));

      final updatedInvoice = Invoice(
        id: invoice.id,
        customerName: invoice.customerName,
        customerEmail: invoice.customerEmail,
        items: invoice.items,
        subtotal: invoice.subtotal,
        tax: invoice.tax,
        total: invoice.total,
        issueDate: invoice.issueDate,
        dueDate: invoice.dueDate,
        status: 'sent',
        notes: invoice.notes,
      );

      provider.updateInvoice(updatedInvoice);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invoice sent to ${invoice.customerEmail}'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
