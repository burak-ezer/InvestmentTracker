import 'package:flutter/widgets.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';

class InvestmentItem extends StatelessWidget {
  final String currencyType;
  final double amount;
  final double totalInvestmentTl;
  final double valueCurrency;
  final String buyDate;
  final double updateValueTl;

  const InvestmentItem(this.currencyType, this.amount, this.totalInvestmentTl,
      this.valueCurrency, this.buyDate, this.updateValueTl,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: CustomColors.color3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 4),
              Text(
                "$amount $currencyType",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.color1),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text("${CustomStrings.tlValue} : ",
                      style:
                          TextStyle(fontSize: 16, color: CustomColors.color4)),
                  Text(
                    "${valueCurrency.toStringAsFixed(2)} ${CustomStrings.tlSymbol}",
                    style: TextStyle(fontSize: 16, color: CustomColors.color1),
                  ),
                  SizedBox(width: 12),
                  Text("${CustomStrings.updateTlValue} : ",
                      style:
                          TextStyle(fontSize: 16, color: CustomColors.color4)),
                  Text(
                    "${updateValueTl.toStringAsFixed(2)} ${CustomStrings.tlSymbol}",
                    style: TextStyle(fontSize: 16, color: CustomColors.color1),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text("${CustomStrings.totalTlValue} : ",
                      style:
                          TextStyle(fontSize: 16, color: CustomColors.color4)),
                  Text(
                    "${totalInvestmentTl.toStringAsFixed(2)} ${CustomStrings.tlSymbol}",
                    style: TextStyle(fontSize: 16, color: CustomColors.color1),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text("${CustomStrings.date} : ",
                      style:
                          TextStyle(fontSize: 16, color: CustomColors.color4)),
                  Text(
                    buyDate,
                    style: TextStyle(fontSize: 16, color: CustomColors.color1),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
