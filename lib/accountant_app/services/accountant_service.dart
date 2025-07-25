import '../models/financial_log.dart';
import '../models/invoice.dart';

class AccountantService {
  static final AccountantService _instance = AccountantService._internal();
  factory AccountantService() => _instance;
  AccountantService._internal();

  // Sample data
  final List<FinancialLog> _financialLogs = [
    FinancialLog(
      id: '1',
      description: 'Client Payment - ABC Corp',
      amount: 5000.00,
      type: 'income',
      category: 'Revenue',
      date: DateTime.now().subtract(const Duration(days: 1)),
      notes: 'Monthly retainer payment',
    ),
    FinancialLog(
      id: '2',
      description: 'Office Rent',
      amount: 2000.00,
      type: 'expense',
      category: 'Operating Expenses',
      date: DateTime.now().subtract(const Duration(days: 2)),
      notes: 'Monthly office rent payment',
    ),
    FinancialLog(
      id: '3',
      description: 'Software Licenses',
      amount: 500.00,
      type: 'expense',
      category: 'Technology',
      date: DateTime.now().subtract(const Duration(days: 3)),
      notes: 'Annual software subscription',
    ),
  ];

  final List<Invoice> _invoices = [
    Invoice(
      id: 'INV-001',
      clientName: 'ABC Corporation',
      clientEmail: 'billing@abccorp.com',
      clientAddress: '123 Business St, Business City',
      items: [
        InvoiceItem(
          description: 'Consulting Services',
          quantity: 40,
          unitPrice: 125.00,
          totalAmount: 5000.00,
        ),
      ],
      subtotalAmount: 5000.00,
      taxRate: 0.0,
      taxAmount: 0.0,
      totalAmount: 5000.00,
      issueDate: DateTime.now().subtract(const Duration(days: 5)),
      dueDate: DateTime.now().add(const Duration(days: 25)),
      status: 'sent',
      notes: 'Monthly consulting retainer',
    ),
  ];

  Future<List<FinancialLog>> getFinancialLogs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_financialLogs);
  }

  Future<List<Invoice>> getInvoices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_invoices);
  }

  Future<void> addFinancialLog(FinancialLog log) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _financialLogs.add(log);
  }

  Future<void> updateFinancialLog(FinancialLog log) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _financialLogs.indexWhere((l) => l.id == log.id);
    if (index != -1) {
      _financialLogs[index] = log;
    }
  }

  Future<void> deleteFinancialLog(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _financialLogs.removeWhere((log) => log.id == id);
  }

  Future<void> addInvoice(Invoice invoice) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _invoices.add(invoice);
  }

  Future<void> updateInvoice(Invoice invoice) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _invoices.indexWhere((i) => i.id == invoice.id);
    if (index != -1) {
      _invoices[index] = invoice;
    }
  }

  Future<void> deleteInvoice(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _invoices.removeWhere((invoice) => invoice.id == id);
  }
}
