class Invoice {
  final String id;
  final String customerId;
  final String customerName;
  final DateTime date;
  final List<InvoiceItem> items;
  final double subtotal;
  final double tax;
  final double total;
  final String status;
  final String? notes;

  Invoice({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.date,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.status,
    this.notes,
  });

  // Getters
  String get getId => id;
  String get getCustomerId => customerId;
  String get getCustomerName => customerName;
  DateTime get getDate => date;
  List<InvoiceItem> get getItems => items;
  double get getSubtotal => subtotal;
  double get getTax => tax;
  double get getTotal => total;
  String get getStatus => status;
  String? get getNotes => notes;

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'date': date.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'tax': tax,
      'total': total,
      'status': status,
      'notes': notes,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      date: DateTime.parse(json['date']),
      items: (json['items'] as List)
          .map((item) => InvoiceItem.fromJson(item))
          .toList(),
      subtotal: json['subtotal'].toDouble(),
      tax: json['tax'].toDouble(),
      total: json['total'].toDouble(),
      status: json['status'],
      notes: json['notes'],
    );
  }

  // Copy with method
  Invoice copyWith({
    String? id,
    String? customerId,
    String? customerName,
    DateTime? date,
    List<InvoiceItem>? items,
    double? subtotal,
    double? tax,
    double? total,
    String? status,
    String? notes,
  }) {
    return Invoice(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      date: date ?? this.date,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}

class InvoiceItem {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double total;

  InvoiceItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  // Getters
  String get getProductId => productId;
  String get getProductName => productName;
  int get getQuantity => quantity;
  double get getUnitPrice => unitPrice;
  double get getTotal => total;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
    };
  }

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'].toDouble(),
      total: json['total'].toDouble(),
    );
  }
}
