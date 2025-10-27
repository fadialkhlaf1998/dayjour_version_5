import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/helper/api_v2.dart';
import 'package:dayjour_version_3/model_v2/product.dart';
import 'package:dayjour_version_3/my_model/customer_order.dart';
import 'package:dayjour_version_3/my_model/my_api.dart';
import 'package:dayjour_version_3/view/order_item.dart';
import 'package:dayjour_version_3/view/refund_items.dart';
import 'package:get/get.dart';



class MyOrderController extends GetxController{

  var my_order = <CustomerOrder>[].obs;
  var loading = true.obs;
  var detailsPageLoading = true.obs;
  List<Product> orderDetails = <Product>[];

  getData()async{
    loading(true);
    var data = await MyApi.get_customer_order(Global.customer!.id);
    my_order.value = data;
    loading(false);
  }
  getDetailsData(int orderId)async{
    detailsPageLoading(true);
    print('start');
    orderDetails = await ApiV2.getProductsForOrder(orderId);
    print('end');
    detailsPageLoading(false);
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

  refund_order(int index){
    Get.to(()=>RefundItems(my_order[index].id));
  }

}