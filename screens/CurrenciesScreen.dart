import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../components/CurrencyItem.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';
import '../models/Currency.dart';
import '../services/AltinkaynakSoapApi.dart';

class CurrenciesScreen extends StatefulWidget {
  const CurrenciesScreen({super.key});

  @override
  State<StatefulWidget> createState() => CurrenciesScreenState();
}

class CurrenciesScreenState extends State {
  var currencyList = <Currency>[];

  @override
  void initState() {
    super.initState();
    currencyListCheck();
  }

  @override
  Widget build(BuildContext context) {
    return currencyList.isEmpty
        ? Center(
            child: CircularProgressIndicator(
            color: CustomColors.color3,
          ))
        : MaterialApp(
            home: Scaffold(
              backgroundColor: CustomColors.color1,
              body: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "${CustomStrings.updateDate} : ${currencyList[0].GuncellenmeZamani}",
                      style: TextStyle(color: CustomColors.color4),
                    ),
                  ),
                  Expanded(
                      child: RefreshIndicator(
                          onRefresh: currencyListCheck,
                          child: ListView.builder(
                              itemCount: currencyList.length,
                              itemBuilder: (context, index) {
                                return CurrencyItem(
                                    Kod: currencyList[index].Kod,
                                    Aciklama: currencyList[index].Aciklama,
                                    Alis: currencyList[index].Alis,
                                    Satis: currencyList[index].Satis,
                                    currencyIcon: SvgPicture.asset(
                                        "assets/${currencyList[index].Kod}.svg"));
                              })))
                ],
              ),
            ),
          );
  }

  Future<void> currencyListCheck() async {
    await AltinkaynakSoapApi(15, "GetCurrency").then((onValue) {
      setState(() {
        currencyList.addAll(onValue);
      });
    });
  }
}
