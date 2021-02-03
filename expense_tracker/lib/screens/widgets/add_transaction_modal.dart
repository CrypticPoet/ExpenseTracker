import 'package:flutter/material.dart';
import '../../constants.dart';
import 'custom_text_field.dart';

class AddTransactionModal extends StatefulWidget {
  AddTransactionModal({
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
  _AddTransactionModalState createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  String _catValue = 'Miscellaneous';
  final List<String> categories = ['Miscellaneous', 'Food and Beverages', 'Shopping', 'Stationary', 'Debts and Loans'];

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextField(
              controller: widget.title,
              fieldTitle: 'Title',
              inputType: TextInputType.text,
              icon: Icons.assignment,
            ),
            CustomTextField(
              controller: widget.amount,
              fieldTitle: 'Amount',
              inputType: TextInputType.number,
              icon: Icons.attach_money,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.category, color: Colors.blue),
                SizedBox(width: 10),
                Text('Select Category', style: kTextStyle),
              ],
            ),
            Container(
              height: 45,
              decoration: kBoxDecoration,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: _catValue,
                selectedItemBuilder: (context) => categories
                    .map<Widget>(
                      (item) => Text(
                        item,
                        style: kTextStyle.copyWith(fontWeight: FontWeight.normal),
                      ),
                    )
                    .toList(),
                items: categories
                    .map((val) => DropdownMenuItem(
                        child: Text(
                          val,
                          style: kTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                        value: val))
                    .toList(),
                onChanged: (val) => setState(() {
                  _catValue = val;
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () => widget.addHandler(widget.title.text, widget.amount.text, widget.bCtx, _catValue),
                  color: kPrimaryColor,
                  textColor: Colors.black,
                ),
                RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(widget.bCtx).pop(),
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
