import '../models/invoice.dart';
import '../models/financial_log.dart';

class AccountantService {
  static final AccountantService _instance = AccountantService._internal();
  factory AccountantService() => _instance;
  AccountantService._internal();

  final List<Invoice> _invoices = [];
  final List<FinancialLog> _financialLogs = [];

  // Invoice methods
  List<Invoice> getInvoices() => List.unmodifiable(_invoices);

  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
  }

  void updateInvoice(Invoice updatedInvoice) {
    final index = _invoices.indexWhere((inv) => inv.id == updatedInvoice.id);
    if (index != -1) {
      _invoices[index] = updatedInvoice;
    }
  }

  void deleteInvoice(String invoiceId) {
    _invoices.removeWhere((inv) => inv.id == invoiceId);
  }

  Invoice? getInvoiceById(String id) {
    try {
      return _invoices.firstWhere((inv) => inv.id == id);
    } catch (e) {
      return null;
    }
  }

  // Financial Log methods
  List<FinancialLog> getFinancialLogs() => List.unmodifiable(_financialLogs);

  void addFinancialLog(FinancialLog log) {
    _financialLogs.add(log);
  }

  void updateFinancialLog(FinancialLog updatedLog) {
    final index = _financialLogs.indexWhere((log) => log.id == updatedLog.id);
    if (index != -1) {
      _financialLogs[index] = updatedLog;
    }
  }

  void deleteFinancialLog(String logId) {
    _financialLogs.removeWhere((log) => log.id == logId);
  }

  FinancialLog? getFinancialLogById(String id) {
    try {
      return _financialLogs.firstWhere((log) => log.id == id);
    } catch (e) {
      return null;
    }
  }

  // Analytics methods
  double getTotalIncome() {
    return _financialLogs
        .where((log) => log.type == 'income')
        .fold(0.0, (sum, log) => sum + log.amount);
  }

  double getTotalExpenses() {
    return _financialLogs
        .where((log) => log.type == 'expense')
        .fold(0.0, (sum, log) => sum + log.amount);
  }

  double getNetProfit() {
    return getTotalIncome() - getTotalExpenses();
  }

  List<Invoice> getPendingInvoices() {
    return _invoices.where((inv) => inv.status != 'paid').toList();
  }

  double getTotalOutstanding() {
    return getPendingInvoices().fold(0.0, (sum, inv) => sum + inv.total);
  }
}
