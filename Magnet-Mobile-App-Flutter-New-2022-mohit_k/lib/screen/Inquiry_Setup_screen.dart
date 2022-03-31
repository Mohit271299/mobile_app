import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class inquirySetupScreen extends StatefulWidget {
  const inquirySetupScreen({Key? key}) : super(key: key);

  @override
  _inquirySetupScreenState createState() => _inquirySetupScreenState();
}

class _inquirySetupScreenState extends State<inquirySetupScreen> {
  PageController? _pageController_customer;

  final inquiry_Setup_controller _inquiryScreenSetupController =
      Get.find(tag: inquiry_Setup_controller().toString());
  @override
  void initState() {
    // display_name_list.add(Customer_account_name_controller.text);
    // Customer_birthdate_controller.text = ""; //set the initial value of text field
    _pageController_customer = PageController(initialPage: 0, keepPage: false);

  }

  List<String> status_Data = [
    "New",
    "Open",
    "Pending",
    "In Process",
    "Successful Closed",
    "Lost",
    "Re Open",
    "Cancelled",
  ];

// Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;

  String? _selectedstatus;
  String result = "";

  String? dateSelected;
  bool isChecked = false;
  bool inquiry_date = false;
  bool follow_date = false;
  bool birth_date = false;
  Future<void> inquiry_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        inquiry_date_controller.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> follow_up_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        follow_up_date_controller.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> birth_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        birth_date_controller.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void dispose() {
    hideLoader(context);
    // TODO: implement dispose
    super.dispose();
  }

  //customers
  final bussiness_name_controller = TextEditingController();
  final name_controller = TextEditingController();
  final inqury_status_controller = TextEditingController();

  final email_controller = TextEditingController();
  final mobile_controller = TextEditingController();
  final inquiry_date_controller = TextEditingController();
  final follow_up_date_controller = TextEditingController();
  final birth_date_controller = TextEditingController();

  final inquiry_for_controller = TextEditingController();
  final Estimate_price_controller = TextEditingController();
  final Source_promotion_controller = TextEditingController();
  final response_controller = TextEditingController();
  final assign_controller = TextEditingController();
  final reffered_controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

