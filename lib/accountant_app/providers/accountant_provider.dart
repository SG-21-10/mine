import 'package:flutter/material.dart';
import '../models/financial_log.dart';
import '../models/invoice.dart';
import '../services/accountant_service.dart';

class AccountantProvider with ChangeNotifier {
  final AccountantService _service = AccountantService();

  List<FinancialLog> _financialLogs = [];
  List<Invoice> _invoices = [];
  bool _isLoading = false;
  String? _error;

  List<FinancialLog> get financialLogs => _financialLogs;
  List<Invoice> get invoices => _invoices;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFinancialLogs() async {
    _setLoading(true);
    try {
      _financialLogs = await _service.getFinancialLogs();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadInvoices() async {
    _setLoading(true);
    try {
      _invoices = await _service.getInvoices();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addFinancialLog(FinancialLog log) async {
    try {
      await _service.addFinancialLog(log);
      _financialLogs.add(log);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateFinancialLog(FinancialLog log) async {
    try {
      await _service.updateFinancialLog(log);
      final index = _financialLogs.indexWhere((l) => l.id == log.id);
      if (index != -1) {
        _financialLogs[index] = log;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteFinancialLog(String id) async {
    try {
      await _service.deleteFinancialLog(id);
      _financialLogs.removeWhere((log) => log.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addInvoice(Invoice invoice) async {
    try {
      await _service.addInvoice(invoice);
      _invoices.add(invoice);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateInvoice(Invoice invoice) async {
    try {
      await _service.updateInvoice(invoice);
      final index = _invoices.indexWhere((i) => i.id == invoice.id);
      if (index != -1) {
        _invoices[index] = invoice;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteInvoice(String id) async {
    try {
      await _service.deleteInvoice(id);
      _invoices.removeWhere((invoice) => invoice.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> sendInvoice(String invoiceId, String email) async {
    try {
      // Find the invoice
      final invoice = _invoices.firstWhere((inv) => inv.id == invoiceId);
      
      // Update the invoice status to 'sent'
      invoice.status = 'sent';
      
      // Notify listeners about the change
      notifyListeners();
      
      // In a real app, you would send the email here
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyPayment(String invoiceId) async {
    try {
      // Find the invoice
      final index = _invoices.indexWhere((inv) => inv.id == invoiceId);
      if (index != -1) {
        // Update the invoice status to 'paid'
        _invoices[index].status = 'paid';
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
