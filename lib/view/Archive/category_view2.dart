import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/product_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/category.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryView2 extends StatelessWidget {
  CategoryView2();
  HomeController homeController = Get.find();
  WishListController wishListController = Get.find();
  // ProductController productController = Get.find();
  final search_controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Obx(() {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColors.main,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: homeController.category.length+2,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    index==0?_promotions(context,index):index==1?_sell(context,index):
                                    _category_drawer(
                                        homeController.category[index-2],
                                        context,
                                        index-2),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          homeController.selected_category.value==0?
                          _promotions_children(context):
                          homeController.selected_category.value==1?
                          _sell_children(context)
                              :homeController.sub_Category.isEmpty
                              ? Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height:
                              MediaQuery.of(context).size.height * 0.1,
                              child:

                              Center(
                                child: Text(
                                  App_Localization.of(context).translate("no_products_with_this_name"),
                                  style: TextStyle(
                                      color: AppColors.main2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,

                                  ),textAlign: TextAlign.center),
                              )
                          ) :
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height,
                            child: Obx((){
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: homeController.sub_Category.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                  _products(
                                          homeController.sub_Category[index],
                                          context,
                                          index),
                                    ],
                                  );
                                },
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
      }
      ),
    );
  }

  _promotions(BuildContext context,index){
    return Column(
      children: [
        Obx((){
          return  GestureDetector(
            onTap: () {

              homeController.selected_category.value=index;
              // homeController.get_sub_category(homeController.category[index].id, context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: homeController.selected_category.value == index ?
              Colors.white :
              Colors.black12,
              child: Center(
                child: Text(
                  "Promotions",
                  style:  TextStyle(
                      color: homeController.selected_category.value == index ? AppColors.main2 : Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 5)
      ],
    );
  }

  _promotions_children(BuildContext context){

    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView.builder(
          itemCount: homeController.slider.length,
          itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                // homeController.get_products(subCategory.id,index,context);
                homeController.go_to_product_slider(index);
              },
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(homeController.slider[index].image == null ?
                        "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                            : homeController.slider[index].image.replaceAll("localhost", "10.0.2.2")),
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
  _sell(BuildContext context,index){
    return Column(
      children: [
        Obx((){
          return  GestureDetector(
            onTap: () {
              homeController.selected_category.value=index;
              // homeController.get_sub_category(homeController.category[index].id, context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: homeController.selected_category.value == index ?
              Colors.white :
              Colors.black12,
              child: Center(
                child: Text(
                  "Sales",
                  style:  TextStyle(
                      color: homeController.selected_category.value == index ? AppColors.main2 : Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 5)
      ],
    );
  }
  _sell_children(BuildContext context){
    return homeController.specialDeals.isEmpty
        ? Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height:
        MediaQuery.of(context).size.height * 0.1,
        child:

        Center(
          child: Text(
              App_Localization.of(context).translate("no_products_with_this_name"),
              style: TextStyle(
                color: AppColors.main2,
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),textAlign: TextAlign.center),
        )
    ) :
    Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.specialDeals.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    // homeController.get_products(subCategory.id,index,context);
                    homeController.go_to_product(homeController.specialDeals[index]);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(homeController.specialDeals[index].image == null ?
                            "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                                : homeController.specialDeals[index].image.replaceAll("localhost", "10.0.2.2")),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Container(
                          child: Text(
                            homeController.specialDeals[index].title.toString(),
                            style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
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
        )

    );
  }
  _header(BuildContext context) {
    return  Container(
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
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              homeController.selected_bottom_nav_bar.value=0;
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
                  Column(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: homeController.searchIcon.value ?
                            40:
                            MediaQuery.of(context).size.width * 0.84,
                            height: 31,
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                  Container(
                                    child: homeController.searchIcon.value ?
                                    GestureDetector(
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        homeController.searchIcon.value= !homeController.searchIcon.value;
                                      },
                                    ) :
                                    TextField(
                                      style: const TextStyle(color: Colors.white),
                                      controller: search_controller,
                                      cursorColor: Colors.white,
                                      textAlignVertical:
                                      TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        hintText:  App_Localization.of(context).translate("search"),
                                        hintStyle: const TextStyle(color: Colors.white),
                                        enabledBorder: const  OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: const  OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        suffixIcon: GestureDetector(
                                          child: const Icon(
                                            Icons.close ,
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            homeController.searchIcon.value= !homeController.searchIcon.value;
                                            // homeController.onclose();

                                          },
                                        ),
                                      ),
                                      onSubmitted: (query){
                                        homeController.get_products_by_search(query, context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
  _category_drawer(Category collection , BuildContext context , int index) {
    return Column(
      children: [
       Obx((){
         return  GestureDetector(
           onTap: () {
             homeController.selected_category.value=index+2;
             homeController.get_sub_category(homeController.category[index].id, context);
           },
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: 40,
             color: homeController.selected_category.value == index+2 ?
             Colors.white :
             Colors.black12,
             child: Center(
               child: Text(
                 collection.title.toString(),
                 style:  TextStyle(
                     color: homeController.selected_category.value == index+2 ? AppColors.main2 : Colors.black45,
                     fontSize: 12,
                     fontWeight: FontWeight.bold
                 ),
               ),
             ),
           ),
         );
       }),
        const SizedBox(height: 5)
      ],
    );
  }
  _products(SubCategory subCategory,BuildContext context , int index) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        GestureDetector(
          onTap: () {
            print('*************');
            homeController.get_products(subCategory.id,index,context);
          },
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(homeController.sub_Category[index].image == null ?
                    "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                        : homeController.sub_Category[index].image.replaceAll("localhost", "10.0.2.2")),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Container(
                  child: Text(
                    homeController.sub_Category[index].title.toString(),
                    style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
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
  }
}
