import 'package:flutter/material.dart';

class FormBoxDescription extends StatelessWidget {
  const FormBoxDescription(
      {Key? key,
      required this.child,
      this.hasIcon = false,
      this.nameRoute = "",
      this.image = "right_arrow_view_icon.png"})
      : super(key: key);

  final Widget child;
  final bool hasIcon;
  final String nameRoute;
  final String image;
  @override
  Widget build(BuildContext context) {
    return hasIcon
        ? Stack(clipBehavior: Clip.hardEdge, children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: child,
            ),
            Positioned(
              top: 15,
              right: 10,
              child: Container(
                child: GestureDetector(
                  onTap: () async {
                    if (nameRoute == "/outflow") {}
                    Navigator.pushNamed(context, nameRoute);
                  },
                  child: Image.asset('assets/images/' + image),
                ),
              ),
            ),
          ])
        : Stack(clipBehavior: Clip.hardEdge, children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: child,
            ),
          ]);
  }
}
