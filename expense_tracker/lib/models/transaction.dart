class Transaction {
  final String title;
  final int amount;
  final DateTime date;
  String category;

  Transaction({this.title, this.amount, this.date, this.category}) {
    this.category = category ?? 'Miscellaneous';
  }
}

List<String> categories = [
  'Miscellaneous',
  'Food and Beverages',
  'Shopping',
  'Stationary',
  'Debts and Loans',
  'UPI / Online'
];
