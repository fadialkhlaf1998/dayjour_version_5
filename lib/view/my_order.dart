import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/my_order_controller.dart';
import 'package:dayjour_version_3/controler/products_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/customer_order.dart';
import 'package:dayjour_version_3/my_model/my_order.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyOrderView extends StatefulWidget {

  List<CustomerOrder> my_orders = <CustomerOrder>[];
  MyOrderController myOrderController = Get.put(MyOrderController());

  MyOrderView(this.my_orders){
    myOrderController.my_order.value=my_orders;
  }

  @override
  State<MyOrderView> createState() => _MyOrderViewState(my_orders);
}

class _MyOrderViewState extends State<MyOrderView> {


  var open = false.obs;
  _MyOrderViewState(my_orders);

  MyOrderController myOrderController = Get.put(MyOrderController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: AppColors.main2,
      body: SafeArea(
          child: Column(
        children: [
          _header(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom+MediaQuery.of(context).padding.top+ MediaQuery.of(context).size.height * 0.09),
            color: AppColors.main,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _body1(context)
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10,left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      App_Localization.of(context)
                          .translate("my_orders"),
                      style: App.textBlod(Colors.white, 16),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10,left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/introduction/logo.png"),
                          fit: BoxFit.cover,
                        ),
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

  _body(BuildContext context) {
    return   myOrderController.my_order.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      color: App.main2,
                      size: 50,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  App_Localization.of(context)
                      .translate("no_products_with_this_name"),
                  style: TextStyle(
                      color: AppColors.main2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : Container(
            color: AppColors.main,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: myOrderController.my_order.length,
                      itemBuilder: (context, index) {
                        return _item(myOrderController.my_order[index], context, index);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }

  _item(CustomerOrder customerOrder, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: GestureDetector(
        onTap: () {
          //todo go to product
          // productsController.go_to_product(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(1, 6), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: App_Localization.of(context)
                                          .translate("name") +
                                      ": ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.main2)),
                              TextSpan(
                                  text: customerOrder.firstname.toString() +
                                      " " +
                                      customerOrder.lastname.toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: App_Localization.of(context)
                                      .translate("phone") +
                                  ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.main2)),
                          TextSpan(
                              text: customerOrder.phone.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: App_Localization.of(context)
                                      .translate("address") +
                                  ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.main2)),
                          TextSpan(
                              text: customerOrder.address.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: App_Localization.of(context)
                                      .translate("sub_totals") +
                                  ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.main2)),
                          TextSpan(
                              text: customerOrder.subTotal.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: App_Localization.of(context)
                                      .translate("shipping") +
                                  ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.main2)),
                          TextSpan(
                              text: customerOrder.shipping.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: App_Localization.of(context)
                                      .translate("details") +
                                  ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.main2)),
                          TextSpan(
                              text: customerOrder.details.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _body1(BuildContext context) {
    return myOrderController.my_order.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      color: App.main2,
                      size: 50,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  App_Localization.of(context)
                      .translate("no_products_with_this_name"),
                  style: TextStyle(
                      color: AppColors.main2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : Container(
            color: AppColors.main,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: myOrderController.my_order.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  for(int i = 0; i < myOrderController.my_order.length; i++){
                                    if(myOrderController.my_order[i] != myOrderController.my_order[index]){
                                      myOrderController.my_order[i].openCard.value = false;
                                    }
                                  }
                                  setState(() {
                                    myOrderController.my_order[index].openCard.value= !myOrderController.my_order[index].openCard.value;
                                  });
                                  print(myOrderController.my_order[index].openCard.value);
                                  print('***');
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeInOutBack,
                                  width: MediaQuery.of(context).size.width - 50,
                                  height: myOrderController.my_order[index].openCard.value ?
                                  300 :
                                  120,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 4,
                                          blurRadius: 7,
                                          offset: Offset(0, 5), // changes position of shadow
                                        ),
                                      ],
                                    borderRadius: BorderRadius.circular(10),
                                   color: AppColors.main2,
                                      /*image: DecorationImage(
                                          colorFilter: ColorFilter.mode(AppColors.main2.withOpacity(0.8), BlendMode.overlay),
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/cardBackground.jpg'
                                          )
                                      )*/
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          //color: Colors.white.withOpacity(0.),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        physics: myOrderController.my_order[index].openCard.value ? null : NeverScrollableScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 6,left: 6),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 100),
                                                  Flexible(child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: App_Localization.of(context)
                                                                    .translate("name") +
                                                                    ": ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 15,
                                                                    color: Colors.white)),
                                                            TextSpan(

                                                                text: myOrderController.my_order[index].firstname.toString() +
                                                                    " " +
                                                                    myOrderController.my_order[index].lastname.toString(),
                                                                style: TextStyle(
                                                                    fontSize: 15, color: Colors.white)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: App_Localization.of(context)
                                                                    .translate("shipping") +
                                                                    ": ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 15,
                                                                    color: Colors.white)),
                                                            TextSpan(
                                                                text: myOrderController.my_order[index].shipping.toString(),
                                                                style:
                                                                TextStyle(fontSize: 15, color: Colors.white)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),),
                                                  SizedBox(width: 40),
                                                  Flexible(child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: App_Localization.of(context)
                                                                    .translate("total") +
                                                                    ": ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 15,
                                                                    color: Colors.white)),
                                                            TextSpan(
                                                                text: myOrderController.my_order[index].total.toString(),
                                                                style:
                                                                TextStyle(fontSize: 15, color: Colors.white)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: App_Localization.of(context)
                                                                    .translate("sub_totals") +
                                                                    ": ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 15,
                                                                    color: Colors.white)),
                                                            TextSpan(
                                                                text: myOrderController.my_order[index].subTotal.toString(),
                                                                style:
                                                                TextStyle(fontSize: 15, color: Colors.white)),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),),
                                                ],
                                              ),
                                              myOrderController.my_order[index].openCard.value ?
                                              Center()
                                              : Text(App_Localization.of(context).translate("press_to_show_more"),
                                                style: TextStyle(color: Colors.white, fontSize: 10),),
                                              Divider(
                                                thickness: 1,
                                                color: Colors.white.withOpacity(0.5),
                                                indent: 50,
                                                endIndent: 50,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                                child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: App_Localization.of(context)
                                                              .translate("address") +
                                                              ":\n",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color: Colors.white)),
                                                      TextSpan(
                                                          text: myOrderController.my_order[index].address.toString(),
                                                          style:
                                                          TextStyle(fontSize: 15, color: Colors.white)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                                color: Colors.white.withOpacity(0.5),
                                                indent: 50,
                                                endIndent: 50,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: App_Localization.of(context)
                                                              .translate("details") +
                                                              ":\n",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color: Colors.white)),
                                                      TextSpan(
                                                          text: myOrderController.my_order[index].details.toString(),
                                                          style:
                                                          TextStyle(fontSize: 15, color: Colors.white)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 30,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          );
  }
}
