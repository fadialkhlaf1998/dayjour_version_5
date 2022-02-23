import 'package:cached_network_image/cached_network_image.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/product_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/category.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryView2 extends StatelessWidget {
  CategoryView2();
  HomeController homeController = Get.find();
  WishListController wishListController = Get.find();
  // ProductController productController = Get.find();
  final search_controller = TextEditingController();
  Global global = Global();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Obx(() {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: AppColors.main,
                child: Column(
                  children: [
                    _header(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.8,
                          color: Colors.grey.withOpacity(0.05),
                          child: ListView.builder(
                            itemCount: homeController.category.length + 2,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? _promotions(context, index)
                                      : index == 1
                                      ? _sell(context, index)
                                      : _category_drawer(
                                      homeController
                                          .category[index - 2],
                                      context,
                                      index - 2),
                                ],
                              );
                            },
                          ),
                        ),
                        homeController.selected_category.value == 0
                            ? _promotions_children(context)
                            : homeController.selected_category.value == 1
                            ? _sell_children(context)
                            : homeController.sub_Category.isEmpty
                            ? Container(
                            width: MediaQuery.of(context).size.width *0.6,
                            height: MediaQuery.of(context).size.height *0.1,
                            child: Center(
                              child: Text(
                                  App_Localization.of(context)
                                      .translate(
                                      "no_products_with_this_name"),
                                  style: TextStyle(
                                    color: AppColors.main2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center),
                            ))
                            :
                        Container(
                          width: MediaQuery.of(context).size.width *0.6,
                          height: MediaQuery.of(context).size.height * 0.77,
                          child: Obx(() {
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 6/8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 0
                              ),
                              shrinkWrap: true,
                              itemCount: homeController
                                  .sub_Category.length,
                              itemBuilder: (context, index) {
                                return
                                    _products(homeController.sub_Category[index],context,index);
                              },
                            );
                          }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  child: homeController.loading.value
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
          ),
        );
      }),
    );
  }


  _promotions(BuildContext context, index) {
    return Column(
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () {
              homeController.selected_category.value = index;
              // homeController.get_sub_category(homeController.category[index].id, context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: homeController.selected_category.value == index
                    ? Colors.white
                    : Colors.grey.withOpacity(0.2),
                //border: Border.all(color: Colors.grey, width: 0.5)
              ),
              width: MediaQuery.of(context).size.width/ 3.2,
              height: 40,

              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Promotions",
                      style: TextStyle(
                          color: homeController.selected_category.value == index
                              ? AppColors.main2
                              : Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 5)
      ],
    );
  }

  _promotions_children(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
          itemCount: homeController.slider.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // homeController.get_products(subCategory.id,index,context);
                    homeController.go_to_product_slider(index,context);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     fit: BoxFit.contain,
                        //     image: NetworkImage(homeController
                        //         .slider[index].image ==
                        //         null
                        //         ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                        //         : homeController.slider[index].image
                        //         .replaceAll("localhost", "10.0.2.2")),
                        //   ),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: homeController.slider[index].image == null
                              ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                              : homeController.slider[index].image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          }),
    );
  }

  _sell(BuildContext context, index) {
    return Column(
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () {
              homeController.selected_category.value = index;
              // homeController.get_sub_category(homeController.category[index].id, context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3.2,
              height: 40,
              decoration: BoxDecoration(
                color: homeController.selected_category.value == index
                    ? Colors.white
                    : Colors.grey.withOpacity(0.2),
                //  border: Border.all(color: Colors.grey, width: 0.5)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sales",
                      style: TextStyle(
                          color: homeController.selected_category.value == index
                              ? AppColors.main2
                              : Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 5)
      ],
    );
  }

  _sell_children(BuildContext context) {
    return homeController.specialDeals.isEmpty
        ? Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: Text(
              App_Localization.of(context)
                  .translate("no_products_with_this_name"),
              style: TextStyle(
                color: AppColors.main2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
        ))
        : Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.specialDeals.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // homeController.get_products(subCategory.id,index,context);
                    homeController
                        .go_to_product(homeController.specialDeals[index]);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     fit: BoxFit.cover,
                        //     image: NetworkImage(homeController
                        //         .specialDeals[index].image ==
                        //         null
                        //         ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                        //         : homeController.specialDeals[index].image
                        //         .replaceAll("localhost", "10.0.2.2")),
                        //   ),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: homeController
                              .specialDeals[index].image == null ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                              : homeController.specialDeals[index].image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Container(
                          child: Text(
                            homeController.specialDeals[index].title
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          },
        ));
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
                  Container(
                    margin: EdgeInsets.only(right: 15,left: 15),
                    child: GestureDetector(
                      onTap: (){
                        homeController.selected_bottom_nav_bar.value = 0;
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
                  Container(
                    child: IconButton(
                      onPressed: () async {
                        final result = await showSearch(
                            context: context,
                            delegate: SearchTextField(
                                suggestion_list: Global.suggestion_list,
                                homeController: homeController));
                        homeController.get_products_by_search(result!, context);
                        print(result);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _category_drawer(Category collection, BuildContext context, int index) {
    return Column(
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () {
              homeController.selected_category.value = index + 2;
              homeController.get_sub_category(
                  homeController.category[index].id, context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3.2,
              height: 40,
              color: homeController.selected_category.value == index + 2
                  ? Colors.white
                  : Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection.title.toString(),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: homeController.selected_category.value == index + 2
                              ? AppColors.main2
                              : Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 5)
      ],
    );
  }

  _products(SubCategory subCategory, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: (){
          homeController.get_products(subCategory.id, index, context,homeController.selected_category.value-2);
        },
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,

                    image: NetworkImage(homeController
                        .sub_Category[index].image ==
                        null
                        ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                        : homeController.sub_Category[index].image
                        .replaceAll("localhost", "10.0.2.2")),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  child: Text(
                    homeController.sub_Category[index].title.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
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
    final suggestions = suggestion_list.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });
    homeController.get_products_by_search(query, context);
    close(context, query);
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

