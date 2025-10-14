import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/helper/api_v2.dart';
import 'package:dayjour_version_3/model_v2/product.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:dayjour_version_3/view/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubSellerProductController extends GetxController{
  List<SubCategory> sub_categories=<SubCategory>[].obs;
  List<Product> my_products=<Product>[].obs;
  List<SubCategory> category=<SubCategory>[].obs;
  var loading = false.obs;
  var fake = false.obs;
  var searchIcon = true.obs;
  TextEditingController searchController = TextEditingController();
  Rx<int> selected_sub_category = 0.obs;
  Rx<int> selected_category = 0.obs;
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();

  var productCountShow = 10.obs;

  showMore(){
    if(productCountShow.value+10<=my_products.length){
      productCountShow.value += 10;
    }else{
      productCountShow.value = my_products.length;
    }
  }

  updateShowCount(){
    if(my_products.length>10){
      productCountShow.value = 10;
    }else{
      productCountShow.value = my_products.length;
    }
  }

  getData(int subSellerId){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        ApiV2.getProductsBySubSeller(subSellerId).then((value) {
          print('ssssssssssssssssssssssss');
          print(value.length);

          if(value.isNotEmpty){
            my_products=value;
          }else{
            Get.back();
          }
          updateShowCount();
          loading.value=false;
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          getData(subSellerId);
        });
      }
    });
  }


  update_product(int index){
    loading.value=true;
    selected_sub_category.value=index;
    ApiV2.getProductsBySubCategory(sub_categories[index].id).then((value) {
      my_products.clear();
      my_products.addAll(value);
      loading.value=false;
      updateShowCount();
    }).catchError((err){
      loading.value=false;
    });
  }
  update_sub_category(int index){
    loading.value=true;
    selected_category.value=index;
    MyApi.getSubCategory(category[index].id).then((sub_category) {
      sub_categories=sub_category;
      selected_sub_category.value=0;
      ApiV2.getProductsBySubCategory(sub_categories.first.id).then((value) {
        my_products.clear();
        my_products.addAll(value);
        loading.value=false;
        updateShowCount();
      }).catchError((err){
        loading.value=false;
      });
      updateShowCount();
    }).catchError((err){
      loading.value=false;
    });
  }

}