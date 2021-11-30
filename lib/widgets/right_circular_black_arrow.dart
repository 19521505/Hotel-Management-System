import 'package:flutter/material.dart';

class RightCircularBlackArrow extends StatelessWidget {
  const RightCircularBlackArrow({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: size.height * 0.035,
      width: size.height * 0.035,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
