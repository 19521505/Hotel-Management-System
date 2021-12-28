class AppEndpoints {
  // get all ingredients
  static const ingredient = "/ingredient";
  // send a new request
  static const sendRequest = "/request/add";
  // get list typr of request and update status request
  static const request = "/request/";

  //get all room in hotel
  static const room = "/room/";
  // get a room detail
  static const roomDetail = "/room/booking/";
  // update paid status
  static const updatePaidStatus = "/room/booking/update_paid_status/";

  // get all entertainment
  static const entertainment = "/entertainment/";
  static const addEntertainBill = "/entertainment/bill/";

  // get all food
  static const getByFoodType = "/food/type";

  static const food = "/food/";

  static const addRestaunrantBill = "/resbill/add";

  static const paidResBill = "/resbill/paid";

  static const statusResBill = "/resbill/status";

  static const restaurantBill = '/resbill/';

  //report
  static const reportEndpoint = '/report';

  //risk bill
  static const riskBillEndpoint = '/risk';
}
