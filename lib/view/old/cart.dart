
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/view/checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Cart extends StatefulWidget {

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  CartController cartController = Get.find();

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
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(cartController
                              .my_order[index].product.value.image == null
                              ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                              : cartController
                              .my_order[index].product.value.image
                              .toString().replaceAll("localhost", "10.0.2.2")),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.62,
                      height: MediaQuery.of(context).size.height * 0.3,
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
                                    Icons.close,
                                    color: Colors.black,
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
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                          SizedBox(height: 7),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              cartController.my_order[index].price.value + " AED",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10,top: 5),
                                child: Container(
                                  height: 38,
                                  width: MediaQuery.of(context).size.width * 0.4,
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
                                              cartController.increase(cartController.my_order[index], index);
                                            },
                                            icon: Icon(
                                              Icons.add,
                                            )),
                                        Text(
                                          cartController.my_order[index].quantity.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cartController.decrease(cartController.my_order[index], index);
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
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
        const SizedBox(height: 60),
      ],
    );
  }
  _sub_totals() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                App_Localization.of(context).translate("sub_totals"),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 11
                ),
              )
            ],
          ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
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
                        BoxDecoration(color: Colors.black45),
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
       Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                cartController.sub_total.value.toString() + " AED",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11
                ),
              )
            ],
          ),
      ],
    );
  }
  _shipping() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              App_Localization.of(context).translate("shipping"),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 11
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
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
                      BoxDecoration(color: Colors.black45),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "10.00 AED",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11
              ),
            )
          ],
        ),
      ],
    );
  }
  _checkout() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: Row(
                    children: [
                      Text(
                        App_Localization.of(context).translate("cart"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _cart(context),
                _total_amount(context),
                _checkout(),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ))
      ),
    );
  }
}
