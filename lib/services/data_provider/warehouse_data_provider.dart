import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/data_repository/warehouse_data_repository.dart';

class WarehouseDataProvider {
  /* Kitchen Department */

  /* Warehouse Department */
  // get list type of request
  Future<List<Request>> typeofRequest() async {
    final response = await WarehouseDataRepository().typeofRequest();
    var listTypeofRequest =
        (response.data as List).map((e) => Request.fromJson(e)).toList();
    return listTypeofRequest;
  }

  // update status of request
  Future<void> updateStatusRequest(
      {required String id, required int status}) async {
    await WarehouseDataRepository().updateStatusRequest(id: id, status: status);
  }
}
