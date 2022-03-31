import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:http/http.dart' as http;

import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class subscription_Screen extends StatefulWidget {
  const subscription_Screen({Key? key}) : super(key: key);

  @override
  _subscription_ScreenState createState() => _subscription_ScreenState();
}

class _subscription_ScreenState extends State<subscription_Screen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  subscriptionScreenController _subscriptionScreenController =
      Get.find(tag: subscriptionScreenController().toString());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: ColorUtils.blueColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<subscriptionScreenController>(
            init: _subscriptionScreenController,
            builder: (_) {
              return Stack(
                children: [
                  Container(
                    height: 30,
                    color: ColorUtils.blueColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: ColorUtils.ogback,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 20,
                          ),
                          child: Text(
                            'Subscription',
                            style: FontStyleUtility.h20(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.bold,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10, // soften the shadow
                                  spreadRadius: -5, //extend the shadow
                                  offset: Offset(
                                    0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                              ],
                              color: ColorUtils.whiteColor,
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: SvgPicture.asset(
                                    AssetUtils.subscroptionLogosvg,),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.04,
                              ),
                              Text(
                                'Select your Plan',
                                style: FontStyleUtility.h20(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.bold,
                                ),
                              ),
                             const SizedBox(height: 15,),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 28),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                  textAlign: TextAlign.center,
                                  style: FontStyleUtility.h14(
                                    fontColor: ColorUtils.greyTextColor,
                                    fontWeight: FWT.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 38, right: 38, top: 0),
                                child: MyLeadingItemCustomButtonWidget(
                                    leadingIcon: AssetUtils.locksvg,
                                    title: 'Skip (Start 14 Days free trial)',
                                    onTap: () {
                                      skip_Api();
                                      Get.offAllNamed(BindingUtils.add_company);
                                    } // Navigator.push(
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              Container(
                                margin:  const EdgeInsets.only(left: 38, right: 38, top: 0),
                                child: MyLeadingItemCustomButtonWidget(
                                  leadingIcon: AssetUtils.locksvg,
                                  title: 'Pay Now',
                                  onTap: () {
                                    Get.offAllNamed(BindingUtils.subscriptionPaymentRoute);

                                    } // Navigator.push(
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
  String Token = "";

  Future skip_Api() async {
    Token = await PreferenceManager().getPref(Api_url.token);

    print("Calling");
    print(Token);
    Map data = {
      "payable_amount": 0,
      "subscription_days": 14,
      "subscription_plan_name": "Free Trial",
      "super_admin_id": 1,
      "total_plan_sale": 0,
      // otp
    };
    print(data);

    String body = json.encode(data);
    var url = Api_url.skip_api;
    var response = await http.post(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token

      },
      body: body,
      // encoding: Encoding.getByName("utf-8")
    );

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      Get.offAllNamed(BindingUtils.add_company);

      print('Seccess');

      var data = json.decode(response.body);
      print(data);
    } else {
      print("error");
    }
  }

}
