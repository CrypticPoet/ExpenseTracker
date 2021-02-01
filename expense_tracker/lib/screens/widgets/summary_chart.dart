import 'package:flutter/material.dart';
import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/models/transaction.dart';

class SummaryChart extends StatelessWidget {
  SummaryChart({Key key, this.transactions}) : super(key: key);
  final List<Transaction> transactions;
  static var sum = 0;

  static const weekdayList = {1: 'M', 2: 'T', 3: 'W', 4: 'TH', 5: 'F', 6: 'S', 7: 'SU'};

  List<Transaction> get recentTransactions {
    return transactions.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

  int sumTransactions(List<Transaction> transactions) {
    sum = 0;
    transactions.forEach((element) {
      sum += element.amount;
    });

    return sum;
  }

  Widget expensePill(int transactionSum, double width) {
    if (transactions.length == 0) {
      return Container();
    }

    var frac = (transactionSum / 2000);
    var color;
    if (frac < 0.25)
      color = Colors.green;
    else if (frac < 0.5)
      color = Colors.blue;
    else if (frac < 0.75)
      color = Color.fromRGBO(255, 100, 100, .75);
    else
      color = Colors.red;
    return ClipRRect(
      clipper: PillClipper(frac),
      child: Container(
        width: width - 4,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
        padding: EdgeInsets.only(top: 5),
        margin: EdgeInsets.symmetric(vertical: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var pillWidth = MediaQuery.of(context).size.width / 7 * 0.4;
    return Container(
      height: 220,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: kBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 1; i < 8; i++)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 17,
                    child: FittedBox(
                      child: Text(
                        '₹${sumTransactions(recentTransactions.where((tx) => tx.date.weekday == i).toList())}',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: double.maxFinite,
                          width: pillWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kPrimaryBorderColor.withOpacity(.3), width: 2)),
                        ),
                        expensePill(sum, pillWidth)
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    weekdayList[i],
                    style: kSecTextSyle.copyWith(color: Colors.white, letterSpacing: 1.5),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class PillClipper extends CustomClipper<RRect> {
  final frac;
  PillClipper(this.frac);

  double get getFrac {
    return frac;
  }

  @override
  RRect getClip(Size size) {
    return RRect.fromLTRBAndCorners(
      0,
      size.height - size.height * frac,
      size.width,
      size.height,
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(100),
    );
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => true;
}
