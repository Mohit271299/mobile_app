import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/leads/ui/selectFlat/LeadsSelectFloor.dart';
import 'package:tring/screens/leads/ui/selectFlat/SelectTower.dart';
import 'package:tring/screens/leads/ui/selectFlat/leadsSelectNumber.dart';

import '../../../AppDetails.dart';
import '../../../common/common_image.dart';
import '../../activity/controller/ActivityController.dart';
import '../../drawer/ui/drawerscreen.dart';
import '../controller/LeadsController.dart';
import 'leads_add_screen.dart';
class EditLeads extends StatefulWidget {
  const EditLeads({Key? key}) : super(key: key);

  @override
  _EditLeadsState createState() => _EditLeadsState();
}

class _EditLeadsState extends State<EditLeads> {
  late double screenHeight, screenWidth;
  final leadscontroller = Get.put(LeadsController());

  DateTime? pickedDate;

  var list_hour = Iterable<int>.generate(100).toList();
  var list_minute = Iterable<int>.generate(100).toList();

  Future<void> InquirydatePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        leadscontroller.inquirydate =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        leadscontroller.inquirydateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> folloUpdatePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        leadscontroller.folloUpdate =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        leadscontroller.folloUpdateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> siteVisitdatePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        leadscontroller.sitevisitdate =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        leadscontroller.sitevisitdateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  List<source_promotion> type = <source_promotion>[
    const source_promotion('Campion', 'Campion'),
    const source_promotion('Banner Hoardings', 'Banner Hoardings'),
    const source_promotion('Call', 'Call'),
    const source_promotion('Google', 'Google'),
    const source_promotion('Facebook', 'Facebook'),
    const source_promotion('Newspaper', 'Newspaper'),
    const source_promotion('Instagram', 'Instagram'),
    const source_promotion('Website', 'Website'),
    const source_promotion('Referred by Member', 'Referred by Member'),
    const source_promotion(
        'Referred by Friends Others', 'Referred by Friends Others'),
    const source_promotion('Referred by Employee', 'Referred by Employee'),
    const source_promotion('Referred by Customer', 'Referred by Customer'),
    const source_promotion('Walk - In', 'Walk - In'),
    const source_promotion('Brochure Pamphlet', 'Brochure Pamphlet'),
    const source_promotion('Social Media', 'Social Media'),
    const source_promotion('Television Add', 'Television Add'),
    const source_promotion('Internet Marketing', 'Internet Marketing'),
    const source_promotion('Email Marketing', 'Email Marketing'),
    const source_promotion('SMS Marketing', 'SMS Marketing'),
    const source_promotion('News Advertisement', 'News Advertisement'),
    const source_promotion('Direct Traffic', 'Direct Traffic'),
    const source_promotion('Inbound Email', 'Inbound Email'),
    const source_promotion('Inbound Phone call', 'Inbound Phone call'),
    const source_promotion('Organic Search', 'Organic Search'),
    const source_promotion('Outbound Phone call', 'Outbound Phone call'),
    const source_promotion('Partner Referral', 'Partner Referral'),
    const source_promotion('Pay per Click Ads', 'Pay per Click Ads'),
    const source_promotion('Referral Sites', 'Referral Sites'),
    const source_promotion('Trade Show', 'Trade Show'),
    const source_promotion('Unknown', 'Unknown'),
    const source_promotion('Other', 'Other'),
  ];

  List<source_promotion> leadStatus = <source_promotion>[
    const source_promotion('Opportunity', 'Opportunity'),
    const source_promotion('Customer', 'Customer'),
    const source_promotion('Prospect', 'Prospect'),
    const source_promotion('Disqualified', 'Disqualified'),
    const source_promotion('Invalid', 'Invalid'),
  ];


