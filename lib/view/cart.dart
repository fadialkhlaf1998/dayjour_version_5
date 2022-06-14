import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/view/checkout.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Cart extends StatefulWidget {

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  CartController cartController = Get.find();


  _CartState(){
    cartController.get_total();
    if(cartController.discountCode!=null){
      cartController.discountCodeController.text = cartController.discountCode!.code;
    }
  }

  _autoDiscountList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.auto_discount.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(cartController
                              .auto_discount[index].product.value.image
                              .toString().replaceAll("localhost", "10.0.2.2")),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.62,
                      //height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //cartController.remove_from_cart(cartController.auto_discount[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5,top: 5),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.transparent,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 4,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              cartController.auto_discount[index].product.value.title.toString(),
                              style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                          SizedBox(height: 7),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(double.parse(cartController.auto_discount[index].price.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 16,
                                  // decoration: TextDecoration.lineThrough,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.main2,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationThickness: 1.5,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10,top: 5,bottom: 15),
                                child:
                                cartController.auto_discount[index].product.value.availability==0?
                                Container(
                                  height: 34,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.all(color: App.main2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(App_Localization.of(context).translate("out_stock"),style: TextStyle(color: App.main2,fontSize: 12),),
                                  ),
                                )
                                    :Container(
                                  height: 34,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: AppColors.main2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(cartController.auto_discount[index].quantity.value.toString()+" X "+App_Localization.of(context).translate("free"),style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
          //return _cart_item(context, index);
        },
      ),
    );
  }
  _cart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.my_order.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
               // height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(cartController
                              .my_order[index].product.value.image
                              .toString().replaceAll("localhost", "10.0.2.2")),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.62,
                      //height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cartController.remove_from_cart(cartController.my_order[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5,top: 5),
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.main2,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 4,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              cartController.my_order[index].product.value.title.toString(),
                              style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                          SizedBox(height: 7),
                          _price(context, index),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10,top: 5,bottom: 15),
                                child:
                                cartController.my_order[index].product.value.availability==0?
                                Container(
                                  height: 34,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.all(color: App.main2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(App_Localization.of(context).translate("out_stock"),style: TextStyle(color: App.main2,fontSize: 12),),
                                  ),
                                )
                                :Container(
                                  height: 34,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              cartController.decrease(cartController.my_order[index], index);
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              size: 20,
                                            )),
                                        Text(
                                          cartController.my_order[index].quantity.toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cartController.increase(cartController.my_order[index], index);
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 20,
                                            )),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
          //return _cart_item(context, index);
        },
      ),
    );
  }
  _price(BuildContext context , int index){
    return double.parse(cartController.my_order[index].discount.value)>0&&
        cartController.canDiscountCode.value?
    Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( (double.parse(cartController.my_order[index].price.value)-double.parse(cartController.my_order[index].discount.value)).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
            style: TextStyle(
                color: AppColors.main2,
                fontSize: 16,
                fontWeight:
                FontWeight.bold),
          ),
          Text( double.parse(cartController.my_order[index].price.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
            style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.main2,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 1.5,
                fontSize: 16,
                fontWeight:
                FontWeight.bold),
          ),

        ],
      ),
    )
        :Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text( double.parse(cartController.my_order[index].price.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
        style: TextStyle(
            color: AppColors.main2,
            fontSize: 16,
            fontWeight:
            FontWeight.bold),
      ),
    );
  }
  _total_amount(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            children: [
              Text(
                App_Localization.of(context).translate("totals_amount"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sub_totals(),
        const SizedBox(height: 20),
        _shipping(),
        const SizedBox(height: 20),
        _tax(),
        const SizedBox(height: 20),
        double.parse(cartController.coupon.value)>0&&cartController.canDiscountCode.value?_coupon():Center(),
        double.parse(cartController.coupon.value)>0&&cartController.canDiscountCode.value?const SizedBox(height: 20):Center(),
        double.parse(cartController.discount.value)>0&&cartController.canDiscountCode.value?_discount():Center(),
        double.parse(cartController.discount.value)>0&&cartController.canDiscountCode.value?const SizedBox(height: 20):Center(),
        _totals(),
        SizedBox(height: 20,),
        activateDicountCode(context),
        const SizedBox(height: 60),
      ],
    );
  }
  activateDicountCode(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.92,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.92-70,
            child: TextField(
              controller: cartController.discountCodeController,
              decoration: InputDecoration(
                label: Text(App_Localization.of(context).translate("discount_code")),
                labelStyle: TextStyle(color: App.main2),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1,color: AppColors.main2)
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              cartController.apply(context);
            },
            child: Container(
              width: 70,
              child: Center(
                child: Text(App_Localization.of(context).translate("apply"),style: TextStyle(color: AppColors.main2),),
              ),
            ),
          )
        ],
      ),
    );
  }
  _discount() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            App_Localization.of(context).translate("discount"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  final dashWidth = 4.0;
                  final dashHeight = 2.0;
                  final dashCount =
                  (boxWidth / (2 * dashWidth)).floor();
                  return Flex(
                    children: List.generate(dashCount, (_) {
                      return SizedBox(
                        width: dashWidth,
                        height: dashHeight,
                        child: const DecoratedBox(
                          decoration:
                          BoxDecoration(color: Colors.grey),
                        ),
                      );
                    }),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            double.parse(cartController.discount.value).toStringAsFixed(2) + " %",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  _coupon() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            App_Localization.of(context).translate("coupon"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  final dashWidth = 4.0;
                  final dashHeight = 2.0;
                  final dashCount =
                  (boxWidth / (2 * dashWidth)).floor();
                  return Flex(
                    children: List.generate(dashCount, (_) {
                      return SizedBox(
                        width: dashWidth,
                        height: dashHeight,
                        child: const DecoratedBox(
                          decoration:
                          BoxDecoration(color: Colors.grey),
                        ),
                      );
                    }),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            double.parse(cartController.coupon.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  _sub_totals() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            App_Localization.of(context).translate("sub_totals"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    final dashWidth = 4.0;
                    final dashHeight = 2.0;
                    final dashCount =
                    (boxWidth / (2 * dashWidth)).floor();
                    return Flex(
                      children: List.generate(dashCount, (_) {
                        return SizedBox(
                          width: dashWidth,
                          height: dashHeight,
                          child: const DecoratedBox(
                            decoration:
                            BoxDecoration(color: Colors.grey),
                          ),
                        );
                      }),
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                    );
                  },
                ),
            ),
          ),
          SizedBox(width: 10),
         Text(
           double.parse(cartController.sub_total.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
           style: TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
               fontSize: 13,
           ),
         ),
        ],
      ),
    );
  }
  _totals() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            App_Localization.of(context).translate("total"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  final dashWidth = 4.0;
                  final dashHeight = 2.0;
                  final dashCount =
                  (boxWidth / (2 * dashWidth)).floor();
                  return Flex(
                    children: List.generate(dashCount, (_) {
                      return SizedBox(
                        width: dashWidth,
                        height: dashHeight,
                        child: const DecoratedBox(
                          decoration:
                          BoxDecoration(color: Colors.grey),
                        ),
                      );
                    }),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            double.parse(cartController.total.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
  _shipping() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            App_Localization.of(context).translate("shipping"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  final dashWidth = 4.0;
                  final dashHeight = 2.0;
                  final dashCount =
                  (boxWidth / (2 * dashWidth)).floor();
                  return Flex(
                    children: List.generate(dashCount, (_) {
                      return SizedBox(
                        width: dashWidth,
                        height: dashHeight,
                        child: const DecoratedBox(
                          decoration:
                          BoxDecoration(color: Colors.grey),
                        ),
                      );
                    }),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                cartController.shipping.value+ " "+App_Localization.of(context).translate("aed"),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  _tax() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            App_Localization.of(context).translate("tax")+" "+
            App_Localization.of(context).translate("included"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  final dashWidth = 4.0;
                  final dashHeight = 2.0;
                  final dashCount =
                  (boxWidth / (2 * dashWidth)).floor();
                  return Flex(
                    children: List.generate(dashCount, (_) {
                      return SizedBox(
                        width: dashWidth,
                        height: dashHeight,
                        child: const DecoratedBox(
                          decoration:
                          BoxDecoration(color: Colors.grey),
                        ),
                      );
                    }),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                double.parse(cartController.tax.value).toStringAsFixed(2)+ " "+App_Localization.of(context).translate("aed"),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  _checkout() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.06,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.main2,
        onPressed: () {
          if(cartController.my_order.isEmpty) {
            return showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: App_Localization.of(context).translate("empty_cart"),
              ),
            );
          }
          else  if(Global.customer == null){
            // App.error_msg(context, App_Localization.of(context).translate("please_login_first"));
            Get.to(SignIn());
          }
          else {
            Get.to(() => Checkout());
          }
        },
        label:  Text(
          App_Localization.of(context).translate("check_out"),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
        ),
      ),
    );
  }
  _emptyMessage(context){
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      //height: MediaQuery.of(context).size.height / 8,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Icon(Icons.remove_shopping_cart, color: AppColors.main2,size: 30,),
              SizedBox(height: 10),
              Text(App_Localization.of(context).translate('dont_have_product'), style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 3),
              Text(App_Localization.of(context).translate('cart_no_data'), style: TextStyle(color: Colors.grey,fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ],
          )
      ),
    );
  }
  _cart_info(){
    return Column(
      children: [
        _autoDiscountList(context),
        _cart(context),
        _total_amount(context),
        _checkout(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
        child: Obx(() => Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      child: Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("cart"),
                            style: TextStyle(
                              color: AppColors.main2,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    cartController.my_order.isEmpty ?
                    _emptyMessage(context) : _cart_info(),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            Positioned(child: cartController.loading.value?Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main.withOpacity(0.6),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.main2,),
              ),
            ):Container(
              width: MediaQuery.of(context).size.width,
              height: 0,
              color: AppColors.main,
            ))
          ],
        ))
      ),
    );
  }
}
