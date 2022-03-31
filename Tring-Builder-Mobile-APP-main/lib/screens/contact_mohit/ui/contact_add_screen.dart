import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../AppDetails.dart';
import '../../../common/Texts.dart';
import '../../../common/common_color.dart';
import '../../../common/common_image.dart';
import '../../../common/common_style.dart';
import '../../../common/common_textformfield.dart';
import '../../../common/common_widget.dart';
import '../../drawer/ui/drawerscreen.dart';
import '../controller/contactsController.dart';

class ContactAddScreen extends StatefulWidget {
  final String contact_type;
  const ContactAddScreen({Key? key, required this.contact_type}) : super(key: key);

  @override
  _ContactAddScreenState createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();


  final contactdetailsController = Get.put(ContactsController());

  @override
  void initState() {
    super.initState();
    contactdetailsController.contact_typeController.text = widget.contact_type;
  }
  final List<String> data = <String>[
    'Phone No',
    'Mobile No',
  ];
  final List<String> data_promotion = <String>[
    'Instagram',
    'Facebook',
    'LinkedIN',
  ];final List<String> data_campaign = <String>[
    'Phone No',
    'Mobile No',
  ];

  DateTime? pickedDate;

  Future<void> birth_datePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        contactdetailsController.birth_date = DateFormat('yyyy-MM-ddTHH:mm:ss').format(pickedDate!);
      });
      setState(() {
        contactdetailsController.contact_bithdateController.text = DateFormat('dd-MM-yyyy').format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
  Future<void> marriage_datePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        contactdetailsController.mrg_date = DateFormat('yyyy-MM-ddTHH:mm:ss').format(pickedDate!);
      });
      setState(() {
        contactdetailsController.contact_marriagedateController.text = DateFormat('dd-MM-yyyy').format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
  final  screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.contact,
      bodyWidget: Scaffold(
        backgroundColor: HexColor(CommonColor.appBackColor),
        key: _globalKey,
        drawer: DrawerScreen(),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: CommonWidget().listingCardDesign(
            context: context,
            getWidget: CommonWidget().CommonButton(
              context: context,
              buttonText: Texts.Save,
              onPressed: () {
                contactdetailsController.storeContacts(context: context);
                // showLoader(context);
                // salesDetailsController.billSubmitValidation(
                //     invoideDate: showInvoiceDate.toString(),
                //     inVoiceNumber: widget.estimateNo.toString(),
                //     context: context
                // ).then((value){
                //   hideLoader(context);
                //   if(value != null){
                //     debugPrint('2-2-2-2-2-2 Values of Sales ${value.toString()}');
                //   }
                // });
              },
            ),
          ),
        ),
        body: GetBuilder<ContactsController>(builder: (values) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(Texts.contact, style: screenHeader()),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CommonWidget().ListviewListingBuilder(
                  context: context,
                  getItemCount: 1,
                  itemBuilder: (context, index) {
                    return CommonWidget().listingCardDesign(
                      context: context,
                      getWidget: Container(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Basic info',
                                  textAlign: TextAlign.left,
                                  style: estimateLabelStyle(),
                                ),
                              ],
                            ),

                            //brokerName and sales
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    readOnly: true,
                                    labelText: "Customer Type",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_typeController,
                                    hintText: "Customer Type",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Name",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_nameController,
                                    hintText: "Name",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Mobile no",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_mobileController,
                                    hintText: "Mobile no",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Email ID",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_emailIdController,
                                    hintText: "Email ID",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Company/Business name",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_companyController,
                                    hintText: "Customer Type",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Businesss Type",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_bussinessTypeController,
                                    hintText: "Broker Name",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Alternate Mobile no",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_alternateNoController,
                                    hintText: "Alternate Mobile no",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Phone no",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_phoneController,
                                    hintText: "Phone no",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: ContainerInnerShadow,
                                        border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                                    height: 44.0,
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
                                                    'Contact On',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: AppDetails.fontSemiBold,
                                                        fontSize: 14.0),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: data
                                                .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: AppDetails.fontSemiBold,
                                                        fontSize: 14.0),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ))
                                                .toList(),
                                            value: contactdetailsController.selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                contactdetailsController.selectedValue = value as String;
                                              });
                                              print(contactdetailsController.selectedValue);
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(CommonImage.dropdown_svg),
                                            iconEnabledColor: Color(0xff007DEF),
                                            iconDisabledColor: Color(0xff007DEF),
                                            buttonHeight: 50,
                                            buttonWidth: 160,
                                            buttonPadding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            buttonDecoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white
                                            ),
                                            buttonElevation: 0,
                                            itemHeight: 40,
                                            itemPadding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownPadding: null,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            dropdownElevation: 8,
                                            scrollbarRadius:
                                            const Radius.circular(40),
                                            scrollbarThickness: 6,
                                            scrollbarAlwaysShow: true,
                                            offset: const Offset(0, -5),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Fax",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_faxController,
                                    hintText: "fax",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Website",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_websiteController,
                                    hintText: "Website",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Birthdate",
                                    readOnly: true,
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_bithdateController,
                                    hintText: "Broker Name",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {
                                      birth_datePicker(context);
                                    },
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "marrige Date",
                                    readOnly: true,
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_marriagedateController,
                                    hintText: "Customer Type",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {
                                      marriage_datePicker(context);
                                    },
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "SocialMedia",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_socialmedaiController,
                                    hintText: "SocialMedia",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Address",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_addressController,
                                    hintText: "Address",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: ContainerInnerShadow,
                                        border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                                    height: 44.0,
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
                                                    'source of promotion',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: AppDetails.fontSemiBold,
                                                        fontSize: 14.0),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: data_promotion
                                                .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style:TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: AppDetails.fontSemiBold,
                                                        fontSize: 14.0),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ))
                                                .toList(),
                                            value: contactdetailsController.selectedValue_promotion,
                                            onChanged: (value) {
                                              setState(() {
                                                contactdetailsController.selectedValue_promotion = value as String;
                                              });
                                              print(contactdetailsController.selectedValue_promotion);
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(CommonImage.dropdown_svg),
                                            iconEnabledColor: Color(0xff007DEF),
                                            iconDisabledColor: Color(0xff007DEF),
                                            buttonHeight: 50,
                                            buttonWidth: 160,
                                            buttonPadding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            buttonDecoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white
                                            ),
                                            buttonElevation: 0,
                                            itemHeight: 40,
                                            itemPadding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownPadding: null,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            dropdownElevation: 8,
                                            scrollbarRadius:
                                            const Radius.circular(40),
                                            scrollbarThickness: 6,
                                            scrollbarAlwaysShow: true,
                                            offset: const Offset(0, -5),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: ContainerInnerShadow,
                                        border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                                    height: 44.0,
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
                                                    'Campaign',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: AppDetails.fontSemiBold,
                                                        fontSize: 14.0),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: data_campaign
                                                .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: AppDetails.fontSemiBold,
                                                        fontSize: 14.0),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ))
                                                .toList(),
                                            value: contactdetailsController.selectedValue_campaign,
                                            onChanged: (value) {
                                              setState(() {
                                                contactdetailsController.selectedValue_campaign = value as String;
                                              });
                                              print(contactdetailsController.selectedValue_campaign);
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(CommonImage.dropdown_svg),
                                            iconEnabledColor: Color(0xff007DEF),
                                            iconDisabledColor: Color(0xff007DEF),
                                            buttonHeight: 50,
                                            buttonWidth: 160,
                                            buttonPadding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            buttonDecoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white
                                            ),
                                            buttonElevation: 0,
                                            itemHeight: 40,
                                            itemPadding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownPadding: null,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            dropdownElevation: 8,
                                            scrollbarRadius:
                                            const Radius.circular(40),
                                            scrollbarThickness: 6,
                                            scrollbarAlwaysShow: true,
                                            offset: const Offset(0, -5),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Desc",
                                    textInputType: TextInputType.text,
                                    controller: contactdetailsController.contact_descriptionController,
                                    hintText: "Desc",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 21.0,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

}
