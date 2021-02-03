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
  DateTime lastSync = DateTime.now().subtract(Duration(days: 365));

  _fetchSMS() async {
    messages = await query.getAllSms;
    for (var i = 0; i < messages.length; i++) {
      if ((messages[i].body).toString().toLowerCase().contains("debit") &&
          messages[i].date.isAfter(lastSync) &&
          !(messages[i].body).toString().toLowerCase().contains("otp") &&
          !(messages[i].body).toString().toLowerCase().contains("password")) {
        if ((messages[i].body).toString().toLowerCase().contains("for") ||
            (messages[i].body).toString().toLowerCase().contains("by")) {
          RegExp reg1 = new RegExp(r'(rs+\d+)');
          RegExp reg2 = new RegExp(r'(rs\.+\d+)');
          RegExp reg3 = new RegExp(r'(rs\s+\d+)');
          RegExp reg4 = new RegExp(r'(\d+\sinr)');
          RegExp reg5 = new RegExp(r'(inr\s+\d+)');
          String str1 = messages[i].body.toLowerCase().replaceAll(',', '');
          String tit = "";
          // ignore: unused_local_variable
          var amou = 0;
          DateTime dt = DateTime.now();
          if (reg1.hasMatch(str1)) {
            Match firstMatch = reg1.firstMatch(str1);
            amou = int.parse(str1.substring(firstMatch.start + 2, firstMatch.end));
            tit = messages[i].address;
            dt = messages[i].date;
          } else if (reg2.hasMatch(str1)) {
            Match firstMatch = reg2.firstMatch(str1);
            amou = int.parse(str1.substring(firstMatch.start + 3, firstMatch.end));
            tit = messages[i].address;
            dt = messages[i].date;
          } else if (reg3.hasMatch(str1)) {
            Match firstMatch = reg3.firstMatch(str1);
            amou = int.parse(str1.substring(firstMatch.start + 3, firstMatch.end));
            tit = messages[i].address;
            dt = messages[i].date;
          } else if (reg4.hasMatch(str1)) {
            Match firstMatch = reg4.firstMatch(str1);
            amou = int.parse(str1.substring(firstMatch.start, firstMatch.end - 4));
            tit = messages[i].address;
            dt = messages[i].date;
          } else if (reg5.hasMatch(str1)) {
            Match firstMatch = reg5.firstMatch(str1);
            amou = int.parse(str1.substring(firstMatch.start + 4, firstMatch.end));
            tit = messages[i].address;
            dt = messages[i].date;
          }
          if (tit != '') {
            var tx = Transaction(amount: amou, category: 'UPI / Online', date: dt, title: tit);
            setState(() {
              transactions.insert(0, tx);
            });
          }
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

  void _addTransaction(String title, String amount, BuildContext ctx, String cat) {
    if (title == '' || amount == '') return;
    var tx = Transaction(amount: int.parse(amount), title: title, date: DateTime.now(), category: cat);
    print(tx.category);
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Builder(
              builder: (BuildContext ctx) {
                switch (selectedIndex) {
                  case 0:
                    return HomeScreen(transactions, deleteHandler: _deleteTransaction, syncHandler: _fetchSMS);
                    break;
                  case 1:
                    return StatsScreen(transactions: transactions);
                    break;
                  default:
                    return HomeScreen(transactions, deleteHandler: _deleteTransaction, syncHandler: _fetchSMS);
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5),
        child: FloatingActionButton(
          onPressed: () => _showTransactionModal(context),
          child: Icon(Icons.add),
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
