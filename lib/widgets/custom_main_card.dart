import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class CustomMainCard extends StatelessWidget {
  const CustomMainCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final VoidCallback press;
  final String icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.height * 0.01,
        right: size.height * 0.01,
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
                color: kPrimaryLightColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.04,
                        top: size.height * 0.04,
                        bottom: size.height * 0.04),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Image.asset(
                      "assets/images/" + icon,
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.03),
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
                        child: Image.asset(
                          "assets/images/right_arrow_view_icon.png",
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
