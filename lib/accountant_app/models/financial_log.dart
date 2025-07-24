class FinancialLog {
  final String id;
  final String description;
  final double amount;
  final String type; // 'income' or 'expense'
  final DateTime date;
  final String category;
  final String? reference;

  FinancialLog({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
    this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'type': type,
      'date': date.toIso8601String(),
      'category': category,
      'reference': reference,
    };
  }

  factory FinancialLog.fromJson(Map<String, dynamic> json) {
    return FinancialLog(
      id: json['id'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      type: json['type'],
      date: DateTime.parse(json['date']),
      category: json['category'],
      reference: json['reference'],
    );
  }

  FinancialLog copyWith({
    String? id,
    String? description,
    double? amount,
    String? type,
    DateTime? date,
    String? category,
    String? reference,
  }) {
    return FinancialLog(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      category: category ?? this.category,
      reference: reference ?? this.reference,
    );
  }
}
