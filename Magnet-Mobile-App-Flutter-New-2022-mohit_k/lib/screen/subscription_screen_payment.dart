import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class subscriptionPayment_screen extends StatefulWidget {
  const subscriptionPayment_screen({Key? key}) : super(key: key);

  @override
  _subscriptionPayment_screenState createState() =>
      _subscriptionPayment_screenState();
}

class _subscriptionPayment_screenState
    extends State<subscriptionPayment_screen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  subscriptionScreenPaymentController _subscriptionscreenpayment_controller =
      Get.find(tag: subscriptionScreenPaymentController().toString());
  PageController? _pageController;
  PageController? _pageController_one;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  bool isChecked = false;

  void payment_details() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Color(0xff737373),
                child: Container(
                  height: 393,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, bottom: 24, left: 37),
                                  child: Text(
                                    'Billing details',
                                    style: FontStyleUtility.h20(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Billing Name',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Email Id',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Mobile Number',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'GST Number (Optional',
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _subscriptionscreenpayment_controller
                                            .pageIndexUpdate('02');
                                        _pageController!.jumpToPage(1);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 20, left: 0),
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff007DEF),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 9),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Next',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, bottom: 24, left: 37),
                                  child: Text(
                                    'Billing Address',
                                    style: FontStyleUtility.h20(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Address',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'City',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'State',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Pincode',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _subscriptionscreenpayment_controller
                                            .pageIndexUpdate('03');
                                        _pageController!.jumpToPage(2);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 20, left: 0),
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff007DEF),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 9),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Next',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, bottom: 20, left: 37),
                                  child: Text(
                                    'Shipping Address',
                                    style: FontStyleUtility.h20(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 30, bottom: 5),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 0, bottom: 0, left: 0),
                                        child: Text(
                                          'Same as Billing Address',
                                          style: FontStyleUtility.h14(
                                            fontColor: ColorUtils.blueColor,
                                            fontWeight: FWT.semiBold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Address',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'City',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'State',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 38, right: 38, bottom: 15),
                                  child: CustomTextFieldWidget_two(
                                    labelText: 'Pincode',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 20, left: 0),
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff007DEF),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 9),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Next',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
    _pageController_one = PageController(initialPage: 0, keepPage: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      payment_details();
      Duration.microsecondsPerSecond;
    });
  }
  String _selectedterma = '0';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: ColorUtils.blueColor,
        centerTitle: true,
      ),
      body: GetBuilder<subscriptionScreenPaymentController>(
          init: _subscriptionscreenpayment_controller,
          builder: (_) {
            return Stack(
              children: [
                Container(
                  height: 30,
                  color: ColorUtils.blueColor,
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: ColorUtils.ogback,
                  ),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController_one,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
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
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  boxShadow: [
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
                              margin: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Text(
                                      'Your Subscription Includes',
                                      style: FontStyleUtility.h17(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 18),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: SvgPicture.asset(
                                                      AssetUtils.checkmark),
                                                ),
                                                Text(
                                                  'Upto 3 Companies',
                                                  style: FontStyleUtility.h14(
                                                    fontColor: ColorUtils
                                                        .black_light_Color,
                                                    fontWeight: FWT.semiBold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  boxShadow: [
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
                              margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 20,
                                      left: 20,
                                    ),
                                    child: Text(
                                      'Your Subscription Includes',
                                      style: FontStyleUtility.h17(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Basic Ammount',
                                              style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils.black_light_Color,
                                                fontWeight: FWT.semiBold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Tax @18%',
                                              style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils.black_light_Color,
                                                fontWeight: FWT.semiBold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Total Amount',
                                              style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils.black_light_Color,
                                                fontWeight: FWT.semiBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '5,000.00',
                                              style: FontStyleUtility.h14(
                                                fontColor: ColorUtils.blueColor,
                                                fontWeight: FWT.semiBold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '900.00',
                                              style: FontStyleUtility.h14(
                                                fontColor: ColorUtils.blueColor,
                                                fontWeight: FWT.semiBold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              ' 5,900.00 / Year',
                                              style: FontStyleUtility.h14(
                                                fontColor: ColorUtils.blueColor,
                                                fontWeight: FWT.semiBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  boxShadow: [
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
                              margin: EdgeInsets.only(left: 20, right: 20,bottom: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.all(15),
                                      child: CustomTextFieldWidget_two(
                                        labelText: 'Mobile Number',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    // flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20, right: 15),
                                      decoration: BoxDecoration(
                                        color: ColorUtils.blueColor,
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 28, vertical: 12),
                                        alignment: Alignment.center,
                                        child:  Text(
                                          'Next',
                                          style: FontStyleUtility.h14(
                                            fontColor:ColorUtils.whiteColor,
                                            fontWeight: FWT.semiBold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  boxShadow: [
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
                              margin: EdgeInsets.only(left: 20, right: 20,),
                              child: Container(
                                margin: EdgeInsets.only(top: 20,bottom: 20,right: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Radio(
                                            // contentPadding: EdgeInsets.all(0),
                                            groupValue: _selectedterma,
                                            // title: Text('Customer',
                                            //     style: FontStyleUtility.h11(
                                            //         fontColor:
                                            //             ColorUtils.greyTextColor,
                                            //         fontWeight: FWT.semiBold)),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedterma =
                                                value as String;
                                              });
                                            },
                                            value: '0',
                                          ),
                                          Expanded(
                                            child: Text('I confirm that he information given above are true, complete and accurate, They can not be modified after the invoice has been issued.',
                                              maxLines: 4,
                                              textAlign: TextAlign.justify,
                                              style: FontStyleUtility.h14(
                                                  fontColor:
                                                  ColorUtils.blackColor,
                                                  fontWeight: FWT.semiBold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 14),
                                      child: Row(
                                        children: [
                                          Radio(
                                            // contentPadding: EdgeInsets.all(0),
                                            groupValue: _selectedterma,
                                            // title: Text('Vendors',
                                            //     style: FontStyleUtility.h11(
                                            //         fontColor:
                                            //             ColorUtils.greyTextColor,
                                            //         fontWeight: FWT.semiBold)),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedterma =
                                                value as String;
                                              });

                                            },
                                            value: '1',
                                          ),
                                          Expanded(
                                            child: Text('I agree to the Terms & Conditions.',
                                                style: FontStyleUtility.h14(
                                                    fontColor:
                                                    ColorUtils.blackColor,
                                                    fontWeight: FWT.semiBold)),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _subscriptionscreenpayment_controller.pageIndexUpdate_one('02');
                                _pageController_one!.jumpToPage(1);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 126),
                                decoration: BoxDecoration(
                                  color: ColorUtils.blueColor,
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 12),
                                  alignment: Alignment.center,
                                  child:  Text(
                                    'Apply',
                                    style: FontStyleUtility.h14(
                                      fontColor:ColorUtils.whiteColor,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              'Subscription',
                              style: FontStyleUtility.h20(
                                fontColor: ColorUtils.blackColor,
                                fontWeight: FWT.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: screenSize.width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8, // soften the shadow
                                    spreadRadius: -5, //extend the shadow
                                    offset: Offset(
                                      0, // Move to right 10  horizontally
                                      1.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                ],
                                color: ColorUtils.lightblueColor_back,
                                borderRadius: BorderRadius.circular(15)),
                            margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 90,),
                                Center(
                                  child: SvgPicture.asset(
                                      AssetUtils.subs_mail),
                                ),
                                SizedBox(height: 42,),

                                Container(

                                  child: Text(
                                    'Congratulations !',
                                    style: FontStyleUtility.h22(
                                      fontColor: ColorUtils.blueColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),Container(
                                  margin: EdgeInsets.symmetric(horizontal: 28,vertical: 13),
                                  child: Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. !',
                                    textAlign: TextAlign.center,
                                    style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.blueColor,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 127,),
                                Container(
                                  margin: EdgeInsets.only(left: 36, right: 36, bottom: 40),
                                  child: MyLeadingItemCustomButtonWidget(
                                    alignment: Alignment.center,
                                    title: 'Continue',
                                    backGroundColor: ColorUtils.blueColor,
                                    onTap: () {
                                      Get.offAllNamed(BindingUtils.add_company);
                                    },                    // Navigator.push(
                                    //     context,
                                    //     PageTransition(
                                    //         child: registrationScreen(),
                                    //         type: PageTransitionType.rightToLeft));                },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),



                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
