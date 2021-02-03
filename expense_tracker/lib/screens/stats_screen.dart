import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/screens/widgets/summary_chart.dart';
import 'package:expense_tracker/screens/widgets/summary_tiles.dart';
import 'package:expense_tracker/utils/cat2icon.dart';
import 'package:expense_tracker/utils/utilFunctions.dart';
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
        Text('Summary', style: kHeading1Style),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            SummaryGridTile(
              title: 'Total Spent',
              amount: sumTransactions(transactions).toString(),
            ),
            SizedBox(width: 20),
            SummaryGridTile(
                title: 'Spent this Year', amount: sumTransactions(yearlyTransactions(transactions)).toString())
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            SummaryGridTile(
                title: 'Spent this Month', amount: sumTransactions(monthlyTransactions(transactions)).toString()),
            SizedBox(width: 20),
            SummaryGridTile(
                title: 'Spent this Week', amount: sumTransactions(weeklyTransactions(transactions)).toString())
          ],
        ),
        SizedBox(height: 20),
        Text('Breakdown by Category', style: kHeading1Style),
        SizedBox(height: 10),
        ...categories
            .map<Widget>((cat) => SummaryTile(
                title: cat,
                amount: sumTransactions(transactions.where((tx) => tx.category == cat).toList()).toString(),
                icon: cat2icon[cat]))
            .toList()
      ],
    );
  }
}
