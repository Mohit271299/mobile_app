import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/tasks/controller/TasksController.dart';

import '../../../AppDetails.dart';
import '../../../common/common_color.dart';
import '../../../common/common_style.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  void displaySalesActionButton(BuildContext context,
      {required int id, required int listIndex}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              height: screenHeight * 0.24,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        right: 38, left: 38, bottom: 20, top: 20.0),
                    decoration: BoxDecoration(
                        color: HexColor(CommonColor.appActiveColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 13,
                        bottom: 13,
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontFamily: AppDetails.fontMedium),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 38, left: 38, bottom: 20),
                    decoration: BoxDecoration(
                        color: HexColor(CommonColor.appActiveColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 13,
                        bottom: 13,
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontFamily: AppDetails.fontMedium),
                      ),
                    ),
                  ),
                ],
              ),
            );
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
              // gotoAddProductScreen(context)
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
                                                      .subject
                                                      .toString(),
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
                                                      onTap: () =>
                                                          displaySalesActionButton(
                                                              context,
                                                              id: int.parse(
                                                                tasksController
                                                                    .getAllTasksModel!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              ),
                                                              listIndex: index),
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
                                                      .priority
                                                      .toString(),
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