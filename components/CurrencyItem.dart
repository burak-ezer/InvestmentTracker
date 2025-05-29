import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';

class CurrencyItem extends StatelessWidget {
  final String Kod;
  final String Aciklama;
  final double Alis;
  final double Satis;
  final SvgPicture? currencyIcon;

  const CurrencyItem(
      {super.key,
      required this.Kod,
      required this.Aciklama,
      required this.Alis,
      required this.Satis,
      this.currencyIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: CustomColors.color3,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
          ),
          currencyIcon ??
              SizedBox(
                width: 12,
              ),
          SizedBox(
            width: 32,
          ),
          Column(
            children: [
              SizedBox(height: 12),
              Text(
                "$Kod ($Aciklama)",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.color1),
              ),
              Row(
                children: [
                  Text("${CustomStrings.buy} : ",
                      style:
                          TextStyle(fontSize: 16, color: CustomColors.color4)),
                  Text(
                    "${Alis.toStringAsFixed(2)} ${CustomStrings.tlSymbol}",
                    style: TextStyle(fontSize: 16, color: CustomColors.color1),
                  ),
                  SizedBox(width: 12),
                  Text("${CustomStrings.sell} : ",
                      style:
                          TextStyle(fontSize: 16, color: CustomColors.color4)),
                  Text(
                    "${Satis.toStringAsFixed(2)} ${CustomStrings.tlSymbol}",
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
