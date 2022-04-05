import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/tasks/controller/TasksController.dart';
import 'package:tring/screens/tasks/ui/tasks_edit.dart';

import '../../../AppDetails.dart';
import '../../../common/common_color.dart';
import '../../../common/common_style.dart';
import 'Tasks_select_task.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return const taskSelectTaskType();
          },
        );
      },
    );
  }

  late double screenHeight, screenWidth;
  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final List _viewData = [
    Texts.task_activity,
    Texts.property,
    Texts.payment,
  ];
  int _indexData = 0;

  final tasksController = Get.put(TasksController());
  int? selected_tasks;
  int? selected_contact;

  @override
  void initState() {
    tasksController.getAllTasksFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.tasks,
      bodyWidget: Scaffold(
          drawerScrimColor: HexColor(CommonColor.appBackColor),
          floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor(CommonColor.appActiveColor),
            onPressed: () {
              displayBottomSheet(context);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          key: _globalKey,
          drawer: DrawerScreen(),
          backgroundColor: HexColor(CommonColor.appBackColor),
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
                // categorySilder(context),
                const SizedBox(
                  height: 15.0,
                ),
                Obx(
                  () => (tasksController.isTasksLoading.value != true)
                      ? CommonWidget().ListviewListingBuilder(
                          context: context,
                          getItemCount: (tasksController.getAllTasksModel
                                      .toString()
                                      .isNotEmpty &&
                                  tasksController.getAllTasksModel.toString() !=
                                      'null' &&
                                  int.parse(tasksController
                                          .getAllTasksModel!.data!.length
                                          .toString()) !=
                                      0 &&
                                  int.parse(tasksController
                                          .getAllTasksModel!.data!.length
                                          .toString()) >=
                                      0)
                              ? tasksController.getAllTasksModel!.data!.length
                              : 10,
                          itemBuilder: (BuildContext context, int index) {
                            return (tasksController.getAllTasksModel
                                        .toString()
                                        .isNotEmpty &&
                                    tasksController.getAllTasksModel
                                            .toString() !=
                                        'null' &&
                                    int.parse(tasksController
                                            .getAllTasksModel!.data!.length
                                            .toString()) !=
                                        0)
                                ? CommonWidget().listingCardDesign(
                                    context: context,
                                    getWidget: Container(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 10.0,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '#${tasksController.getAllTasksModel!.data![index].subject}',
                                                    style: cartIdDateStyle(),
                                                  ),
                                                  const SizedBox(
                                                    width: 11.0,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18.0),
                                                child: Text(
                                                  tasksController
                                                      .getAllTasksModel!
                                                      .data![index]
                                                      .id!
                                                      .toString(),
                                                  style: cartIdDateStyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  tasksController
                                                      .getAllTasksModel!
                                                      .data![index]
                                                      .type!.type!,
                                                  maxLines: 1,
                                                  style: cartNameStyle(),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '₹12112123',
                                                    maxLines: 1,
                                                    style: cartNameStyle(),
                                                  ),
                                                  const SizedBox(
                                                    width: 0.0,
                                                  ),
                                                  Container(
                                                    width: 17,
                                                    height: 17,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        await showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled: true,
                                                            builder: (context) {
                                                              return StatefulBuilder(
                                                                builder: (BuildContext context,
                                                                    StateSetter setState) {
                                                                  return Padding(
                                                                    padding:
                                                                    MediaQuery.of(context).viewInsets,
                                                                    child: Container(
                                                                      color: Color(0xff737373),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.only(
                                                                            topRight: Radius.circular(15),
                                                                            topLeft: Radius.circular(15),
                                                                          ),
                                                                        ),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft:
                                                                                Radius.circular(30),
                                                                                topRight:
                                                                                Radius.circular(30)),
                                                                          ),
                                                                          child: SingleChildScrollView(
                                                                            child: Column(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      tasksController.task_id =
                                                                                          tasksController
                                                                                              .getAllTasksModel!
                                                                                              .data![index]
                                                                                              .id;
                                                                                      tasksController.customer_id =
                                                                                          tasksController
                                                                                              .getAllTasksModel!
                                                                                              .data![index]
                                                                                              .contactId;
                                                                                    });
                                                                                    print(
                                                                                        selected_tasks);
                                                                                    // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                                                    Get.to(EditTasks(
                                                                                      contactId: tasksController.customer_id!,
                                                                                      taskId:
                                                                                      tasksController.task_id!,)
                                                                                    );

                                                                                    // Navigator.of(context).push(MaterialPageRoute(
                                                                                    //     builder: (c) => ledgerEditScreen(
                                                                                    //       customer: selected_customer,
                                                                                    //     )));
                                                                                  },
                                                                                  child: Container(
                                                                                      margin:
                                                                                      EdgeInsets.only(
                                                                                          right: 38,
                                                                                          left: 38,
                                                                                          bottom: 10),
                                                                                      decoration: BoxDecoration(
                                                                                          color: Color(
                                                                                              0xfff3f3f3),
                                                                                          borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(
                                                                                              10)),
                                                                                      child: Container(
                                                                                          alignment:
                                                                                          Alignment
                                                                                              .center,
                                                                                          margin: EdgeInsets
                                                                                              .only(
                                                                                            top: 13,
                                                                                            bottom: 13,
                                                                                          ),
                                                                                          child: Text(
                                                                                            'Edit',
                                                                                            style: TextStyle(
                                                                                                fontSize:
                                                                                                15,
                                                                                                decoration:
                                                                                                TextDecoration
                                                                                                    .none,
                                                                                                fontWeight:
                                                                                                FontWeight
                                                                                                    .w600,
                                                                                                color: Color(
                                                                                                    0xff000000),
                                                                                                fontFamily:
                                                                                                'GR'),
                                                                                          ))),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    // setState(() {
                                                                                    //   selected_tasks =
                                                                                    //       CustomersData[
                                                                                    //       index]
                                                                                    //           .id;
                                                                                    // });
                                                                                    // Customer_delete();
                                                                                    // print(
                                                                                    //     selected_tasks);
                                                                                  },
                                                                                  child: Container(
                                                                                    margin: const EdgeInsets
                                                                                        .only(
                                                                                        right: 38,
                                                                                        left: 38,
                                                                                        bottom: 10),
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color(
                                                                                            0xfff3f3f3),
                                                                                        borderRadius:
                                                                                        BorderRadius
                                                                                            .circular(
                                                                                            10)),
                                                                                    child: Container(
                                                                                      alignment:
                                                                                      Alignment.center,
                                                                                      margin:
                                                                                      EdgeInsets.only(
                                                                                        top: 13,
                                                                                        bottom: 13,
                                                                                      ),
                                                                                      child: const Text(
                                                                                        'Delete',
                                                                                        style: TextStyle(
                                                                                            fontSize: 15,
                                                                                            decoration:
                                                                                            TextDecoration
                                                                                                .none,
                                                                                            fontWeight:
                                                                                            FontWeight
                                                                                                .w600,
                                                                                            color: Color(
                                                                                                0xffE74B3B),
                                                                                            fontFamily:
                                                                                            'GR'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            });
                                                        setState(() {});
                                                      },
                                                      child: const Icon(
                                                        Icons.more_vert,
                                                        size: 15.0,
                                                        color: Colors.black,
                                                      ),
                                                      splashColor: HexColor(
                                                          CommonColor
                                                              .appBackColor),
                                                      highlightColor: HexColor(
                                                          CommonColor
                                                              .appBackColor),
                                                      hoverColor: HexColor(
                                                          CommonColor
                                                              .appBackColor),
                                                      focusColor: HexColor(
                                                          CommonColor
                                                              .appBackColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  tasksController
                                                      .getAllTasksModel!
                                                      .data![index]
                                                      .contact!.name!,
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      cartMobileNumberStyle(),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: Text(
                                                    '555% Due',
                                                    textAlign: TextAlign.right,
                                                    style: salesdueStyle(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : CommonWidget().showShimmer(
                                    leftM: 10,
                                    rightM: 10,
                                    bottomM: 15.0,
                                    shimmerHeight: 100);
                          },
                        )
                      : CommonWidget().ListviewListingBuilder(
                          context: context,
                          getItemCount: 15,
                          itemBuilder: (BuildContext context, int index) {
                            return CommonWidget().showShimmer(
                                leftM: 10,
                                rightM: 10,
                                bottomM: 15.0,
                                shimmerHeight: 100);
                          },
                        ),
                ),
              ],
            ),
          )),
    );
  }

  SizedBox categorySilder(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _viewData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _indexData = index;
              });
              print(_indexData);
            },
            child: Container(
              margin:
                  const EdgeInsets.only(right: 0, top: 0, bottom: 0, left: 20),
              decoration: BoxDecoration(
                boxShadow: (_indexData == index)
                    ? [
                        BoxShadow(
                          color: HexColor(CommonColor.appActiveColor),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: -5,
                          blurRadius: 5,
                        )
                      ]
                    : [
                        BoxShadow(
                          color: Color(0x17000000),
                          blurRadius: 1.0,
                        ),
                      ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  _viewData[index],
                  style: TextStyle(
                      fontFamily: "GR",
                      color: _indexData != null && _indexData == index
                          ? HexColor(CommonColor.appActiveColor)
                          : HexColor(CommonColor.subHeaderColor),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
