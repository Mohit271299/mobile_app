import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class addCompanyScreen extends StatefulWidget {
  const addCompanyScreen({Key? key}) : super(key: key);

  @override
  _addCompanyScreenState createState() => _addCompanyScreenState();
}

class _addCompanyScreenState extends State<addCompanyScreen> {
  PageController? _pageController;
  Company_profile_controller _companyDetailsController =
      Get.find(tag: Company_profile_controller().toString());

  var reg_pan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  var reg_cin = RegExp(
      "([L|U]{1})([0-9]{5})([A-Za-z]{2})([0-9]{4})([A-Za-z]{3})([0-9]{6})");
  var reg_gst =
      RegExp("^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");
  var reg_ifsc = RegExp("^[A-Z]{4}0[A-Z0-9]{6}");

  //Company_profile//
  final cnameController = TextEditingController();
  final pan_number_Controller = TextEditingController();
  final tan_number_Controller = TextEditingController();
  final f_year_start_date_Controller = TextEditingController();
  final f_year_end_date_Controller = TextEditingController();
  final incorporate_date_Controller = TextEditingController();
  final book_start_date_Controller = TextEditingController();
  final start_prefix_Controller = TextEditingController();
  final middle_prefix_Controller = TextEditingController();
  final end_number_Controller = TextEditingController();
  final invoice_format_Controller = TextEditingController();
  final cin_number_Controller = TextEditingController();

  //Company_address//
  final company_address_Controller = TextEditingController();
  final city_Controller = TextEditingController();
  final pincode_Controller = TextEditingController();
  final state_Controller = TextEditingController();
  final country_Controller = TextEditingController();
  final stdcode_Controller = TextEditingController();
  final ofc_number_Controller = TextEditingController();
  final mobile_number_Controller = TextEditingController();
  final company_email_Controller = TextEditingController();
  final responsible_person_Controller = TextEditingController();
  final d_responsible_person_Controller = TextEditingController();

  //Bussiness_Gst//
  final gst_type_Controller = TextEditingController();
  final gst_no_Controller = TextEditingController();
  final nature_bussiness_Controller = TextEditingController();
  final gst_registration_date_Controller = TextEditingController();

  final bank_name_Controller = TextEditingController();
  final account_number_Controller = TextEditingController();
  final ifsc_code_Controller = TextEditingController();
  final ac_holdername_Controller = TextEditingController();

