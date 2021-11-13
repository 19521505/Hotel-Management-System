import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.press,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(
          left: size.height * 0.02,
          right: size.height * 0.02,
        ),
        child: InkWell(
          onTap: press,
          child: Container(
            height: size.height * 0.2,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: kPrimaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            subtitle: Text(
                              subTitle,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: kPrimaryColor,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
