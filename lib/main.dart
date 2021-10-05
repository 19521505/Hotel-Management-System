import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: '/main',
    );
  }
}
