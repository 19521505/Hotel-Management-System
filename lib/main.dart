import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/view_models/request_provider.dart';
import 'package:hotel_management_system/view_models/warehouse_provider.dart';
import 'package:hotel_management_system/views/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(HotelManagerSystem());
}

class HotelManagerSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<RequestProvider>(
          create: (context) => RequestProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<WarehouseProvider>(
          create: (context) => WarehouseProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<HotelProvider>(
          create: (context) => HotelProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: '/landing',
      ),
    );
  }
}
