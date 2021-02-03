import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/transaction.dart';
import './transaction_detail.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;

  TransactionList(this.transactions, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < transactions.length; i++)
          TransactionDetail(
            title: transactions[i].title,
            amount: transactions[i].amount,
            date: DateFormat.yMMMEd().format(transactions[i].date),
            index: i,
            category: transactions[i].category,
            handler: deleteHandler,
          ),
      ],
    );
  }
}
