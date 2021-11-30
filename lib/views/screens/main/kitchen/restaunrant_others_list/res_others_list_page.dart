import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/request_card.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';

class ResOthersList extends StatefulWidget {
  static const String nameRoute = '/resotherslist';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ResOthersList(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const ResOthersList({Key? key}) : super(key: key);

  @override
  _ResOthersListState createState() => _ResOthersListState();
}

class _ResOthersListState extends State<ResOthersList> {
  int filter = 0; // Sort by status
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomFormAppBar(
        title: 'Restaurant Orders List',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            top: size.height * 0.03,
            right: size.height * 0.02,
            bottom: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'List of Orders',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: size.height * 0.04,
                    width: size.height * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryLightColor,
                    ),
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: Center(
                      child: DropdownButton<int>(
                        dropdownColor: kPrimaryLightColor,
                        iconSize: 30,
                        underline: SizedBox(),
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (val) {
                          setState(() {
                            this.filter = val!;
                          });
                        },
                        value: filter,
                        items: [
                          DropdownMenuItem(child: Text('All'), value: 0),
                          DropdownMenuItem(child: Text('Done'), value: 1),
                          DropdownMenuItem(child: Text('Canceled'), value: 2),
                          DropdownMenuItem(child: Text('Pending'), value: 3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              WidgetRequestCard(
                nameRequest: 'aaaaa',
                nameStaff: 'aaaa',
                date: 'aaaa',
                time: 'aaaa',
                status: 'aa',
                color: Colors.black,
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