  Future<void> f_year_start_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        f_year_start_date_Controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> f_year_end_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        f_year_end_date_Controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> incorporate_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        incorporate_date_Controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> book_start_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        book_start_date_Controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> gst_registration_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        gst_registration_date_Controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: false);
    middle_prefix_Controller.text = '-';
    middle_prefix_Controller.text =
        '${start_prefix_Controller.text} ${middle_prefix_Controller.text}${end_number_Controller.text}';
    pan_number_Controller.text = 'BNZAA2318J';
    cin_number_Controller.text = 'U12345AA1234AAA123456';
    gst_no_Controller.text = '06BZAHM6385P6Z2';
    ifsc_code_Controller.text = 'SBIN0125620';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    String dialCodedigits = "+00";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.blueColor,
        title: Text(
          'Company Master',
          style: FontStyleUtility.h20(
            fontColor: ColorUtils.whiteColor,
            fontWeight: FWT.semiBold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<Company_profile_controller>(
          init: _companyDetailsController,
          builder: (_) {
            print(_companyDetailsController.pageIndex);
            return Stack(
              children: [
                Container(
                  color: ColorUtils.blueColor,
                ),
                Container(
                  margin: EdgeInsets.only(top: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Color(0xfff3f3f3),
                  ),
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 40, bottom: 40),
                              width: screenSize.width * 0.90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.whiteColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'Company Detail',
                                      style: FontStyleUtility.h20(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenSize.height * 0.10,
                                    width: screenSize.height * 0.10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorUtils.lightBlueColor,
                                      border: Border.all(
                                          color: ColorUtils.boarderColor),
                                    ),
                                    child: imageFile == null
                                        ? GestureDetector(
                                            onTap: () {
                                              _showDialog();
                                            },
                                            child: Image(
                                              image: AssetImage(
                                                AssetUtils
                                                    .profileImagePreviewPng,
                                              ),
                                            ),
                                          )
                                        : Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: cnameController,
                                      labelText: 'Company Name',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: pan_number_Controller,
                                      labelText: 'PAN Number',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: tan_number_Controller,
                                      labelText: 'TAN Number',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            controller:
                                                f_year_start_date_Controller,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              labelText:
                                                  'Financial Year Start Date',
                                              labelStyle: FontStyleUtility.h12(
                                                  fontColor:
                                                      ColorUtils.greyTextColor,
                                                  fontWeight: FWT.medium),
                                              border: InputBorder.none,
                                            ),
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            f_year_start_DatePicker(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
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
                                    margin: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            controller:
                                                f_year_end_date_Controller,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              labelText:
                                                  'Financial Year End Date',
                                              labelStyle: FontStyleUtility.h12(
                                                  fontColor:
                                                      ColorUtils.greyTextColor,
                                                  fontWeight: FWT.medium),
                                              border: InputBorder.none,
                                            ),
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            f_year_end_DatePicker(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
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
                                    margin: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            controller:
                                                incorporate_date_Controller,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              labelText: 'Incorporation Date',
                                              labelStyle: FontStyleUtility.h12(
                                                  fontColor:
                                                      ColorUtils.greyTextColor,
                                                  fontWeight: FWT.medium),
                                              border: InputBorder.none,
                                            ),
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            incorporate_DatePicker(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
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
                                    margin: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            controller:
                                                book_start_date_Controller,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              labelText: 'Booking Start Date',
                                              labelStyle: FontStyleUtility.h12(
                                                  fontColor:
                                                      ColorUtils.greyTextColor,
                                                  fontWeight: FWT.medium),
                                              border: InputBorder.none,
                                            ),
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            book_start_DatePicker(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFieldWidget_two(
                                            controller: start_prefix_Controller,
                                            labelText: 'Invoice',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomTextFieldWidget_two(
                                            readOnly: true,
                                            align: TextAlign.center,
                                            controller:
                                                middle_prefix_Controller,
                                            labelText: 'Book Start Date',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomTextFieldWidget_two(
                                            controller: end_number_Controller,
                                            labelText: '001',
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                        controller: invoice_format_Controller,
                                        labelText: 'Invoice-10'),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: cin_number_Controller,
                                      labelText: 'CIN',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _companyDetailsController
                                              .pageIndexUpdate('02');
                                          _pageController!.jumpToPage(1);

                                          if (!reg_pan.hasMatch(
                                              pan_number_Controller.text)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Enter Valid PAN Number")));
                                            return;
                                          }
                                          if (!reg_cin.hasMatch(
                                              cin_number_Controller.text)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Enter Valid CIN Number")));
                                            return;
                                          }
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
                                      )
                                    ],
                                  ),

                                  // Container(
                                  //   margin: EdgeInsets.only(bottom: 50),
                                  //   child: MyLeadingItemCustomButtonWidget(
                                  //     alignment:
                                  //         Alignment.center,
                                  //     title: 'Next',
                                  //     onTap: () {
                                  //       _companyDetailsController
                                  //           .pageIndexUpdate(
                                  //               '02');
                                  //       _pageController!
                                  //           .jumpToPage(1);
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 40),
                              width: screenSize.width * 0.90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.whiteColor,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'Registered Address',
                                      style: FontStyleUtility.h20(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: company_address_Controller,
                                      labelText: 'Address',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: city_Controller,
                                      labelText: 'City',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: pincode_Controller,
                                      labelText: 'Pincode',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: state_Controller,
                                      labelText: 'State',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: country_Controller,
                                      labelText: 'Country',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: stdcode_Controller,
                                      labelText: 'STD Code',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: ofc_number_Controller,
                                      labelText: 'Office Number',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            child: CountryCodePicker(
                                              onChanged: (country) {
                                                setState(() {
                                                  dialCodedigits =
                                                      country.dialCode!;
                                                });
                                              },
                                              initialSelection: "IN",
                                              showCountryOnly: false,
                                              showOnlyCountryWhenClosed: false,
                                              favorite: [
                                                "+1",
                                                "US",
                                                "+91",
                                                "IN"
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: 25,
                                              child: VerticalDivider(
                                                  color: Colors.black87)),
                                          Expanded(
                                            child: CustomTextFieldWidget_two(
                                              controller:
                                                  mobile_number_Controller,
                                              labelText: 'Phone Number',
                                            ),
                                          ),
                                        ],
                                      )),

                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: company_email_Controller,
                                      labelText: 'Email Id',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller: responsible_person_Controller,
                                      labelText: 'Responsible person',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    child: CustomTextFieldWidget_two(
                                      controller:
                                          d_responsible_person_Controller,
                                      labelText:
                                          'Designation of Responsible Person',
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment
                                  //           .spaceEvenly,
                                  //   children: [
                                  //     MyLeadingItemCustomButtonWidget(
                                  //       alignment:
                                  //           Alignment.center,
                                  //       backGroundColor:
                                  //           ColorUtils
                                  //               .whiteColor,
                                  //       width:
                                  //           screenSize.width *
                                  //               0.40,
                                  //       textColor: ColorUtils
                                  //           .darkBlueColor,
                                  //       borderColor: ColorUtils
                                  //           .purpleBorderColor,
                                  //       title: 'Back',
                                  //       onTap: () {
                                  //         _companyDetailsController
                                  //             .pageIndexUpdate(
                                  //                 '01');
                                  //         _pageController!
                                  //             .jumpToPage(0);
                                  //       },
                                  //     ),
                                  //     MyLeadingItemCustomButtonWidget(
                                  //       alignment:
                                  //           Alignment.center,
                                  //       width:
                                  //           screenSize.width *
                                  //               0.40,
                                  //       title: 'Next',
                                  //       onTap: () {
                                  //         _companyDetailsController
                                  //             .pageIndexUpdate(
                                  //                 '03');
                                  //         _pageController!
                                  //             .jumpToPage(2);
                                  //       },
                                  //     ),
                                  //
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _companyDetailsController
                                              .pageIndexUpdate('01');
                                          _pageController!.jumpToPage(0);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 30, bottom: 30),
                                          height: 32,
                                          decoration: BoxDecoration(
                                              color: const Color(0xfff3f3f3),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xff007DEF))),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 28, vertical: 9),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Back',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff9d9d9d)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _companyDetailsController
                                              .pageIndexUpdate('03');
                                          _pageController!.jumpToPage(2);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 30, bottom: 30, left: 10),
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
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: screenSize.width * 0.90,
                              margin: EdgeInsets.symmetric(vertical: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      child: Text(
                                        'GST Info.',
                                        style: FontStyleUtility.h20(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: gst_type_Controller,
                                        labelText: 'GST Registration Type',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: gst_no_Controller,
                                        labelText: 'GST Number',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: nature_bussiness_Controller,
                                        labelText: 'Nature of Business',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              readOnly: true,
                                              controller:
                                                  gst_registration_date_Controller,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 5, left: 12),
                                                labelText: 'Registration Date',
                                                labelStyle:
                                                    FontStyleUtility.h12(
                                                        fontColor: ColorUtils
                                                            .greyTextColor,
                                                        fontWeight: FWT.medium),
                                                border: InputBorder.none,
                                              ),
                                              style: FontStyleUtility.h14(
                                                  fontColor:
                                                      ColorUtils.blackColor,
                                                  fontWeight: FWT.semiBold),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              gst_registration_DatePicker(
                                                  context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _companyDetailsController
                                                .pageIndexUpdate('02');
                                            _pageController!.jumpToPage(1);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, top: 30, bottom: 30),
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: const Color(0xfff3f3f3),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xff007DEF))),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 28,
                                                      vertical: 9),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Back',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff9d9d9d)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (!reg_gst.hasMatch(
                                                gst_no_Controller.text)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Enter Valid GST Number")));
                                              return;
                                            }

                                            _companyDetailsController
                                                .pageIndexUpdate('04');
                                            _pageController!.jumpToPage(3);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 30, bottom: 30, left: 10),
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
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 40),
                              width: screenSize.width * 0.90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      child: Text(
                                        'Bank Details',
                                        style: FontStyleUtility.h20(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: bank_name_Controller,
                                        labelText: 'Bank Name',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: account_number_Controller,
                                        labelText: 'Account Number',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: ifsc_code_Controller,
                                        labelText: 'IFSC code',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: CustomTextFieldWidget_two(
                                        controller: ac_holdername_Controller,
                                        labelText: 'Account Holder Name',
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _companyDetailsController
                                                .pageIndexUpdate('03');
                                            _pageController!.jumpToPage(2);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, top: 30, bottom: 30),
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: const Color(0xfff3f3f3),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xff007DEF))),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 28,
                                                      vertical: 9),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Back',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff9d9d9d)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (!reg_ifsc.hasMatch(
                                                ifsc_code_Controller.text)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Enter Valid IFSC Number")));
                                              return;
                                            }

                                            asnMethod();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 30, bottom: 30, left: 10),
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
                                                'DashBoard',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(39.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 19, left: 20, right: 20),
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
                              ((_companyDetailsController.pageIndex == '02') ||
                                      (_companyDetailsController.pageIndex ==
                                          '03') ||
                                      (_companyDetailsController.pageIndex ==
                                          '04')
                                  ? 68
                                  : ((_companyDetailsController.pageIndex ==
                                              '03') ||
                                          (_companyDetailsController
                                                  .pageIndex ==
                                              '04')
                                      ? 136
                                      : ((_companyDetailsController.pageIndex ==
                                              '04')
                                          ? 207
                                          : 207)))),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  String? fileName;
  File? imageFile;

  /// Get from gallery
  _getFromGallery() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Pick Image from"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: const Text("Gallery")),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: const Text("Camera")),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String Token = "";
  String userID = "";
  String user_name = "";

  Future asnMethod() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    userID = await PreferenceManager().getPref(Api_url.user_id);
    print(userID.toString());
    print(Token.toString());

    Timer(Duration(microseconds: 500), () {
      company_profile();
    });
    setState(() {});
  }

  Future company_profile() async {
    print("Calling");
    Map data = {
      "business_address": {
        // "id": 0,
        // "business_id": 0,
        "address": company_address_Controller.text,
        "city": city_Controller.text,
        "pincode": pincode_Controller.text,
        "state": state_Controller.text,
        "country": country_Controller.text,
        "std_code": stdcode_Controller.text,
        "office_number": ofc_number_Controller.text,
        "mobile_number": mobile_number_Controller.text,
        "country_code": "+91",
        "business_email": company_email_Controller.text,
        "responsible_person": responsible_person_Controller.text,
        "designation_responsible_person": d_responsible_person_Controller.text,
      },
      "business_gst": {
        // "id": 0,
        // "company_profile_id": 0,
        "gst_registration_type": gst_type_Controller.text,
        "gst_no": gst_no_Controller.text,
        "registration_date": gst_registration_date_Controller.text,
        "nature_of_business": "goods",
        "ifsc_code": ifsc_code_Controller.text,
        "bank_name": bank_name_Controller.text,
        "account_number": account_number_Controller.text,
        "account_holder_name": ac_holdername_Controller.text,
      },
      // "id": ,
      "logo": "string",
      "user_id": int.parse(userID),
      "company_name": cnameController.text,
      "pan_number": pan_number_Controller.text,
      "tan_number": tan_number_Controller.text,
      "financial_year_start_date": f_year_start_date_Controller.text,
      "financial_year_end_date": f_year_end_date_Controller.text,
      "incorporation_date": incorporate_date_Controller.text,
      "book_start_date": book_start_date_Controller.text,
      "start_prefix": start_prefix_Controller.text,
      "middle_symbol": middle_prefix_Controller.text,
      "number_start": end_number_Controller.text,
      "invoice_format": invoice_format_Controller.text,
      "cin": cin_number_Controller.text,
      "is_default": true,
      // "user": {},
      // "created_at": "2021-12-29T07:16:11.562Z",
      // "updated_at": "2021-12-29T07:16:11.562Z"
    };
    print(data);

    var url = Api_url.Company_profile_api;

    var response = await http_service.post(url, data);

    if (response["success"]) {
      Get.offAllNamed(BindingUtils.dashBoardScreenRoute);
  }
}
}