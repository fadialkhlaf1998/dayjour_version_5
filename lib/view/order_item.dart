// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderItems extends StatelessWidget {
  List<MyProduct> products;
  String code;

  HomeController homeController = Get.find();

  OrderItems(this.products,this.code);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SafeArea(
          child: Obx((){
            return Stack(
              children: [
                Column(
                  children: [
                    _header(context),
                    Container(
                      color: App.main,
                      height: MediaQuery.of(context).size.height*0.89-MediaQuery.of(context).padding.top,
                      child: ListView.builder(

                          itemCount: products.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: App.main,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 4,
                                      blurRadius: 7,
                                      offset: Offset(0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        homeController.go_to_product(products[index]);
                                      },
                                      child: Container(
                                        width:120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                            image: DecorationImage(
                                                image: NetworkImage(products[index].image)
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width-155,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(products[index].title,style: TextStyle(color: Colors.grey,fontSize: 12,overflow: TextOverflow.ellipsis,),maxLines: 2,),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(App_Localization.of(context).translate("oreder_id")+" :  ",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                            Text(code,style: TextStyle(color: Colors.grey,fontSize: 12,overflow: TextOverflow.ellipsis),),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width-155,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(App_Localization.of(context).translate("count")+" :  ",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                                  Text(products[index].count==null?"1":products[index].count!.toString(),style: TextStyle(color: Colors.grey,fontSize: 12,overflow: TextOverflow.ellipsis),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(App_Localization.of(context).translate("total")+" :  ",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                                  Text((products[index].count!*products[index].price).toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: TextStyle(color: App.main2,fontSize: 12,overflow: TextOverflow.ellipsis),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),




                                      ],
                                    )

                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
                Positioned(child: homeController.loading.value?Container(
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
            );
          })),
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

}
