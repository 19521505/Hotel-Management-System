import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/import_request/form_foods_request.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/kitchenpage.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:hotel_management_system/views/screens/landing/landing_page.dart';
import 'package:hotel_management_system/views/screens/screens.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.nameRoute:
        return LoginPage.route();
      case MainScreen.nameRoute:
        return MainScreen.route();
      // case HomePage.nameRoute:
      //   return HomePage.route();
      case LandingPage.nameRoute:
        return LandingPage.route();
      case KitchenPage.nameRoute:
        return KitchenPage.route();
      case FoodRequest.nameRoute:
        return FoodRequest.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Container(
          child: Center(
            child: Text('Error'),
          ),
        ),
      ),
      settings: RouteSettings(
        name: '/error',
      ),
    );
  }
}
