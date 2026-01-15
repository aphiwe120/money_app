class Transaction {
  final int? id;
  final double amount;
  final bool isExpense;
  final String category;
  final DateTime date;
  final String note;

  Transaction({
    this.id,
    required this.amount,
    required this.isExpense,
    required this.category,
    required this.date,
    required this.note,
  });

  // Convert Transaction to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'isExpense': isExpense ? 1 : 0,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  // Create Transaction from Map
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int?,
      amount: map['amount'] as double,
      isExpense: map['isExpense'] == 1,
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
      note: map['note'] as String,
    );
  }

  // CopyWith method for easy updates
  Transaction copyWith({
    int? id,
    double? amount,
    bool? isExpense,
    String? category,
    DateTime? date,
    String? note,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      isExpense: isExpense ?? this.isExpense,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }
}
