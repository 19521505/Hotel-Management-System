import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/ingredient.dart';
import 'package:hotel_management_system/view_models/warehouse/ingredient_provider.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/bottom_sheet_mangement_ingre.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/ingre_card.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:hotel_management_system/widgets/delete_item_widget.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ManageIngredientScreen extends StatefulWidget {
  static const String nameRoute = '/manage_ingredient';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<IngredientProvider>(
        create: (_) => IngredientProvider(),
        child: ManageIngredientScreen(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const ManageIngredientScreen({Key? key}) : super(key: key);

  @override
  State<ManageIngredientScreen> createState() => _ManageIngredientScreenState();
}

class _ManageIngredientScreenState extends State<ManageIngredientScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.read<IngredientProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List of Ingredients',
          style: TextStyle(
              color: startLinearColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: CustomBackButton(),
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (context) {
                  return ChangeNotifierProvider.value(
                      value: provider, child: AddIngreBottomSheet());
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
      body: Consumer<IngredientProvider>(builder: (context, provider, child) {
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
              itemBuilder: (BuildContext context, int index) {
                final ingredient = provider.listIngredient[index];
                return Dismissible(
                  key: ValueKey<int>(ingredient.hashCode),
                  confirmDismiss: (DismissDirection direction) {
                    return DialogSuccessNotify().confirmDialog(
                        context, "Do you want to delete this Ingredient?", () {
                      provider.deleteIngredient(
                        ingredient.ingreID,
                      );
                      provider.listIngredient.removeAt(index);
                    });
                  },
                  background: DeleteItemWidget(),
                  child: IngredientCard(
                    ingredient: ingredient,
                    press: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                              value: provider,
                              child: UpdateIngreBottomSheet(
                                ingredient: ingredient,
                              ));
                        },
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: size.height * 0.02,
              ),
              itemCount: provider.listIngredient.length,
            ),
          ),
        );
      }),
    );
  }
}
