import 'package:flutter/material.dart';
import '../models/financial_log.dart';
import '../theme/app_theme.dart';
import 'acc_home_screen.dart';
import 'maintain_financial_log_screen.dart';
import 'track_financial_logs_screen.dart';
import 'generate_invoice_screen.dart';
import 'send_invoice_screen.dart';
import 'verify_payment_screen.dart';

class FinancialLogsDisplayScreen extends StatelessWidget {
  final List<FinancialLog>? logs;

  const FinancialLogsDisplayScreen({
    Key? key,
    required this.logs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Financial Logs'),
          backgroundColor: AppTheme.primaryColor,
          actions: [
            IconButton(
              onPressed: () => _exportLogs(context),
              icon: const Icon(Icons.download),
            ),
          ],
        ),
        drawer: _buildNavigationDrawer(context),
        body: Container(
          color: AppTheme.backgroundColor,
          child: logs == null || logs!.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 64,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No financial logs available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildSummarySection(),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: logs!.length,
                        itemBuilder: (context, index) {
                          final log = logs![index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: log.type == 'income'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                child: Icon(
                                  log.type == 'income'
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color: log.type == 'income'
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                ),
                              ),
                              title: Text(
                                log.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category: ${log.category}',
                                    style: const TextStyle(color: AppTheme.textColor),
                                  ),
                                  Text(
                                    'Date: ${log.date.day}/${log.date.month}/${log.date.year}',
                                    style: const TextStyle(color: AppTheme.textColor),
                                  ),
                                  if (log.notes != null && log.notes!.isNotEmpty)
                                    Text(
                                      'Notes: ${log.notes}',
                                      style: const TextStyle(
                                        color: AppTheme.textColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              ),
                              trailing: Text(
                                '${log.type == 'income' ? '+' : '-'}\$${log.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: log.type == 'income'
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerifyPaymentScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/Users/surma/Development/Projects/ff/lib/authpage/pages/login_page.dart');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    if (logs == null || logs!.isEmpty) return const SizedBox.shrink();

    final totalIncome = logs!
        .where((log) => log.type == 'income')
        .fold(0.0, (sum, log) => sum + log.amount);

    final totalExpenses = logs!
        .where((log) => log.type == 'expense')
        .fold(0.0, (sum, log) => sum + log.amount);

    final netAmount = totalIncome - totalExpenses;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.trending_up, color: Colors.green, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      '\$${totalIncome.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Text('Total Income', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Card(
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.trending_down, color: Colors.red, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      '\$${totalExpenses.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text('Total Expenses', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Card(
              color: netAmount >= 0 ? Colors.blue[50] : Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      netAmount >= 0 ? Icons.account_balance : Icons.warning,
                      color: netAmount >= 0 ? Colors.blue : Colors.orange,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${netAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: netAmount >= 0 ? Colors.blue : Colors.orange,
                      ),
                    ),
                    Text(
                      'Net Amount',
                      style: TextStyle(
                        color: netAmount >= 0 ? Colors.blue : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exportLogs(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export functionality would be implemented here'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
