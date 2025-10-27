import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/controler/my_order_controller.dart';
import 'package:dayjour_version_3/helper/api_v2.dart';
import 'package:dayjour_version_3/model_v2/product.dart';
import 'package:dayjour_version_3/model_v2/refund_item_request.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefundItemsController extends GetxController{

  int orderId = -1;
  RxBool loading = true.obs;
  List<Product> orderDetails = <Product>[];
  List<RxInt> productRefundCounts = <RxInt>[];
  TextEditingController note = TextEditingController();
  MyOrderController myOrderController = Get.find();

  getData(int orderId)async{
    this.orderId = orderId;
    loading(true);
    orderDetails = await ApiV2.getProductsForOrder(orderId);
    productRefundCounts.clear();
    for(int i=0;i<orderDetails.length;i++){
      productRefundCounts.add(0.obs);
    }
    loading(false);
  }

  openDialog(BuildContext context){
    int sum = 0;
    for(int i=0;i<orderDetails.length;i++){
      sum+= productRefundCounts[i].value;
    }
    if(sum == 0){
      errorDialog(context);
    }else{
      addNote(context);
    }
  }

  submit(BuildContext context)async{
    List<RefundItemRequest> items = [];
    for(int i=0;i<orderDetails.length;i++){
      print(orderDetails[i].line_item_id!);
      items.add(RefundItemRequest(lineItemId: orderDetails[i].line_item_id!, count: productRefundCounts[i].value));
    }
    loading(true);
    Get.back();
    bool success = await ApiV2.refundRequest(orderId, note.text, items);
    loading(false);
    if(success){
      myOrderController.getData();
      App.sucss_msg(context, App_Localization.of(context).translate("refund_request_success"));
      Future.delayed(Duration(milliseconds: 1000)).then((val){
        Get.back();
      });
    }else{
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
  }

  errorDialog(BuildContext context){
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(App_Localization.of(context).translate("refund")),
        content: Text(App_Localization.of(context).translate("no_qty_to_refund")),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(App_Localization.of(context).translate("ok")),
          ),
        ],
      ),
    );
  }

  addNote(BuildContext context){
    Get.defaultDialog(
      title: App_Localization.of(context).translate("refund"),
      content: Column(
        children: [
          Text(
            App_Localization.of(context).translate("describe_reason"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: note,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: App_Localization.of(context).translate("enter_the_reason_here"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      textCancel: App_Localization.of(context).translate("cancel"),
      textConfirm: App_Localization.of(context).translate("submit"),
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      onConfirm: () {
        final reason = note.text.trim();
        if (reason.isEmpty) {
          Get.snackbar(
            App_Localization.of(context).translate("missing_reason"),
            App_Localization.of(context).translate("enter_reason_before_submit"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        } else {
          submit(context);
        }
      },
    );
  }

}