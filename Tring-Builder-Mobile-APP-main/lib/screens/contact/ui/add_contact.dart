import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/contact/controller/addcontactcontroller.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';

import '../../../AppDetails.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  String dropdownvalue = "Select Cutomer Type";
  String dropdownvalue1 = "One";
  String contactOn = "Select Contact on";
  String sourceOfPromotion = "Select Source of Promotion";
  var items = [
    'Select Cutomer Type',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  late double screenHeight, screenWidth;

  final _formKey = GlobalKey<FormState>();
  final addContactController = Get.put(AddContactController());

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      drawer: DrawerScreen(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor(CommonColor.appBackColor),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: HexColor(CommonColor.textDarkColor),
          ),
        ),
        actions: [
          CommonWidget().appBarAction(),
        ],
      ),
      body: InkWell(
        highlightColor: HexColor(CommonColor.appBackColor),
        splashColor: HexColor(CommonColor.appBackColor),
        focusColor: HexColor(CommonColor.appBackColor),
        hoverColor: HexColor(CommonColor.appBackColor),
        onTap: () => CommonWidget().hideFocusKeyBoard(context),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    Texts.contactcustomer,
                    style: screenHeader(),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2.0),
                      ],
                    ),
                    padding: const EdgeInsets.only(top: 2.0, right: 10.0),
                    margin: const EdgeInsets.only(
                      left: 0.0,
                    ),
                    width: screenWidth,
                    height: 46.0,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 5),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 5.0, top: 0.0, right: 0.0, bottom: 0.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 5),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: AppDetails.fontSemiBold,
                        ),
                        hintText: "Name",
                        fillColor: Colors.white,
                      ),
                      icon: Image.asset(
                        CommonImage.custome_dropdown_image,
                        height: 4.0,
                        width: 10.0,
                        fit: BoxFit.fill,
                      ),
                      value: dropdownvalue,
                      onChanged: (String? Value) {
                        setState(() {
                          dropdownvalue = Value!;
                        });
                      },
                      items: items
                          .map(
                            (cityTitle) => DropdownMenuItem(
                              value: cityTitle,
                              child: Text(
                                "$cityTitle",
                                style: TextStyle(
                                    fontFamily: AppDetails.fontSemiBold,
                                    color: HexColor(CommonColor.textDarkColor),
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 2.0),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 22.0, bottom: 20.0),
                          child: Text(
                            Texts.BasicInfo,
                            style: screenSubheaderStyle(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 22.0,
                            right: 22.0,
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: CommonTextFieldLabel(
                            labelText: Texts.name,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.name,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.nameController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.nameController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .nameErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.mobileno,
                            textInputType: TextInputType.number,
                            validator: (value) {},
                            maxLength: 10,
                            hintText: Texts.mobileno,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.mobileNoController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.mobileNoController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .mobileNoErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.emailid,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {},
                            hintText: Texts.emailid,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.emailIdController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.emailIdController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .emailErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.companybusiness,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.companybusiness,
                            textInputAction: TextInputAction.next,
                            controller:
                                addContactController.companyBusinessController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController
                                      .companyBusinessController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .companyErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor(CommonColor.appActiveColor),
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -1,
                                  blurRadius: 0.2,
                                )
                              ],
                            ),
                            width: screenWidth,
                            height: 46.0,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Business Type',
                                contentPadding: EdgeInsets.only(
                                    top: 5.0, left: 5.0, bottom: 5.0),
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text("Business Type"),
                                  isExpanded: true,
                                  value:
                                      addContactController.businessType.value,
                                  elevation: 4,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue1 = newValue!;
                                    });
                                    addContactController.businessType.value =
                                        newValue.toString();
                                  },
                                  items: <String>['One', 'Two', 'Free', 'Four']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppDetails.fontSemiBold,
                                            fontSize: 14.0),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.businessType
                                          .trim()
                                          .toString() ==
                                      "One")
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .businessTypeErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.alternateMobileNo,
                            textInputType: TextInputType.number,
                            maxLength: 10,
                            validator: (value) {},
                            hintText: Texts.alternateMobileNo,
                            textInputAction: TextInputAction.next,
                            controller: addContactController
                                .alternateMobileNoController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController
                                      .alternateMobileNoController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .alternatePhoneErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.phoneno,
                            textInputType: TextInputType.number,
                            maxLength: 10,
                            validator: (value) {},
                            hintText: Texts.phoneno,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.phoneNoController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.phoneNoController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .phoneNoErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor(CommonColor.appActiveColor),
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -1,
                                  blurRadius: 0.2,
                                )
                              ],
                            ),
                            width: screenWidth,
                            height: 46.0,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Contact on',
                                contentPadding: EdgeInsets.only(
                                    top: 5.0, left: 5.0, bottom: 5.0),
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text("Contact on"),
                                  isExpanded: true,
                                  value: addContactController.constactOn.value,
                                  elevation: 4,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      contactOn = newValue!;
                                    });
                                    addContactController.constactOn.value =
                                        newValue.toString();
                                  },
                                  items: <String>[
                                    'Select Contact on',
                                    'Mobile No',
                                    'Phone no'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppDetails.fontSemiBold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.constactOn
                                          .trim()
                                          .toString() ==
                                      "Select Contact on")
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .contactOnErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.fax,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.fax,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.faxController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.faxController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .faxErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.website,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.website,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.websiteController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.websiteController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .websiteErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0,
                                    right: 15.0,
                                    top: 0.0,
                                    bottom: 10.0),
                                child: CommonTextFieldLabelIcon(
                                  icon: CommonImage.date_icon,
                                  labelText: Texts.BirthDate,
                                  textInputType: TextInputType.datetime,
                                  validator: (value) {},
                                  hintText: Texts.BirthDate,
                                  textInputAction: TextInputAction.next,
                                  controller: addContactController
                                      .dateofbirthController,
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0,
                                    right: 22.0,
                                    top: 0.0,
                                    bottom: 10.0),
                                child: CommonTextFieldLabelIcon(
                                  icon: CommonImage.date_icon,
                                  labelText: Texts.MarriageDate,
                                  textInputType: TextInputType.text,
                                  validator: (value) {},
                                  hintText: Texts.MarriageDate,
                                  textInputAction: TextInputAction.next,
                                  controller: addContactController
                                      .marriageDateController,
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Obx(
                                () => (addContactController
                                            .isCheckAddContactValidatation
                                            .value ==
                                        true)
                                    ? (addContactController
                                            .dateofbirthController.text
                                            .trim()
                                            .isEmpty)
                                        ? CommonWidget()
                                            .addContactshowErrorMessage(
                                                errorMessage:
                                                    addContactController
                                                        .birthDateErrorMessage
                                                        .value
                                                        .toString())
                                        : Container()
                                    : Container(),
                              ),
                            ),
                            Flexible(
                              child: Obx(
                                () => (addContactController
                                            .isCheckAddContactValidatation
                                            .value ==
                                        true)
                                    ? (addContactController
                                            .marriageDateController.text
                                            .trim()
                                            .isEmpty)
                                        ? CommonWidget()
                                            .addContactshowErrorMessage(
                                                errorMessage:
                                                    addContactController
                                                        .marriageDateErrorMessage
                                                        .value
                                                        .toString())
                                        : Container()
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => (addContactController
                                          .isBirthDateError.value ==
                                      true)
                                  ? Flexible(
                                      child: CommonWidget()
                                          .addContactshowErrorMessage(
                                        errorMessage: addContactController
                                            .birthDateErrorMessage.value
                                            .toString(),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.only(top: 5.0),
                                    ),
                            ),
                            Obx(
                              () => (addContactController
                                          .isMarriageDateError.value ==
                                      true)
                                  ? Flexible(
                                      child: CommonWidget()
                                          .addContactshowErrorMessage(
                                        errorMessage: addContactController
                                            .marriageDateErrorMessage.value
                                            .toString(),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.only(top: 5.0),
                                    ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.socialMedialink,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.socialMedialink,
                            textInputAction: TextInputAction.next,
                            controller: addContactController
                                .socialMediaAccountController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController
                                      .socialMediaAccountController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .socialMediaErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.address,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.address,
                            textInputAction: TextInputAction.next,
                            controller: addContactController.addressController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.addressController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .addressErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor(CommonColor.appActiveColor),
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -1,
                                  blurRadius: 0.2,
                                )
                              ],
                            ),
                            width: screenWidth,
                            height: 46.0,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Source of promotion',
                                contentPadding: EdgeInsets.only(
                                    top: 5.0, left: 5.0, bottom: 5.0),
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(
                                    "Source of promotion",
                                    style: TextStyle(
                                      fontFamily: AppDetails.fontSemiBold,
                                      color:
                                          HexColor(CommonColor.subHeaderColor),
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  isExpanded: true,
                                  value: addContactController
                                      .sourcePromation.value,
                                  elevation: 4,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      sourceOfPromotion = newValue!;
                                    });
                                    addContactController.sourcePromation.value =
                                        newValue.toString();
                                  },
                                  items: <String>[
                                    'Select Source of Promotion',
                                    'Mobile No',
                                    'Phone no'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppDetails.fontSemiBold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController.sourcePromation.value ==
                                      "Select Source of Promotion")
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .sourceOfPromotionErrorMessage.value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 0.0, bottom: 10.0),
                          child: CommonTextFieldLabel(
                            labelText: Texts.DescriptionInformation,
                            textInputType: TextInputType.text,
                            validator: (value) {},
                            hintText: Texts.DescriptionInformation,
                            textInputAction: TextInputAction.next,
                            controller: addContactController
                                .descriptionInformationController,
                            onTap: () {},
                          ),
                        ),
                        Obx(
                          () => (addContactController
                                      .isCheckAddContactValidatation.value ==
                                  true)
                              ? (addContactController
                                      .descriptionInformationController.text
                                      .trim()
                                      .isEmpty)
                                  ? CommonWidget().addContactshowErrorMessage(
                                      errorMessage: addContactController
                                          .descriptionInformationErrorMessage
                                          .value
                                          .toString())
                                  : Container()
                              : Container(),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: screenWidth,
                  height: 70.0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2.0),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          height: 40.0,
                          minWidth: 108,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: HexColor(CommonColor.appActiveColor),
                            // onPressed: () => addContactController
                            //     .validateValue(context: context)
                            //     .then(
                            //   (value) {
                            //     debugPrint(
                            //         '1-1-1-1-1 Add Contact Validation ${value.toString()}');
                            //     if (value == true) {
                            //       addContactController.cleanErrorMessage();
                            //       showLoader(context);
                            //       addContactController
                            //           .storeContactValue()
                            //           .then((value) {
                            //         if (value != null) {
                            //           hideLoader(context);
                            //         }
                            //       });
                            //     }
                            //   },
                            onPressed: () => addContactController
                                .isCheckAddContactValidatation.value = true,
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: AppDetails.fontSemiBold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
