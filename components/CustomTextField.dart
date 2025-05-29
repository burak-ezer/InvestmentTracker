import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants/CustomColors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Icon? prefixIcon;
  final bool? obscureText;
  final int? maxLenght;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    required this.textInputType,
    this.prefixIcon,
    this.obscureText,
    this.maxLenght,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: TextStyle(color: CustomColors.color4),
        controller: textEditingController,
        keyboardType: textInputType,
        maxLength: maxLenght,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon,
            prefixIconColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.focused)
                    ? CustomColors.color4
                    : CustomColors.color2),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: TextStyle(color: CustomColors.color3),
            counterText: "",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.color3)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.color4))));
  }
}
