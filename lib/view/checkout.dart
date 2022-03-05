
import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/controler/cart_controller.dart';
import 'package:dayjour_version_3/controler/checkout_controller.dart';
import 'package:dayjour_version_3/controler/home_controller.dart';
import 'package:dayjour_version_3/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_fatoorah/my_fatoorah.dart';


class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _Checkout2State createState() => _Checkout2State();
}

class _Checkout2State extends State<Checkout> {

  CheckoutController checkoutController = Get.put(CheckoutController());
  CartController cartController = Get.find();
  HomeController homeController = Get.find();

  GlobalKey<ScaffoldState> _key =  GlobalKey<ScaffoldState>();

  _Checkout2State(){
    checkoutController.firstname.text=Global.customer!.firstname;
    checkoutController.lastname.text=Global.customer!.lastname;
    if(Global.my_address!=null){
      checkoutController.address.text = Global.my_address!.address;
      checkoutController.apartment.text = Global.my_address!.apartment;
      checkoutController.city.text = Global.my_address!.city;
      checkoutController.phone.text = Global.my_address!.phone;
      checkoutController.country.value = Global.my_address!.country;
      checkoutController.emirate.value = Global.my_address!.Emirate;
    }

  }

  _bar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10 , right: 10, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if(checkoutController.selected_operation.value == 0 ){
                      Get.back();
                    }else if( checkoutController.selected_operation.value==1&&checkoutController.selected.value){
                      checkoutController.selected.value=false;
                      // checkoutController.selected_operation.value --;
                    }
                    else {
                      checkoutController.selected.value=false;
                      checkoutController.selected_operation.value --;
                    }

                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    homeController.selected_bottom_nav_bar.value = 0;
                    Get.off(()=>Home());
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/introduction/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _header(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                color: AppColors.main2,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.32,
            child: Divider(
              thickness: 1.5,
              color: Colors.black45,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: 32,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checkoutController.selected_operation.value >=  1?
                AppColors.main2 : Colors.white,
                border: Border.all(
                    color: checkoutController.selected_operation.value >=  1 ?
                    Colors.transparent : Colors.black45,
                    width: 1.5
                ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.32,
            child: Divider(
              thickness: 1.5,
              color: Colors.black45,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: 32,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checkoutController.selected_operation.value == 2 ?
                AppColors.main2 : Colors.white,
                border: Border.all(
                    color: checkoutController.selected_operation.value ==  2 ?
                    Colors.transparent : Colors.black45,
                    width: 1.5
                ),
            ),
          ),
        ],
      ),
    );
  }
  _footer() {
    return GestureDetector(
      onTap: () {
        checkoutController.next(context);

      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 55,
        decoration: BoxDecoration(
            color: AppColors.main2,
            borderRadius: BorderRadius.circular(30)
        ),
        child: checkoutController.selected_operation.value == 3 ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              App_Localization.of(context).translate("track_order"),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ):
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  checkoutController.selected_operation.value==0?
                  App_Localization.of(context).translate("continue_to_payment_main")
                  :App_Localization.of(context).translate("continue_to_payment"),
                  style: TextStyle(
                    fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),)
              ],
            )
          ],
        ),
      ),
    );
  }
  _checkout_body() {
    return Column(
      children: [
        const SizedBox(height: 10),

        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("address"),
                    style: TextStyle(
                        color: Colors.black
                    ),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      App_Localization.of(context).translate("payments"),
                      style: TextStyle(
                    color: checkoutController.selected_operation.value ==  1 ?
                    Colors.black : Colors.black45,
                  ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      App_Localization.of(context).translate("summary"),
                      style: TextStyle(
                    color: checkoutController.selected_operation.value ==  2 ?
                    Colors.black : Colors.black45,
                  ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: checkoutController.firstname,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        errorText:
                        checkoutController.address_err.value && checkoutController.firstname.text.isEmpty ? App_Localization.of(context).translate("first_name_is_required") : null,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black45)
                        ),
                        hintText: App_Localization.of(context).translate("first_name"),
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: checkoutController.lastname,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        errorText:
                        checkoutController.address_err.value && checkoutController.lastname.text.isEmpty ? App_Localization.of(context).translate("last_name_is_required") : null,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black45)
                        ),
                        hintText: App_Localization.of(context).translate("lastname"),
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: checkoutController.address,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        errorText:
                        checkoutController.address_err.value && checkoutController.address.text.isEmpty ? App_Localization.of(context).translate("address_is_required") : null,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black45)
                        ),
                        hintText: App_Localization.of(context).translate("address2"),
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: checkoutController.apartment,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        errorText:
                        checkoutController.address_err.value && checkoutController.apartment.text.isEmpty ? App_Localization.of(context).translate("apartment_is_required") : null,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black45)
                        ),
                        hintText: App_Localization.of(context).translate("apartment"),
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: checkoutController.city,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        errorText:
                        checkoutController.address_err.value && checkoutController.city.text.isEmpty ? App_Localization.of(context).translate("city_is_required") : null,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black45)
                        ),
                        hintText: App_Localization.of(context).translate("city2"),
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: checkoutController.address_err.value&&checkoutController.country.value=="non"  ?
                      Border.all(color: Colors.red) :
                      Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: DropdownButton(
                      underline: Container(),
                      dropdownColor: AppColors.main,
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          child: Text(
                            App_Localization.of(context).translate("country2"),
                            style: TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),),
                        ),
                      ),
                      value: checkoutController.country.value =="non" ? null: checkoutController.country.value,
                      icon: Icon(Icons.keyboard_arrow_down , size: 30,),
                      items: checkoutController.countries.map((newvalue) {
                        return DropdownMenuItem(
                          value: newvalue,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.45,
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(newvalue),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                          checkoutController.country.value = newValue.toString();
                          // checkoutController.country_validate.value = true;
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                      App_Localization.of(context).translate("country_is_required"),
                  style: TextStyle(
                    color: checkoutController.address_err.value&&checkoutController.country.value=="non" ?
                        Colors.red : Colors.transparent,
                    fontSize: 12
                  ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: checkoutController.address_err.value&&checkoutController.emirate.value=="non"  ?
                        Border.all(color: Colors.red) :
                        Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: DropdownButton(
                      dropdownColor: AppColors.main,
                      underline: Container(),
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          App_Localization.of(context).translate("emirate"),
                        style: TextStyle(color: Colors.black),),
                      ),
                      value: checkoutController.emirate.value =="non" ? null: checkoutController.emirate.value,
                      icon: Icon(Icons.keyboard_arrow_down , size: 30,),
                      items: checkoutController.emirates.map((newvalue) {
                        return DropdownMenuItem(
                          value: newvalue,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.45,
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(newvalue),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          checkoutController.emirate.value = newValue.toString();
                          // checkoutController.emirate_validate.value = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                     App_Localization.of(context).translate("emirate_is_required"),
                      style: TextStyle(
                          color: checkoutController.address_err.value&&checkoutController.emirate.value=="non"
                              ? Colors.red
                              : Colors.transparent,
                          fontSize: 12))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          height:  MediaQuery.of(context).size.height*0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: 70,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: checkoutController.phone,
                      cursorColor: AppColors.main2,
                      maxLength: 9,
                      decoration: InputDecoration(
                        prefixStyle: TextStyle(color: Colors.transparent),
                        prefixText: '+971 |   ',
                        fillColor: Colors.white,
                        filled: true,
                        errorText:
                        checkoutController.address_err.value && (checkoutController.phone.text.isEmpty||checkoutController.phone.value.text.length<9) ? App_Localization.of(context).translate("phone_is_required") : null,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black45)
                        ),
                        // hintText: App_Localization.of(context).translate("phone"),
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(5),

                      ),
                    ),
                  ),
                  Positioned(left: 5,top:12.5,child: Container(height: 20,color: Colors.transparent,child: Text("+971 - " , style: TextStyle(color: Colors.black,fontSize: 16),)),)
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
  _payment_body() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("address"),
                    style: TextStyle(
                        color: Colors.black
                    ),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      App_Localization.of(context).translate("payments"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value ==  1 ?
                        Colors.black : Colors.black45,
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      App_Localization.of(context).translate("summary"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value ==  2 ?
                        Colors.black : Colors.black45,
                      ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
       _payment(context)
      ],
    );
  }
  _summary_body() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    App_Localization.of(context).translate("address"),
                    style: TextStyle(
                        color: Colors.black
                    ),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      App_Localization.of(context).translate("payments"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value >=  1?
                        Colors.black : Colors.black45,
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      App_Localization.of(context).translate("summary"),
                      style: TextStyle(
                        color: checkoutController.selected_operation.value ==  2 ?
                        Colors.black : Colors.black45,
                      ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Row(
            children: [
              Text(
                App_Localization.of(context).translate("summary"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: EdgeInsets.only(right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.32,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cartController.my_order.length,
              itemBuilder: (context,index) {
                return Row(
                  children: [
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(cartController
                                  .my_order[index].product.value.image
                                  .toString() ==
                                  null
                                  ? "https://www.pngkey.com/png/detail/85-853437_professional-makeup-cosmetics.png"
                                  : cartController
                                  .my_order[index].product.value.image
                                  .toString()),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                cartController.my_order[index].product.value.title.toString(),
                                //overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                cartController.my_order[index].product.value.price.toStringAsFixed(2) + " "+App_Localization.of(context).translate("aed") ,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.main2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }
          ),
        ),
        Divider(
          color: Colors.black38,
          indent: 8,
          endIndent: 8,
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.92,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         App_Localization.of(context)!.translate("shipping_address"),
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold
        //         ),),
        //       Checkbox(
        //         shape: CircleBorder(),
        //         value: checkoutController.shipping_address.value,
        //         activeColor: AppColors.main2,
        //         checkColor: Colors.white,
        //         onChanged: (newValue) {},
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 10),
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.92,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         width: MediaQuery.of(context).size.width * 0.92,
        //         child: Text("12, Bay brook, Sharps Rd, Keilor East, Melbourne, Australia",
        //           style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 18),),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 80),
      ],
    );
  }
  _accepted() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: CircleAvatar(
                child:  SvgPicture.asset('assets/icons/accept_order.svg',
                    width:MediaQuery.of(context).size.width * 0.55),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
            App_Localization.of(context).translate("order_accepted"),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23
            )),
        const SizedBox(height: 30),
        Text(
           App_Localization.of(context).translate("your_order_number") + "22323",
            style: TextStyle(
                fontSize: 18
            )),
        const SizedBox(height: 50),
      ],
    );
  }

  _payment(BuildContext context){
    return !checkoutController.selected.value?
    Container(
      height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  // App.box_shadow()
                ]
            ),
            child: ListTile(
              onTap: (){
                checkoutController.my_order.clear();
                checkoutController.my_order.addAll(cartController.my_order);
                checkoutController.selected.value=true;
                checkoutController.is_paid.value=false;
                checkoutController.is_cod.value=true;
                checkoutController.next(context);
              },
              leading: CircleAvatar(
                child: Icon(Icons.delivery_dining),
                backgroundColor: AppColors.main2,
              ),
              title: Text(App_Localization.of(context).translate("cod")),
              subtitle: Text(App_Localization.of(context).translate("cash")),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [
                //
                // ]
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.credit_card),
                  backgroundColor: AppColors.main2  
              ),
              onTap: (){
                checkoutController.selected.value=true;
                checkoutController.is_cod.value=false;

              },
              title: Text(App_Localization.of(context).translate("payment")),
              subtitle: Text(App_Localization.of(context).translate("c_card")),
            ),
          )
        ],
      ),
    )
        :Container(
      height: MediaQuery.of(context).size.height*0.65-MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child:MyFatoorah(
        onResult:(response){
          if(response.status==PaymentStatus.Success){
            checkoutController.my_order.clear();
            checkoutController.my_order.addAll(cartController.my_order);
            checkoutController.add_order_payment(context);
            checkoutController.next(context);
            checkoutController.is_paid.value=true;
          }else{
            checkoutController.selected.value=false;
          }
        },
        errorChild: Center(
          child: Icon(
            Icons.error,
            color: Colors.redAccent,
            size: 50,
          ),
        ),
        succcessChild: Center(
          child: Icon(
            Icons.done_all,
            color: Colors.greenAccent,
            size: 50,
          ),
        ),
        request: MyfatoorahRequest.test(
          currencyIso: Country.UAE,
          successUrl:
          'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
          errorUrl:
          'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
          invoiceAmount: double.parse(cartController.total.value),
          language: Global.lang_code=="en"?ApiLanguage.English:ApiLanguage.Arabic,
          token: "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: AppColors.main2,
      key: _key,
        body: Obx(() {
          return SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _bar(),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      child: Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("checkout"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                   // checkoutController.selected_operation.value == 3 ? _accepted() :
                    _header(),
                    checkoutController.selected_operation.value == 0 ? _checkout_body() :
                        checkoutController.selected_operation.value == 1 ? _payment_body() :
                            checkoutController.selected_operation.value == 2 ? _summary_body() :
                    Center(),
                    const SizedBox(height: 20),
                    checkoutController.selected_operation.value == 1 ? Center() : _footer(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        })
    );
  }
}
