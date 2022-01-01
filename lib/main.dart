import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/accountant/accountant_provider.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/manager/add_food_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/view_models/kitchen/request_provider.dart';
import 'package:hotel_management_system/view_models/restaurant/restaurant_bill_provider.dart';
import 'package:hotel_management_system/view_models/warehouse/warehouse_provider.dart';
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
       
        ChangeNotifierProvider<AccountantProvider>(
          create: (context) => AccountantProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<RestaunrantBillProvider>(
          create: (context) => RestaunrantBillProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<AddFoodProvider>(
          create: (context) => AddFoodProvider(),
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
