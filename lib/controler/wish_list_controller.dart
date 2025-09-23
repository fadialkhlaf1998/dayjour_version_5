import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/helper/api_v2.dart';
import 'package:dayjour_version_3/model_v2/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  List<Product> wishlist = <Product>[].obs;
  List<Product> recently = <Product>[].obs;
  List<Product> rate = <Product>[].obs;
  RxBool loading = false.obs;

  Future<void> getData()async{
    if(Global.customer == null){
      return;
    }
    loading(true);
    wishlist = await ApiV2.getWishList();
    loading(false);
    return ;
  }

  wishlistAction(Product p , BuildContext context)async{
    p.wishlistLoading(true);

    if(p.favorite.value){
      await deleteFromWishlist(p.id, context);
    }else{
      await addToWishlist(p.id, context);
    }
    p.favorite(!p.favorite.value);
    p.wishlistLoading(false);
  }

  addToWishlist(int product_id,BuildContext context)async{
    if(Global.customer == null){
      App.error_msg(context, "login_first");
      return false;
    }
    loading(true);
    await ApiV2.addToWishlist(product_id);
    App.sucss_msg(context, App_Localization.of(context).translate("wishlist_msg"));
    getData();
  }
  deleteFromWishlist(int product_id,BuildContext context)async {
    if(Global.customer == null){
      App.error_msg(context, "login_first");
      return false;
    }
    loading(true);
    await ApiV2.deleteFromWishlist(product_id);
    getData();
  }
  moveToCart(int product_id,BuildContext context)async{
    //todo add product to cart
    loading(true);
    CartController cartController = Get.find();
    var succ = await cartController.addOrUpdateCart(product_id, null, 1, context);
    if(succ){
      deleteFromWishlist(product_id,context);
    }else{
      // loading(false);
    }
  }

  // add_to_wishlist(MyProduct product){
  //   product.favorite.value=true;
  //   wishlist.add(product);
  //   Store.save_wishlist(wishlist);
  // }
  // delete_from_wishlist(MyProduct product){
  //   product.favorite.value=false;
  //   for( int i=0 ;i < wishlist.length ; i++){
  //     if(wishlist[i].id==product.id){
  //       wishlist.removeAt(i);
  //       break;
  //     }
  //   }
  //   Store.save_wishlist(wishlist);
  // }
  // add_to_recently(MyProduct myProduct){
  //
  //   if(recently.length>=10){
  //     recently.removeAt(0);
  //     for(int i=0;i<recently.length;i++){
  //       if(recently[i].id==myProduct.id){
  //         return;
  //       }
  //     }
  //     recently.add(myProduct);
  //   }else{
  //     for(int i=0;i<recently.length;i++){
  //       if(recently[i].id==myProduct.id){
  //         return;
  //       }
  //     }
  //     recently.add(myProduct);
  //   }
  //   Store.save_recently(recently);
  // }
  // add_to_rate(MyProduct myProduct,double rating){
  //   myProduct.rate=rating;
  //   rate.add(myProduct);
  //   Store.save_rate(rate);
  // }
  //
  // bool is_favorite(MyProduct product){
  //   for(int i=0;i<wishlist.length;i++){
  //     if(product.id==wishlist[i].id){
  //       // product.is_favoirite.value=true;
  //       return true;
  //     }
  //   }
  //   // product.is_favoirite.value=false;
  //   return false;
  // }

}