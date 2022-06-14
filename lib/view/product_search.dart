// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/products_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductSearch extends StatelessWidget {
  ProductsController productsController = Get.put(ProductsController());
  HomeController homeController = Get.find();
  CartController cartController = Get.find();
  WishListController wishlistController = Get.find();
  List<MyProduct> products;
  Global global = Global();
  ScrollController scrollController = ScrollController();
  String text;

  ProductSearch(this.products,this.text){
    productsController.my_products=this.products;
    if(text.isNotEmpty){
      productsController.searchIcon.value=!productsController.searchIcon.value;
      productsController.searchController.text=text;
    }
    if(productsController.my_products.length>10){
      productsController.productCountShow = 10.obs;
    }else{
      productsController.productCountShow = productsController.my_products.length.obs;
    }
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
        child: Obx(() => Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20 + MediaQuery.of(context).size.height*0.09,),
                    _body(context),
                    SizedBox(height: 20,),
                    showMoreBtn(context),
                  ],
                ),
              ),
            ),
            Positioned(top: 0,child:_header(context),),
            Positioned(child: productsController.loading.value?Container(
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
        )
        ),
      ),
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
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        homeController.selected_bottom_nav_bar.value = 0;
                        Get.off(Home());
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
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            final result = await showSearch(
                                context: context,
                                delegate: SearchTextField(
                                    suggestion_list: Global.suggestion_list, homeController: homeController));
                            get_result(result!, context);
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          Get.back();
                          Get.back();
                          homeController.selected_bottom_nav_bar.value=2;
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              Get.back();
                              Get.back();
                              homeController.selected_bottom_nav_bar.value=3;
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            child: cartController.my_order.value.length==0?Center():Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child:  Center(child: FittedBox(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                child: Text(cartController.my_order.value.length.toString(),style: TextStyle(color: App.main2,fontSize: 10),),
                              ))),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  get_result(String query,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        productsController.loading.value=true;
        MyApi.getProductsSearch(homeController.wishListController.wishlist,query).then((value) {
          productsController.loading.value=false;
          if(value.isNotEmpty){
            productsController.my_products=this.products=value;
          }else{
            App.error_msg(context, App_Localization.of(context).translate("fail_search"));
          }

        }).catchError((err){
          productsController.loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          // get_products_by_search(query,context);
        });
      }
    });
  }
  showMoreBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Center(
        child: productsController.productCountShow.value ==
            productsController.my_products.length ? Center() : GestureDetector(
          onTap: () {
            productsController.showMore();
          },
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: App.main2
            ),
            child: Center(child: Text(
              App_Localization.of(context).translate("show_more"),
              style: TextStyle(fontSize: 12, color: Colors.white),),),
          ),
        ),
      ),
    );
  }
  _body(BuildContext context) {
    return productsController.my_products.isEmpty ?
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
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            Container(
        child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ),
          shrinkWrap: true,
          itemCount: productsController.productCountShow.value,
          itemBuilder: (context,index){
            return  _products(productsController.my_products[index],context,index);
          }),
              /* child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(productsController.my_products.length, (index) {
                  return Column(
                    children: [
                      _products(productsController.my_products[index],context,index)
                    ],
                  );
                }),
              ),*/
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
  _products( MyProduct product , BuildContext context , int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: GestureDetector(
        onTap: () {
          productsController.go_to_product(index);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(3, 5), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius
                    .only(
                    bottomLeft: Radius.circular(25),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight:
                    Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                product.image
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          product.title.toString(),
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: App.price(context, product.price, product.offer_price)
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(child: Obx((){
              return IconButton(
                icon: Icon(productsController.my_products[index].favorite.value?Icons.favorite:Icons.favorite_border,color: App.main2,),
                onPressed: (){
                  if(productsController.my_products[index].favorite.value){
                    wishlistController.delete_from_wishlist(productsController.my_products[index]);
                  }else{
                    wishlistController.add_to_wishlist(productsController.my_products[index]);
                  }

                },
              );
            }))
          ],
        ),
      ),
    );
  }

}



class SearchTextField extends SearchDelegate<String> {
  final List<String> suggestion_list;
  String? result;
  HomeController homeController;

  SearchTextField(
      {required this.suggestion_list, required this.homeController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? Visibility(
        child: Text(''),
        visible: false,
      )
          : IconButton(
        icon: Icon(Icons.search, color: Colors.white,),
        onPressed: () {
          close(context, query);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: AppBarTheme(
        color: AppColors.main2, //new AppBar color
        elevation: 0,
      ),
      hintColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    homeController.get_products_by_search(query, context);
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      close(context, query);
    });
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.main2,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = suggestion_list.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
      color: AppColors.main,
      child: query.isEmpty?Center():ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
              style: TextStyle(color: AppColors.main2),
            ),
            onTap: () {
              query = suggestions.elementAt(index);
              close(context, query);
            },
          );
        },
      ),
    );
  }
}

