import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accountant_provider.dart';
import '../theme/app_theme.dart';
import '../../constants/colors.dart';
import '../models/invoice.dart';

class VerifyPaymentScreen extends StatefulWidget {
  const VerifyPaymentScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPaymentScreen> createState() => _VerifyPaymentScreenState();
}

class _VerifyPaymentScreenState extends State<VerifyPaymentScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Payment'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
        body: Container(
          color: AppColors.background,
          child: Consumer<AccountantProvider>(
            builder: (context, provider, child) {
              final sentInvoices = provider.invoices.where((inv) => inv.status == 'sent').toList();
              
              if (sentInvoices.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No sent invoices to verify',
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
                      'Sent Invoices',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sentInvoices.length,
                        itemBuilder: (context, index) {
                          final invoice = sentInvoices[index];
                          final isOverdue = DateTime.now().isAfter(invoice.dueDate);
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isOverdue ? AppColors.error : AppColors.warning,
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
                                    'Total: \$${invoice.total.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Due: ${_formatDate(invoice.dueDate)}',
                                    style: TextStyle(
                                      color: isOverdue ? AppColors.error : AppColors.textSecondary,
                                      fontWeight: isOverdue ? FontWeight.w500 : FontWeight.normal,
                                    ),
                                  ),
                                  if (isOverdue)
                                    const Text(
                                      'OVERDUE',
                                      style: TextStyle(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: _isLoading ? null : () => _verifyPayment(invoice.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  foregroundColor: AppColors.textLight,
                                ),
                                child: const Text('Mark Paid'),
                              ),
                            ),
                          );
                        },
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _verifyPayment(String invoiceId) async {
    setState(() {
      _isLoading = true;
    });

    final provider = context.read<AccountantProvider>();
    final invoice = provider.getInvoiceById(invoiceId);

    if (invoice != null) {
      // Simulate payment verification process
      await Future.delayed(const Duration(seconds: 1));

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
        status: 'paid',
        notes: invoice.notes,
      );

      provider.updateInvoice(updatedInvoice);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment verified for ${invoice.customerName}'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
