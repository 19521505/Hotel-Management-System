import 'package:hotel_management_system/models/restaurant/dish.dart';
import 'package:hotel_management_system/models/restaurant/drink.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/services/data_repository/restaurant_data_repository.dart';

class RestaurantDataProvider {
  Future<List<Food>> getAllFood({required int foodType}) async {
    final response =
        await RestaurantDataRepository().getAllFood(foodType: foodType);
    var listFood = (response.data as List)
        .map((e) => e['foodType'] == 1 ? Dish.fromJson(e) : Drink.fromJson(e))
        .toList();
    return listFood;
  }

  Future<void> addRestaunrantBill({
    required int status,
    required String date,
    required List<Map<String, dynamic>> resBillDetail,
    required String staffId,
    required int totalPrice,
  }) async {
    final response = await RestaurantDataRepository().addRestaunrantBill(
        status: status,
        date: date,
        resBillDetail: resBillDetail,
        staffId: staffId,
        totalPrice: totalPrice);
  }

  Future<List<ResBill>> unPaidResBills({required int paidStatus}) async {
    final response =
        await RestaurantDataRepository().getUnPaidBills(paidStatus: paidStatus);
    var listBill =
        (response.data as List).map((e) => ResBill.fromJson(e)).toList();
    return listBill;
  }

  Future<void> updatePaidResBill(
      {required String id, required int paidStatus}) async {
    await RestaurantDataRepository()
        .updatePaidResBill(id: id, paidStatus: paidStatus);
  }

  Future<void> deleteResBill({required String id}) async {
    await RestaurantDataRepository().deleteResBill(id: id);
  }

  Future<List<ResBill>> getResBillPending({required int status}) async {
    final response =
        await RestaurantDataRepository().getResBillPending(status: status);
    var listBill =
        (response.data as List).map((e) => ResBill.fromJson(e)).toList();
    return listBill;
  }

  Future<void> updateStatusResBill(
      {required String id, required int status}) async {
    await RestaurantDataRepository()
        .updateStatusResBill(id: id, status: status);
  }
}
