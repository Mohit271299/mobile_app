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
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/product/controller/Productcontroller.dart';
import 'package:tring/screens/product/ui/Product_list.dart';

import '../../../AppDetails.dart';
import '../../../common/common_image.dart';
import '../../drawer/ui/drawerscreen.dart';
import '../controller/ActivityController.dart';

class AddActivity extends StatefulWidget {
  final String taskType_name;
  final String taskType_id;
  final String customer_name;
  final String customer_id;

  const AddActivity(
      {Key? key, required this.taskType_name, required this.customer_name,  required this.taskType_id, required this.customer_id})
      : super(key: key);

  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  late double screenHeight, screenWidth;
  final activityController = Get.put(ActivityController());

  ProductController productControllers =
  Get.put(ProductController(), tag: ProductController().toString());

  DateTime? pickedDate;

  var list_hour = Iterable<int>.generate(100).toList();
  var list_minute = Iterable<int>.generate(100).toList();


  Future<void> datePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        activityController.birth_date =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        activityController.dateController.text =
            DateFormat('dd-MM-yyyy').format(
                pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: activityController.selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != activityController.selectedTime) {
      setState(() {
        activityController.selectedTime = timeOfDay;
      });
      print("${activityController.selectedTime.hour}:${activityController
          .selectedTime.minute}");
      // Conversion logic starts here
      DateTime tempDate = DateFormat("hh:mm").parse(
          activityController.selectedTime.hour.toString() +
              ":" + activityController.selectedTime.minute.toString());
      var dateFormat = DateFormat("h:mm a"); // you can change the format here
      print(dateFormat.format(tempDate).toLowerCase());
      setState(() {
        activityController.timeController.text =
            dateFormat.format(tempDate).toLowerCase();
      });
    }
  }


  @override
  void initState() {
    activityController.task_typeController.text = widget.taskType_name;
    activityController.associated_lead_Controller.text = widget.customer_name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              margin: EdgeInsets.symmetric(horizontal: 100),
              child: CommonWidget().CommonButton(
                context: context,
                buttonText: Texts.Save,
                onPressed: () {
                  activityController.storeActivity(context: context,
                      activityType: widget.taskType_name,
                      activityTypeId: widget.taskType_id,
                      associatedName: widget.customer_name,
                      associatedLeadId: widget.customer_id);
                  // contactdetailsController.storeContacts(context: context);
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
            )
            ,
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
                  child: Text(Texts.activity, style: screenHeader()),
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
                            'Activity Details',
                            textAlign: TextAlign.left,
                            style: estimateLabelStyle(),
                          ),
                        ],
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        readOnly: true,
                        labelText: "Task Type",
                        textInputType: TextInputType.text,
                        controller: activityController.task_typeController,
                        hintText: "Task Type",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Lead Owner Name",
                        textInputType: TextInputType.text,
                        controller: activityController.lead_ownerController,
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
                        labelText: "Associated Lead",
                        textInputType: TextInputType.text,
                        controller: activityController
                            .associated_lead_Controller,
                        hintText: "Associated Lead",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Address",
                        textInputType: TextInputType.text,
                        controller: activityController.addressController,
                        hintText: "Address",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: CommonTextFieldLabel(
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "Date",
                              textInputType: TextInputType.text,
                              controller: activityController.dateController,
                              hintText: "Date",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                datePicker(context);
                              },
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: CommonTextFieldLabel(
                              validator: (String? value) {},
                              labelText: "Time",
                              readOnly: true,
                              textInputType: TextInputType.text,
                              controller: activityController.timeController,
                              hintText: "Time",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                _selectTime(context);
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
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: ContainerInnerShadow,
                                    border: Border.all(
                                        color: Colors.black, width: 1)
                                ),
                                // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                                height: 44.0,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
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
                                                'Hour',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: AppDetails
                                                        .fontSemiBold,
                                                    fontSize: 14.0),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: list_hour
                                            .map((item) =>
                                            DropdownMenuItem<int>(
                                              value: item,
                                              child: Text(
                                                "${item.toString()} hr",
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
                                        value: activityController.selectedhr,
                                        onChanged: (value) {
                                          setState(() {
                                            activityController.selectedhr =
                                            value as int;
                                          });
                                          print(activityController.selectedhr);
                                        },
                                        iconSize: 25,
                                        icon: SvgPicture.asset(
                                            CommonImage.dropdown_svg),
                                        iconEnabledColor: Color(0xff007DEF),
                                        iconDisabledColor: Color(0xff007DEF),
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        buttonDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            color: Colors.white
                                        ),
                                        buttonElevation: 0,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 200,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
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
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: ContainerInnerShadow,
                                    // color: Colors.red
                                    border: Border.all(
                                        color: Colors.black, width: 1)
                                ),
                                // margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                                height: 44.0,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
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
                                                'Minutes',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: AppDetails
                                                        .fontSemiBold,
                                                    fontSize: 14.0),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: list_minute
                                            .map((item) =>
                                            DropdownMenuItem<int>(
                                              value: item,
                                              child: Text(
                                                "${item.toString()} min",
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
                                        value: activityController.selectedmn,
                                        onChanged: (value) {
                                          setState(() {
                                            activityController.selectedmn =
                                            value as int;
                                          });
                                          print(activityController.selectedmn);
                                        },
                                        iconSize: 25,
                                        icon: SvgPicture.asset(
                                            CommonImage.dropdown_svg),
                                        iconEnabledColor: Color(0xff007DEF),
                                        iconDisabledColor: Color(0xff007DEF),
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        buttonDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            color: Colors.white
                                        ),
                                        buttonElevation: 0,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 200,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
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
                          ]
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Description",
                        textInputType: TextInputType.text,
                        controller: activityController.descriptionController,
                        hintText: "Description",
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
}
