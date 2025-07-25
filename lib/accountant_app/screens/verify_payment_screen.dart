import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/invoice.dart';
import '../providers/accountant_provider.dart';
import '../theme/app_theme.dart';
import 'acc_home_screen.dart';
import 'maintain_financial_log_screen.dart';
import 'track_financial_logs_screen.dart';
import 'generate_invoice_screen.dart';
import 'send_invoice_screen.dart';

class VerifyPaymentScreen extends StatefulWidget {
  const VerifyPaymentScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPaymentScreen> createState() => _VerifyPaymentScreenState();
}

class _VerifyPaymentScreenState extends State<VerifyPaymentScreen> {
  String _selectedFilter = 'all';
  final List<String> _filterOptions = ['all', 'sent', 'paid', 'overdue'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountantProvider>().loadInvoices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Payments'),
          backgroundColor: AppTheme.primaryColor,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  _selectedFilter = value;
                });
              },
              itemBuilder: (context) => _filterOptions.map((filter) {
                return PopupMenuItem(
                  value: filter,
                  child: Text(filter.toUpperCase()),
                );
              }).toList(),
              icon: const Icon(Icons.filter_list),
            ),
          ],
        ),
        drawer: _buildNavigationDrawer(context),
        body: Container(
          color: AppTheme.backgroundColor,
          child: Consumer<AccountantProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppTheme.primaryColor),
                );
              }

              if (provider.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${provider.error}',
                        style: const TextStyle(color: AppTheme.textColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => provider.loadInvoices(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final filteredInvoices = _getFilteredInvoices(provider.invoices);

              if (filteredInvoices.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.receipt_long,
                        size: 64,
                        color: AppTheme.secondaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _selectedFilter == 'all'
                            ? 'No invoices found'
                            : 'No ${_selectedFilter} invoices found',
                        style: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  _buildSummaryCards(provider.invoices),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredInvoices.length,
                      itemBuilder: (context, index) {
                        final invoice = filteredInvoices[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: _getStatusColor(invoice.status),
                              child: Icon(
                                _getStatusIcon(invoice.status),
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              invoice.clientName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount: \$${invoice.totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textColor,
                                  ),
                                ),
                                Text(
                                  'Due: ${invoice.dueDate.day}/${invoice.dueDate.month}/${invoice.dueDate.year}',
                                  style: const TextStyle(color: AppTheme.textColor),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(invoice.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                invoice.status.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInvoiceDetails(invoice),
                                    const SizedBox(height: 16),
                                    _buildActionButtons(invoice),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Accountant App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountantHomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Maintain Financial Logs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaintainFinancialLogScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Track Financial Logs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrackFinancialLogsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Generate Invoice'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GenerateInvoiceScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Send Invoice'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendInvoiceScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified),
            title: const Text('Verify Payment'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(List<Invoice> invoices) {
    final sentInvoices = invoices.where((i) => i.status == 'sent').length;
    final paidInvoices = invoices.where((i) => i.status == 'paid').length;
    final overdueInvoices = invoices.where((i) => i.status == 'overdue').length;
    final totalPending = invoices
        .where((i) => i.status == 'sent')
        .fold(0.0, (sum, i) => sum + i.totalAmount);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Icon(Icons.send, color: Colors.blue, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      '$sentInvoices',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text('Sent', style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      '$paidInvoices',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Text('Paid', style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Card(
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Icon(Icons.warning, color: Colors.red, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      '$overdueInvoices',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text('Overdue', style: TextStyle(color: Colors.red, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Card(
              color: Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.orange, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      '\$${totalPending.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const Text('Pending', style: TextStyle(color: Colors.orange, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails(Invoice invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Invoice Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text('Email: ${invoice.clientEmail}'),
        Text('Issue Date: ${invoice.issueDate.day}/${invoice.issueDate.month}/${invoice.issueDate.year}'),
        Text('Due Date: ${invoice.dueDate.day}/${invoice.dueDate.month}/${invoice.dueDate.year}'),
        Text('Subtotal: \$${invoice.subtotalAmount.toStringAsFixed(2)}'),
        if (invoice.taxRate > 0)
          Text('Tax (${(invoice.taxRate * 100).toStringAsFixed(1)}%): \$${invoice.taxAmount.toStringAsFixed(2)}'),
        Text(
          'Total: \$${invoice.totalAmount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Notes: ${invoice.notes}'),
        ],
        const SizedBox(height: 8),
        const Text(
          'Items:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...invoice.items.map((item) => Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text('• ${item.description} (${item.quantity}x \$${item.unitPrice.toStringAsFixed(2)})'),
        )),
      ],
    );
  }

  Widget _buildActionButtons(Invoice invoice) {
    return Row(
      children: [
        if (invoice.status == 'sent') ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _verifyPayment(invoice),
              icon: const Icon(Icons.check),
              label: const Text('Mark as Paid'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _markAsOverdue(invoice),
              icon: const Icon(Icons.warning),
              label: const Text('Mark Overdue'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
        ] else if (invoice.status == 'paid') ...[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Payment Verified',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else if (invoice.status == 'overdue') ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _verifyPayment(invoice),
              icon: const Icon(Icons.check),
              label: const Text('Mark as Paid'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }

  List<Invoice> _getFilteredInvoices(List<Invoice> invoices) {
    if (_selectedFilter == 'all') {
      return invoices;
    }
    return invoices.where((invoice) => invoice.status == _selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return Colors.grey;
      case 'sent':
        return Colors.blue;
      case 'paid':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return Icons.edit;
      case 'sent':
        return Icons.send;
      case 'paid':
        return Icons.check_circle;
      case 'overdue':
        return Icons.warning;
      default:
        return Icons.edit;
    }
  }

  Future<void> _verifyPayment(Invoice invoice) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify Payment'),
        content: Text('Mark invoice for ${invoice.clientName} as paid?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Store context in a local variable
      final currentContext = context;
      
      // Call the verifyPayment method in the provider
      final success = await context.read<AccountantProvider>().verifyPayment(invoice.id);

      if (mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Payment verified successfully!'
                  : 'Failed to verify payment',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _markAsOverdue(Invoice invoice) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Overdue'),
        content: Text('Mark invoice for ${invoice.clientName} as overdue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Mark Overdue'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Store context in a local variable
      final currentContext = context;
      
      // Update the invoice status to 'overdue'
      invoice.status = 'overdue';
      
      // Notify the UI
      setState(() {});

      if (mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(
            content: Text('Invoice marked as overdue'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }
}
