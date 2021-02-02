import 'package:flutter/material.dart';
import 'package:learning_flutter/constants.dart';
import 'package:learning_flutter/models/transaction.dart';
import 'package:learning_flutter/screens/widgets/add_transaction_modal.dart';
import 'package:learning_flutter/screens/widgets/summary_chart.dart';
import 'package:learning_flutter/screens/widgets/transaction_list.dart';
import 'package:sms/sms.dart';

class Screen extends StatefulWidget {
  static const Color bg = kBgColor;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  var selectedIndex = 0;
  final List<Transaction> transactions = [
    Transaction(title: 'Mobile Recharge', amount: 1000, date: DateTime.now()),
    Transaction(title: 'Samosas', amount: 10, date: DateTime.now()),
    Transaction(title: 'Patties', amount: 20, date: DateTime.now()),
    Transaction(title: 'Practical Copy', amount: 50, date: DateTime.now()),
    Transaction(
        title: 'ParleG',
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        title: 'ParleG',
        amount: 500,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        title: 'ParleG',
        amount: 500,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        title: 'ParleG',
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        title: 'ParleG',
        amount: 500,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        title: 'ParleG',
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        title: 'ParleG',
        amount: 400,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        title: 'ParleG',
        amount: 1020,
        date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(
        title: 'ParleG',
        amount: 100,
        date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(
        title: 'ParleG',
        amount: 5,
        date: DateTime.now().subtract(Duration(days: 3))),
  ];

  final title = TextEditingController();
  final amount = TextEditingController();
  SmsQuery query = new SmsQuery();
  List messages = new List();
  DateTime lastSync = DateTime.now().subtract(Duration(days: 600000));
  fetchSMS() async {
    messages = await query.getAllSms;
    for (var i = 0; i < messages.length; i++) {
      if ((messages[i].body).toString().toLowerCase().contains("debit") &&
          messages[i].date.isAfter(lastSync)) {
        if ((messages[i].body).toString().toLowerCase().contains("for") ||
            (messages[i].body).toString().toLowerCase().contains("by")) {
          RegExp reg1 = new RegExp(r'(\b\d+)');
          String str1 = messages[i].body;
          Match firstMatch = reg1.firstMatch(str1);
          print(
              'First match: ${str1.substring(firstMatch.start, firstMatch.end)}');
          //print(messages[i].body);
          print(messages[i].address);
        }
      }
    }
    lastSync = DateTime.now();
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  void _addTransaction(String title, String amount, BuildContext ctx) {
    if (title == '' || amount == '') return;
    var tx = Transaction(
        amount: int.parse(amount), title: title, date: DateTime.now());
    this.title.clear();
    this.amount.clear();
    setState(() {
      transactions.insert(0, tx);
    });
    Navigator.of(ctx).pop();
  }

  void _showTransactionModal(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (bCtx) => AddTransactionModal(
        title: title,
        amount: amount,
        addHandler: _addTransaction,
        bCtx: bCtx,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Screen.bg,
      //   title: Text('Personal Expense Tracker', style: GoogleFonts.poppins(fontSize: 18)),
      // ),
      backgroundColor: Screen.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Summary', style: kHeading1Style),
                SummaryChart(
                  transactions: transactions,
                ),
                Text('Details', style: kHeading1Style),
                SizedBox(height: 20),
                TransactionList(transactions, _deleteTransaction),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                fetchSMS();
              },
              child: Icon(Icons.navigate_before),
            ),
            FloatingActionButton(
              onPressed: () => _showTransactionModal(context),
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Settings')),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text('History')),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Screen.bg,
        unselectedItemColor: Colors.white70,
        elevation: 20,
      ),
    );
  }
}
