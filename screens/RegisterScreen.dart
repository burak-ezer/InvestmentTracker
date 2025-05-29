import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/CustomButton.dart';
import '../components/CustomTextField.dart';
import '../constants/CustomColors.dart';
import '../constants/CustomFunctions.dart';
import '../constants/CustomStrings.dart';
import '../services/AuthFirebaseService.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

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
                  labelText: CustomStrings.email,
                  textInputType: TextInputType.emailAddress,
                  textEditingController: emailController),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                  maxLenght: 12,
                  labelText: CustomStrings.password,
                  textInputType: TextInputType.number,
                  textEditingController: passwordController),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                  maxLenght: 12,
                  labelText: CustomStrings.repeatPassword,
                  textInputType: TextInputType.number,
                  textEditingController: repeatPasswordController),
              SizedBox(
                height: 12,
              ),
              CustomButton(
                  voidCallback: () {
                    if (CustomFunctions.emptyControl([
                      emailController,
                      passwordController,
                      repeatPasswordController
                    ], context)) {
                      if (CustomFunctions.passwordControl(
                          passwordController.text,
                          repeatPasswordController.text,
                          context)) {
                        createUser(context);
                      }
                    }
                  },
                  string: CustomStrings.signUp),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createUser(BuildContext context) async {
    try {
      await AuthFirebaseService().createUser(
          email: emailController.text, password: passwordController.text);
      CustomFunctions.customShowDialog(
          context, CustomStrings.info, CustomStrings.successCreate);
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomFunctions.customShowDialog(
            context, CustomStrings.error, CustomStrings.weakPasswordError);
      } else if (e.code == 'email-already-in-use') {
        CustomFunctions.customShowDialog(
            context, CustomStrings.error, CustomStrings.alreadyEmailError);
      } else {
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
    repeatPasswordController.dispose();
  }
}