        body:custom_header(
          labelText: 'Add Ledger',
          back: AssetUtils.back_svg,
          backRoute: BindingUtils.inquiry_Screen_Route,
          data:  GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x17000000),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ]
                  ),
                  margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                  height: 35,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.all(Radius.circular(39.0)),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                    height: 7,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(39))),
                      margin: EdgeInsets.only(
                          right:
                          // ((_ledgerScreenSetupController.pageIndex ==
                          //             '02') ||
                          //         (_ledgerScreenSetupController.pageIndex ==
                          //             '03') ||
                          //         (_ledgerScreenSetupController.pageIndex ==
                          //             '04')
                          //     ? screenSize.width/2
                          //     : ((_ledgerScreenSetupController.pageIndex ==
                          //                 '03') ||
                          //             (_ledgerScreenSetupController
                          //                     .pageIndex ==
                          //                 '04')
                          //         ? screenSize.width/3
                          //         : ((_ledgerScreenSetupController
                          //                     .pageIndex ==
                          //                 '04')
                          //             ? screenSize.width
                          //             : screenSize.width)))
                          (_inquiryScreenSetupController.pageIndex_customer == '01'
                              ? screenSize.width / 3
                              : (_inquiryScreenSetupController.pageIndex_customer == '02'
                              ? 0
                              : 0))),

                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    child: inquiry_setup(),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Future inquiry_API() async {
    // showLoader(context);
    print('calling');
    Map data = {
      "id": 0,
      "first_name": "string",
      "last_name": "string",
      "business_name": bussiness_name_controller.text,
      "mobile_no": mobile_controller.text,
      "inquiry_date": inquiry_date_controller.text,
      "followup_date": follow_up_date_controller.text,
      "email": email_controller.text,
      "name": name_controller.text,
      "inquiry_for": inquiry_for_controller.text,
      "estimation_price": Estimate_price_controller.text,
      "source_of_promotion": Source_promotion_controller.text,
      "inquiry_status": inqury_status_controller.text,
      "response": response_controller.text,
      "assign_to": assign_controller.text,
      "birth_date": birth_date_controller.text,
      "referred_by": reffered_controller.text,
      // "created_at": "2022-02-02T08:30:46.332Z",
      // "updated_at": "2022-02-02T08:30:46.332Z"
    };

    print(data);


    var url = Api_url.inquiry_add_api;
    var response = await http_service.post(url, data);
    if(response["success"]){
      Get.offAllNamed(BindingUtils.inquiry_Screen_Route);
    }

  }

  Widget inquiry_setup() {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<inquiry_Setup_controller>(
      init: _inquiryScreenSetupController,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorUtils.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0x17000000),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.75),
                ),
              ]
          ),
          margin: EdgeInsets.only(
            top: 15,
            left: 20,
            bottom: 20,
            right: 20,
          ),
          child: PageView(
            controller: _pageController_customer,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Add inquiry',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 0, left: 20),
                      child: Text(
                        'Basic Information',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: name_controller,
                        labelText: 'Name',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: bussiness_name_controller,
                        labelText: 'Bussiness Name',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: email_controller,
                        labelText: 'Email',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: mobile_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Mobile no',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                        border: (inquiry_date == true
                            ? Border.all(
                            color:
                            ColorUtils.blueColor,
                            width: 1.5)
                            : Border.all(
                            color: Colors.transparent,
                            width: 1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                setState(() {
                                  inquiry_date = true;
                                });
                                inquiry_DatePicker(context);

                              },
                              showCursor: true,
                              readOnly: true,
                              controller: inquiry_date_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 5, left: 15),
                                labelText: 'Inquiry Date',
                                labelStyle: FontStyleUtility.h12(
                                    fontColor: ColorUtils.ogfont,
                                    fontWeight: FWT.semiBold),
                                border: InputBorder.none,
                              ),
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: SvgPicture.asset(
                              AssetUtils.date_picker,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                        border: (follow_date == true
                            ? Border.all(
                            color:
                            ColorUtils.blueColor,
                            width: 1.5)
                            : Border.all(
                            color: Colors.transparent,
                            width: 1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                setState(() {
                                  follow_date = true;
                                });
                                follow_up_DatePicker(context);

                              },
                              showCursor: true,
                              readOnly: true,
                              controller: follow_up_date_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 5, left: 15),
                                labelText: 'Follow-Up Date',
                                labelStyle: FontStyleUtility.h12(
                                    fontColor: ColorUtils.ogfont,
                                    fontWeight: FWT.semiBold),
                                border: InputBorder.none,
                              ),
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              follow_up_DatePicker(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: SvgPicture.asset(
                                AssetUtils.date_picker,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _inquiryScreenSetupController
                                    .pageIndexUpdate_customer('02');
                                _pageController_customer!.jumpToPage(1);
                              });

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff007DEF),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 29, vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      fontFamily: 'GR',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Add Inquiry',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 19, bottom: 0, left: 20),
                      child: Text(
                        'Basic Info',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: inquiry_for_controller,
                        labelText: 'Inquiry For',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Estimate_price_controller,
                        labelText: 'Estimate Price',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Source_promotion_controller,
                        labelText: 'Source of Promotion',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'inquiry Status',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: status_Data
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: FontStyleUtility.h14(
                                              fontColor: ColorUtils.blackColor,
                                              fontWeight: FWT.semiBold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _selectedstatus,
                              onChanged: (value) {
                                setState(() {
                                  _selectedstatus = value as String;
                                  inqury_status_controller.text =
                                      _selectedstatus!;
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
                              buttonElevation: 0,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: response_controller,
                        labelText: 'Response',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: assign_controller,
                        labelText: 'Assign To',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: reffered_controller,
                        labelText: 'Reffered By',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                        border: (birth_date == true
                            ? Border.all(
                            color:
                            ColorUtils.blueColor,
                            width: 1.5)
                            : Border.all(
                            color: Colors.transparent,
                            width: 1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                setState(() {
                                  birth_date = true;
                                });
                                birth_DatePicker(context);

                              },
                              showCursor: true,
                              readOnly: true,
                              controller: birth_date_controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15, top: 5),

                                labelText: 'Birth Date',
                                labelStyle: FontStyleUtility.h12(
                                    fontColor: ColorUtils.ogfont,
                                    fontWeight: FWT.semiBold),
                                border: InputBorder.none,
                              ),
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: SvgPicture.asset(
                              AssetUtils.date_picker,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _inquiryScreenSetupController
                                    .pageIndexUpdate_customer('01');
                                _pageController_customer!.jumpToPage(0);
                              });

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.blueColor, width: 1),
                                color: ColorUtils.ogback,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 9),
                                alignment: Alignment.center,
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      fontFamily: 'GR',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorUtils.blueColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              inquiry_API();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff007DEF),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 29, vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                      fontFamily: 'GR',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
