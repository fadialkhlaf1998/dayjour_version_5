import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/checkout_controller.dart';
import 'package:dayjour_version_3/controler/wish_list_controller.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:dayjour_version_3/my_model/brand.dart';
import 'package:dayjour_version_3/my_model/category.dart';
import 'package:dayjour_version_3/my_model/marquee.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/my_model/my_product.dart';
import 'package:dayjour_version_3/my_model/slider.dart';
import 'package:dayjour_version_3/my_model/start_up.dart';
import 'package:dayjour_version_3/my_model/sub_category.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:dayjour_version_3/view/recovery_code.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  List<Marquee> marquee = <Marquee>[];
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
    Store.load_remember();
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

      print('*****');
      MyApi.check_internet().then((internet) async{
        print(internet);
        if(internet){
          MyApi.getShipping();
          print('----');
          MyApi.getAutoDiscount().then((value) {
            print(value);
            Global.auto_discounts = value ;

            cartController.get_total();
          }).catchError((err){
            print(err);
          });
          //to wait login
          Future.delayed(Duration(milliseconds: 2000)).then((val){
            Store.load_discount_code().then((code) {
              if(code!="non"){
                MyApi.discountCode(code).then((value) {
                  print(value);
                  if(value!=null){
                    cartController.discountCode = value;
                    cartController.discount.value  = value.persent.toString();
                    cartController.get_total();
                  }
                });
              }
            });
          });
          MyApi.search_suggestion();

          var val = await getHomeData();

          Future.delayed(Duration(milliseconds: 2500),(){
               //    App.sucss_msg(context, "nav");
                  get_nav();
          });
          }else{
          // App.error_msg(context, "err");
          Get.to(()=>NoInternet())!.then((value) {
            get_data();
          });
        }


      });
    });

  }
  Future<bool> getHomeData()async{
    StartUp? value = await MyApi.startUp();
    if(value == null){
      return await getHomeData();
    }
    category = value.category;
    brands = value.brand;
    newArrivals = value.newArrivals;
    specialDeals = value.specialDeals;
    sliders = value.slider;
    topCategory = value.topCategories;
    bestSellers = value.bestSellers;
    marquee = value.marquee;
    return true;
  }
  get_nav(){
    Store.loadLogInInfo().then((info) {
      if(info.email=="non"){
        Get.offAll(()=>Home());
      }else{
        Store.load_verificat().then((verify){
          if(verify){
            MyApi.check_internet().then((internet) async {
              if(internet){
                final packageInfo = await PackageInfo.fromPlatform();
                MyApi.login(info.email,info.pass,Global.firebase_token,packageInfo.version).then((value) {
                  if(value.state==200){
                    Get.offAll(()=>Home());
                  }else{
                    Get.offAll(()=>Home());
                  }
                }).catchError((err){
                  print(err.toString());
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