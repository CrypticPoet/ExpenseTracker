import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_text_field.dart';

class AddTransactionModal extends StatelessWidget {
  const AddTransactionModal({
    Key key,
    @required this.title,
    @required this.amount,
    @required this.addHandler,
    @required this.bCtx,
  }) : super(key: key);

  final TextEditingController title;
  final TextEditingController amount;
  final Function addHandler;
  final BuildContext bCtx;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kBgColor,
      // insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 130),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: kBoxDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomTextField(
              controller: title,
              fieldTitle: 'Title',
              inputType: TextInputType.text,
              icon: Icons.assignment,
            ),
            CustomTextField(
              controller: amount,
              fieldTitle: 'Amount',
              inputType: TextInputType.number,
              icon: Icons.attach_money,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () => addHandler(title.text, amount.text, bCtx),
                  color: kPrimaryColor,
                  textColor: Colors.black,
                ),
                RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(bCtx).pop(),
                  color: Colors.red[400],
                  textColor: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
