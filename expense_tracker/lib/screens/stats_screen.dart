import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/screens/widgets/summary_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/constants.dart';

class StatsScreen extends StatelessWidget {
  StatsScreen({this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('This Week', style: kHeading1Style),
        SummaryChart(
          transactions: transactions,
        ),
      ],
    );
  }
}
