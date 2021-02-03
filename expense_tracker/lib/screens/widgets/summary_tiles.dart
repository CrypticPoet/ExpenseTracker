import 'package:flutter/material.dart';

import '../../constants.dart';

class SummaryGridTile extends StatelessWidget {
  const SummaryGridTile({Key key, @required this.title, @required this.amount, @required this.color}) : super(key: key);

  final String title;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: kBoxDecoration.copyWith(border: Border.all(color: color, width: 2)),
        child: Column(
          children: <Widget>[
            Text(title, style: kTextStyle),
            Text('₹$amount', style: kSecTextSyle.copyWith(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  const SummaryTile({Key key, @required this.title, @required this.amount, @required this.icon}) : super(key: key);

  final String title;
  final String amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: kBoxDecoration,
      child: ListTile(
        dense: false,
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: kTextStyle),
        subtitle: Text('₹$amount', style: kSecTextSyle.copyWith(fontSize: 18)),
      ),
    );
  }
}
