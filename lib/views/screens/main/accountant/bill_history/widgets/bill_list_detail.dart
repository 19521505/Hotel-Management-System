import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/accountant/bill_history_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/bill_history/widgets/bill_list_item.dart';
import 'package:hotel_management_system/widgets/right_circular_black_arrow.dart';
import 'package:provider/provider.dart';

class BillListDetail extends StatelessWidget {
  static const String nameRoute = '/billListDetail';
  const BillListDetail(
      {required this.size,
      required this.index,
      required this.typeOfInflowList,
      Key? key})
      : super(key: key);
  final Size size;
  final int index;
  final String typeOfInflowList;
  @override
  Widget build(BuildContext context) {
    return Consumer<BillHistoryProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/ic_pin_staff.png'),
                        SizedBox(width: 5),
                        typeOfInflowList == "ResBill"
                            ? Text(
                                provider.listResBill[index].staff.fullName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            : typeOfInflowList == "RoomBill"
                                ? Text(
                                    provider
                                        .listRoomBill[index].staffId.fullName,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                : typeOfInflowList == "EntertainmentBill"
                                    ? Text(
                                        provider.listEntertainmentBill[index]
                                            .staff.fullName,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ),
                      ],
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          if (typeOfInflowList == "ResBill") {
                            Navigator.pushNamed(context, BillListItem.nameRoute,
                                arguments: BillListItemArgument(
                                    provider,
                                    typeOfInflowList,
                                    index,
                                    "Restaurant Bill"));
                          } else if (typeOfInflowList == "RoomBill") {
                            Navigator.pushNamed(context, BillListItem.nameRoute,
                                arguments: BillListItemArgument(provider,
                                    typeOfInflowList, index, "Room Bill"));
                          } else if (typeOfInflowList == "EntertainmentBill") {
                            Navigator.pushNamed(context, BillListItem.nameRoute,
                                arguments: BillListItemArgument(
                                    provider,
                                    typeOfInflowList,
                                    index,
                                    "Entertainment Bill"));
                          }
                        },
                        child: RightCircularBlackArrow(size: size),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                typeOfInflowList == "RoomBill"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              provider.listRoomBill[index].totalPrice
                                      .toString() +
                                  " VND",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("1 Room",
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      )
                    : typeOfInflowList == "ResBill"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  provider.listResBill[index].totalPrice
                                          .toString() +
                                      " VND",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                  provider.listResBill[index].resBillDetail
                                          .length
                                          .toString() +
                                      " Orders",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ))
                            ],
                          )
                        : typeOfInflowList == "EntertainmentBill"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      provider.listEntertainmentBill[index]
                                              .totalPrice
                                              .toString() +
                                          " VND",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                      provider.listEntertainmentBill[index]
                                              .entertainBillDetail.length
                                              .toString() +
                                          " Services",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))
                                ],
                              )
                            : SizedBox(
                                width: 0,
                              ),
                SizedBox(
                  height: 10,
                ),
                typeOfInflowList == "RoomBill"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            FormatDateTime.formatterDay.format(
                                provider.listRoomBill[index].dateCreate),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            FormatDateTime.formatterTime.format(
                                provider.listRoomBill[index].dateCreate),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "PAID",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset('assets/images/ic_paid.png')
                            ],
                          )
                        ],
                      )
                    : typeOfInflowList == "EntertainmentBill"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                FormatDateTime.formatterDay.format(
                                    provider.listEntertainmentBill[index].date),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                FormatDateTime.formatterTime.format(
                                    provider.listEntertainmentBill[index].date),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "PAID",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset('assets/images/ic_paid.png')
                                ],
                              )
                            ],
                          )
                        : typeOfInflowList == "ResBill"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    FormatDateTime.formatterDay.format(
                                        provider.listResBill[index].date),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    FormatDateTime.formatterTime.format(
                                        provider.listResBill[index].date),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "PAID",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset('assets/images/ic_paid.png')
                                    ],
                                  )
                                ],
                              )
                            : SizedBox(
                                width: 0,
                              ),
              ],
            ),
          ),
        );
      },
    );
  }
}
