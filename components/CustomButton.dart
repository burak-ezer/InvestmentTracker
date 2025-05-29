import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants/CustomColors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String string;

  const CustomButton(
      {super.key, required this.voidCallback, required this.string});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: voidCallback,
      style: TextButton.styleFrom(
          backgroundColor: CustomColors.color3,
          foregroundColor: CustomColors.color4,
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0)),
      child: Text(string),
    );
  }
}
