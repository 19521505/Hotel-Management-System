import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/login/widgets/login_background.dart';
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
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Stack(children: <Widget>[
      Scaffold(
        body: SingleChildScrollView(
          child: LoginBackground(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/images/hotel_logo_icon.png"),
                  SizedBox(
                    height: 10,
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
                  RoundedButton(
                    text: "SIGN IN",
                    height: _height,
                    press: () async {
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
                                    description: authProvider
                                        .authState.data['msg']
                                        .toString(),
                                    image: 'cancel.png',
                                    hasDescription: true,
                                  ));
                        }
                      }
                    },
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Image.asset("assets/images/bottom_hotel_logo_icon.png"),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Container(
          child: Provider.of<AuthProvider>(context).loading
              ? Loader()
              : Container())
    ]);
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
