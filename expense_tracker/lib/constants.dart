import 'package:flutter/material.dart';

// UI Colors
const Color kBgColor = Color(0xFF171941);
const Color kPrimaryColor = Colors.blue;

// Border Colors
const Color kPrimaryBorderColor = Color.fromRGBO(52, 123, 189, 0.70);
const Color kSecondaryBorderColor = Color.fromRGBO(255, 92, 151, 0.63);

// Text Colors
const Color kTextColor = Colors.white;
const Color kTextSecColor = Color(0xFFFF8C8C);

// Text styles
const TextStyle kHeading1Style = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800);
const TextStyle kTextStyle = TextStyle(color: kTextColor, fontSize: 14, fontWeight: FontWeight.w600);
const TextStyle kSecTextSyle = TextStyle(color: kTextSecColor, fontSize: 11, fontWeight: FontWeight.w600);

// Box Decorations
BoxDecoration kBoxDecoration = BoxDecoration(
  border: Border.all(color: kPrimaryBorderColor, width: 2),
  borderRadius: BorderRadius.circular(8),
);

BoxDecoration kCircleBoxDecoration = BoxDecoration(
  shape: BoxShape.circle,
  border: Border.all(color: kSecondaryBorderColor, width: 2),
);
