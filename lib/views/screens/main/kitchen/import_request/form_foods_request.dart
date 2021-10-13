import 'package:flutter/material.dart';

class FoodRequest extends StatelessWidget {
  static const String nameRoute = '/foodrequest';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => FoodRequest(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const FoodRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Request'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              'Name Request',
              style: TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
