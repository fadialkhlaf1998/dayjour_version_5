import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/my_model/customer_order.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/order_item.dart';
import 'package:get/get.dart';



class MyOrderController extends GetxController{

  var my_order = <CustomerOrder>[].obs;
  var loading = false.obs;

  open_order_item(int order_id,String code){
    loading.value=true;
    MyApi.getOrderItems(order_id).then((value) {
      loading.value=false;
      Get.to(()=>OrderItems(value,code));
    });
  }

  cancel_order(int index){
    loading.value=true;
    MyApi.cancelOrder(my_order[index].id).then((value) {

      MyApi.get_customer_order(Global.customer!.id).then((value) {
        my_order.value=value;
        loading.value=false;
      });
    });
  }

}