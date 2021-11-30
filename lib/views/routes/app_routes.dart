import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/form_revenue_report.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/kitchenpage.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/form_foods_request.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/res_others_list/res_others_list_page.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:hotel_management_system/views/screens/landing/landing_page.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/add_new_booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/hotel_page.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/room_detail_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/receptionist_page.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/list_request.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/warehouse_page.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/form_detail_request.dart';
import 'package:hotel_management_system/views/screens/screens.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.nameRoute:
        return LoginPage.route();
      case MainScreen.nameRoute:
        return MainScreen.route();
      case LandingPage.nameRoute:
        return LandingPage.route();
      // Kitchen Department
      case KitchenPage.nameRoute:
        return KitchenPage.route();
      case FoodRequest.nameRoute:
        return FoodRequest.route();
      case ResOthersList.nameRoute:
        return ResOthersList.route();
      // Accountant
      case RevenueReport.nameRoute:
        return RevenueReport.route();
      case CashInflowPage.nameRoute:
        return CashInflowPage.route();
      case CashOutflowPage.nameRoute:
        return CashOutflowPage.route();
      // Warehouse Department
      case WarehousePage.nameRoute:
        return WarehousePage.route(settings);
      case ListRequest.nameRoute:
        return ListRequest.route(settings);
      case DetailRequest.nameRoute:
        return DetailRequest.route(settings);
      //Reception Department
      case ReceptionistPage.nameRoute:
        return ReceptionistPage.route();
      case HotelPage.nameRoute:
        return HotelPage.route();
      case BookingScreen.nameRoute:
        return BookingScreen.route(settings);
      case RoomDetail.nameRoute:
        return RoomDetail.route(settings);
      case AddBookingScreen.nameRoute:
        return AddBookingScreen.route(settings);
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
