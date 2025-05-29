import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomStrings.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset("assets/wallet-money-business.svg"),
          SizedBox(
            height: 140,
          ),
          CircularProgressIndicator(
            color: CustomColors.color3,
          ),
          SizedBox(height: 140),
          Text(
            CustomStrings.appName,
            style: TextStyle(fontSize: 20, color: CustomColors.color3),
          ),
          SizedBox(
            height: 56,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
