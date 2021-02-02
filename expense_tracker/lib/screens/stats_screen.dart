import 'package:flutter/material.dart';
import 'package:expense_tracker/constants.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Statistics Screen',
        style: kHeading1Style,
      ),
    );
  }
}
