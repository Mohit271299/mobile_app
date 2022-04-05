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

import '../../../AppDetails.dart';
import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../drawer/ui/drawerscreen.dart';
import '../controller/ActivityController.dart';

class EditActivity extends StatefulWidget {
  final int activity_id;
  final int contact_id;

  const EditActivity(
      {Key? key, required this.activity_id, required this.contact_id})
      : super(key: key);

  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  late double screenHeight, screenWidth;
  final activityController = Get.put(ActivityController());

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
        activityController.dateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
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
      print(
          "${activityController.selectedTime.hour}:${activityController.selectedTime.minute}");
      // Conversion logic starts here
      DateTime tempDate = DateFormat("hh:mm").parse(
          activityController.selectedTime.hour.toString() +
              ":" +
              activityController.selectedTime.minute.toString());
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
    // activityController.task_typeController.text = widget.taskType_name;
    // activityController.associated_lead_Controller.text = widget.customer_name;
    super.initState();
    init();
  }
  init() async {
    await activityController.getAllCustomerFromAPI();
   await activityController.GetActivityById(
        contactId: widget.contact_id,
        activityId: widget.activity_id,
        context: context);
  }
  final TextEditingController searchController = TextEditingController();

  customer_add(){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              height: screenHeight * 0.757,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            Texts.SelectCustomer,
                            style: dialogTitleStyle(),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () => gotoAddContactScreen(context),
                            child: Text(
                              Texts.AddNewCustomer,
                              style: linkTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CommonTextFieldSearch(
                      controller: searchController,
                      validator: (value) {},
                      icon: CommonImage.search_icon,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      hintText: Texts.search_hint,
                    ),
                    const SizedBox(
                      height: 21.0,
                    ),
                    Obx(() => (activityController.isCustomerLoading.value == false &&
                        activityController.getAllCustomerDetails
                            .toString()
                            .isNotEmpty &&
                        activityController.getAllCustomerDetails.toString() !=
                            'null' &&
                        int.parse(activityController
                            .getAllCustomerDetails!.data!.length
                            .toString()) !=
                            0 &&
                        int.parse(activityController
                            .getAllCustomerDetails!.data!.length
                            .toString()) >=
                            0)
                        ? CommonWidget().ListviewListingBuilder(
                      context: context,
                      getItemCount:
                      activityController.getAllCustomerDetails!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              activityController.customer_id = activityController.getAllCustomerDetails!.data![index].id!;
                              activityController.customer_name = activityController.getAllCustomerDetails!.data![index].name!;
                              activityController.associated_lead_Controller.text =activityController.customer_name!;
                            });

                            //
                            // gotoSalesShowDetailScreen(
                            //   context,
                            //   estimateNo: '00',
                            //   mobileNumber: tasksController
                            //       .getAllCustomerDetails!.data![index].mobileNo
                            //       .toString(),
                            //   name: tasksController
                            //       .getAllCustomerDetails!.data![index].name
                            //       .toString(),
                            // );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: HexColor(
                                    CommonColor.dialogBorderColor,
                                  ),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 18.0, bottom: 18.0),
                                    child: Text(
                                      activityController.getAllCustomerDetails!
                                          .data![index].name
                                          .toString(),
                                      maxLines: 2,
                                      style: cartNameStyle(),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0, bottom: 18.0, right: 18.0),
                                    child: Text(
                                      activityController.getAllCustomerDetails!
                                          .data![index].mobileNo
                                          .toString(),
                                      style: cartMobileNumberStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : CommonWidget().ListviewListing(
                      context: context,
                      getItemCount: 16,
                      getWidets: CommonWidget().showShimmer(
                        shimmerHeight: 50,
                        leftM: 0.0,
                        rightM: 0.0,
                        bottomM: 20.0,
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
                  activityController.storeActivitybyID(
                      activityId:widget.activity_id,
                    ownerId: activityController.owner_id.toString(),
                    context: context,
                    associatedLeadId: activityController.customer_id.toString(),
                    activityTypeId: activityController.activity_id.toString()
                  );
                  // activityController.storeActivity(context: context,
                  //     activityType: widget.taskType_name,
                  //     activityTypeId: widget.taskType_id,
                  //     associatedName: widget.customer_name,
                  //     associatedLeadId: widget.customer_id);
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
                        readOnly: true,
                        validator: (String? value) {},
                        labelText: "Associated Lead",
                        textInputType: TextInputType.text,
                        controller:
                            activityController.associated_lead_Controller,
                        hintText: "Associated Lead",
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          customer_add();},
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
                      Row(children: <Widget>[
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: ContainerInnerShadow,
                              // border: Border.all(
                              //     color: Colors.black, width: 1)
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
                                            'Hour',
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
                                    items: list_hour
                                        .map((item) => DropdownMenuItem<int>(
                                              value: item,
                                              child: Text(
                                                "${item.toString()} hr",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        AppDetails.fontSemiBold,
                                                    fontSize: 14.0),
                                                overflow: TextOverflow.ellipsis,
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent),
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
                                    scrollbarRadius: const Radius.circular(40),
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
                              // border: Border.all(
                              //     color: Colors.black, width: 1)
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
                                            'Minutes',
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
                                    items: list_minute
                                        .map((item) => DropdownMenuItem<int>(
                                              value: item,
                                              child: Text(
                                                "${item.toString()} min",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        AppDetails.fontSemiBold,
                                                    fontSize: 14.0),
                                                overflow: TextOverflow.ellipsis,
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent),
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
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                    offset: const Offset(0, -5),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
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
