import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/dialog_details_req.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FoodRequest extends StatefulWidget {
  static const String nameRoute = '/foodrequest';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => FoodRequest(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const FoodRequest({Key? key}) : super(key: key);

  @override
  State<FoodRequest> createState() => _FoodRequestState();
}

class _FoodRequestState extends State<FoodRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Request',
          style: TextStyle(color: startLinearColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: CustomBackButton(),
      ),
      body: BodyFormReq(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        heroTag: null,
        backgroundColor: startLinearColor,
        child: IconButton(
          onPressed: () {
            // Navigator.pushNamed(context, AddIngre.nameRoute);
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog();
                });
          },
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}

class BodyFormReq extends StatefulWidget {
  const BodyFormReq({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyFormReq> createState() => _BodyFormReqState();
}

class _BodyFormReqState extends State<BodyFormReq> {
  bool typeCheck = false;
  int type = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        color: Colors.white,
        padding: EdgeInsets.only(
          left: size.height * 0.01,
          top: size.height * 0.03,
          right: size.height * 0.01,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 2),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Type Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: startButtonLinearColor,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: DropdownButton<int>(
                            dropdownColor: Colors.white,
                            iconSize: 34,
                            underline: SizedBox(),
                            isExpanded: true,
                            style: TextStyle(
                              color: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onChanged: (val) {
                              setState(() {
                                this.type = val!;
                              });
                            },
                            value: type,
                            items: [
                              DropdownMenuItem(child: Text('Import'), value: 1),
                              DropdownMenuItem(child: Text('Export'), value: 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _InfoForm1(
                      title: 'Staff Name',
                      content: authProvider.currentStaff.fullName),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _InfoForm1(
                    title: 'DateTime',
                    content: DateFormat('yyyy-MM-dd hh:mm')
                        .format(DateTime.now())
                        .toString(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 2),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Ingredients List',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              // color: startButtonLinearColor,
              height: size.height * 0.07,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  'SEND',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(startButtonLinearColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoForm1 extends StatelessWidget {
  const _InfoForm1({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
