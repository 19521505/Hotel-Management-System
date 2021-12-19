import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/services/data_repository/manager_data_repository.dart';

class ManagerDataProvider {
  //******************************* */
  // Entertaiment Management
  //******************************* */

  // add Entertainment
  Future<void> addNewEntertainment({required String entertainName}) async {
    await ManagerDataRepository()
        .addNewEntertainment(entertainName: entertainName);
  }

  Future<void> deleteEntertainment({required String entertainId}) async {
    await ManagerDataRepository().deleteEntertainment(entertainId: entertainId);
  }

  Future<void> addTicketIntoEntertainment(
      {required String entertainId, required String ticket}) async {
    await ManagerDataRepository()
        .addTicketIntoEntertainment(entertainId: entertainId, ticket: ticket);
  }

  Future<void> deleteTicketInEntertainment(
      {required String entertainId, required String typeTicket}) async {
    await ManagerDataRepository().deleteTicketInEntertainment(
        entertainId: entertainId, typeTicket: typeTicket);
  }

  // add type ticket
  Future<void> addTypeTicket(
      {required String typeName, required int type, required int price}) async {
    await ManagerDataRepository()
        .addTypeTicket(typeName: typeName, type: type, price: price);
  }

  // update type ticket
  Future<void> updateTypeTicket(
      {required String typeId, required int newPrice}) async {
    await ManagerDataRepository()
        .updateTypeTicket(typeId: typeId, newPrice: newPrice);
  }

  // delete type ticket
  Future<void> deleteTypeTicket({required String typeId}) async {
    await ManagerDataRepository().deleteTypeTicket(typeId: typeId);
  }

  Future<List<TypeTicket>> getAllTypeTicket() async {
    final response = await ManagerDataRepository().getAllTypeTicket();
    var listTypeTicket =
        (response.data as List).map((e) => TypeTicket.fromJson(e)).toList();
    return listTypeTicket;
  }

  //******************************* */
  // Hotel Management
  //******************************* */
  Future<void> addNewRoom(
      {required String roomName, required int roomPrice}) async {
    await ManagerDataRepository()
        .addNewRoom(roomName: roomName, roomPrice: roomPrice);
  }

  Future<void> updateRoom(
      {required String roomId, required int newPrice}) async {
    await ManagerDataRepository()
        .updateRoom(roomId: roomId, newPrice: newPrice);
  }

  //******************************* */
  // Food Management
  //******************************* */

  Future<void> addFood({
    required String foodName,
    required int foodPrice,
    required int foodType,
    required String image,
  }) async {
    final response = await ManagerDataRepository().addFood(
        foodName: foodName,
        foodPrice: foodPrice,
        foodType: foodType,
        image: image);
  }

  Future<void> updateFood(
      {required String foodID,
      required int foodPrice,
      required String foodName}) async {
    await ManagerDataRepository()
        .updateFood(foodID: foodID, foodPrice: foodPrice, foodName: foodName);
  }

  Future<void> deleteFood({required String foodID}) async {
    await ManagerDataRepository().deleteFood(foodID: foodID);
  }
}
