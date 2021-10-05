import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/views/screens/login/widgets/login_background.dart';
import 'package:hotel_management_system/widgets/rounded_button.dart';
import 'package:hotel_management_system/widgets/rounded_input_field.dart';
import 'package:hotel_management_system/widgets/rounded_password_field.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginBackground(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                  hintText: "Your Email",
                  onChanged: (value) {},
                  icon: Icons.person,
                ),
                RoundedPasswordField(
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "SIGN IN",
                  height: _height,
                  press: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
                Image.asset("assets/images/bottom_hotel_logo_icon.png"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account ? ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
