import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../services/database_service.dart';

class MoneyProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Transaction> _transactions = [];
  bool _isLoading = false;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  // Get all expenses
  List<Transaction> get expenses =>
      _transactions.where((t) => t.isExpense).toList();

  // Get all income
  List<Transaction> get income =>
      _transactions.where((t) => !t.isExpense).toList();

  // Calculate total balance
  double get totalBalance {
    double total = 0;
    for (var transaction in _transactions) {
      if (transaction.isExpense) {
        total -= transaction.amount;
      } else {
        total += transaction.amount;
      }
    }
    return total;
  }

  // Calculate total expenses
  double get totalExpenses {
    return expenses.fold(0, (sum, transaction) => sum + transaction.amount);
  }

  // Calculate total income
  double get totalIncome {
    return income.fold(0, (sum, transaction) => sum + transaction.amount);
  }

  // Fetch all transactions from database
  Future<void> fetchTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _transactions = await _databaseService.getTransactions();
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new transaction
  Future<void> addTransaction(Transaction transaction) async {
    try {
      final id = await _databaseService.insertTransaction(transaction);
      final newTransaction = transaction.copyWith(id: id);
      _transactions.insert(0, newTransaction);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      rethrow;
    }
  }

  // Update an existing transaction
  Future<void> updateTransaction(Transaction transaction) async {
    try {
      await _databaseService.updateTransaction(transaction);
      final index = _transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        _transactions[index] = transaction;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating transaction: $e');
      rethrow;
    }
  }

  // Delete a transaction
  Future<void> deleteTransaction(int id) async {
    try {
      await _databaseService.deleteTransaction(id);
      _transactions.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
      rethrow;
    }
  }

  // Get transactions filtered by date range
  Future<List<Transaction>> getTransactionsByDateRange(
      DateTime startDate, DateTime endDate) async {
    try {
      return await _databaseService.getTransactionsFiltered(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      debugPrint('Error fetching transactions by date range: $e');
      return [];
    }
  }

  // Get transactions by category
  Future<List<Transaction>> getTransactionsByCategory(String category) async {
    try {
      return await _databaseService.getTransactionsFiltered(
        category: category,
      );
    } catch (e) {
      debugPrint('Error fetching transactions by category: $e');
      return [];
    }
  }

  // Get unique categories
  List<String> get categories {
    final categorySet = <String>{};
    for (var transaction in _transactions) {
      categorySet.add(transaction.category);
    }
    return categorySet.toList()..sort();
  }

  // Get expenses grouped by category with totals
  Map<String, double> getExpensesByCategory() {
    final expenseMap = <String, double>{};
    
    for (var transaction in expenses) {
      if (expenseMap.containsKey(transaction.category)) {
        expenseMap[transaction.category] = 
            expenseMap[transaction.category]! + transaction.amount;
      } else {
        expenseMap[transaction.category] = transaction.amount;
      }
    }
    
    return expenseMap;
  }

  // Delete all transactions
  Future<void> deleteAllTransactions() async {
    try {
      await _databaseService.deleteAllTransactions();
      _transactions.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting all transactions: $e');
      rethrow;
    }
  }
}
