import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/widgets/summary_chart.dart';
import 'package:expense_tracker/screens/widgets/transaction_list.dart';
import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/models/transaction.dart';

class HomeScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;

  HomeScreen(this.transactions, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Summary', style: kHeading1Style),
        SummaryChart(transactions: transactions),
        Text('Details', style: kHeading1Style),
        SizedBox(height: 20),
        TransactionList(transactions, deleteHandler),
      ],
    );
  }
}
