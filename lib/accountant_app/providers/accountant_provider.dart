import 'package:flutter/foundation.dart';
import '../models/invoice.dart';
import '../models/financial_log.dart';
import '../services/accountant_service.dart';

class AccountantProvider with ChangeNotifier {
  final AccountantService _service = AccountantService();

  List<Invoice> get invoices => _service.getInvoices();
  List<FinancialLog> get financialLogs => _service.getFinancialLogs();

  // Invoice methods
  void addInvoice(Invoice invoice) {
    _service.addInvoice(invoice);
    notifyListeners();
  }

  void updateInvoice(Invoice invoice) {
    _service.updateInvoice(invoice);
    notifyListeners();
  }

  void deleteInvoice(String invoiceId) {
    _service.deleteInvoice(invoiceId);
    notifyListeners();
  }

  Invoice? getInvoiceById(String id) {
    return _service.getInvoiceById(id);
  }

  // Financial Log methods
  void addFinancialLog(FinancialLog log) {
    _service.addFinancialLog(log);
    notifyListeners();
  }

  void updateFinancialLog(FinancialLog log) {
    _service.updateFinancialLog(log);
    notifyListeners();
  }

  void deleteFinancialLog(String logId) {
    _service.deleteFinancialLog(logId);
    notifyListeners();
  }

  FinancialLog? getFinancialLogById(String id) {
    return _service.getFinancialLogById(id);
  }

  // Analytics
  double get totalIncome => _service.getTotalIncome();
  double get totalExpenses => _service.getTotalExpenses();
  double get netProfit => _service.getNetProfit();
  List<Invoice> get pendingInvoices => _service.getPendingInvoices();
  double get totalOutstanding => _service.getTotalOutstanding();

  // Load methods (for initialization)
  void loadInvoices() {
    // In a real app, this would load from a database or API
    // For now, we'll add some sample data
    if (invoices.isEmpty) {
      _addSampleInvoices();
    }
    notifyListeners();
  }

  void loadFinancialLogs() {
    // In a real app, this would load from a database or API
    // For now, we'll add some sample data
    if (financialLogs.isEmpty) {
      _addSampleFinancialLogs();
    }
    notifyListeners();
  }

  void _addSampleInvoices() {
    final sampleInvoices = [
      Invoice(
        id: '1',
        customerName: 'John Doe',
        customerEmail: 'john@example.com',
        items: [
          InvoiceItem(
            description: 'Product A',
            quantity: 2,
            unitPrice: 100.0,
            total: 200.0,
          ),
        ],
        subtotal: 200.0,
        tax: 20.0,
        total: 220.0,
        issueDate: DateTime.now().subtract(const Duration(days: 5)),
        dueDate: DateTime.now().add(const Duration(days: 25)),
        status: 'sent',
      ),
      Invoice(
        id: '2',
        customerName: 'Jane Smith',
        customerEmail: 'jane@example.com',
        items: [
          InvoiceItem(
            description: 'Service B',
            quantity: 1,
            unitPrice: 500.0,
            total: 500.0,
          ),
        ],
        subtotal: 500.0,
        tax: 50.0,
        total: 550.0,
        issueDate: DateTime.now().subtract(const Duration(days: 10)),
        dueDate: DateTime.now().add(const Duration(days: 20)),
        status: 'paid',
      ),
    ];

    for (final invoice in sampleInvoices) {
      _service.addInvoice(invoice);
    }
  }

  void _addSampleFinancialLogs() {
    final sampleLogs = [
      FinancialLog(
        id: '1',
        description: 'Sales Revenue',
        amount: 1000.0,
        type: 'income',
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Sales',
      ),
      FinancialLog(
        id: '2',
        description: 'Office Supplies',
        amount: 150.0,
        type: 'expense',
        date: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Office',
      ),
      FinancialLog(
        id: '3',
        description: 'Consulting Fee',
        amount: 750.0,
        type: 'income',
        date: DateTime.now().subtract(const Duration(days: 3)),
        category: 'Services',
      ),
    ];

    for (final log in sampleLogs) {
      _service.addFinancialLog(log);
    }
  }
}
