import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChefPage extends StatelessWidget {
  const ChefPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        padding: EdgeInsets.all(size.width * 0.04),
        children: <Widget>[
          Container(
            color: Colors.black,
            height: size.height * 0.17,
            child: SvgPicture.asset("assets/svg/mask_group.svg"),
          ),
          SizedBox(
            height: size.height * 0.2,
          )
        ],
      ),
    );
  }
}
