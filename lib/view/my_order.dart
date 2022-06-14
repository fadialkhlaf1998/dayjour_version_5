// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/my_order_controller.dart';
import 'package:dayjour_version_3/my_model/customer_order.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      body:Obx((){
        return SafeArea(
            child: Stack(
              children: [
                Column(
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
                ),
                Positioned(child: myOrderController.loading.value?Container(
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
            ));
    }),
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

  _date_covert(String dateTimeString){
    final dateTime = DateTime.parse(dateTimeString);

    final format = DateFormat('yyyy-MMM-dd hh:mm');
    final clockString = format.format(dateTime);
    return clockString.replaceAll(" ", ",");
  }

  _body1(BuildContext context) {
    return myOrderController.my_order.isEmpty
        ? Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Icon(Icons.remove_shopping_cart, color: AppColors.main2,size: 30,),
                SizedBox(height: 10),
                Text(App_Localization.of(context).translate('dont_have_order'), style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(onTap: (){Get.offAll(()=>Home());},child: Text(App_Localization.of(context).translate('order_no_data'), style: TextStyle(color: Colors.grey,fontSize: 12, fontWeight: FontWeight.normal), textAlign: TextAlign.center,)),
                    GestureDetector(onTap: (){Get.offAll(()=>Home());},child: Text(App_Localization.of(context).translate('start_shopping'), style: TextStyle(color: Colors.grey,fontSize: 12, fontWeight: FontWeight.bold,decoration: TextDecoration.underline), textAlign: TextAlign.center,)),

                  ],
                )
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

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  height: 140,
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
                                   color: AppColors.main,
                                      /*image: DecorationImage(
                                          colorFilter: ColorFilter.mode(AppColors.main2.withOpacity(0.8), BlendMode.overlay),
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/cardBackground.jpg'
                                          )
                                      )*/
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(_date_covert(myOrderController.my_order[index].date.toString()),style: TextStyle(color: Colors.grey,fontSize: 10),),
                                            // Text(_date_covert(DateTime.now().toString()),style: TextStyle(color: Colors.grey,fontSize: 10),),
                                            Row(
                                              children: [
                                                Text(myOrderController.my_order[index].deliver==1?App_Localization.of(context).translate("completed"):myOrderController.my_order[index].deliver==-1?App_Localization.of(context).translate("refused"):App_Localization.of(context).translate("process"),style: TextStyle(color: myOrderController.my_order[index].deliver==1?Colors.green:myOrderController.my_order[index].deliver==-1?Colors.red:Colors.blue,fontSize: 10),),
                                                SizedBox(width: 5,),
                                                Icon(myOrderController.my_order[index].deliver==1?Icons.check_circle:myOrderController.my_order[index].deliver==-1?Icons.close:Icons.history,size: 15,color: myOrderController.my_order[index].deliver==1?Colors.green:myOrderController.my_order[index].deliver==-1?Colors.red:Colors.blue,)
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(App_Localization.of(context).translate("oreder_id")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                            Text(myOrderController.my_order[index].code.toString(),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                          ],
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Row(
                                                children: [
                                                  Text(App_Localization.of(context).translate("sub_totals")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                  Text(myOrderController.my_order[index].subTotal.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(App_Localization.of(context).translate("shipping")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                  Text(myOrderController.my_order[index].shipping.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(App_Localization.of(context).translate("total")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                            Text(myOrderController.my_order[index].total.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                          ],
                                        ),

                                        DateTime.parse(myOrderController.my_order[index].current.toString()).isBefore(DateTime.parse(myOrderController.my_order[index].date.toString()))
                                            &&myOrderController.my_order[index].isPaid!=1&&myOrderController.my_order[index].deliver==0?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            GestureDetector(
                                              onTap: (){
                                                myOrderController.open_order_item(myOrderController.my_order[index].id,myOrderController.my_order[index].code);
                                              },
                                              child: Container(
                                                width: 75,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    color: App.main2,
                                                    border: Border.all(color: App.main2),
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(App_Localization.of(context).translate("view_order"),style: TextStyle(fontSize: 11,color: Colors.white),),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                myOrderController.cancel_order(index);
                                              },
                                              child: Container(
                                                width: 75,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    color: App.main2,
                                                    border: Border.all(color: App.main2),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(App_Localization.of(context).translate("cancel_order"),style: TextStyle(fontSize: 11,color: Colors.white),),
                                                ),
                                              ),
                                            )
                                          ],
                                        ):
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            GestureDetector(
                                              onTap: (){
                                                myOrderController.open_order_item(myOrderController.my_order[index].id,myOrderController.my_order[index].code);
                                              },
                                              child: Container(
                                                width: 75,
                                                height: 27,
                                                decoration: BoxDecoration(
                                                    color: App.main2,
                                                    border: Border.all(color: App.main2),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(App_Localization.of(context).translate("view_order"),style: TextStyle(fontSize: 11,color: Colors.white),),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
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
