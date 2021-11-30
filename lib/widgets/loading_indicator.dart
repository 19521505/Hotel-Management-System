import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class Loader extends StatelessWidget {
  Loader({
    Key? key,
    this.opacity: 0.5,
    this.dismissibles: false,
    this.color: Colors.white,
  }) : super(key: key);

  final double opacity;
  final bool dismissibles;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(dismissible: false, color: Colors.white),
        ),
        Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10),
              child: SpinKitFadingCube(
                color: kPrimaryColor,
                size: 40.0,
              ),
            ),
          ],
        )),
      ],
    );
  }
}
