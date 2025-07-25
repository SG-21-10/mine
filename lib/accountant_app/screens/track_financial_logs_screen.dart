import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accountant_provider.dart';
import '../models/financial_log.dart';
import '../theme/app_theme.dart';
import 'financial_logs_display_screen.dart';
import 'acc_home_screen.dart';
import 'maintain_financial_log_screen.dart';
import 'generate_invoice_screen.dart';
import 'send_invoice_screen.dart';
import 'verify_payment_screen.dart';

class TrackFinancialLogsScreen extends StatefulWidget {
  const TrackFinancialLogsScreen({Key? key}) : super(key: key);

  @override
  State<TrackFinancialLogsScreen> createState() => _TrackFinancialLogsScreenState();
}

class _TrackFinancialLogsScreenState extends State<TrackFinancialLogsScreen> {
  String _selectedFilter = 'all';
  String _selectedCategory = 'all';
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountantProvider>().loadFinancialLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Track Financial Logs'),
          backgroundColor: AppTheme.primaryColor,
          actions: [
            IconButton(
              onPressed: _showFilterDialog,
              icon: const Icon(Icons.filter_list),
            ),
          ],
        ),
        drawer: _buildNavigationDrawer(context),
        body: Container(
          color: AppTheme.backgroundColor,
          child: Column(
            children: [
              _buildFilterChips(),
              Expanded(
                child: Consumer<AccountantProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
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
                              style: const TextStyle(
                                color: AppTheme.textColor,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => provider.loadFinancialLogs(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    final filteredLogs = _getFilteredLogs(provider.financialLogs);

                    return Column(
                      children: [
                        _buildSummaryCards(filteredLogs),
                        Expanded(
                          child: filteredLogs.isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: AppTheme.secondaryColor,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'No logs match your filters',
                                        style: TextStyle(
                                          color: AppTheme.textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: filteredLogs.length,
                                  itemBuilder: (context, index) {
                                    final log = filteredLogs[index];
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
                                        subtitle: Text(
                                          '${log.category} • ${log.date.day}/${log.date.month}/${log.date.year}',
                                          style: const TextStyle(color: AppTheme.textColor),
                                        ),
                                        trailing: Text(
                                          '${log.type == 'income' ? '+' : '-'}\$${log.amount.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final provider = context.read<AccountantProvider>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinancialLogsDisplayScreen(
                  logs: _getFilteredLogs(provider.financialLogs),
                ),
              ),
            );
          },
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(Icons.visibility, color: Colors.white),
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

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        children: [
          FilterChip(
            label: const Text('All'),
            selected: _selectedFilter == 'all',
            onSelected: (selected) {
              setState(() {
                _selectedFilter = 'all';
              });
            },
          ),
          FilterChip(
            label: const Text('Income'),
            selected: _selectedFilter == 'income',
            onSelected: (selected) {
              setState(() {
                _selectedFilter = 'income';
              });
            },
          ),
          FilterChip(
            label: const Text('Expenses'),
            selected: _selectedFilter == 'expense',
            onSelected: (selected) {
              setState(() {
                _selectedFilter = 'expense';
              });
            },
          ),
          if (_selectedDateRange != null)
            FilterChip(
              label: Text('${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}'),
              selected: true,
              onSelected: (selected) {
                setState(() {
                  _selectedDateRange = null;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(List<FinancialLog> logs) {
    final totalIncome = logs
        .where((log) => log.type == 'income')
        .fold(0.0, (sum, log) => sum + log.amount);
    
    final totalExpenses = logs
        .where((log) => log.type == 'expense')
        .fold(0.0, (sum, log) => sum + log.amount);
    
    final netAmount = totalIncome - totalExpenses;

    return Padding(
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
                    const Text('Income', style: TextStyle(color: Colors.green)),
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
                    const Text('Expenses', style: TextStyle(color: Colors.red)),
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
                      'Net',
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Select Date Range'),
              trailing: const Icon(Icons.date_range),
              onTap: () async {
                Navigator.pop(context);
                final DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  initialDateRange: _selectedDateRange,
                );
                if (picked != null) {
                  setState(() {
                    _selectedDateRange = picked;
                  });
                }
              },
            ),
            if (_selectedDateRange != null)
              ListTile(
                title: const Text('Clear Date Filter'),
                trailing: const Icon(Icons.clear),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedDateRange = null;
                  });
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  List<FinancialLog> _getFilteredLogs(List<FinancialLog> logs) {
    var filtered = logs.where((log) {
      // Filter by type
      if (_selectedFilter != 'all' && log.type != _selectedFilter) {
        return false;
      }

      // Filter by date range
      if (_selectedDateRange != null) {
        if (log.date.isBefore(_selectedDateRange!.start) ||
            log.date.isAfter(_selectedDateRange!.end)) {
          return false;
        }
      }

      return true;
    }).toList();

    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));
    
    return filtered;
  }
}
