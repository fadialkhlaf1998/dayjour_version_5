import 'dart:ui';

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/product_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/product_info.dart';
import 'package:dayjour_version_3/view/Archive/no_internet.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductView extends StatelessWidget {
  TextEditingController textReview = TextEditingController();
  ProductController productController =
      Get.put<ProductController>(ProductController());
  ProductInfo products;
  MyProduct old_init_products;
  WishListController wishlistController = Get.find();
  double product_rating=0;

  CartController cartController = Get.find();

  final controller = CarouselController();

  ProductView(this.products, this.old_init_products) {
    productController.myProduct = this.products;
    Global.add_to_recently(products);
    for(int i=0;i<wishlistController.rate.length;i++){
      if( productController.myProduct!.id==wishlistController.rate[i].id){
        product_rating=wishlistController.rate[i].rate;
      }
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
      body: Obx(() => SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main,
              child: productController.loading.value?Center(child: CircularProgressIndicator(color: App.main2,),):SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    _slider_images(context),
                    _title(context),
                    _review(context),
                    _description(context),
                    _add_to_cart(context),
                    _show_review(context),
                    _recently_product(context)
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
      height: MediaQuery.of(context).size.height * 0.09,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10,left: 10),
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
                  Container(
                    margin: EdgeInsets.only(right: 10,left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => Home());
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  go_to_product(MyProduct product){
    productController.loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(productController.wishListController.wishlist,product.id).then((value) {
          productController.loading.value=false;
          //todo add favorite
         //Get.to(ProductView(value!,product));
          productController.selected_slider.value=0;
          products=value!;
          old_init_products=product;
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product(product);
        });
      }
    });
  }

  _slider_images(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            products.images.isNotEmpty
                ? Stack(
                    children: [
                      CarouselSlider.builder(
                        carouselController: controller,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.3,
                            autoPlay:
                                products.images.length <= 1 ? false : true,
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            autoPlayInterval: Duration(seconds: 2),
                            onPageChanged: (index, reason) {
                              productController.selected_slider.value = index;
                            }),
                        itemCount: products.images.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return _products(
                              products.images[index].link, context);
                        },
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.25,
                        bottom: 15,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex:
                                  productController.selected_slider.value,
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
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(products.image))),
                  ),
          ],
        ),
      ),
    );
  }
  _products(String path, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(path == null
              ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
              : path),
        ),
      ),
    );
  }
  _title(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  products.title.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  products.is_favoirite.value =
                                      !products.is_favoirite.value;
                                  old_init_products.favorite.value =
                                      products.is_favoirite.value;
                                  if (products.is_favoirite.value) {
                                    MyProduct p = MyProduct(
                                        id: products.id,
                                        subCategoryId: products.subCategoryId,
                                        brandId: products.brandId,
                                        title: products.title,
                                        subTitle: products.subTitle,
                                        description: products.description,
                                        price: products.price,
                                        rate: products.rate,
                                        image: products.image,
                                        ratingCount: products.ratingCount
                                        ,availability: products.availability);
                                    wishlistController.add_to_wishlist(p);
                                  } else {
                                    MyProduct p = MyProduct(
                                        id: products.id,
                                        subCategoryId: products.subCategoryId,
                                        brandId: products.brandId,
                                        title: products.title,
                                        subTitle: products.subTitle,
                                        description: products.description,
                                        price: products.price,
                                        rate: products.rate,
                                        image: products.image,
                                        ratingCount: products.ratingCount
                                        ,availability: products.availability);
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
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              products.price.toString() +
                                  " " +
                                  App_Localization.of(context).translate("aed"),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star,color: App.main2,),
                              SizedBox(width: 5,),
                              Text(productController.myProduct!.rate.toStringAsFixed(2), style: TextStyle(color: AppColors.main2, fontWeight: FontWeight.bold, fontSize: 17),)
                            ],
                          ),
                        )
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
  _review(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height / 13,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(1, 5), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: RatingBar.builder(
                  glowColor: AppColors.main2,
                  allowHalfRating: true,
                  initialRating: product_rating,
                  minRating: 0,
                  itemSize: 22,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (Global.customer == null){
                    App.error_msg(context, App_Localization.of(context).translate('please_login_first'));
                    }else{
                    MyProduct myProduct1 = MyProduct(id: productController.myProduct!.id, subCategoryId: productController.myProduct!.subCategoryId, brandId: productController.myProduct!.brandId, title: productController.myProduct!.title, subTitle: productController.myProduct!.subTitle, description: productController.myProduct!.description, price: productController.myProduct!.price, rate: productController.myProduct!.rate, image: productController.myProduct!.image, ratingCount: productController.myProduct!.ratingCount,availability: products.availability);
                    wishlistController.add_to_rate(myProduct1, rating);
                    MyApi.rate(productController.myProduct!, rating);
                    }

                    print(rating);
                  },
                ),
              ),
              VerticalDivider(thickness: 1.5, endIndent: 10, indent: 10),
              GestureDetector(
                onTap: () {
                  Global.customer == null
                      ? App.error_msg(context, App_Localization.of(context).translate('please_login_first'))
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _alertDialogBox();
                          },
                        );
                },
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black, size: 20),
                    SizedBox(width: 4),
                    Container(
                      child: Text(
                        App_Localization.of(context).translate("add_review"),
                        style: App.textBlod(Colors.black, 14),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: App_Localization.of(context).translate('available') + ": ", style: TextStyle(fontSize: 16, color: AppColors.main2, fontWeight: FontWeight.bold)),
              TextSpan(text: products.availability.toString(), style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold) )
            ]
          ),
        ),
      ],
    );
  }
  _description(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  App_Localization.of(context).translate("description"),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Html(data: products.description)),
              ],
            ),
          ],
        ),
      ),
    );
  }
  _add_to_cart(BuildContext context) {
    return Column(
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
                    MyProduct p = MyProduct(
                        id: products.id,
                        subCategoryId: products.subCategoryId,
                        brandId: products.brandId,
                        title: products.title,
                        subTitle: products.subTitle,
                        description: products.description,
                        price: products.price,
                        rate: products.rate,
                        image: products.image,
                        ratingCount: products.ratingCount,
                        availability: products.availability);

                    productController.add_to_cart();
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: App_Localization.of(context)
                            .translate("Just_Added_To_Your_Cart"),
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
                          SvgPicture.asset(
                            "assets/icons/add_shopping_cart.svg",
                            height: 25,
                          ),
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
        SizedBox(
          height: 20,
        ),
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
    );
  }
  _getCloseButton(context) {
    return Container(
      alignment: FractionalOffset.topRight,
      child: GestureDetector(
        child: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
  _alertDialogBox() {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: Builder(
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 2.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      App_Localization.of(context).translate('write_a_review'),
                      style: TextStyle(fontSize: 18),
                    ),
                    _getCloseButton(context),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  height: MediaQuery.of(context).size.height / 5,

                  child: TextField(
                    controller: textReview,
                    maxLines: 5,
                    autofocus: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background_box,
                      border: OutlineInputBorder(),
                      hintText:
                          App_Localization.of(context).translate('comment'),
                      hintStyle: TextStyle(fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (Global.customer != null) {
                      if (textReview.text.isNotEmpty) {
                        List<Review> reviews = <Review>[];
                        reviews.add(Review(
                            customerName: Global.customer!.firstname,
                            body: textReview.text,
                            customerId: Global.customer!.id,
                            id: -1,
                            priductId: productController.myProduct!.id));
                        reviews.addAll(productController.myProduct!.reviews);
                        productController.myProduct!.reviews = reviews;
                        productController.add_review(
                            textReview.text, productController.myProduct!.id,
                            context);
                        Get.back();
                        textReview.text = "";
                      }
                    }else{
                    //  App.error_msg(context, 'you_should_login_first');
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 18,
                        decoration: BoxDecoration(
                          color: App.main2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Text(
                        App_Localization.of(context).translate("post_review"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  _show_review(context){
    return Container(
      color: AppColors.main,
      width: MediaQuery.of(context).size.width ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: products.reviews.isEmpty ? Center() : Text(App_Localization.of(context).translate("reviews"),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
          ),
          ListView.builder(
            padding: EdgeInsets.only(top: 15),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.reviews.length,
            itemBuilder: (context, index){
              return Container(
                //color: AppColors.background_box,
                //width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(

                       // color: AppColors.background_box,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: ListTile(
                          title: Text(products.reviews[index].customerName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),maxLines: 4,),
                          subtitle: Text(products.reviews[index].body, style: TextStyle(fontSize: 17)),
                        ),
                      ),
                    ),
                    Divider(thickness: 1,indent: 15,endIndent: 15, color: Colors.black.withOpacity(0.5),),
                    SizedBox(height: 40),
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
  _recently_product(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Global.recentlyProduct.isEmpty ? Center() : Text(App_Localization.of(context).translate("recently_products"),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
          SizedBox(height: 15,),
          Container(
            height: MediaQuery.of(context).size.height*0.15,
            child: ListView.builder(
                itemCount: Global.recentlyProduct.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: (){
                      print('***');
                      go_to_product(MyProduct(
                          description: Global.recentlyProduct[index].description,
                          id: Global.recentlyProduct[index].id,
                          image: Global.recentlyProduct[index].image,
                          availability: Global.recentlyProduct[index].availability,
                          title: Global.recentlyProduct[index].title,
                          brandId: Global.recentlyProduct[index].brandId,
                          price: Global.recentlyProduct[index].price,
                          rate: Global.recentlyProduct[index].rate,
                          ratingCount: Global.recentlyProduct[index].ratingCount,
                          subCategoryId: Global.recentlyProduct[index].subCategoryId,
                          subTitle: Global.recentlyProduct[index].subTitle
                      ));
                      },
                    child: Container(
                      width: MediaQuery.of(context).size.height*0.15,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(Global.recentlyProduct[index].image),
                              )
                            ),
                          )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(Global.recentlyProduct[index].title,style: TextStyle(fontSize: 9),maxLines: 2,textAlign: TextAlign.center),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
            }),
          ),
        ],
      ),
    );
  }

}
