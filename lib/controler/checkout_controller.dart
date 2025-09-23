import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/my_address_controller.dart';
import 'package:dayjour_version_3/helper/api_v2.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/customer_order.dart';
import 'package:dayjour_version_3/my_model/my_order.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/accepted_order.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class CheckoutController extends GetxController{
  MyAddressController myAddressController = Get.put(MyAddressController());
  var selected_operation = 0.obs;
  var selectedAddress = 0.obs;
  var address_err=false.obs;
  // var my_order = <MyOrder>[].obs;
  var is_paid=false.obs;
  var selected=false.obs;
  var is_cod=false.obs;
  var cashewLoading=false.obs;
  CartController cartController = Get.find();
  // String shipping ="";
  // String total ="";
  // String sub_total ="";
  String orderTabbyId = "";
  //
  // List<LineItem> lineItems = <LineItem>[];


  @override
  void onInit() {
    super.onInit();
  }

  /**address controllers*/
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<String> country="non".obs;
  Rx<String> emirate="non".obs;
  List<String> countries=["United Arab Emirates"];
  List<String> emirates=["Abu Dhabi","Ajman","Dubai","Fujairah","Ras Al Khaimah","Sharjah","Umm Al Quwain"];


  getShippingAmount(String emirate){
    for(int i=0 ; i < Global.new_shipping.length; i++){
      if(emirate == Global.new_shipping[i].emirate){
        return Global.new_shipping[i].amount;
      }
    }
    return Global.new_shipping.first.amount;
  }

  getMinValueForFree(String emirate){
    for(int i=0 ; i < Global.new_shipping.length; i++){
      if(emirate == Global.new_shipping[i].emirate){
        return Global.new_shipping[i].minAmountFree;
      }
    }
    return Global.new_shipping.first.minAmountFree;
  }
  next(BuildContext context) async{
    // cartController.get_total(min_amount_for_free: getMinValueForFree(emirate.value.toString()),
    //     shipping_amount: getShippingAmount(emirate.value.toString()));
    get_details();
    // shipping = cartController.shipping.value;
    if(selected_operation==0){
      // shipping=cartController.shipping.value;
      // sub_total=cartController.sub_total.value;
      // total=cartController.total.value;

      // if(address.value.text.isEmpty||firstname.value.text.isEmpty||lastname.value.text.isEmpty||
      //     apartment.value.text.isEmpty||city.value.text.isEmpty||phone.value.text.isEmpty||country=="non"||emirate=="non"||phone.value.text.length<9){
      //   address_err.value=true;
        // selected_operation++;
      if(myAddressController.address.isNotEmpty){
        selected_operation++;
      }

    }else{
      if(selected.value&&!is_cod.value) {
        // App.error_msg(
        //     context, App_Localization.of(context).translate("wrong"));
      }else if(selected.value && selected_operation != 2){
        selected_operation++;
      }else if (selected.value && selected_operation == 2){
        selected_operation.value = 0;
        selected.value = false;
        await add_order_payment(context);

        Get.off(Accepted_order(cartController.cart!.total.toString(),cartController.cart!.subTotal.toString(),
            cartController.cart!.shipping.toString()));
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
  // pay(double price,BuildContext context){
  //   MyFatoorah.startPayment(
  //     context: context,
  //     request: MyfatoorahRequest.test(
  //       currencyIso: Country.UAE,
  //       successUrl:
  //       "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
  //       errorUrl:
  //       "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
  //       invoiceAmount: price,
  //       language: Global.lang_code=="en"?ApiLanguage.English:ApiLanguage.Arabic,
  //       token: "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
  //     ),
  //   ).then((response) {
  //     print(response);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  List<CustomerOrder> tabbyList = <CustomerOrder>[];
  lunch_session()async{
    var regesterSince = new DateTime.now();
    tabbyList = await MyApi.get_customer_order(Global.customer!.id);
    try{
      regesterSince = DateTime.parse(Global.customer!.created_at);
    }catch(e){
      regesterSince = new DateTime.now();
    }
    var now = new DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    var regesterSinceFormated = DateFormat("yyyy-MM-ddTHH:mm:ss").format(regesterSince);
    orderTabbyId = DateTime.now().millisecondsSinceEpoch.toString();
    print(DateTime.now().toIso8601String());
    final mockPayload = Payment(
      amount: cartController.cart!.total.toString(),
      currency: Currency.aed,
      buyer: Buyer(
        email: Global.customer!.email,
        phone: phone.text,
        name: firstname.text+" "+lastname.text,
      ),

      buyerHistory: BuyerHistory(
        loyaltyLevel: 0,
        registeredSince: regesterSinceFormated+"+04:00",
        wishlistCount: 0,
      ),
      shippingAddress: ShippingAddress(
        city: city.text,
        address: country.value+"/"+emirate.value+"/"+address.text+"/"+apartment.text,
        zip: '',
      ),
      order: Order(referenceId: orderTabbyId, items:
      cartController.cart!.cartList.map((element) => OrderItem(
          title: element.title,
          description: element.description,
          quantity: element.count,
          unitPrice: element.totalPrice.toStringAsFixed(2) ,
          referenceId: element.sku,
          productUrl: '',
          category: element.category,
          brand: element.brand,
          imageUrl:  element.image
      )).toList()
      ),

      orderHistory: tabbyList.map((element) => OrderHistoryItem(
          amount: element.total.toString(),
          purchasedAt:  DateFormat("yyyy-MM-ddTHH:mm:ss").format(element.date)+"+04:00",
          status: element.deliver == -1
              ?OrderHistoryItemStatus.canceled
              :element.deliver == 0?
                OrderHistoryItemStatus.processing:OrderHistoryItemStatus.complete
      )).toList(),
    );
    final session = await TabbySDK().createSession(TabbyCheckoutPayload(
      merchantCode: 'DJPP',
      lang: Global.lang_code=="en"?Lang.en:Lang.ar,
      payment: mockPayload,
    ));
  }
  lunch_order_tabby(BuildContext context)async{
    cashewLoading(true);
    try{
      var regesterSince = new DateTime.now();
      try{
        regesterSince = DateTime.parse(Global.customer!.created_at);
      }catch(e){
        regesterSince = new DateTime.now();
      }
      var now = new DateTime.now();
      var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
      var regesterSinceFormated = DateFormat("yyyy-MM-ddTHH:mm:ss").format(regesterSince);

      print(regesterSinceFormated);
      final mockPayload = Payment(
        amount: cartController.cart!.total.toString(),
        currency: Currency.aed,
        buyer: Buyer(
          // email: "id.card.success@tabby.ai",
          // email: "card.success@tabby.ai",
          // email: "rejected.ae@tabby.ai",

          email: Global.customer!.email,
          // phone: "500000001",
          phone: phone.text,
          name: firstname.text+" "+lastname.text,
        ),
        buyerHistory: BuyerHistory(
          loyaltyLevel: 0,
          registeredSince: regesterSinceFormated+"+04:00",
          wishlistCount: 0,
        ),
        shippingAddress: ShippingAddress(
          city: city.text,
          address: country.value+"/"+emirate.value+"/"+address.text+"/"+apartment.text,
          zip: '',
        ),
        order: Order(referenceId: orderTabbyId, items:
        cartController.cart!.cartList.map((element) => OrderItem(
            title: element.title,
            description: element.description,
            quantity: element.count,
            unitPrice: element.totalPrice.toStringAsFixed(2) ,
            referenceId: element.sku,
            productUrl: '',
            category: element.category,
            brand: element.brand,
            imageUrl:  element.image
        )).toList()
        ),
        orderHistory: tabbyList.map((element) => OrderHistoryItem(
            amount: element.total.toString(),
            purchasedAt: DateFormat("yyyy-MM-ddTHH:mm:ss").format(element.date)+"+04:00",
            status: element.deliver == -1
                ?OrderHistoryItemStatus.canceled
                :element.deliver == 0?
            OrderHistoryItemStatus.processing:OrderHistoryItemStatus.complete
        )).toList(),
      );
      final session = await TabbySDK().createSession(TabbyCheckoutPayload(
        merchantCode: 'DJPP',
        lang: Global.lang_code=="en"?Lang.en:Lang.ar,
        payment: mockPayload,
      ));
      TabbyWebView.showWebView(
        context: context,
        webUrl: session.availableProducts.installments!.webUrl,
        onResult: (WebViewResult resultCode) {
          print('*************** RESULT ***************');
          print(resultCode.name);
          cashewLoading(false);
          if(resultCode.name == "authorized"){
            add_order_tabby(context,orderTabbyId);
          }else if(resultCode.name == "close"){
            Get.back();
            // App.error_msg(context, App_Localization.of(context).translate("wrong"));
          }else{
            Get.back();
          }
        },
      );
    }catch(e){
      cashewLoading(false);
      App.error_msg(context, App_Localization.of(context).translate("tabby_rejection"));
      print(e);
      print('***************');
      e.printError();
    }
  }

  add_order_payment(BuildContext context){
    // cartController.get_total(min_amount_for_free: getMinValueForFree(emirate.value.toString()),
    //     shipping_amount: getShippingAmount(emirate.value.toString()));
    // add_order(firstname.value.text, lastname.value.text, address.text, apartment.text, city.text, country.value, emirate.value, phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value), double.parse(cartController.total.value), is_paid.value?1:0,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),"",cartController.discountCode == null?null:cartController.discountCode!.id,cartController.discountCode == null?null:cartController.discountCode!.code);
    placeOrder(Global.discountCode,"",myAddressController.address[selectedAddress.value].id,is_paid.value?1:0);
    Get.off(Accepted_order(cartController.cart!.total.toString(),cartController.cart!.subTotal.toString(),
        cartController.cart!.shipping.toString()));
    // cartController.clear_cart();
  }
  add_order_tabby(BuildContext context,String reference){
    placeOrder(Global.discountCode,reference,myAddressController.address[selectedAddress.value].id,-3);
    App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
    Get.offAll(()=>Home());

    // my_order.addAll(cartController.my_order.value);
    // get_details();
    // print(lineItems.length.toString()+"*-*-*-*-*-*");
    // add_order(firstname.text, lastname.text, address.text, apartment.text, city.text, country.value, emirate.value, phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), -3,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),reference,cartController.discountCode == null?null:cartController.discountCode!.id,cartController.discountCode == null?null:cartController.discountCode!.code);
    // cartController.clear_cart();

  }


  // add_order(String first,String last,String address,String apartment,String city,String country,String emirate,String phone,String details,double sub_total,double shipping, double total,int is_paid,List<LineItem> lineItems,String discount,String referance,int? discount_id,String? dicount_code){
  //   MyApi.add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount,referance,discount_id,dicount_code).then((succ) {
  //     if(!succ){
  //       add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount,referance,discount_id,dicount_code);
  //     }else{
  //       selected_operation.value = 0;
  //       address_err.value=false;
  //       my_order.value = <MyOrder>[];
  //       this.is_paid.value=false;
  //       selected.value=false;
  //       is_cod.value=false;
  //       cashewLoading.value=false;
  //       my_order.clear();
  //       cartController.clear_cart();
  //     }
  //   }).catchError((err){
  //     add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount,referance,discount_id,dicount_code);
  //   });
  // }

  placeOrder(String? discountCode,String reference,int addressId,int isPaid)async{
    try{
      bool succ = await ApiV2.placeOrder(discountCode, reference, addressId, isPaid);
      if(!succ){
        placeOrder(discountCode, reference, addressId, isPaid);
      }else{
        selected_operation.value = 0;
        selectedAddress.value = 0;
        address_err.value=false;
        this.is_paid.value=false;
        selected.value=false;
        is_cod.value=false;
        cashewLoading.value=false;
        cartController.getData(null);
        Store.save_discount_code("");
        Global.discountCode = "";
      }
    }catch(e){
      placeOrder(discountCode, reference, addressId, isPaid);
    }

  }

  // add_order_shopyfi(BuildContext context){
  //   cartController.get_total(min_amount_for_free: getMinValueForFree(emirate.value.toString()),
  //       shipping_amount: getShippingAmount(emirate.value.toString()));
  //   if(is_paid.value){
  //     // cartController.clear_cart();
  //     App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
  //   }else{
  //     add_order(firstname.value.text, lastname.value.text, address.text, apartment.text, city.text, country.value, emirate.value, phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value), double.parse(cartController.total.value), is_paid.value?1:0,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),"",cartController.discountCode == null?null:cartController.discountCode!.id,cartController.discountCode == null?null:cartController.discountCode!.code);
  //     // cartController.clear_cart();
  //     App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
  //   }
  // }


  String get_details(){
    String text="";
    // lineItems.clear();
    for(int i=0;i<cartController.cart!.cartList.length;i++){
      var elm = cartController.cart!.cartList[i];
      if(elm.count>0){
        // lineItems.add(LineItem(id: my_order[i].product.value.id, quantity: my_order[i].quantity.value));
        text+=elm.title+" X "+elm.count.toString()+"\n";
      }else{
        // my_order.removeAt(i);
      }
    }
    // for(int i=0;i<cartController.auto_discount.length;i++){
    //   if(cartController.auto_discount[i].quantity.value>0&&cartController.auto_discount[i].product.value.availability>0){
    //     lineItems.add(LineItem(id: cartController.auto_discount[i].product.value.id, quantity: cartController.auto_discount[i].quantity.value));
    //     text+=cartController.auto_discount[i].product.value.title+" X "+cartController.auto_discount[i].quantity.value.toString()+"\n";
    //   }else{
    //     cartController.auto_discount.removeAt(i);
    //   }
    // }
    return text;
  }



}