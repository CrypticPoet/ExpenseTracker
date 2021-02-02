import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/screens/widgets/add_transaction_modal.dart';
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
    Transaction(title: 'ParleG', amount: 50, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(title: 'ParleG', amount: 500, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(title: 'ParleG', amount: 500, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(title: 'ParleG', amount: 50, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(title: 'ParleG', amount: 500, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(title: 'ParleG', amount: 50, date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(title: 'ParleG', amount: 400, date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(title: 'ParleG', amount: 1020, date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(title: 'ParleG', amount: 100, date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(title: 'ParleG', amount: 5, date: DateTime.now().subtract(Duration(days: 3))),
  ];

  final title = TextEditingController();
  final amount = TextEditingController();

  // SMS fetch settings
  SmsQuery query = new SmsQuery();
  List messages = new List();
  DateTime lastSync = DateTime.now().subtract(Duration(days: 600000));

  _fetchSMS() async {
    messages = await query.getAllSms;
    for (var i = 0; i < messages.length; i++) {
      if ((messages[i].body).toString().toLowerCase().contains("debit") &&
          messages[i].date.isAfter(lastSync) &&
          !(messages[i].body).toString().toLowerCase().contains("otp") &&
          !(messages[i].body).toString().toLowerCase().contains("password")) {
        if ((messages[i].body).toString().toLowerCase().contains("for") ||
            (messages[i].body).toString().toLowerCase().contains("by")) {
          RegExp reg1 = new RegExp(r'(\d+)');
          String str1 = messages[i].body;
          Match firstMatch = reg1.firstMatch(str1);
          print('First match: ${str1.substring(firstMatch.start, firstMatch.end)}');
          print(messages[i].body);
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
    var tx = Transaction(amount: int.parse(amount), title: title, date: DateTime.now());
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
      backgroundColor: Screen.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(
            builder: (BuildContext ctx) {
              switch (selectedIndex) {
                case 0:
                  return HomeScreen(transactions, _deleteTransaction);
                  break;
                case 1:
                  return StatsScreen();
                  break;
                default:
                  return HomeScreen(transactions, _deleteTransaction);
              }
            },
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
                onPressed: () {
                  _fetchSMS();
                },
                child: Icon(Icons.navigate_before)),
            SizedBox(width: 20),
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
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), title: Text('Statistics')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
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
