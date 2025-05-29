import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';
import '../services/AuthFirebaseService.dart';
import 'CurrenciesScreen.dart';
import 'GoldScreen.dart';
import 'MyInvestmentScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State {
  int selectedScreen = 0;
  List<Widget> screenList = [
    MyInvestmentsScreen(),
    CurrenciesScreen(),
    GoldScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: CustomColors.color1,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  AuthFirebaseService().signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout),
                color: CustomColors.color4,
              )
            ],
            title: Text(CustomStrings.appName),
            centerTitle: true,
            backgroundColor: CustomColors.color3,
            titleTextStyle: TextStyle(color: CustomColors.color4, fontSize: 20),
          ),
          body: screenList[selectedScreen],
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: CustomColors.color1,
            style: TabStyle.textIn,
            activeColor: CustomColors.color3,
            items: [
              TabItem(
                  icon: SvgPicture.asset("assets/wallet-money-business.svg"),
                  title: CustomStrings.myInvestments),
              TabItem(
                  icon: SvgPicture.asset("assets/money-bag.svg"),
                  title: CustomStrings.currencies),
              TabItem(
                  icon: SvgPicture.asset("assets/gold-ingots-gold.svg"),
                  title: CustomStrings.gold)
            ],
            onTap: (int i) {
              setState(() {
                selectedScreen = i;
              });
            },
          ),
        ),
      )),
    );
  }
}
