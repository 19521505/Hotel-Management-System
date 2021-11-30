import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/data_repository/kitchen_data_repository.dart';

class KitchenDataProvider {
  // send new request
  Future<void> sendRequest({
    required RequestType requestType,
    required String nameRequest,
    required String date,
    required String staffId,
    required int status,
    required List<Map<String, dynamic>> ingredients,
    required int total,
  }) async {
    final response = await KitchenDataRepository().sendRequest(
      requestType: requestType.value,
      nameRequest: nameRequest,
      date: date,
      staffId: staffId,
      status: status,
      ingredients: ingredients,
      total: total,
    );
  }
}
