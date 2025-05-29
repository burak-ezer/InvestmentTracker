import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/CustomTextField.dart';
import '../components/InvestmentItem.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';
import '../models/Currency.dart';
import '../models/Investment.dart';
import '../services/AltinkaynakSoapApi.dart';
import '../services/RestApi.dart';

class MyInvestmentsScreen extends StatefulWidget {
  const MyInvestmentsScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyInvestmentsScreenState();
}

class MyInvestmentsScreenState extends State {
  final TextEditingController amountController = TextEditingController();
  var investmentList = <Investment>[];
  var currencyList = <Currency>[];
  double updateValueTl = 0;
  double totalInvestmentTlValue = 0;
  String? userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    investmentListCheck();
    currencyListCheck();
    goldListCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: CustomColors.color1,
      body: Container(
        child: investmentList.isEmpty
            ? Center(
                child: Text(
                  CustomStrings.emptyInvestmentList,
                  style: TextStyle(color: CustomColors.color3),
                ),
              )
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "${CustomStrings.totalInvestmentTlValue} : ${totalInvestmentTlValue.toStringAsFixed(2)} ${CustomStrings.tlSymbol}",
                      style: TextStyle(color: CustomColors.color4),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: investmentListCheck,
                        child: ListView.builder(
                            itemCount: investmentList.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  child: Icon(
                                    Icons.delete,
                                    size: 60,
                                    color: CustomColors.color1,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: Colors.red,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(
                                    () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setstate) {
                                              return AlertDialog(
                                                title:
                                                    Text(CustomStrings.warning),
                                                backgroundColor:
                                                    CustomColors.color1,
                                                titleTextStyle: TextStyle(
                                                    color: CustomColors.color3),
                                                contentTextStyle: TextStyle(
                                                    color: CustomColors.color3),
                                                content: Text(CustomStrings
                                                    .askDeleteInvestment),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () {
                                                        deleteMyInvestment(
                                                            investmentList[
                                                                    index]
                                                                .id!);
                                                        Navigator.pop(context);
                                                        investmentListCheck();
                                                      },
                                                      child: Text(
                                                          CustomStrings.yes,
                                                          style: TextStyle(
                                                              color: CustomColors
                                                                  .color3))),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        CustomStrings.cancel,
                                                        style: TextStyle(
                                                            color: CustomColors
                                                                .color3),
                                                      ))
                                                ],
                                              );
                                            });
                                          });
                                    },
                                  );
                                },
                                child: InvestmentItem(
                                    investmentList[index].currencyType,
                                    investmentList[index].amount,
                                    investmentList[index].totalInvestmentTl,
                                    investmentList[index].valueCurrency,
                                    investmentList[index].buyDate!,
                                    updateCurrencyValue(investmentList[index]
                                                .currencyType) !=
                                            null
                                        ? updateValueTl
                                        : 0),
                              );
                            })),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var selectedCurrency = currencyList.first.Aciklama;
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setstate) {
                  return AlertDialog(
                    title: Text(CustomStrings.addInvestment),
                    backgroundColor: CustomColors.color1,
                    titleTextStyle: TextStyle(color: CustomColors.color3),
                    contentTextStyle: TextStyle(color: CustomColors.color1),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                            labelText: CustomStrings.amount,
                            textInputType: TextInputType.number,
                            maxLenght: 10,
                            textEditingController: amountController),
                        DropdownButton<String>(
                            underline: SizedBox(),
                            value: selectedCurrency,
                            menuMaxHeight: 240,
                            style: TextStyle(color: CustomColors.color3),
                            items: currencyList.map((Currency item) {
                              return DropdownMenuItem<String>(
                                value: item.Aciklama,
                                child: Text(item.Aciklama),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setstate(() {
                                selectedCurrency = value!;
                              });
                            })
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            if (double.parse(amountController.text).ceil() >
                                0) {
                              createInvestment(Investment(
                                  currencyType: selectedCurrency,
                                  amount: double.parse(amountController.text),
                                  totalInvestmentTl:
                                      double.parse(amountController.text) *
                                          updateCurrencyValue(selectedCurrency),
                                  valueCurrency:
                                      updateCurrencyValue(selectedCurrency)));
                              Navigator.pop(context);
                            }
                          },
                          child: Text(CustomStrings.add,
                              style: TextStyle(color: CustomColors.color3))),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            CustomStrings.cancel,
                            style: TextStyle(color: CustomColors.color3),
                          ))
                    ],
                  );
                });
              });
        },
        backgroundColor: CustomColors.color3,
        foregroundColor: CustomColors.color1,
        child: Icon(Icons.add),
      ),
    ));
  }

  Future<void> createInvestment(Investment investment) async {
    await addInvestment(
        Investment(
            currencyType: investment.currencyType,
            amount: investment.amount,
            totalInvestmentTl: investment.totalInvestmentTl,
            valueCurrency: investment.valueCurrency),
        userID!);
    investmentListCheck();
  }

  Future<void> deleteMyInvestment(int id) async {
    await deleteInvestment(userID!, id);
    investmentListCheck();
  }

  Future<void> investmentListCheck() async {
    await getMyInvestments(userID!).then((onValue) {
      setState(() {
        investmentList = onValue;
      });
      totalInvestmentTlValue = 0;
      for (Investment investment in onValue) {
        totalInvestmentTlValue += investment.totalInvestmentTl;
      }
    });
  }

  Future<void> currencyListCheck() async {
    await AltinkaynakSoapApi(15, "GetCurrency").then((onValue) {
      setState(() {
        currencyList.addAll(onValue);
      });
    });
  }

  Future<void> goldListCheck() async {
    await AltinkaynakSoapApi(22, "GetGold").then((onValue) {
      setState(() {
        currencyList.addAll(onValue);
      });
    });
  }

  updateCurrencyValue(String selectedCurrency) {
    for (Currency currency in currencyList) {
      if (currency.Aciklama == selectedCurrency) {
        return updateValueTl = currency.Alis;
      }
    }
  }
}
