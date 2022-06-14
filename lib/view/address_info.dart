// ignore_for_file: must_be_immutable

import 'package:dayjour_version_3/app_localization.dart';
import 'package:dayjour_version_3/const/app.dart';
import 'package:dayjour_version_3/const/app_colors.dart';
import 'package:dayjour_version_3/const/global.dart';
import 'package:dayjour_version_3/helper/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {

  /**address controllers*/
  TextEditingController address = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<String> country="non".obs;
  Rx<String> emirate="non".obs;
  List<String> countries=["United Arab Emirates"];
  List<String> emirates=["Abu Dhabi","Ajman","Dubai","Fujairah","Ras Al Khaimah","Sharjah","Umm Al Quwain"];

  AddressView(){
    if(Global.my_address!=null){
      address.text = Global.my_address!.address;
      apartment.text = Global.my_address!.apartment;
      city.text = Global.my_address!.city;
      phone.text = Global.my_address!.phone;
      country.value = Global.my_address!.country;
      emirate.value = Global.my_address!.Emirate;
    }
  }

  _checkout_body(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
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
                      controller: address,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
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
                      controller: apartment,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
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
                      controller: city,
                      cursorColor: AppColors.main2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
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
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: DropdownButton(
                      underline: Container(),
                      dropdownColor: AppColors.main,
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          App_Localization.of(context).translate("country2"),
                          style: TextStyle(color: Colors.black),),
                      ),
                      value: country.value =="non" ? null: country.value,
                      icon: Icon(Icons.keyboard_arrow_down , size: 30,),
                      items: countries.map((newvalue) {
                        return DropdownMenuItem(
                          value: newvalue.toString(),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.45,
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(newvalue),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        country.value = newValue.toString();
                        // checkoutController.country_validate.value = true;
                      },
                    ),
                  ),
                  SizedBox(height: 12),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
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
                      value: emirate.value =="non" ? null: emirate.value,
                      icon: Icon(Icons.keyboard_arrow_down , size: 30,),
                      items: emirates.map((newvalue) {
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
                        emirate.value = newValue.toString();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
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
                      controller: phone,
                      cursorColor: AppColors.main2,
                      maxLength: 9,
                      decoration: InputDecoration(
                        prefixStyle: TextStyle(color: Colors.transparent),
                        prefixText: '+971 |   ',
                        fillColor: Colors.white,
                        filled: true,
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
        GestureDetector(
          onTap: (){
            Store.save_address( address.text,
                apartment.text, city.text, country.value, emirate.value, phone.text);
            App.sucss_msg(context, App_Localization.of(context).translate("your_address_has_been_saved_successfully"));
            Get.back();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.065,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Center(
              child: Text(App_Localization.of(context).translate("submit"),
              //textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        )
      ],
    );
  }
  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      color: AppColors.main2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //width: MediaQuery.of(context).size.width ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: 30,
                  child: IconButton(onPressed: (){
                    Get.back();
                  },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
                ),
                Text(
                  App_Localization.of(context).translate("address"),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(width: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.79,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.main,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: _checkout_body(context),
        ),

      ],
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
            body: Obx(()=> SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.main2,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _header(context),
                        _body(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
      );
    }


}
