import 'dart:ui';

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/product_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/product_info.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class ProductView extends StatelessWidget {
  ProductController productController = Get.put<ProductController>(ProductController());
  ProductInfo products;
  MyProduct old_init_products;
  WishListController wishlistController = Get.find();

  CartController cartController = Get.find();

  final controller = CarouselController();


  ProductView(this.products,this.old_init_products){
    productController.myProduct = this.products;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main2,
      body: Obx(() => SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _slider_images(context),
                _title(context),
                _description(context),
                _add_to_cart(context),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      )),
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
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 12),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {

                              Get.back();

                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.offAll(()=>Home());
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
  _slider_images(BuildContext context) {
    return   Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.3,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          children: [
            products.images.isNotEmpty?Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  options: CarouselOptions(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height *
                          0.3,
                      autoPlay: products.images.length <= 1
                          ? false
                          : true,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enlargeStrategy:
                      CenterPageEnlargeStrategy.height,
                      autoPlayInterval: Duration(
                          seconds: 2),
                      onPageChanged: (index, reason) {
                        productController.selected_slider.value=index;
                      }),
                  itemCount: products.images.length,
                  itemBuilder: (BuildContext context,
                      int index,
                      int realIndex) {
                    return _products(
                        products.images[index].link,
                        context);
                  },
                ),
                Positioned(
                  left:
                  MediaQuery
                      .of(context)
                      .size
                      .width * 0.25,
                  bottom: 15,
                  child: Container(
                    width:
                    MediaQuery
                        .of(context)
                        .size
                        .width * 0.5,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: productController.selected_slider.value,
                        count: products.images.length,
                        effect: SlideEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: AppColors.main2,
                          dotColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ):Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(products.image)
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  _products(String path, BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.2,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(path == null
              ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
              : path
          ),
        ),
      ),
    );
  }
  _title(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  products.title.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      fontWeight: FontWeight
                                          .bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {

                                  products.is_favoirite.value = !products.is_favoirite.value;
                                  old_init_products.favorite.value= products.is_favoirite.value;
                                  if (products.is_favoirite.value) {
                                    MyProduct p = MyProduct(id: products.id, subCategoryId: products.subCategoryId, brandId: products.brandId, title: products.title, subTitle: products.subTitle, description: products.description, price: products.price, rate: products.rate, image: products.image, ratingCount: products.ratingCount,availability: products.availability);
                                    wishlistController.add_to_wishlist(p);
                                  }
                                  else {
                                    MyProduct p = MyProduct(id: products.id, subCategoryId: products.subCategoryId, brandId: products.brandId, title: products.title, subTitle: products.subTitle, description: products.description, price: products.price, rate: products.rate, image: products.image, ratingCount: products.ratingCount,availability: products.availability);
                                    wishlistController.delete_from_wishlist(p);
                                  }

                                },
                                child: !products.is_favoirite.value
                                    ? Icon(
                                  Icons.favorite_border,
                                  color: Colors.black45,
                                  size: 25,
                                )
                                    : Icon(
                                  Icons.favorite_outlined,
                                  color: AppColors.main2,
                                  size: 25,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      children: [
                        Container(
                          width:
                          MediaQuery
                              .of(context)
                              .size
                              .width *
                              0.7,
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.03,
                          child: Text(
                            products.price.toString() + " "+App_Localization.of(context).translate("aed"),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ],
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
  _description(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  App_Localization.of(context).translate("description"),
                  style: const TextStyle(
                      fontWeight: FontWeight
                          .bold,
                      fontSize: 23),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Html(data: products.description)),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
  _add_to_cart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                productController.increase();
                              },
                              icon: Icon(
                                Icons.add,
                              )),
                          Text(
                            productController.cart_count.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {
                                productController.decrease();
                              },
                              icon: Icon(
                                Icons.remove,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      MyProduct p = MyProduct(id: products.id, subCategoryId: products.subCategoryId, brandId: products.brandId, title: products.title, subTitle: products.subTitle, description: products.description, price: products.price, rate: products.rate, image: products.image, ratingCount: products.ratingCount,availability: products.availability);

                      productController.add_to_cart();
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: App_Localization.of(context).translate("Just_Added_To_Your_Cart"),
                          //backgroundColor: AppColors.main2,
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: AppColors.main2, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset("assets/icons/add_shopping_cart.svg",
                              height: 25,),
                            Text(
                              App_Localization.of(context)
                                  .translate("add_to_cart"),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             // productController.save_first_product(context,productController.product!);
          //           },
          //           child: Container(
          //             height: 45,
          //             width: 100,
          //             decoration: BoxDecoration(
          //               color: AppColors.main2,
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Center(
          //                   child: Text(
          //                     App_Localization.of(context)
          //                         .translate("compare"),
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

