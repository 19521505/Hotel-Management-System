import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/manager/entertainment_management_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/entertainment_management_detail.dart';
import 'package:hotel_management_system/views/screens/main/manager/widgets/bottom_sheet_management_entertainment.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:hotel_management_system/widgets/delete_item_widget.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/right_circular_black_arrow.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EntertainmentManagementScreen extends StatelessWidget {
  static const String nameRoute = '/entertainment_management';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<EntertainmentManagmentProvider>(
        create: (_) => EntertainmentManagmentProvider(),
        child: EntertainmentManagementScreen(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const EntertainmentManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.read<EntertainmentManagmentProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Entertainment Management",
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
                    child: AddEntertainmentBottomSheet(),
                  );
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
      body: Consumer<EntertainmentManagmentProvider>(
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
            child: RefreshIndicator(
              onRefresh: () => provider.loadListEntertainment(),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final entertainment = provider.listEntertainment[index];
                    return Dismissible(
                      key: ValueKey<int>(entertainment.hashCode),
                      confirmDismiss: (DismissDirection direction) {
                        return DialogSuccessNotify().confirmDialog(context,
                            "Do you want to delete this Entertainment?", () {
                          provider.deleteEntertainment(entertainment.sId);
                        });
                      },
                      background: DeleteItemWidget(),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, EntertainmentManagementDetail.nameRoute,
                              arguments: entertainment);
                        },
                        child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: entertainment.entertainName,
                                            style: TextStyle(
                                              color: redLightColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  RightCircularBlackArrow(size: size),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Status: ',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: provider.listEntertainment[index]
                                              .typeTicket.isNotEmpty
                                          ? "Approved"
                                          : "No Ticket Price Yet",
                                      style: TextStyle(
                                        color: provider.listEntertainment[index]
                                                .typeTicket.isNotEmpty
                                            ? colorYesButton
                                            : redLightColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: size.height * 0.02,
                      ),
                  itemCount: provider.listEntertainment.length),
            ),
          ),
        );
      }),
    );
  }
}
