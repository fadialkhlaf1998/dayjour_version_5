import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/controler/refund_items_controller.dart';
import 'package:dayjour_version_3/wedgits/internal_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefundItems extends StatelessWidget {

  RefundItemsController refundItemsController = Get.put(RefundItemsController());

  RefundItems(int orderId){
    refundItemsController.getData(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.main2,
      body: SafeArea(
        child: Container(
          color: App.main,
          child: SafeArea(
            child: Obx(()=>
                refundItemsController.loading.value?Center(child: CircularProgressIndicator(),):
                Column(
              children: [
                InternalHeader(title: "refund"),
                Expanded(
                  child: ListView.builder(
                      itemCount: refundItemsController.orderDetails.length,
                      itemBuilder: (context, index) {
                        var product = refundItemsController.orderDetails[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            decoration: BoxDecoration(
                              color: App.main,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [

                                GestureDetector(
                                  onTap: (){
                                    // homeController.go_to_product(products[index].id);
                                  },
                                  child: Container(
                                    width:140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                        image: DecorationImage(
                                            image: NetworkImage(product.image)
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Obx(()=>Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(product.getTitle(),style: TextStyle(color: Colors.grey,fontSize: 12,overflow: TextOverflow.ellipsis,),maxLines: 2,),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(App_Localization.of(context).translate("count")+" :  ",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                                Text(product.countForOrderItem==null?"1":product.countForOrderItem!.toString(),style: TextStyle(color: Colors.grey,fontSize: 12,overflow: TextOverflow.ellipsis),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(App_Localization.of(context).translate("total")+" :  ",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                                Text((product.countForOrderItem!*product.price).toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: TextStyle(color: App.main2,fontSize: 12,overflow: TextOverflow.ellipsis),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(App_Localization.of(context).translate("how_many_items_need_to_refund"),style: TextStyle(fontSize: 11),),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      if(refundItemsController.productRefundCounts[index].value > 0){
                                                        refundItemsController.productRefundCounts[index].value--;
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Icon(Icons.remove),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(refundItemsController.productRefundCounts[index].value.toString(),style: TextStyle(color: refundItemsController.productRefundCounts[index].value == 0?Colors.red:Colors.black),),
                                                  SizedBox(width: 5,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      if(refundItemsController.productRefundCounts[index].value < product.countForOrderItem){
                                                        refundItemsController.productRefundCounts[index].value++;
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Icon(Icons.add),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      refundItemsController.productRefundCounts[index].value==0?Text(App_Localization.of(context).translate("no_qty_to_refund"),style: TextStyle(color: Colors.red,fontSize: 10),):Center()
                                    ],
                                  )),
                                ),
                                SizedBox(width: 10,),

                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    refundItemsController.openDialog(context);
                  },
                  child: Container(
                    width: Get.width*0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: App.main2,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text(App_Localization.of(context).translate("submit"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),)
          ),
        ),
      ),
    );
  }
}
