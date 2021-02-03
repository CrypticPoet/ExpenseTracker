import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/widgets/summary_chart.dart';
import 'package:expense_tracker/screens/widgets/transaction_list.dart';
import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/models/transaction.dart';

class HomeScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;
  final Function syncHandler;

  HomeScreen(this.transactions, {this.deleteHandler, this.syncHandler});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Actions', style: kHeading1Style),
        SizedBox(height: 20),
        RaisedButton.icon(
          onPressed: () => syncHandler(),
          icon: Icon(Icons.sync),
          label: Text('Sync Transactions'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        SizedBox(height: 20),
        Text('Recent Transactions', style: kHeading1Style),
        SizedBox(height: 20),
        TransactionList(
            transactions.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList(),
            deleteHandler),
      ],
    );
  }
}
