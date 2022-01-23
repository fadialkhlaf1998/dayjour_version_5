import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/products_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/customer_order.dart';
import 'package:dayjour_version_3/my_model/my_order.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderView extends StatelessWidget {
  List<CustomerOrder> my_orders = <CustomerOrder>[];


  MyOrderView(this.my_orders);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    const SizedBox(height: 20,),
                    _body(context)
                  ],
                ),
              ),
            ),
          ],
        )

      ),
    );
  }


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      color: AppColors.main2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10 , right: 10, top: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.95,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();

                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                               onTap: (){
                                 Get.back();
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
                            Spacer(),
                            Text(App_Localization.of(context).translate("my_orders"),style: App.textBlod(Colors.white, 16),)
                          ],
                        ),
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

  _body(BuildContext context) {
    return my_orders.isEmpty ?
    Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info,color: App.main2,size: 50,)
            ],
          ),
          SizedBox(height: 15,),
          Text(
            App_Localization.of(context).translate("no_products_with_this_name"),
            style: TextStyle(
                color: AppColors.main2,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
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
                itemCount: my_orders.length,
                itemBuilder: (context,index){
                  return _item(my_orders[index], context, index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  _item( CustomerOrder customerOrder , BuildContext context , int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: GestureDetector(
        onTap: () {
          //todo go to product
          // productsController.go_to_product(index);
        },
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius
                  .only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight:
                  Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: MediaQuery.of(context).size.width,),
                    Text(
                      App_Localization.of(context).translate("details")
                      +": "+
                      customerOrder.details.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("first_name")
                          +": "+
                          customerOrder.firstname.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("last_name")
                          +": "+
                          customerOrder.lastname.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("phone")
                          +": "+
                          customerOrder.phone.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("address")
                          +": "+
                          customerOrder.address.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("apartment2")
                          +": "+
                          customerOrder.apartment.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("sub_totals")
                          +": "+
                          customerOrder.subTotal.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      App_Localization.of(context).translate("shipping")
                          +": "+
                          customerOrder.shipping.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