  @override
  void initState() {
    super.initState();
    // leadscontroller.customerController.text =
    //     widget.selectCustomerName.toString();
    // leadscontroller.selectCustomerId.value = widget.selectCustomerId.toString();
  }


  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     '1-1-1-1-1- Inside the Select Customer Details ${widget.selectCustomerId
    //         .toString()} == ${widget.selectCustomerName.toString()}');
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.activity,
      bodyWidget: Scaffold(
        drawerScrimColor: HexColor(CommonColor.appBackColor),
        drawer: DrawerScreen(),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: CommonWidget().listingCardDesign(
            context: context,
            getWidget: Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: CommonWidget().CommonButton(
                context: context,
                buttonText: Texts.Save,
                onPressed: () {
                  //
                  // leadscontroller.storeLeads(context: context,
                  //     contactID: widget.selectCustomerId!,
                  //     contactName: widget.selectCustomerName!);
                  //
                  // salesDetailsController.billSubmitValidation(
                  //     invoideDate: showInvoiceDate.toString(),
                  //     inVoiceNumber: widget.estimateNo.toString(),
                  //     context: context
                  // ).then((value){
                  //     hideLoader(context);
                  //   if(value != null){
                  //     debugPrint('2-2-2-2-2-2 Values of Sales ${value.toString()}');
                  //   }
                  // });
                },
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => CommonWidget().hideFocusKeyBoard(context),
                child: Container(
                  width: screenWidth,
                  child: Text(Texts.leads, style: screenHeader()),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              CommonWidget().listingCardDesign(
                getWidget: Container(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Leads Details',
                            textAlign: TextAlign.left,
                            style: estimateLabelStyle(),
                          ),
                        ],
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        readOnly: true,
                        labelText: "Customer Name",
                        textInputType: TextInputType.text,
                        controller: leadscontroller.customerController,
                        hintText: "Customer Name",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CommonTextFieldLabel(
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "Flat No",
                              textInputType: TextInputType.text,
                              controller: leadscontroller.flatNoController,
                              hintText: "Flat No",
                              textInputAction: TextInputAction.next,
                              onTap: () {},
                              onChanged: (value) {},
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_box_outlined),
                            tooltip: 'Navigation menu',
                            onPressed: () {
                              selectTowerBottomSheet(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        readOnly: true,
                        labelText: "Inquiry Date",
                        textInputType: TextInputType.text,
                        controller: leadscontroller.inquirydateController,
                        hintText: "Inquiry Date",
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          InquirydatePicker(context);
                        },
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CommonTextFieldLabel(
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "FollowUp Date",
                              textInputType: TextInputType.text,
                              controller: leadscontroller.folloUpdateController,
                              hintText: "FollowUp Date",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                folloUpdatePicker(context);
                              },
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: CommonTextFieldLabel(
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "Site-Visit Date",
                              textInputType: TextInputType.text,
                              controller:
                              leadscontroller.sitevisitdateController,
                              hintText: "Site-Visit Date",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                siteVisitdatePicker(context);
                              },
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: ContainerInnerShadow,
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                              height: 44.0,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton2<source_promotion>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Source of Promotion',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                  AppDetails.fontSemiBold,
                                                  fontSize: 14.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: type
                                          .map((source_promotion item) =>
                                          DropdownMenuItem<
                                              source_promotion>(
                                            value: item,
                                            child: Text(
                                              "${item.name}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: AppDetails
                                                      .fontSemiBold,
                                                  fontSize: 14.0),
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                          ))
                                          .toList(),
                                      value: leadscontroller.select_promotion,
                                      onChanged: (value) {
                                        setState(() {
                                          leadscontroller.select_promotion =
                                              value;
                                          // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                          print(
                                              leadscontroller.select_promotion!
                                                  .name);
                                          // place_of_supply_Controller.text =
                                          // _selectedstate!.name!;
                                        });
                                      },
                                      iconSize: 25,
                                      icon: SvgPicture.asset(
                                          CommonImage.dropdown_svg),
                                      iconEnabledColor: Color(0xff007DEF),
                                      iconDisabledColor: Color(0xff007DEF),
                                      buttonHeight: 50,
                                      buttonWidth: 160,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: Colors.white),
                                      buttonElevation: 0,
                                      itemHeight: 40,
                                      itemPadding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      dropdownMaxHeight: 200,
                                      dropdownWidth: 200,
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
                                      offset: const Offset(0, 0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: ContainerInnerShadow,
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                              height: 44.0,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton2<source_promotion>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Lead status',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                  AppDetails.fontSemiBold,
                                                  fontSize: 14.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: leadStatus
                                          .map((source_promotion item) =>
                                          DropdownMenuItem<
                                              source_promotion>(
                                            value: item,
                                            child: Text(
                                              "${item.name}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: AppDetails
                                                      .fontSemiBold,
                                                  fontSize: 14.0),
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                          ))
                                          .toList(),
                                      value: leadscontroller.selected_status,
                                      onChanged: (value) {
                                        setState(() {
                                          leadscontroller.selected_status =
                                              value;
                                          // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                          print(leadscontroller.selected_status!
                                              .name);
                                          // place_of_supply_Controller.text =
                                          // _selectedstate!.name!;
                                        });
                                      },
                                      iconSize: 25,
                                      icon: SvgPicture.asset(
                                          CommonImage.dropdown_svg),
                                      iconEnabledColor: Color(0xff007DEF),
                                      iconDisabledColor: Color(0xff007DEF),
                                      buttonHeight: 50,
                                      buttonWidth: 160,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: Colors.white),
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
                                      offset: const Offset(0, 0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Lead Owner Name",
                        textInputType: TextInputType.text,
                        controller: leadscontroller.leadownerController,
                        hintText: "Lead Owner Name",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Source Campaign",
                        textInputType: TextInputType.text,
                        controller: leadscontroller.sourceCampaignController,
                        hintText: "Lead Owner Name",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Sales Person",
                        textInputType: TextInputType.text,
                        controller: leadscontroller.salespersonController,
                        hintText: "Sales Person",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Notes",
                        textInputType: TextInputType.text,
                        controller: leadscontroller.notesController,
                        hintText: "Notes",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectTowerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return SelectTower();
          },
        );
      },
    );
  }

  selectFloorBottomSheet(BuildContext context,
      {required String selectFloorName, required int selectedTowerIndex}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return LeadsSelectFloor(
              getSelectTownValue: selectFloorName,
              getSelectedTownIndex: selectedTowerIndex.toString(),
            );
          },
        );
      },
    );
  }

  selectFloorNumberBottomSheet(BuildContext context, {
    required String getSalesSelectFloorValue,
    required String getSalesSelectTownValue,
    required int getSelectedFloorIndex,
  }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return LeadsSelectNumber(
              getSelectTownValue: getSalesSelectTownValue,
              getSelectFloorValue: getSalesSelectFloorValue,
              getSelectedFloorIndexId: getSelectedFloorIndex,
            );
          },
        );
      },
    );
  }

  List selected_flats = [];

  setFlatNumber({required String selectFlat, required int selectFlatId}) {
    debugPrint(
        'Inside the Set Flat Number ${selectFlat.toString()} = ${selectFlatId
            .toString()}');

    leadscontroller.selectedFlats.value.add(selectFlat.toString());
    leadscontroller.selectFlatId.value = selectFlatId;
    leadscontroller.flatNoController.text = leadscontroller.selectedFlats.value
        .toString()
        .split('[')
        .last
        .split(']')
        .first
        .toString();
    print("selectFlat.toString()");
    print(selected_flats);
    debugPrint(
        'Selected Flat Index ${leadscontroller.selectedFlats.toString()}');
  }
}
