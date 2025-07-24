import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accountant_provider.dart';
import '../theme/app_theme.dart';
import '../../constants/colors.dart';

class TrackFinancialLogsScreen extends StatefulWidget {
  const TrackFinancialLogsScreen({Key? key}) : super(key: key);

  @override
  State<TrackFinancialLogsScreen> createState() => _TrackFinancialLogsScreenState();
}

class _TrackFinancialLogsScreenState extends State<TrackFinancialLogsScreen> {
  String _filterType = 'all';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Track Financial Logs'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
        body: Container(
          color: AppColors.background,
          child: Consumer<AccountantProvider>(
            builder: (context, provider, child) {
              final allLogs = provider.financialLogs;
              final filteredLogs = _filterType == 'all'
                  ? allLogs
                  : allLogs.where((log) => log.type == _filterType).toList();

              return Column(
                children: [
                  _buildSummaryCards(provider),
                  _buildFilterTabs(),
                  Expanded(
                    child: filteredLogs.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 64,
                                  color: AppColors.textSecondary,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No financial logs found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.textSecondary,
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
                              return _buildLogCard(log);
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

  Widget _buildSummaryCards(AccountantProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Income',
              '\$${provider.totalIncome.toStringAsFixed(2)}',
              AppColors.success,
              Icons.trending_up,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Total Expenses',
              '\$${provider.totalExpenses.toStringAsFixed(2)}',
              AppColors.error,
              Icons.trending_down,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String amount, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterTab('All', 'all'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterTab('Income', 'income'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterTab('Expenses', 'expense'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, String value) {
    final isSelected = _filterType == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? AppColors.textLight : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLogCard(log) {
    final isIncome = log.type == 'income';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome ? AppColors.success : AppColors.error,
          child: Icon(
            isIncome ? Icons.add : Icons.remove,
            color: AppColors.textLight,
          ),
        ),
        title: Text(
          log.description,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: ${log.category}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            Text(
              'Date: ${log.date.day}/${log.date.month}/${log.date.year}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            if (log.reference != null)
              Text(
                'Ref: ${log.reference}',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
          ],
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}\$${log.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isIncome ? AppColors.success : AppColors.error,
          ),
        ),
      ),
    );
  }
}
