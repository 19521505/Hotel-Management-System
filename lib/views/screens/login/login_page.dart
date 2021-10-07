import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/home/home_page.dart';
import 'package:hotel_management_system/views/screens/login/widgets/login_background.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginBackground(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.nameRoute, (route) => false);
                      }
                    }
                  },
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
                Image.asset("assets/images/bottom_hotel_logo_icon.png"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
