import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/my_order.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/accepted_order.dart';
// import 'package:dayjour_version_2/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class CheckoutController extends GetxController{
  var selected_operation = 0.obs;
  var address_err=false.obs;
  var my_order = <MyOrder>[].obs;
  var is_paid=false.obs;
  var selected=false.obs;
  var is_cod=false.obs;
  CartController cartController = Get.find();
  List<LineItem> lineItems = <LineItem>[];

  /**address controllers*/
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<String> country="non".obs;
  Rx<String> emirate="non".obs;
  List<String> countries=["United Arab Emirates"];
  List<String> emirates=["Abu Dhabi","Ajman","Dubai","Fujairah","Ras Al Khaimah","Sharjah","Umm Al Quwain"];


  next(BuildContext context) async{
    get_details();
    if(selected_operation==0){
      if(firstName.value.text.isEmpty||lastName.value.text.isEmpty||address.value.text.isEmpty||
          apartment.value.text.isEmpty||city.value.text.isEmpty||phone.value.text.isEmpty||country=="non"||emirate=="non"||phone.value.text.length<9){
        address_err.value=true;
        // selected_operation++;
      }else{
        selected_operation++;
      }
    }else{
      if(selected.value&&!is_cod.value) {
        App.error_msg(
            context, App_Localization.of(context).translate("err_next_step"));
      }else if(selected.value && selected_operation != 2){
        selected_operation++;
      }else if (selected.value && selected_operation == 2){
        selected_operation.value = 0;
        selected.value = false;
        await add_order_payment(context);
        Get.off(Accepted_order(cartController.sub_total.value,cartController.shipping.value,cartController.total.value));
      }
    }
  }
  back(){
    selected.value=false;
    if(selected_operation==0){
      Get.back();
    }else if(selected.value){
      selected.value=false;
    }
    else if(selected_operation==1){
        address_err.value=false;
        selected_operation--;
    }
  }
  pay(double price,BuildContext context){
    MyFatoorah.startPayment(
      context: context,
      request: MyfatoorahRequest.test(
        currencyIso: Country.UAE,
        successUrl:
        "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
        errorUrl:
        "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
        invoiceAmount: price,
        language: Global.lang_code=="en"?ApiLanguage.English:ApiLanguage.Arabic,
        token: "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
      ),
    ).then((response) {
      print(response);
    }).catchError((e) {
      print(e);
    });
  }
  add_order_payment(BuildContext context){
    cartController.get_total();
    //todo add order to shpify
    MyApi.add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, phone.text, get_details(), double.parse(cartController.sub_total.value), double.parse(cartController.shipping.value), double.parse(cartController.total.value), is_paid.value,lineItems);
    cartController.clear_cart();
   // App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
  }
  add_order_shopyfi(BuildContext context){
    cartController.get_total();
    if(is_paid.value){
      cartController.clear_cart();
      App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
      // Get.offAll(()=>Home());
    }else{
      //todo add order to shpify
      MyApi.add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, phone.text, get_details(), double.parse(cartController.sub_total.value), double.parse(cartController.shipping.value), double.parse(cartController.total.value), is_paid.value,lineItems);
      cartController.clear_cart();
      App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
      // Get.offAll(()=>Home());
    }
  }

  String get_details(){
    String text="";
    lineItems.clear();
    for(int i=0;i<my_order.length;i++){
      print(my_order.length);
      print('*****************************');
      print( my_order[i].product.value.id);
      print( my_order[i].quantity);
      print('*****************************');
      lineItems.add(LineItem(id: my_order[i].product.value.id, quantity: my_order[i].quantity.value));
      text+=my_order[i].product.value.title+" X "+my_order[i].quantity.value.toString()+"\n";
    }
    return text;
  }

}