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
import 'package:tring/screens/tasks/controller/TasksController.dart';

import '../../../AppDetails.dart';
import '../../../common/common_image.dart';
import '../../drawer/ui/drawerscreen.dart';


class AddTasks extends StatefulWidget {
  final String taskType_name;
  final String taskType_id;
  final String customer_name;
  final String customer_id;

  const AddTasks(
      {Key? key,
      required this.taskType_name,
      required this.taskType_id,
      required this.customer_name,
      required this.customer_id})
      : super(key: key);

  @override
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
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
        taskscontroller.fromdateController.text =
            DateFormat('dd-MM-yyyy').format(
                pickedDate!); //set output date to TextField value.
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
        taskscontroller.to_date =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
      setState(() {
        taskscontroller.todateController.text =
            DateFormat('dd-MM-yyyy').format(
                pickedDate!); //set output date to TextField value.
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
        taskscontroller.reminderdateController.text =
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
      initialTime: taskscontroller.selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != taskscontroller.selectedTime) {
      setState(() {
        taskscontroller.selectedTime = timeOfDay;
      });
      print("${taskscontroller.selectedTime.hour}:${taskscontroller
          .selectedTime.minute}");
      // Conversion logic starts here
      DateTime tempDate = DateFormat("hh:mm").parse(
          taskscontroller.selectedTime.hour.toString() +
              ":" + taskscontroller.selectedTime.minute.toString());
      var dateFormat = DateFormat("h:mm a"); // you can change the format here
      print(dateFormat.format(tempDate).toLowerCase());
      setState(() {
        taskscontroller.timeController.text =
            dateFormat.format(tempDate).toLowerCase();
      });
    }
  }


  @override
  void initState() {
    taskscontroller.task_typeController.text = widget.taskType_name;
    taskscontroller.associated_lead_Controller.text = widget.customer_name;
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
                  taskscontroller.storeTasks(context: context,
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
                        validator: (String? value) {},
                        labelText: "Associated Lead",
                        textInputType: TextInputType.text,
                        controller: taskscontroller
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
                        controller: taskscontroller.addressController,
                        hintText: "Address",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ), CommonTextFieldLabel(
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
                              controller: taskscontroller.reminderdateController,
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
