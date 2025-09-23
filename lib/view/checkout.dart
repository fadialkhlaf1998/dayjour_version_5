import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/checkout_controller.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/view/add_edit_address.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/my_fatoraah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Checkout extends StatelessWidget {
  Checkout() {
    // checkoutController.lunch_session();
    getData();
  }

  getData() async {
    await checkoutController.myAddressController.getData();
    getShippingDataForSelectedAddress();
  }

  getShippingDataForSelectedAddress() {
    if (checkoutController.myAddressController.address.length > 0) {
      checkoutController.cartController.getData(checkoutController
          .myAddressController
          .address[checkoutController.selectedAddress.value]
          .id);
    } else {
      checkoutController.cartController.getData(null);
    }
  }

  CheckoutController checkoutController = Get.put(CheckoutController());

  CartController cartController = Get.find();

  HomeController homeController = Get.find();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () {
        if (checkoutController.selected_operation.value == 0) {
          Get.back();
        } else if (checkoutController.selected_operation.value == 1 &&
            checkoutController.selected.value) {
          checkoutController.selected.value = false;
          // checkoutController.selected_operation.value --;
        } else {
          checkoutController.selected.value = false;
          checkoutController.selected_operation.value--;
        }
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: AppColors.main2,
          key: _key,
          body: Obx(() {
            return SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.main,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _bar(context),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        child: Row(
                          children: [
                            Text(
                              App_Localization.of(context)
                                  .translate("checkout"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // checkoutController.selected_operation.value == 3 ? _accepted() :
                      _header(context),
                      checkoutController.selected_operation.value == 0
                          ? _checkout_body(context)
                          : checkoutController.selected_operation.value == 1
                              ? _payment_body(context)
                              : checkoutController.selected_operation.value == 2
                                  ? _summary_body(context)
                                  : Center(),
                      const SizedBox(height: 20),
                      checkoutController.selected_operation.value == 1
                          ? Center()
                          : _footer(context),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }

  _bar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (checkoutController.selected_operation.value == 0) {
                      Get.back();
                    } else if (checkoutController.selected_operation.value ==
                            1 &&
                        checkoutController.selected.value) {
                      checkoutController.selected.value = false;
                      // checkoutController.selected_operation.value --;
                    } else {
                      checkoutController.selected.value = false;
                      checkoutController.selected_operation.value--;
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    homeController.selected_bottom_nav_bar.value = 0;
                    Get.off(() => Home());
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/introduction/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.main2,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.32,
            child: Divider(
              thickness: 1.5,
              color: Colors.black45,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: checkoutController.selected_operation.value >= 1
                  ? AppColors.main2
                  : Colors.white,
              border: Border.all(
                  color: checkoutController.selected_operation.value >= 1
                      ? Colors.transparent
                      : Colors.black45,
                  width: 1.5),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.32,
            child: Divider(
              thickness: 1.5,
              color: Colors.black45,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: checkoutController.selected_operation.value == 2
                  ? AppColors.main2
                  : Colors.white,
              border: Border.all(
                  color: checkoutController.selected_operation.value == 2
                      ? Colors.transparent
                      : Colors.black45,
                  width: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  _footer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        checkoutController.next(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 55,
        decoration: BoxDecoration(
            color: AppColors.main2, borderRadius: BorderRadius.circular(30)),
        child: checkoutController.selected_operation.value == 3
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    App_Localization.of(context).translate("track_order"),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        checkoutController.selected_operation.value == 0
                            ? App_Localization.of(context)
                                .translate("continue_to_payment_main")
                            : App_Localization.of(context)
                                .translate("continue_to_payment"),
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }

  _checkout_body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("address"),
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("payments"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value == 1
                            ? Colors.black
                            : Colors.black45,
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("summary"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value == 2
                            ? Colors.black
                            : Colors.black45,
                      ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 40),
        Obx(() => checkoutController.myAddressController.loading.value
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(color: App.main2,),
                ),
              )
            : Container(
                height: Get.height*0.45,
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: 70,
                      child: checkoutController.cartController.loading.value
                          ? Center(
                              child: LinearProgressIndicator(color: App.main2),
                            )
                          : Center(
                              child: checkoutController
                                      .myAddressController.address.isEmpty
                                  ? Text(App_Localization.of(context).translate(
                                      "there_is_no_address_plz_add_address"))
                                  : (Text(
                                      App_Localization.of(context)
                                              .translate("shipping_is") +
                                          " " +
                                          (checkoutController.cartController
                                                      .cart!.shipping ==
                                                  0
                                              ? App_Localization.of(context)
                                                  .translate("free")
                                              : (checkoutController
                                                      .cartController
                                                      .cart!
                                                      .shipping
                                                      .toStringAsFixed(2) +
                                                  " AED")),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                            ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: checkoutController
                            .myAddressController.address.length,
                        itemBuilder: (context, index) {
                          var address = checkoutController
                              .myAddressController.address[index];
                          return Obx(() => GestureDetector(
                                onTap: () async {
                                  checkoutController.selectedAddress(index);
                                  getShippingDataForSelectedAddress();
                                },
                                child: Card(
                                  elevation: 4, // shadow
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: 13,
                                                  height: 13,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: checkoutController
                                                                .selectedAddress
                                                                .value ==
                                                            index
                                                        ? App.main2
                                                        : Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              address.nickName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(App_Localization.of(
                                                          context)
                                                      .translate("edit")),
                                                ],
                                              ),
                                              onTap: () {
                                                Get.to(() => AddEditAddress(
                                                        address))!
                                                    .then((val) async {
                                                  await checkoutController
                                                      .myAddressController
                                                      .getData();
                                                  getShippingDataForSelectedAddress();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Container(
                                          width: Get.width,
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  App_Localization.of(context)
                                                      .translate("name"),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(address.first_name +
                                                    " " +
                                                    address.last_name)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  App_Localization.of(context)
                                                      .translate("address"),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(address.emirate +
                                                    " - " +
                                                    address.city +
                                                    " - " +
                                                    address.address +
                                                    " - " +
                                                    address.apartment)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  App_Localization.of(context)
                                                      .translate("phone"),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Text(address.phone)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(AddEditAddress(null))!.then((val) async {
                          await checkoutController.myAddressController
                              .getData();
                          getShippingDataForSelectedAddress();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: App.main2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            App_Localization.of(context)
                                .translate("add_new_address"),
                            style: TextStyle(color: App.main2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
      ],
    );
  }

  _payment_body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("address"),
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("payments"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value == 1
                            ? Colors.black
                            : Colors.black45,
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("summary"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value == 2
                            ? Colors.black
                            : Colors.black45,
                      ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        _payment(context)
      ],
    );
  }

  _summary_body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("address"),
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("payments"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value >= 1
                            ? Colors.black
                            : Colors.black45,
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(App_Localization.of(context).translate("summary"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value == 2
                            ? Colors.black
                            : Colors.black45,
                      ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            children: [
              Text(
                App_Localization.of(context).translate("summary"),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    App_Localization.of(context).translate("sub_totals"),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Container(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
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
                                  decoration: BoxDecoration(color: Colors.grey),
                                ),
                              );
                            }),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    cartController.cart!.subTotal.toString() +
                        " " +
                        App_Localization.of(context).translate("aed"),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    App_Localization.of(context).translate("shipping"),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Container(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
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
                                  decoration: BoxDecoration(color: Colors.grey),
                                ),
                              );
                            }),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    cartController.cart!.shipping.toString() +
                        " " +
                        App_Localization.of(context).translate("aed"),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    App_Localization.of(context).translate("total"),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Container(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
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
                                  decoration: BoxDecoration(color: Colors.grey),
                                ),
                              );
                            }),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    cartController.cart!.total.toString() +
                        " " +
                        App_Localization.of(context).translate("aed"),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: EdgeInsets.only(right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.32,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cartController.cart!.cartList.length,
              itemBuilder: (context, index) {
                var elm = cartController.cart!.cartList[index];
                return Row(
                  children: [
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(elm.image.toString()),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                elm.title.toString(),
                                //overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                elm.totalPrice.toStringAsFixed(2) +
                                    " " +
                                    App_Localization.of(context)
                                        .translate("aed"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.main2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
        Divider(
          color: Colors.black38,
          indent: 8,
          endIndent: 8,
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.92,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         App_Localization.of(context)!.translate("shipping_address"),
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold
        //         ),),
        //       Checkbox(
        //         shape: CircleBorder(),
        //         value: checkoutController.shipping_address.value,
        //         activeColor: AppColors.main2,
        //         checkColor: Colors.white,
        //         onChanged: (newValue) {},
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 10),
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.92,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         width: MediaQuery.of(context).size.width * 0.92,
        //         child: Text("12, Bay brook, Sharps Rd, Keilor East, Melbourne, Australia",
        //           style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 18),),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 80),
      ],
    );
  }

  _payment(BuildContext context) {
    return !checkoutController.selected.value
        ? Container(
            height: MediaQuery.of(context).size.height * 0.7 -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    // App.box_shadow()
                  ]),
                  child: ListTile(
                    onTap: () {
                      // checkoutController.my_order.clear();
                      // checkoutController.my_order.addAll(cartController.my_order);
                      checkoutController.selected.value = true;
                      checkoutController.is_paid.value = false;
                      checkoutController.is_cod.value = true;
                      checkoutController.next(context);
                    },
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.main2,
                    ),
                    title: Text(App_Localization.of(context).translate("cod")),
                    subtitle:
                        Text(App_Localization.of(context).translate("cash")),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // boxShadow: [
                    //
                    // ]
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Icon(Icons.credit_card, color: Colors.white),
                        backgroundColor: AppColors.main2),
                    onTap: () {
                      checkoutController.selected.value = true;
                      checkoutController.is_cod.value = false;
                    },
                    title:
                        Text(App_Localization.of(context).translate("payment")),
                    subtitle:
                        Text(App_Localization.of(context).translate("c_card")),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                cartController.cart!.total >= 10 &&
                        cartController.cart!.total <= 4000
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // boxShadow: [
                          //
                          // ]
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Icon(Icons.payments_outlined,
                                  color: Colors.white),
                              backgroundColor: AppColors.main2),
                          onTap: () {
                            checkoutController.lunch_order_tabby(context);
                          },
                          title: Row(
                            children: [
                              Container(
                                width: 57,
                                height: 25,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/icons/tabby.png",
                                        ),
                                        fit: BoxFit.contain)),
                              ),
                            ],
                          ),
                          subtitle: Text(App_Localization.of(context)
                              .translate("tabby_promotion")),
                        ),
                      )
                    : Center(),
              ],
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.65 -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: MyFatoraahPage(
                "title", cartController.cart!.total.toStringAsFixed(2)),
          );
  }
}
