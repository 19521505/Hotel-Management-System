import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/view_models/manager/hotel_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/widgets/bottom_sheet_management_hotel.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HotelManagementScreen extends StatefulWidget {
  static const String nameRoute = '/hotel_management';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<HotelManagementProvider>(
        create: (_) => HotelManagementProvider(),
        child: HotelManagementScreen(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const HotelManagementScreen({Key? key}) : super(key: key);

  @override
  State<HotelManagementScreen> createState() => _HotelManagementScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _HotelManagementScreenState extends State<HotelManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<HotelManagementProvider>();
    final insetSize = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Hotel Management",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: CustomBackButton(),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (context) {
                  return ChangeNotifierProvider.value(
                      value: provider,
                      child: AddHotelBottomSheet(insetSize: insetSize));
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: kPrimaryColor,
              size: 32,
            ),
          ),
        ],
      ),
      body: _BodyHotelMangementScreen(),
    );
  }
}

class _BodyHotelMangementScreen extends StatelessWidget {
  const _BodyHotelMangementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HotelManagementProvider>(
        builder: (context, provider, child) {
      return ModalProgressHUD(
        progressIndicator: SpinKitFoldingCube(
          color: kPrimaryColor,
          size: 40.0,
        ),
        inAsyncCall: provider.isLoad,
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            top: size.height * 0.03,
            right: size.height * 0.02,
            bottom: size.height * 0.03,
          ),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final room = provider.listAllRoom[index];
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Hotel Name: ',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: room.roomName,
                                  style: TextStyle(
                                    color: redLightColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                builder: (context) {
                                  return ChangeNotifierProvider.value(
                                      value: provider,
                                      child: UpdateHotelBottomSheet(
                                        room: room,
                                      ));
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/svg/ic_edit.svg',
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Hotel Price: ',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FormatCurrency.currencyFormat
                                      .format(room.roomPrice) +
                                  ' VND',
                              style: TextStyle(
                                color: redLightColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: size.height * 0.02,
                  ),
              itemCount: provider.listAllRoom.length),
        ),
      );
    });
  }
}
