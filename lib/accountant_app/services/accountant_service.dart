import '../models/financial_log.dart';
import '../models/invoice.dart';

class AccountantService {
  // Mock data storage - in a real app, this would be a database
  static final List<FinancialLog> _financialLogs = [];
  static final List<Invoice> _invoices = [];

  // Financial Logs methods
  Future<List<FinancialLog>> getFinancialLogs() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_financialLogs);
  }

  Future<void> addFinancialLog(FinancialLog log) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _financialLogs.add(log);
  }

  Future<void> deleteFinancialLog(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _financialLogs.removeWhere((log) => log.id == id);
  }

  // Invoice methods
  Future<List<Invoice>> getInvoices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_invoices);
  }

  Future<void> addInvoice(Invoice invoice) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _invoices.add(invoice);
  }

  Future<void> sendInvoice(String invoiceId, String email) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Mock sending invoice via email
    print('Sending invoice $invoiceId to $email');
  }

  Future<void> verifyPayment(String invoiceId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock payment verification
    print('Verifying payment for invoice $invoiceId');
  }
}
