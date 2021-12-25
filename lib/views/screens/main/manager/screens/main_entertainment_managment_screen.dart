import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/entertainment_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/type_ticket_management.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class MainEntertainemtManagementScreen extends StatelessWidget {
  static const String nameRoute = '/main_entertainment_management';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => MainEntertainemtManagementScreen(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const MainEntertainemtManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(title: 'Main Entertainment Management'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: Column(
            children: [
              CustomMainCard(
                title: 'Entertainment Management',
                subTitle: '.......',
                press: () {
                  Navigator.pushNamed(
                      context, EntertainmentManagementScreen.nameRoute);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CustomMainCard(
                title: 'Type Ticket Management',
                subTitle: '.....',
                press: () {
                  Navigator.pushNamed(
                      context, TypeTicketManagementScreen.nameRoute);
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
