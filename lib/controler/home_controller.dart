import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/controler/intro_controller.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/brand.dart';
import 'package:dayjour_version_3/my_model/category.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/my_model/slider.dart';
import 'package:dayjour_version_3/my_model/top_category.dart';
import 'package:dayjour_version_3/view/category_view.dart';
import 'package:dayjour_version_3/view/my_order.dart';
import 'package:dayjour_version_3/view/no_internet.dart';
import 'package:dayjour_version_3/view/product.dart';
import 'package:dayjour_version_3/view/product_search.dart';
import 'package:dayjour_version_3/view/sign_in.dart';
import 'package:dayjour_version_3/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  List<Brand> brands=<Brand>[];
  List<MySlider> slider=<MySlider>[];
  List<TopCategory> topCategory=<TopCategory>[];
  List<MyProduct> bestSellers=<MyProduct>[];
  List<MyProduct> newArrivals=<MyProduct>[];
  List<MyProduct> specialDeals=<MyProduct>[];

  var searchIcon = true.obs;
  var selected_category = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var selected_bottom_nav_bar = 0.obs;
  ScrollController scrollController = new ScrollController();
  // List<Collection> collections=<Collection>[].obs;
  List<Category> category=<Category>[];
  List<SubCategory> sub_Category=<SubCategory>[].obs;
  IntroController introController=Get.find();
  WishListController wishListController = Get.find();
  var product_loading=true.obs;
  var loading=true.obs;
  var selder_selected=0.obs;
  var bottom_selected=0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    get_data();
  }


  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    Get.back();
  }

  void nave_to_home() {
    selected_bottom_nav_bar.value=0;
    loading.value=true;
    sub_Category.clear();
    loading.value=false;
    Get.back();
  }
  void nave_to_wishlist() {
    selected_bottom_nav_bar.value=2;
    Get.back();
  }
  void nave_to_setting() {
    // Get.to(()=>Setting());
  }
  void nave_to_about_us() {
    Get.back();
  }
  void nave_to_logout() {
    Store.logout();
  }


  get_sub_category(int category_id,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getSuperCategory(category_id).then((value) {
          sub_Category.clear();
          loading.value=false;
          sub_Category.addAll(value);
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_sub_category(category_id,context);
        });
      }
    });
  }

  view_all(List<MyProduct> products,String title){
    Get.to(()=>ProductSearch(products, title));
  }

  get_products(int sub_category,index,BuildContext context,int selected_category){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getSubCategory(sub_category).then((value0){
          MyApi.getProducts(wishListController.wishlist,value0.first.id).then((value) {
            loading.value=false;
            Get.to(()=>CategoryView(value0, value,0,sub_Category,index,category[selected_category].title));
          }).catchError((err){
            loading.value=false;
          });
        });

      }else{
        Get.to(NoInternet())!.then((value) {
          get_products(sub_category,index,context,selected_category);
        });
      }
    });
  }

  Future<int?> get_products_by_search(String query,BuildContext context)async{
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getProductsSearch(wishListController.wishlist,query).then((value) {
          loading.value=false;
          if(value.isNotEmpty){
            Get.to(()=>ProductSearch(value,query));
            return 0;
          }else{
            App.error_msg(context, App_Localization.of(context).translate("fail_search"));
          }

        }).catchError((err){
          loading.value=false;
          return 0;
        });
      }else{
        Get.to(NoInternet())!.then((value) async{
          return await get_products_by_search(query,context);
          // return 0;
        });
      }
    });
  }



  get_products_by_brand(int brand_id,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getProductsByBrand(wishListController.wishlist,brand_id).then((value) {
          loading.value=false;
          if(value.isNotEmpty){
            Get.to(()=>ProductSearch(value,""));
          }else{
            App.error_msg(context, App_Localization.of(context).translate("no_elm"));
          }
        }).catchError((err){
          loading.value=false;
          App.error_msg(context, App_Localization.of(context).translate("wrong"));
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_products_by_brand(brand_id,context);
        });
      }
    });
  }

  get_data(){
    try{
      MyApi.check_internet().then((internet) {
        if (internet) {
          if(introController.category.length>0){
            category.clear();
            category.addAll(introController.category);
            loading.value=false;
            if(introController.topCategory.isNotEmpty){
              topCategory.clear();
              topCategory.addAll(introController.topCategory);
              loading.value=false;
            }else{
              introController.get_data();
              get_data();
            }
            if(introController.bestSellers.isNotEmpty){
              bestSellers.clear();
              bestSellers.addAll(introController.bestSellers);
            }else{
              introController.get_data();
              get_data();
            }
            if(introController.newArrivals.isNotEmpty){
              newArrivals.clear();
              newArrivals.addAll(introController.newArrivals);
            }else{
              introController.get_data();
              get_data();
            }
            if(introController.specialDeals.isNotEmpty){
              specialDeals.clear();
              specialDeals.addAll(introController.specialDeals);
            }else{
              introController.get_data();
              get_data();
            }

            if(introController.brands.isNotEmpty){
              brands.clear();
              brands.addAll(introController.brands);
            }else{
              introController.get_data();
              get_data();
            }
            if(introController.sliders.isNotEmpty){
              slider.clear();
              slider.addAll(introController.sliders);
            }else{
              introController.get_data();
              get_data();
            }
          }else{
            introController.get_data();
            get_data();
          }

        }else{
          Get.to(NoInternet())!.then((value) {
            get_data();
          });
        }
      });
    }catch (e){
      print(e);
      get_data();
    }
  }


  set_bottom_bar(int index){
    selected_bottom_nav_bar.value=index;
  }

  go_to_sub_category_page(int category_id,BuildContext context,int selected_category){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getSuperCategory(category_id).then((value) {
          sub_Category.clear();
          // product_loading.value=false;
          sub_Category.addAll(value);
          if(sub_Category.isNotEmpty){
            MyApi.getSubCategory(sub_Category.first.id).then((sub_cate) {
              MyApi.getProducts(wishListController.wishlist, sub_cate.first.id).then((value) {
                loading.value=false;
                Get.to(()=>CategoryView(sub_cate, value, 0,sub_Category,0,category[selected_category].title));
              });
            });

          }else{

            App.error_msg(context, App_Localization.of(context).translate("no_elm"));
            loading.value=false;
          }

        }).catchError((err){
          print(err);
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_sub_category(category_id,context);
        });
      }
    });
  }

  go_to_product(MyProduct product){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(wishListController.wishlist,product.id).then((value) {
          loading.value=false;
          Get.to(()=>ProductView(value!,product));
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product(product);
        });
      }
    });
  }
  go_to_my_order(BuildContext context){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        if(Global.customer!=null){
          MyApi.get_customer_order(Global.customer!.id).then((value) {
            loading.value=false;
            Get.to(()=>MyOrderView(value));
          });
        }else{
          // App.error_msg(context, App_Localization.of(context).translate("you_must_login"));
          loading.value = false;
          Get.to(()=>SignIn());
        }
        
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_my_order(context);
        });
      }
    });
  }
  go_to_product_slider(int index,BuildContext context){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        if(slider[index].product_id!=null&&slider[index].is_product==1){
          MyApi.getProductsInfo(wishListController.wishlist,slider[index].product_id!).then((value) {
            loading.value=false;
            MyProduct p = MyProduct(id: value!.id, subCategoryId: value.subCategoryId, brandId:value.brandId, title: value.title, subTitle: value.subTitle, description: value.description, price: value.price, rate: value.rate, image: value.image, ratingCount: value.ratingCount, availability: value.availability,offer_price: value.offer_price,category_id: value.category_id,super_category_id: value.super_category_id);
            Get.to(()=>ProductView(value,p));
          });
        }else{
          MyApi.sliderProducts(wishListController.wishlist,slider[index].id).then((value) {
            loading.value=false;
            if(value.isNotEmpty){
              Get.to(()=>ProductSearch(value,slider[index].title));
            }else{
              App.error_msg(context, App_Localization.of(context).translate("no_elm"));
            }
          })
              .catchError((err){
            loading.value=false;
            App.error_msg(context, App_Localization.of(context).translate("wrong"));
          });
        }

      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product_slider(index,context);
        });
      }
    });
  }
}