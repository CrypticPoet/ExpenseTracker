import 'package:expense_tracker/models/transaction.dart';

List<Transaction> recentTransactions(List<Transaction> transactions) {
  return transactions.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
}

int sumTransactions(List<Transaction> transactions) {
  int sum = 0;
  transactions.forEach((tx) => sum += tx.amount);

  return sum;
}

List<Transaction> monthlyTransactions(List<Transaction> transactions) {
  DateTime now = DateTime.now();
  return transactions.where((tx) => tx.date.month == now.month && tx.date.year == now.year).toList();
}

List<Transaction> yearlyTransactions(List<Transaction> transactions) {
  return transactions.where((tx) => tx.date.year == DateTime.now().year).toList();
}

List<Transaction> weeklyTransactions(List<Transaction> transactions) {
  return transactions.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
}
