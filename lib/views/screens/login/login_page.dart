import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:hotel_management_system/widgets/custom_dialog.dart';
import 'package:hotel_management_system/widgets/loading_indicator.dart';
import 'package:hotel_management_system/widgets/rounded_button.dart';
import 'package:hotel_management_system/widgets/rounded_input_field.dart';
import 'package:hotel_management_system/widgets/rounded_password_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String nameRoute = '/login';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  double _height = 56;
  GlobalKey _globalKey = GlobalKey();
  var name, password;
  bool loginSuccess = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: ExactAssetImage('assets/images/login_bottom_background.png'),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BottomHalfContainer(true, () {}, size.height * 0.62),
              Container(
                height: size.height * 0.47,
                width: size.width,
                child: Image.asset(
                  'assets/images/login_background.png',
                  fit: BoxFit.fill,
                ),
              ),
              Form(
                key: _formKey,
                child: Center(
                  child: Wrap(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(39.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 15,
                                        spreadRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.12,
                                  ),
                                  RoundedInputField(
                                    inputName: "Your Username",
                                    hintText: "Enter Your Name",
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    icon: Icons.person,
                                  ),
                                  RoundedPasswordField(
                                    hintText: "Enter Your Password",
                                    onChanged: (value) {
                                      password = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.08,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: size.height * 0.04),
                              width: size.width * 0.87,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Sign In".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Hotel",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                          children: [
                                            TextSpan(
                                              text: " Management",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BottomHalfContainer(
                false,
                () async {
                  if (_formKey.currentState!.validate()) {
                    loginSuccess = await authProvider.login(name, password);
                    if (loginSuccess) {
                      authProvider.loading = false;
                      showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                                title: "Success",
                                description: "",
                                image: 'checked.png',
                                hasDescription: false,
                              ));
                      navigateToMainScreen();
                    } else {
                      authProvider.loading = false;
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: "Failed",
                          description:
                              authProvider.authState.data['msg'].toString(),
                          image: 'cancel.png',
                          hasDescription: true,
                        ),
                      );
                    }
                  }
                },
                size.height * 0.62,
              ),
            ],
          ),
        ),
        Container(
            child: Provider.of<AuthProvider>(context).loading
                ? Loader()
                : Container())
      ]),
    );
  }

  navigateToMainScreen() {
    _timer = new Timer(const Duration(milliseconds: 400), () {
      setState(() {
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.nameRoute, (route) => false);
      });
    });
  }
}

Widget BottomHalfContainer(
    bool showShadow, VoidCallback onSignInPress, double size) {
  return AnimatedPositioned(
    duration: Duration(milliseconds: 700),
    curve: Curves.bounceInOut,
    top: size,
    right: 0,
    left: 0,
    child: Center(
      child: Container(
        height: 90,
        width: 90,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1.5,
                  blurRadius: 10,
                )
            ]),
        child: !showShadow
            ? GestureDetector(
                onTap: onSignInPress,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [kPrimaryLightColor, kPrimaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              )
            : Center(),
      ),
    ),
  );
}
