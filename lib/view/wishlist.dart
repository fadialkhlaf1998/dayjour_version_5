// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  Wishlist({Key? key}) : super(key: key);

  CartController cartController = Get.find();
  HomeController homeController = Get.find();
  WishListController wishlistController = Get.find();

  _wishlist(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4/5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: wishlistController.wishlist.length,
          itemBuilder: (context, index) {
            return  Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset:
                    Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width*0.45-20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                wishlistController.wishlist[index].image.toString()
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8 , top: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5 , top: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      wishlistController.delete_from_wishlist(wishlistController.wishlist[index]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.main2,
                                      size: 23,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        child: Text(
                          wishlistController.wishlist[index].title.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(wishlistController.wishlist[index].availability>0){
                            if(cartController.add_to_cart(wishlistController.wishlist[index],1,context)) {
                              wishlistController.delete_from_wishlist(wishlistController.wishlist[index]);
                            }
                          }
                        },
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width*0.4,
                          decoration: BoxDecoration(
                            color: AppColors.main2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                                wishlistController.wishlist[index].availability>0?
                              App_Localization.of(context)
                                  .translate("move_to_cart"):
                                App_Localization.of(context)
                                    .translate("out_stock"),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ) ;
          },
        ),
      ),
    );
  }
  _emptyMessage(context){
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Center(
          child: Column(
            children: [
              Icon(Icons.favorite_border, color: AppColors.main2,size: 35,),
              SizedBox(height: 15,),
              Text(App_Localization.of(context).translate('dont_have_wishlist'), style: TextStyle(color: AppColors.main2,fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  homeController.selected_bottom_nav_bar.value=0;
                },
                child: Container(
                  width: 120,
                  height: 40,
                  color: AppColors.main2,
                  child: Center(
                    child:Text(App_Localization.of(context).translate('start_shopping'), style: TextStyle(color: Colors.white,fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: AppColors.main2,
      body: SafeArea(
        child: Obx(
              () => Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 13),
                      color: AppColors.main2,
                      child:    Text(
                        App_Localization.of(context).translate("wishlist"),
                        style: TextStyle(
                          color: Colors.white,
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1.4,
            decoration: BoxDecoration(
                color: AppColors.main,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                        ),
                      SizedBox(height: 10),
                      wishlistController.wishlist.isEmpty ? _emptyMessage(context) : _wishlist(context)
                    ],
                  ),
            ),
          ),
                ],
              ),
        ),
      ),
    );
  }


}
