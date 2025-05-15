// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/products_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  ProductsController productsController = Get.put(ProductsController());
  WishListController wishlistController = Get.find();
  CartController cartController = Get.find();
  HomeController homeController = Get.find();
  Global global = Global();
  List<MyProduct> products;
  List<SubCategory> subCategory;
  List<SubCategory> category;
  int selected;
  int selected_category;
  String title;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController_2 = ScrollController();

  CategoryView(this.subCategory, this.products, this.selected,this.category,this.selected_category,this.title) {
    productsController.my_products = this.products;
    productsController.sub_categories = this.subCategory;
    productsController.selected_sub_category.value = this.selected;
    productsController.category=this.category;
    productsController.selected_category=this.selected_category.obs;
    productsController.productCountShow.value = 10;
    if(productsController.my_products.length>10){
      productsController.productCountShow.value = 10;
    }else{
      productsController.productCountShow.value = productsController.my_products.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      scrollController.animateTo(
        (MediaQuery.of(context).size.height * 0.1 + 20) * selected,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 800),
      );
      scrollController_2.animateTo(
        (MediaQuery.of(context).size.height * 0.1 + 20) * selected_category,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 800),
      );
    });

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

                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width,
                          color: App.main2,
                        ),
                        _category(context),
                        _sub_category(context),

                        const SizedBox(
                          height: 10,
                        ),
                        _body(context),
                        const SizedBox(
                          height: 10,
                        ),
                        showMoreBtn(context),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 0,child:_header(context),),
                Positioned(
                    child: productsController.loading.value ||
                            homeController.loading.value
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: AppColors.main.withOpacity(0.6),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.main2,
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0,
                            color: AppColors.main,
                          ))
              ],
            )),
      ),
    );
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

    _category(BuildContext context) {
    return Container(
      color: App.main,
      child: Column(

        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 10,),
              Text(this.title,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: App.main,
            child: ListView.builder(

                padding: EdgeInsets.only(left: 10, right: 10),
                itemCount: productsController.category.length,
                shrinkWrap: true,
                controller: scrollController_2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          productsController.update_sub_category(index);
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.height * 0.14,
                                decoration: BoxDecoration(
                                    boxShadow: [

                                    ],
                                    border: Border.all(color: productsController.selected_category==index?AppColors.main2:Colors.transparent,width: 2),
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(productsController
                                            .category[index].image))),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Text(
                                  productsController.category[index].title,
                                  maxLines: 2,
                                  style: App.textNormal( productsController.selected_category==index?AppColors.main2:Colors.black, 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
  _sub_category(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 10, right: 10,top: 10),
          itemCount: productsController.sub_categories.length,
          shrinkWrap: true,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    productsController.update_product(index);
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(height: 5),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                productsController.sub_categories[index].title,
                                maxLines: 1,
                                style: App.textNormal(Colors.black, 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(height: 2,width: MediaQuery.of(context).size.width / 4,color:productsController.selected_sub_category.value==index?App.main2: Colors.transparent,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
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
            padding: const EdgeInsets.only(top: 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10),
                        child: Row(
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10,left: 0),
                        child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/introduction/logo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () async {
                            final result = await showSearch(
                                context: context,
                                delegate: SearchTextField(
                                    suggestion_list: Global.suggestion_list,
                                    homeController: homeController));
                            homeController.get_products_by_search(result!, context);
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () async {
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
                              child: cartController.my_order.length==0?Center():Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child:  Center(child: FittedBox(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 1),
                              child: Text(cartController.my_order.length.toString(),style: TextStyle(color: App.main2,fontSize: 10),),
                            ))),
                          ))
                        ],
                      ),

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
    return productsController.my_products.isEmpty
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
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3/4,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                    ),
                    padding: EdgeInsets.only(left: 10,right: 10),
                    itemCount:  productsController.productCountShow.value,
                    itemBuilder: (context, index){
                      return
                          _products(productsController.my_products[index],
                              context, index);
                    },
                    ),
                  ),
              ],
            ),
          );
  }

  _products(MyProduct product, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        productsController.go_to_product(index);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                // BoxShadow(
                //   color: Colors.grey.withOpacity(0.4),
                //   spreadRadius: 2,
                //   blurRadius: 6,
                //   offset: Offset(0, 5), // changes position of shadow
                // ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.image),
                          opacity: product.availability > 0 ?1:0.5
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                product.title.toString(),
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child:App.price(context, product.price, product.offer_price),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Positioned(child: Obx(() {
            return IconButton(
              icon: Icon(
                productsController.my_products[index].favorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: App.main2,
              ),
              onPressed: () {
                if (productsController.my_products[index].favorite.value) {
                  wishlistController.delete_from_wishlist(
                      productsController.my_products[index]);
                } else {
                  wishlistController
                      .add_to_wishlist(productsController.my_products[index]);
                }
              },
            );
          })),
          App.outOfStock(product.availability),
        ],
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
        headlineSmall: TextStyle(
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