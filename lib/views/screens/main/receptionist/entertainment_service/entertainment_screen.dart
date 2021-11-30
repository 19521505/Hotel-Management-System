import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/receptionist/entertainment_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/invoice_entertainment.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/widgets/entertainment_widget.dart';

import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EntertainmentScreen extends StatefulWidget {
  static const String nameRoute = '/entertainment';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<EntertainmentProvider>.value(
        value: EntertainmentProvider(),
        // lazy: false,
        child: EntertainmentScreen(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const EntertainmentScreen({Key? key}) : super(key: key);

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<EntertainmentProvider>().loadListEntertainment();
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomFormAppBar(title: 'List of Entertainment Service'),
      body:
          Consumer<EntertainmentProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoad,
          child: BodyEntertainmentScreen(),
        );
      }),
    );
  }
}

class BodyEntertainmentScreen extends StatelessWidget {
  const BodyEntertainmentScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.height * 0.02,
        right: size.height * 0.02,
        top: size.height * 0.03,
      ),
      child:
          Consumer<EntertainmentProvider>(builder: (context, provider, child) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return EntertaimentWidget(
              nameEntertainment:
                  provider.listEntertainment[index].entertainName,
              press: () {
                context.read<EntertainmentProvider>().setType(
                    provider.listEntertainment[index].typeTicket.first,
                    notify: false);
                context.read<EntertainmentProvider>().clearListDetail();
                Navigator.pushNamed(
                  context,
                  InvoiceEntertainment.nameRoute,
                  arguments: InvoiceEntertainmentArguments(
                      provider, provider.listEntertainment[index]),
                );
              },
            );
          },
          itemCount: provider.listEntertainment.length,
        );
      }),
    );
  }
}
