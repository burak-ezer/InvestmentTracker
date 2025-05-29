import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'CustomColors.dart';
import 'CustomStrings.dart';

class CustomFunctions {
  String altinkaynakRequestXml(String requestType) {
    return """<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Header>
    <AuthHeader xmlns="http://data.altinkaynak.com/">
      <Username>AltinkaynakWebServis</Username>
      <Password>AltinkaynakWebServis</Password>
    </AuthHeader>
  </soap12:Header>
  <soap12:Body>
    <$requestType xmlns="http://data.altinkaynak.com/" />
  </soap12:Body>
</soap12:Envelope>""";
  }

  static customShowDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: CustomColors.color1,
              titleTextStyle: TextStyle(color: CustomColors.color3),
              contentTextStyle: TextStyle(color: CustomColors.color3),
              title: Text(title),
              content: Text(content),
            ));
  }

  static bool emptyControl(
      List<TextEditingController> list, BuildContext context) {
    for (TextEditingController i in list) {
      if (i.text.isEmpty) {
        CustomFunctions.customShowDialog(
            context, CustomStrings.warning, CustomStrings.emptyFieldWarning);
        return false;
      }
    }
    return true;
  }

  static bool passwordControl(
      String password, String repeatPassword, BuildContext context) {
    if (password == repeatPassword) {
      return true;
    } else {
      CustomFunctions.customShowDialog(
          context, CustomStrings.warning, CustomStrings.passwordEqualError);
      return false;
    }
  }
}
