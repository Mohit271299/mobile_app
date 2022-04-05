import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/screens/tasks/controller/TasksController.dart';
import 'package:tring/screens/tasks/ui/tasks_edit.dart';

import '../../../common/Texts.dart';
import '../../../common/common_color.dart';
import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../../common/common_style.dart';
import '../../../common/common_textformfield.dart';
import '../../../common/common_widget.dart';
import '../controller/TasksController.dart';
import 'tasks_add.dart';

class TaskEditSelectCustomer extends StatefulWidget {
  const TaskEditSelectCustomer({Key? key}) : super(key: key);

  @override
  _TaskEditSelectCustomerState createState() => _TaskEditSelectCustomerState();
}

class _TaskEditSelectCustomerState extends State<TaskEditSelectCustomer> {
  TasksController tasksController = Get.put(
    TasksController(),
    tag: TasksController().toString(),
  );

  void initState() {
    super.initState();
    tasksController.getAllCustomerFromAPI();
  }

  late double screenHeight, screenWidth;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
            Obx(() => (tasksController.isCustomerLoading.value == false &&
                tasksController.getAllCustomerDetails
                    .toString()
                    .isNotEmpty &&
                tasksController.getAllCustomerDetails.toString() !=
                    'null' &&
                int.parse(tasksController
                    .getAllCustomerDetails!.data!.length
                    .toString()) !=
                    0 &&
                int.parse(tasksController
                    .getAllCustomerDetails!.data!.length
                    .toString()) >=
                    0)
                ? CommonWidget().ListviewListingBuilder(
              context: context,
              getItemCount:
              tasksController.getAllCustomerDetails!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      tasksController.customer_name =tasksController.getAllCustomerDetails!.data![index].name;
                      tasksController.customer_id =tasksController.getAllCustomerDetails!.data![index].id;
                    });
                    Get.to(EditTasks(
                      taskId: tasksController.task_id,
                      contactId:  tasksController.customer_id!,
                        // taskType_name: widget.taskType_name,
                        // customer_name: tasksController.customer_name!,
                        // customer_id: tasksController.customer_id.toString(),
                        // taskType_id: widget.taskType_id
                    )
                    );
                    setState(() {
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
                              tasksController.getAllCustomerDetails!
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
                              tasksController.getAllCustomerDetails!
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
  }
}
