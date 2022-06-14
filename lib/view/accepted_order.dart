// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/checkout_controller.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Accepted_order extends StatefulWidget {
  String total;
  String sub_total;
  String shipping;


  Accepted_order(this.total, this.sub_total, this.shipping);

  @override
  _Accepted_orderState createState() => _Accepted_orderState(this.total, this.sub_total, this.shipping);
}

class _Accepted_orderState extends State<Accepted_order> {

  String total;
  String sub_total;
  String shipping;


  _Accepted_orderState(this.total, this.sub_total, this.shipping);

  CheckoutController checkoutController = Get.find();
  HomeController homeController = Get.put(HomeController());


  _bar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10 , right: 10, top: 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>Home());
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/introduction/logo.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _footer() {
    return GestureDetector(
      onTap: () {
        homeController.selected_bottom_nav_bar.value = 0;
        Get.off(Home());
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 55,
        decoration: BoxDecoration(
            color: AppColors.main2,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              App_Localization.of(context).translate("done"),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ],
        )
      ),
    );
  }
  _body(){
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: CircleAvatar(
                child: SvgPicture.asset('assets/icons/accept_order.svg',
                    width: MediaQuery.of(context).size.width * 0.55),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(App_Localization.of(context).translate("order_accepted"),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
        const SizedBox(height: 50),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _bar(),
              const SizedBox(height: 40),
              _body(),
              Container(
                width: MediaQuery.of(context).size.width*0.8,

                child:  Column(
                  children: [
                    Row(
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
                          sub_total.toString() + " "+App_Localization.of(context).translate("aed"),
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
                          shipping.toString() + " "+App_Localization.of(context).translate("aed"),
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
                          total.toString() + " "+App_Localization.of(context).translate("aed"),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }
}
