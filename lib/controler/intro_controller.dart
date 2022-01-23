import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/checkout_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/helper/api.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/best_sellers.dart';
import 'package:dayjour_version_3/my_model/brand.dart';
import 'package:dayjour_version_3/my_model/category.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/slider.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/recovery_code.dart';
import 'package:dayjour_version_3/view/welcome.dart';
// import 'package:albassel_version_1/view/home.dart';
// import 'package:albassel_version_1/view/no_internet.dart';
// import 'package:albassel_version_1/view/verification_code.dart';
// import 'package:albassel_version_1/view/welcome.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../my_model/top_category.dart';
import '../view/no_internet.dart';

class IntroController extends GetxController{
  List<Category> category=<Category>[];
  List<SubCategory> sub_Category=<SubCategory>[];
  List<Brand> brands=<Brand>[];
  List<MySlider> sliders=<MySlider>[];

  List<TopCategory> topCategory=<TopCategory>[];
  List<MyProduct> bestSellers=<MyProduct>[];
  List<MyProduct> specialDeals=<MyProduct>[];
  List<MyProduct> newArrivals=<MyProduct>[];
  CartController cartController = Get.put(CartController());
  WishListController wishListController = Get.put(WishListController());
  CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  Future<void> onInit() async {
    super.onInit();
    get_data();
    await Store.load_address();
  }

  get_data(){
    Store.load_order().then((my_order) {
      cartController.my_order.value = my_order;
    });
    Store.load_rate().then((my_order) {
      wishListController.rate = my_order;
    });
    Store.load_recently().then((my_order) {
      wishListController.recently = my_order;
    });
    Store.load_wishlist().then((wishlist) {
      wishListController.wishlist=wishlist.obs;

      MyApi.check_internet().then((internet) {
        if(internet){
          if(category.isEmpty)
          {
            MyApi.getCategory().then((value) {
              if(value.isNotEmpty){
                category.clear();
                category.addAll(value);
                MyApi.getTopCategory().then((value) {
                  topCategory.clear();
                  topCategory.addAll(value);
                });
                MyApi.getSpecialDeals(wishListController.wishlist).then((value) {
                  specialDeals.clear();
                  specialDeals.addAll(value);
                });
                MyApi.getProductsNewArrivals(wishListController.wishlist).then((value) {
                  newArrivals.clear();
                  newArrivals.addAll(value);
                });
                MyApi.getSlider().then((value) {
                  sliders.clear();
                  sliders.addAll(value);
                });
                MyApi.getBestSellers(wishListController.wishlist).then((value) {
                  bestSellers.clear();
                  bestSellers.addAll(value);
                });
                MyApi.getBrands().then((value) {
                  brands.clear();
                  brands.addAll(value);
                });


                Future.delayed(Duration(milliseconds: 2500),(){
                  get_nav();
                });
              }else{
                Future.delayed(Duration(milliseconds: 2500),(){
                  get_nav();
                });
              }
            }).catchError((err){
              category=<Category>[];
              sub_Category=<SubCategory>[];
            });
          }

        }else{
          Future.delayed(Duration(milliseconds: 1000),(){
            //  Get.to(()=>NoInternet())!.then((value) {
            //   get_data();
            // });
          });

        }
      });
    });

  }

  // get_data(){
  //   Api.check_internet().then((internet) {
  //     if(internet){
  //       if(collections.isEmpty)
  //       {
  //         Api.get_collections().then((value) {
  //           if(value.isNotEmpty){
  //             collections.addAll(value);
  //             get_nav();
  //           }else{
  //             get_nav();
  //           }
  //         }).catchError((err){
  //           collections=<Collection>[];
  //         });
  //       }
  //       Store.load_order().then((my_order) {
  //         cartController.my_order.value = my_order;
  //       });
  //       Store.load_wishlist().then((wishlist) {
  //         wishListController.wishlist.addAll(wishlist);
  //       });
  //     }else{
  //       Future.delayed(Duration(milliseconds: 1000),(){
  //         Get.to(()=>NoInternet())!.then((value) {
  //           get_data();
  //         });
  //       });
  //
  //     }
  //   });
  // }

  get_nav(){
    Store.loadLogInInfo().then((info) {
      if(info.email=="non"){
        Get.offAll(()=>Welcome());
      }else{
        Store.load_verificat().then((verify){
          if(verify){
            MyApi.check_internet().then((internet) {
              if(internet){
                MyApi.login(info.email,info.pass).then((value) {
                  print(value.message);
                  if(value.state==200){
                    Get.offAll(()=>Home());
                  }else{
                    Get.offAll(()=>Welcome());
                  }

                });

              }else{
                Get.to(()=>NoInternet())!.then((value) {
                  get_nav();
                });
              }
            });

          }else{
            Get.offAll(RecoveryCode());
          }
        });
      }
    });
  }
}