
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/controler/product_controller.dart';
import 'package:dayjour_version_3/controler/products_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {

  ProductsController productsController = Get.put(ProductsController());
  WishListController wishlistController = Get.find();
  HomeController homeController = Get.find();
  List<MyProduct> products;
  List<SubCategory> subCategory;
  int selected;
  ScrollController scrollController = ScrollController();

  CategoryView(this.subCategory,this.products,this.selected){
    productsController.my_products=this.products;
    productsController.sub_categories=this.subCategory;
    productsController.selected_sub_category.value=this.selected;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      scrollController.animateTo(
        (MediaQuery.of(context).size.height*0.1+20)*selected,
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
                    _header(context),
                    const SizedBox(height: 20,),
                    _sub_category(context),
                    const SizedBox(height: 20,),
                    _body(context)
                  ],
                ),
              ),
            ),
            Positioned(child: productsController.loading.value||homeController.loading.value?Container(
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

  _sub_category(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height*0.15,
      child: ListView.builder(
          itemCount: productsController.sub_categories.length,
          shrinkWrap: true,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            productsController.update_product(index);
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.height*0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(productsController.sub_categories[index].image)
                      )
                    ),
                  ),
                ),
                Text(productsController.sub_categories[index].title,style: App.textNormal(Colors.black, 12),)
              ],
            ),
          ),
        );
      }),
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
                            width: productsController.searchIcon.value ?
                            40:
                            MediaQuery.of(context).size.width * 0.76,
                            height: 31,
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                  Container(
                                    child: productsController.searchIcon.value ?
                                    GestureDetector(
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        productsController.searchIcon.value= !productsController.searchIcon.value;
                                      },
                                    ) :
                                    TextField(
                                      style: const TextStyle(color: Colors.white),
                                      controller: productsController.searchController,
                                      cursorColor: Colors.white,
                                      textAlignVertical:
                                      TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        hintText: App_Localization.of(context).translate("search"),
                                        hintStyle: const TextStyle(color: Colors.white),
                                        enabledBorder: const  OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        suffixIcon: GestureDetector(
                                          child: const Icon(
                                            Icons.close ,
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            productsController.searchIcon.value= !productsController.searchIcon.value;
                                          },
                                        ),
                                      ),
                                     onSubmitted: (query){
                                       productsController.get_products_by_search(query, context);
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
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              child: GridView.count(
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
              ),
            )
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
        //todo go to product
          productsController.go_to_product(index);
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.44,
              height: MediaQuery.of(context).size.height * 0.26,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius
                    .only(
                    bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight:
                    Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(flex: 4,child:  Container(
                    width: MediaQuery.of(context).size.width * 0.44,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            product.image == null ?
                            "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png":
                            product.image
                        ),
                      ),
                    ),
                  )),
                  Expanded(flex: 2,child: Column(
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
                            child: Text(
                              product.price.toString()+ " "+App_Localization.of(context).translate("aed"),
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))

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

