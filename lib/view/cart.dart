import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/model_v2/cart.dart';
import 'package:dayjour_version_3/view/checkout.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/wedgits/plz_signin_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Cart extends StatelessWidget {

  CartController cartController = Get.find();

  _cart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.cart!.cartList.length,
        itemBuilder: (context, index) {
          var elm = cartController.cart!.cartList[index];
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
                          image: NetworkImage(elm.image
                              .toString().replaceAll("localhost", "10.0.2.2")),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.62,
                      //height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cartController.deleteFromCart(elm.cartId,context);
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
                              elm.title,
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
                          cartController.cart!.discountCode != null&&
                              !elm.includeDiscount?
                          Text(App_Localization.of(context).translate("this_product_illegal"),style: const TextStyle(color: Colors.red,fontSize: 12),):Center(),

                          // cartController.discountCode != null&&
                          // cartController.amountOfCanDiscount > cartController.discountCode!.minimumQuantity&&
                          // double.parse(cartController.my_order[index].discount.value)> 0?
                          // Text(App_Localization.of(context).translate("you_saved")
                          //     +" "+cartController.my_order[index].discount.value+" "+App_Localization.of(context).translate("aed")+" "
                          //     +App_Localization.of(context).translate("on_this_item"),style: const TextStyle(color: Colors.green,fontSize: 12),):Center(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10,top: 5,bottom: 15),
                                child:
                                elm.availability==0?
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
                                :elm.isAutoDiscount?Container(
                                  height: 34,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: AppColors.main2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(elm.count.toString()+" X "+App_Localization.of(context).translate("free"),style: TextStyle(color: Colors.white),),
                                  ),
                                ):
                                Container(
                                  height: 34,
                                  width: 135,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            cartController.addOrUpdateCart(
                                                elm.productId,elm.optionId,-1,context);
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            size: 20,
                                          )),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            _showCounterPicker(elm,context);
                                          },
                                          child: Container(
                                            color: App.main2,
                                            child: Center(
                                              child: Text(
                                                elm.count.toString(),
                                                style: TextStyle(fontSize: 15,color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            cartController.addOrUpdateCart(
                                                elm.productId,elm.optionId,1,context);
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 20,
                                          )),

                                    ],
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

  void _showCounterPicker(CartItem cartItem,BuildContext context) {
    int selectedValue = cartItem.count;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 320,
        // color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                color: Colors.white,
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      // Top bar with Done button

                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: FixedExtentScrollController(initialItem: selectedValue-1),
                          onSelectedItemChanged: (int value) {
                            // setState(() {
                            //
                            // });
                            selectedValue = value+1;
                          },
                          children: List<Widget>.from(
                            List.generate(
                              cartItem.availability,
                                  (index) => index + 1, // generates 1..availability
                            ).map((number) => Center(
                              child: Text(
                                "$number",
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          cartController.addOrUpdateCart(cartItem.productId,
                              cartItem.optionId, selectedValue-cartItem.count, context);
                          Get.back();
                        },
                        child: Container(
                          width: Get.width*0.9,
                          height: 50,
                          decoration: BoxDecoration(
                              color: App.main2,
                              borderRadius: BorderRadius.circular(25)
                          ),

                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline,color: Colors.white,),
                              SizedBox(width: 5,),
                              Text(
                                App_Localization.of(context).translate("submit"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 10,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colors.black)
                        // boxShadow: [
                        //   App.softShadow
                        // ]
                    ),
                    child: Icon(Icons.close,color: Colors.black,size: 30,)),
              ),
            )
          ],
        ),
      ),
    );
  }
  _price(BuildContext context , int index){
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text( cartController.cart!.cartList[index].totalPrice.toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
        style: TextStyle(
            color: AppColors.main2,
            fontSize: 16,
            fontWeight:
            FontWeight.bold),
      ),
    );

    //   double.parse(cartController.my_order[index].discount.value)>0&&
    //     cartController.canDiscountCode.value?
    // Container(
    //   width: MediaQuery.of(context).size.width * 0.6,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text( (double.parse(cartController.my_order[index].price.value)-double.parse(cartController.my_order[index].discount.value)).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
    //         style: TextStyle(
    //             color: AppColors.main2,
    //             fontSize: 16,
    //             fontWeight:
    //             FontWeight.bold),
    //       ),
    //       Text( double.parse(cartController.my_order[index].price.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
    //         style: TextStyle(
    //             color: Colors.black26,
    //             decoration: TextDecoration.lineThrough,
    //             decorationColor: AppColors.main2,
    //             decorationStyle: TextDecorationStyle.solid,
    //             decorationThickness: 1.5,
    //             fontSize: 16,
    //             fontWeight:
    //             FontWeight.bold),
    //       ),
    //
    //     ],
    //   ),
    // )
    //     :Container(
    //   width: MediaQuery.of(context).size.width * 0.6,
    //   child: Text( double.parse(cartController.my_order[index].price.value).toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
    //     style: TextStyle(
    //         color: AppColors.main2,
    //         fontSize: 16,
    //         fontWeight:
    //         FontWeight.bold),
    //   ),
    // );
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
        _sub_totals(context),
        const SizedBox(height: 20),
        _shipping(context),
        const SizedBox(height: 20),
        _tax(context),
        const SizedBox(height: 20),
        cartController.cart!.coupon>0?_coupon(context):Center(),
        cartController.cart!.coupon>0?const SizedBox(height: 20):Center(),
        cartController.cart!.discount>0?_discount(context):Center(),
        cartController.cart!.discount>0?const SizedBox(height: 20):Center(),
        _totals(context),
        cartController.cart!.discountCode != null&&cartController.cart!.discountErrorMsg.length > 0?
        cartController.cart!.discountErrorMsg == "you_did_not_reach_min_amount"?
        Text(
          App_Localization.of(context).translate("you_did_not_reach_min_amount")+" "+
              cartController.cart!.discountCode!.minimumQuantity.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: App.textNormal(Colors.red, 14),overflow: TextOverflow.clip,) :
        Text(cartController.cart!.discountErrorMsg ,style: App.textNormal(Colors.red, 14),overflow: TextOverflow.clip,):const Center(),
        const SizedBox(height: 20),
        Container(
          width: Get.width * 0.85,
          child: TabbyPresentationSnippet(
            price: cartController.cart!.total.toString(),
            currency: Currency.aed,
            lang: Global.lang_code == "en"?Lang.en:Lang.ar,
          ),
        ),
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

  _discount(BuildContext context) {
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
            cartController.cart!.discount.toStringAsFixed(2) + " %",
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

  _coupon(BuildContext context) {
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
            cartController.cart!.coupon.toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
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

  _sub_totals(BuildContext context) {
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
           cartController.cart!.subTotal.toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
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

  _totals(BuildContext context) {
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
            cartController.cart!.total.toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed"),
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

  _shipping(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("Shipping_will_be_calculated_at_checkout"),style: TextStyle(
            color: Colors.black,
            fontSize: 13,
          fontWeight: FontWeight.bold
        ),)
          // Text(
          //   App_Localization.of(context).translate("shipping"),
          //   style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 13,
          //     fontWeight: FontWeight.bold
          //   ),
          // ),
          // SizedBox(width: 10),
          // Flexible(
          //   child: Container(
          //     child: LayoutBuilder(
          //       builder: (BuildContext context,
          //           BoxConstraints constraints) {
          //         final boxWidth = constraints.constrainWidth();
          //         final dashWidth = 4.0;
          //         final dashHeight = 2.0;
          //         final dashCount =
          //         (boxWidth / (2 * dashWidth)).floor();
          //         return Flex(
          //           children: List.generate(dashCount, (_) {
          //             return SizedBox(
          //               width: dashWidth,
          //               height: dashHeight,
          //               child: const DecoratedBox(
          //                 decoration:
          //                 BoxDecoration(color: Colors.grey),
          //               ),
          //             );
          //           }),
          //           mainAxisAlignment:
          //           MainAxisAlignment.spaceBetween,
          //           direction: Axis.horizontal,
          //         );
          //       },
          //     ),
          //   ),
          // ),
          // SizedBox(width: 10),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(
          //       cartController.shipping.value+ " "+App_Localization.of(context).translate("aed"),
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 13
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  _tax(BuildContext context) {
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
                cartController.cart!.tax.toStringAsFixed(2)+ " "+App_Localization.of(context).translate("aed"),
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

  _checkout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.06,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.main2,
        onPressed: () {
          if(cartController.cart!.cartList.isEmpty) {
            return showTopSnackBar(
              Overlay.of(context),
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
              color: Colors.white,
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

  _cart_info(BuildContext context){
    return Column(
      children: [
        // _autoDiscountList(context),
        _cart(context),
        _total_amount(context),
        _checkout(context),
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
                    cartController.loading.value?Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      color: AppColors.main.withOpacity(0.6),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.main2,),
                      ),
                    ):
                    Global.customer == null?PlzSigninSignup():
                    cartController.cart == null || cartController.cart!.cartList.isEmpty ?
                    _emptyMessage(context) : _cart_info(context),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            // Positioned(child: cartController.loading.value?Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   color: AppColors.main.withOpacity(0.6),
            //   child: Center(
            //     child: CircularProgressIndicator(color: AppColors.main2,),
            //   ),
            // ):Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 0,
            //   color: AppColors.main,
            // ))
          ],
        ))
      ),
    );
  }
}
