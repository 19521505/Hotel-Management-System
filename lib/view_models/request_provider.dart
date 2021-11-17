import 'package:flutter/foundation.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/request_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestProvider extends ChangeNotifier {
  List<Request> requestList = [];

  Future<void> fetchRequestList(date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    requestList = await RequestService.getRequestByDate(token, date);
    notifyListeners();
  }
}
