import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/screens/main/accountant/accountant_page.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/form_revenue_report.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow_list.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/widgets/inflow_list_item.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow_item_detail.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/revenue_report_result.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/kitchenpage.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/form_foods_request.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/restaunrant_others_list/pending_res_bill.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:hotel_management_system/views/screens/landing/landing_page.dart';
import 'package:hotel_management_system/views/screens/main/manager/manager_home_page.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/food_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/hotel_management.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/entertainment_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/invoice_entertainment.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/add_new_booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_payment_detail_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/hotel_page.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/room_detail_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/receptionist_page.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/add_detail_dish.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/add_food_screen.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/pay_detail_res_bill.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/form_create_res_bill_screen.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/pay_res_bills.dart';
import 'package:hotel_management_system/views/screens/main/waiter/waiter_page.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/list_request.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/manage_ingredient_screen.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/warehouse_page.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/form_detail_request.dart';
import 'package:hotel_management_system/views/screens/screens.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.nameRoute:
        return LoginPage.route();
      case MainScreen.nameRoute:
        return MainScreen.route();
      case LandingPage.nameRoute:
        return LandingPage.route();
      /**
        * Kitchen Department 
      */
      case KitchenPage.nameRoute:
        return KitchenPage.route();
      case FoodRequest.nameRoute:
        return FoodRequest.route();
      case PendingResList.nameRoute:
        return PendingResList.route();
      /**
        * Accountant Department 
      */
      case AccountantPage.nameRoute:
        return AccountantPage.route();
      case RevenueReport.nameRoute:
        return RevenueReport.route();
      case CashInflowPage.nameRoute:
        return CashInflowPage.route();
      case CashOutflowPage.nameRoute:
        return CashOutflowPage.route();
      case OutFlowItemDetail.nameRoute:
        return OutFlowItemDetail.route(settings);
      case InflowListPage.nameRoute:
        final args = settings.arguments as InflowListDetailArgument;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: args.accountantProvider)
            ],
            child: InflowListPage(),
          ),
        );
      case InflowListItem.nameRoute:
        final args = settings.arguments as InflowListItemArgument;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: args.accountantProvider)
            ],
            child: InflowListItem(),
          ),
        );
      case RevenueReportResultPage.nameRoute:
        final args = settings.arguments as RevenueReportResultPageArgument;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: args.accountantProvider)
            ],
            child: RevenueReportResultPage(),
          ),
        );
      /**
        * Warehouse Department 
      */
      case WarehousePage.nameRoute:
        return WarehousePage.route(settings);
      case ListRequest.nameRoute:
        return ListRequest.route(settings);
      case DetailRequest.nameRoute:
        return DetailRequest.route(settings);
      case ManageIngredientScreen.nameRoute:
        return ManageIngredientScreen.route();
      /**
        * Receptionist Department 
      */
      case ReceptionistPage.nameRoute:
        return ReceptionistPage.route();
      // Hotel
      case HotelPage.nameRoute:
        return HotelPage.route();
      case BookingScreen.nameRoute:
        return BookingScreen.route(settings);
      case RoomDetail.nameRoute:
        return RoomDetail.route(settings);
      case AddBookingScreen.nameRoute:
        return AddBookingScreen.route(settings);
      case BookingPaymentDetail.nameRoute:
        return BookingPaymentDetail.route(settings);
      // Entertainment
      case EntertainmentScreen.nameRoute:
        return EntertainmentScreen.route();
      case InvoiceEntertainment.nameRoute:
        return InvoiceEntertainment.route(settings);
      /**
        * Waiter Department 
      */
      case WaiterPage.nameRoute:
        return WaiterPage.route();
      case FormCreateRestaurantBill.nameRoute:
        return FormCreateRestaurantBill.route();
      case AddFoodScreen.nameRoute:
        return AddFoodScreen.route();
      case PayResBills.nameRoute:
        return PayResBills.route(settings);
      case PayResBillDetail.nameRoute:
        return PayResBillDetail.route(settings);
      /**
        * Manager Department 
      */
      case ManagerHomePage.nameRoute:
        return ManagerHomePage.route();
      case FoodManagementScreen.nameRoute:
        return FoodManagementScreen.route();
      case HotelManagementScreen.nameRoute:
        return HotelManagementScreen.route();
      /**
        * Default 
      */
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
