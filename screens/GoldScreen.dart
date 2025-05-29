import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/CurrencyItem.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';
import '../models/Currency.dart';
import '../services/AltinkaynakSoapApi.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<StatefulWidget> createState() => GoldScreenState();
}

class GoldScreenState extends State {
  var goldList = <Currency>[];

  @override
  void initState() {
    super.initState();
    goldListCheck();
  }

  @override
  Widget build(BuildContext context) {
    return goldList.isEmpty
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
                      "${CustomStrings.updateDate} : ${goldList[0].GuncellenmeZamani}",
                      style: TextStyle(color: CustomColors.color4),
                    ),
                  ),
                  Expanded(
                      child: RefreshIndicator(
                          onRefresh: goldListCheck,
                          child: ListView.builder(
                              itemCount: goldList.length,
                              itemBuilder: (context, index) {
                                return CurrencyItem(
                                    Kod: goldList[index].Kod,
                                    Aciklama: goldList[index].Aciklama,
                                    Alis: goldList[index].Alis,
                                    Satis: goldList[index].Satis);
                              })))
                ],
              ),
            ),
          );
  }

  Future<void> goldListCheck() async {
    await AltinkaynakSoapApi(22, "GetGold").then((onValue) {
      setState(() {
        goldList = onValue;
      });
    });
  }
}
