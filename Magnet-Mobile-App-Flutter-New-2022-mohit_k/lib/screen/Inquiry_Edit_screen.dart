import 'package:flutter/material.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
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
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/model_class/inquiry_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class inquiryEditScreen extends StatefulWidget {
  final int? inquiry_id;
  const inquiryEditScreen({Key? key, this.inquiry_id}) : super(key: key);

  @override
  _inquiryEditScreenState createState() => _inquiryEditScreenState();
}

class _inquiryEditScreenState extends State<inquiryEditScreen> {
  PageController? _pageController_customer;

  final inquiry_Edit_controller _inquiryEditController =
  Get.put(
      inquiry_Edit_controller(),
      tag: inquiry_Edit_controller().toString());
  @override
  void initState() {
     _pageController_customer = PageController(initialPage: 0, keepPage: false);
     Customer_Edit_Get();
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

  String query_inquiry = '';
  List<Data_inquiry> inquiryData = [];
var data;
  Future Customer_Edit_Get() async {
    var url = Api_url.inquiry_add_api + '/${widget.inquiry_id}';
    final response = await http_service.get_Data(url);
    print(response);
    print(response["business_name"]);

      setState(() {
        bussiness_name_controller.text = response["business_name"];
        name_controller.text = response["name"];
        _selectedstatus= response["inquiry_status"];
        email_controller.text = response["email"];
        mobile_controller.text = response["mobile_no"];
        inquiry_date_controller.text = response["inquiry_date"];
        follow_up_date_controller.text = response["followup_date"];
        birth_date_controller.text = response["birth_date"];
        inquiry_for_controller.text = response["inquiry_for"];
        Estimate_price_controller.text = response["estimation_price"];
        Source_promotion_controller.text = response["source_of_promotion"];
        response_controller.text = response["response"];
        assign_controller.text = response["assign_to"];
        reffered_controller.text = response["referred_by"];

      });

  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

        body: custom_header(
          labelText: 'Edit inquiry',
          back: AssetUtils.back_svg,
          backRoute: BindingUtils.inquiry_Screen_Route,
          data: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(39.0)),
                  boxShadow: [
                    BoxShadow(
                        color: ColorUtils.black_light_Color,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 10.0,
                        spreadRadius: -5),
                  ],
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
                        (_inquiryEditController.pageIndex_customer ==
                            '01'
                            ? screenSize.width / 2
                            : (_inquiryEditController
                            .pageIndex_customer ==
                            '02'
                            ? screenSize.width / 3
                            : (_inquiryEditController
                            .pageIndex_customer ==
                            '03'
                            ? screenSize.width / 4
                            : 0)))),
                  ),
                ),
              ),

              Expanded(
                child: ledger_setup(),
              ),
            ],
          ),

        )
    );
  }

  Future inquiry_put_API() async {
    // showLoader(context);
    print('calling');
    Map data = {
      "id": "${widget.inquiry_id}",
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
      "inquiry_status": _selectedstatus,
      "response": response_controller.text,
      "assign_to": assign_controller.text,
      "birth_date": birth_date_controller.text,
      "referred_by": reffered_controller.text,
      "voucher_number" : "String",
      "total_credit_amount" : 0,
      "total_debit_amount" : 0,
      // "created_at": "2022-02-02T08:30:46.332Z",
      "updated_at": "2022-02-02T08:30:46.332Z"
    };

    print(data);

    var url = "https://magnetbackend.fsp.media/api/inquiry";

    var response = await http_service.put(url, data);

    if(response["success"]){
      Get.offAllNamed(BindingUtils.inquiry_Screen_Route);
    }

  }


  Widget ledger_setup() {
    final screenSize = MediaQuery.of(context).size;

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

    return GetBuilder<inquiry_Edit_controller>(
      init: _inquiryEditController,
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
                      margin: EdgeInsets.only(left: 20,top: 20),
                      child: Text(
                        'Edit inquiry',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,

                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 15, left: 20),
                      child: Text(
                        'Basic Information',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: name_controller,
                        labelText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: bussiness_name_controller,
                        labelText: 'Bussiness Name',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: email_controller,
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: mobile_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Mobile no',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              controller: inquiry_date_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.only(top: 5, left: 12),
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
                          GestureDetector(
                            onTap: () async {
                              inquiry_DatePicker(context);
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
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              controller: follow_up_date_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.only(top: 5, left: 12),
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
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // if (!reg_pan.hasMatch(
                            //     Customer_pan_number_controller.text)) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //           content: Text("Enter Valid PAN Number")));
                            //   return;
                            // }
                            //
                            // if (!reg_gst.hasMatch(
                            //     Customer_gisin_number_controller.text)) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //           content:
                            //               Text("Enter Valid GSTIN Number")));
                            //   return;
                            // }

                            _inquiryEditController
                                .pageIndexUpdate('02');
                            _pageController_customer!.jumpToPage(1);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 0),
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
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20),
                      child: Text(
                        'Edit inquiry',
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
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: inquiry_for_controller,
                        labelText: 'Inquiry For',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Estimate_price_controller,
                        labelText: 'Estimate Price',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Source_promotion_controller,
                        labelText: 'Source of Promotion',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
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
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: response_controller,
                        labelText: 'Response',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: assign_controller,
                        labelText: 'Assign To',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: CustomTextFieldWidget_two(
                        controller: reffered_controller,
                        labelText: 'Reffered By',
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              controller: birth_date_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.only(top: 5, left: 12),
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
                          GestureDetector(
                            onTap: () async {
                              birth_DatePicker(context);
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
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _inquiryEditController
                                .pageIndexUpdate('01');
                            _pageController_customer!.jumpToPage(0);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorUtils.blueColor),
                              color: ColorUtils.ogback,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 29, vertical: 9),
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
                            // if(Customer_mobile_number_controller.text.length != 10 )
                            //   {
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(SnackBar(
                            //         content: Text(
                            //             "Mobile number must be 10 digits")));
                            //     return;
                            //   }
                            // if (!reg_email.hasMatch(
                            //     Customer_email_controller.text)) {
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(SnackBar(
                            //       content: Text(
                            //           "Enter Valid EmailID")));
                            //   return;
                            // }
                            inquiry_put_API();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 0),
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
