class InvoiceItem {
  final String description;
  final int quantity;
  final double unitPrice;
  final double totalAmount;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'].toDouble(),
      totalAmount: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': totalAmount,
    };
  }
}

class Invoice {
  final String id;
  final String clientName;
  final String clientEmail;
  final String? clientAddress;
  final List<InvoiceItem> items;
  final double subtotalAmount;
  final double taxRate;
  final double taxAmount;
  final double totalAmount;
  final DateTime issueDate;
  final DateTime dueDate;
  String status; // Changed from final to mutable
  final String? notes;

  Invoice({
    required this.id,
    required this.clientName,
    required this.clientEmail,
    this.clientAddress,
    required this.items,
    required this.subtotalAmount,
    required this.taxRate,
    required this.taxAmount,
    required this.totalAmount,
    required this.issueDate,
    required this.dueDate,
    required this.status,
    this.notes,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      clientName: json['clientName'],
      clientEmail: json['clientEmail'],
      clientAddress: json['clientAddress'],
      items: (json['items'] as List)
          .map((item) => InvoiceItem.fromJson(item))
          .toList(),
      subtotalAmount: json['subtotalAmount'].toDouble(),
      taxRate: json['taxRate'].toDouble(),
      taxAmount: json['taxAmount'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
      issueDate: DateTime.parse(json['issueDate']),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientAddress': clientAddress,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotalAmount': subtotalAmount,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'issueDate': issueDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'status': status,
      'notes': notes,
    };
  }
}
