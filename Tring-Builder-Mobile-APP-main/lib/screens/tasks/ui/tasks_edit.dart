import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/tasks/controller/TasksController.dart';
import 'package:tring/screens/tasks/ui/task_select_edit_customer.dart';

import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../drawer/ui/drawerscreen.dart';

class EditTasks extends StatefulWidget {
  final int? taskId;
  final int contactId;

  const EditTasks(
      {Key? key,
       this.taskId,
       required this.contactId,})
      : super(key: key);

  @override
  _EditTasksState createState() => _EditTasksState();
}

class _EditTasksState extends State<EditTasks> {
  late double screenHeight, screenWidth;
  final taskscontroller = Get.put(TasksController());

  DateTime? pickedDate;

  var list_hour = Iterable<int>.generate(100).toList();
  var list_minute = Iterable<int>.generate(100).toList();

  Future<void> datePicker_from(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        taskscontroller.from_date =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        taskscontroller.fromdateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> datePicker_to(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        taskscontroller.to_date = DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        taskscontroller.todateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> datePicker_reminder(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() {
        taskscontroller.reminder_date =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        taskscontroller.reminderdateController.text = DateFormat('dd-MM-yyyy')
            .format(pickedDate!); //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }


  @override
  void initState() {
    // taskscontroller.task_typeController.text = widget.taskType_name;
    // taskscontroller.associated_lead_Controller.text = widget.customer_name;
    super.initState();
    init();
  }

  init() async {
    await taskscontroller.getAllCustomerFromAPI();
    await taskscontroller.GetTasksById(
        context: context,
        contactId: widget.contactId,
        taskId: widget.taskId!,);
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
                    Obx(() => (taskscontroller.isCustomerLoading.value == false &&
                        taskscontroller.getAllCustomerDetails
                            .toString()
                            .isNotEmpty &&
                        taskscontroller.getAllCustomerDetails.toString() !=
                            'null' &&
                        int.parse(taskscontroller
                            .getAllCustomerDetails!.data!.length
                            .toString()) !=
                            0 &&
                        int.parse(taskscontroller
                            .getAllCustomerDetails!.data!.length
                            .toString()) >=
                            0)
                        ? CommonWidget().ListviewListingBuilder(
                      context: context,
                      getItemCount:
                      taskscontroller.getAllCustomerDetails!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              taskscontroller.customer_id = taskscontroller.getAllCustomerDetails!.data![index].id!;
                              taskscontroller.customer_name = taskscontroller.getAllCustomerDetails!.data![index].name!;
                              taskscontroller.associated_lead_Controller.text =taskscontroller.customer_name!;
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
                                      taskscontroller.getAllCustomerDetails!
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
                                      taskscontroller.getAllCustomerDetails!
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
      labelText: Texts.tasks,
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

                  taskscontroller.storeTasksbyID(
                    context: context,
                    taskId: widget.taskId!,
                    activityTypeId: taskscontroller.task_id.toString(),
                    associatedLeadId: taskscontroller.customer_id.toString(),
                    ownerId: taskscontroller.owner_id.toString()
                  );
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
                  child: Text(Texts.tasks, style: screenHeader()),
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
                            'Tasks Details',
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
                        controller: taskscontroller.task_typeController,
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
                        labelText: "Assign To",
                        textInputType: TextInputType.text,
                        controller: taskscontroller.assignToController,
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
                        controller: taskscontroller.associated_lead_Controller,
                        hintText: "Associated Lead",
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          customer_add();
                        },
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Address",
                        textInputType: TextInputType.text,
                        controller: taskscontroller.addressController,
                        hintText: "Address",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Subject",
                        textInputType: TextInputType.text,
                        controller: taskscontroller.subjectController,
                        hintText: "Subject",
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
                            child: CommonTextFieldLabelIcon(
                              icon: CommonImage.date_icon,
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "From Date",
                              textInputType: TextInputType.text,
                              controller: taskscontroller.fromdateController,
                              hintText: "Date",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                datePicker_from(context);
                              },
                              // onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: CommonTextFieldLabelIcon(
                              icon: CommonImage.date_icon,
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "To Date",
                              textInputType: TextInputType.text,
                              controller: taskscontroller.todateController,
                              hintText: "Date",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                datePicker_to(context);
                              },
                              // onChanged: (value) {},
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
                            child: CommonTextFieldLabelIcon(
                              icon: CommonImage.date_icon,
                              validator: (String? value) {},
                              readOnly: true,
                              labelText: "Reminder",
                              textInputType: TextInputType.text,
                              controller:
                                  taskscontroller.reminderdateController,
                              hintText: "Reminder",
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                datePicker_reminder(context);
                              },
                              // onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: CommonTextFieldLabel(
                              validator: (String? value) {},
                              labelText: "Priority",
                              textInputType: TextInputType.text,
                              controller: taskscontroller.priorityController,
                              hintText: "Priority",
                              textInputAction: TextInputAction.next,
                              onTap: () {},
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Description",
                        textInputType: TextInputType.text,
                        controller: taskscontroller.descriptionController,
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
