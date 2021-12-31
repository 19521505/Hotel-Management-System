import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/accountant/bill_history/bill_history_page.dart';
import 'package:hotel_management_system/views/screens/main/accountant/payment_history/payment_history_page.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/form_revenue_report.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class AccountantPage extends StatefulWidget {
  const AccountantPage({Key? key}) : super(key: key);
  static const String nameRoute = '/accountantPage';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => AccountantPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  @override
  _AccountantPageState createState() => _AccountantPageState();
}

class _AccountantPageState extends State<AccountantPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: size.height * 0.02,
                top: size.height * 0.03,
              ),
              child: Text(
                'Activities',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // Create new revenue report
            CustomMainCard(
              icon: "ic_statistic.png",
              title: 'New Revenue Report',
              subTitle:
                  'Create a revenue daily report about the profit of the company',
              press: () {
                Navigator.pushNamed(context, RevenueReport.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            //View payment history
            CustomMainCard(
              icon: "ic_history.png",
              title: 'Payment History',
              subTitle: 'List of invoices for purchase ingredients',
              press: () {
                Navigator.pushNamed(context, PaymentHistoryPage.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // View list of bills history
            CustomMainCard(
              icon: "ic_history.png",
              title: 'Bills History',
              subTitle: 'List of bills from hotel services and restaurant',
              press: () {
                Navigator.pushNamed(context, BillHistoryPage.nameRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
