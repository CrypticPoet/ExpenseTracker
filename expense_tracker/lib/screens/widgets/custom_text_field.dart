import 'package:flutter/material.dart';
import 'package:expense_tracker/constants.dart';

class CustomTextField extends StatelessWidget {
  final String fieldTitle;
  final TextEditingController controller;
  final TextInputType inputType;
  final IconData icon;
  static const textStyle = kTextStyle;

  const CustomTextField({
    Key key,
    this.controller,
    @required this.fieldTitle,
    this.inputType,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        cursorColor: Colors.white,
        style: textStyle,
        controller: controller,
        keyboardType: inputType,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: kPrimaryBorderColor,
              width: 2,
            ),
          ),
          labelText: fieldTitle,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelStyle: textStyle.copyWith(fontWeight: FontWeight.w800),
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}
