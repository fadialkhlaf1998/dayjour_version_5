import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/my_model/category.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:dayjour_version_3/view/product.dart';
// import 'package:dayjour_version_2/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../view/product.dart';

class ProductsController extends GetxController{
  List<SubCategory> sub_categories=<SubCategory>[].obs;
  List<MyProduct> my_products=<MyProduct>[].obs;
  List<SubCategory> category=<SubCategory>[].obs;
  var loading = false.obs;
  var searchIcon = true.obs;
  TextEditingController searchController = TextEditingController();
  Rx<int> selected_sub_category = 0.obs;
  Rx<int> selected_category = 0.obs;
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();




  get_products_by_search(String query,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getProductsSearch(wishListController.wishlist,query).then((value) {
          loading.value=false;
          if(value.isNotEmpty){
            my_products=value;
          }else{
            App.error_msg(context, App_Localization.of(context).translate("fail_search"));
          }

        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_products_by_search(query,context);
        });
      }
    });
  }


  update_product(int index){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        selected_sub_category.value=index;
        MyApi.getProducts(wishListController.wishlist,sub_categories[index].id).then((value) {
          my_products.clear();
          my_products.addAll(value);
          loading.value=false;
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          update_product(index);
        });
      }
      });
  }
  update_sub_category(int index){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        selected_category.value=index;
        MyApi.getSubCategory(category[index].id).then((sub_category) {
          sub_categories=sub_category;
          selected_sub_category.value=0;
          MyApi.getProducts(wishListController.wishlist,sub_categories.first.id).then((value) {
            my_products.clear();
            my_products.addAll(value);
            loading.value=false;
          }).catchError((err){
            loading.value=false;
          });

        }).catchError((err){
          loading.value=false;
        });

      }else{
        Get.to(()=>NoInternet())!.then((value) {
          update_product(index);
        });
      }
      });
  }


  go_to_product(int index){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(wishListController.wishlist,my_products[index].id).then((value) {
          // selected_sub_category.value=index;
          loading.value=false;
          //todo add favorite
          Get.to(()=>ProductView(value!,my_products[index]));
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product(index);
        });
      }
    });
  }
}