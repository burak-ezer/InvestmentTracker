import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/CustomButton.dart';
import '../components/CustomTextField.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomFunctions.dart';
import '../constants/CustomStrings.dart';
import '../services/AuthFirebaseService.dart';
import 'MainScreen.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMeValue = false;

  @override
  void initState() {
    super.initState();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: CustomColors.color1,
        appBar: AppBar(
          title: Text(CustomStrings.appName),
          centerTitle: true,
          backgroundColor: CustomColors.color3,
          titleTextStyle: TextStyle(color: CustomColors.color4, fontSize: 20),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  maxLenght: 28,
                  prefixIcon: Icon(Icons.email),
                  labelText: CustomStrings.email,
                  textInputType: TextInputType.emailAddress,
                  textEditingController: emailController),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                maxLenght: 12,
                prefixIcon: Icon(Icons.lock),
                labelText: CustomStrings.password,
                textInputType: TextInputType.numberWithOptions(),
                textEditingController: passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CustomStrings.rememberMe,
                    style: TextStyle(color: CustomColors.color4, fontSize: 16),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Switch(
                      value: rememberMeValue,
                      activeColor: CustomColors.color3,
                      inactiveThumbColor: CustomColors.color3,
                      inactiveTrackColor: CustomColors.color4,
                      onChanged: (bool value) {
                        setState(() {
                          rememberMeValue = value;
                          setLoginInfo();
                        });
                      })
                ],
              ),
              SizedBox(height: 12),
              CustomButton(
                  voidCallback: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                    if (CustomFunctions.emptyControl(
                        [emailController, passwordController], context)) {
                      signIn(context);
                    }
                  },
                  string: CustomStrings.signIn),
              SizedBox(height: 12),
              CustomButton(
                  voidCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  string: CustomStrings.signUp),
            ],
          ),
        ),
      ),
    );
  }

  getLoginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') != null ||
        prefs.getString('password') != null ||
        prefs.getBool('rememberMe') != null) {
      emailController.text = prefs.getString('email')!;
      passwordController.text = prefs.getString('password')!;
      rememberMeValue = prefs.getBool('rememberMe')!;
    }
  }

  setLoginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMeValue) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', rememberMeValue);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      await AuthFirebaseService().signIn(
          email: emailController.text, password: passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomFunctions.customShowDialog(
            context, CustomStrings.error, CustomStrings.notFoundUser);
      } else if (e.code == 'wrong-password') {
        CustomFunctions.customShowDialog(
            context, CustomStrings.error, CustomStrings.passwordError);
      } else if (e.code == 'invalid-email') {
        CustomFunctions.customShowDialog(
            context, CustomStrings.error, CustomStrings.emailFormatError);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
