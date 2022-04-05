import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';

import '../../../common/common_widget.dart';
import '../../leads/controller/LeadsController.dart';
import '../../tasks/controller/TasksController.dart';
import '../controller/HomepageController.dart';
import '../model/getAllProjectsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  void displayTasksActionButton(BuildContext context,
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

  final oCcy = NumberFormat("#,##0.00", "en_US");
  int _indexData = 0;
  String dropdownvalue = "Item 1";
  final TextEditingController searchController = TextEditingController();
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final List _viewData = [
    Texts.task_activity,
    Texts.property,
    Texts.payment,
  ];

  final homepagecontroller = Get.put(HomepageController());
  final tasksController = Get.put(TasksController());

  @override
  void initState() {
    super.initState();
    tasksController.getAllTasksFromAPI();
    homepagecontroller.getAllLeadsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      backgroundColor: HexColor(CommonColor.appBackColor),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Column(
            children: <Widget>[
              dataSlider(context),
              const SizedBox(
                height: 10.0,
              ),
              categorySilder(context),
              const SizedBox(
                height: 15.0,
              ),
              dropDownPart(context),
              const SizedBox(
                height: 15.0,
              ),
              // Text((screenWidth * 0.48).toInt().toString()),
              searchPart(context),
              const SizedBox(
                height: 15.0,
              ),
              (_indexData == 0 ? tasks_main(context) : property_main(context)),
              // bookPart_main(context),

              const SizedBox(
                height: 15.0,
              ),
              // bookPart(context),
              // const SizedBox(
              //   height: 15.0,
              // ),
              // bookPart(context),
              // const SizedBox(
              //   height: 15.0,
              // ),
              // bookPart(context),
            ],
          ),
        ),
      ),
    );
  }

  InkWell dialogLabelPart1(
      {required String labelTitle,
      required String labelShapeColor,
      required void Function()? onTap}) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 0.0,
          bottom: 0.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: HexColor(CommonColor.dialogBorderColor),
            width: 1.0,
          ),
        ),
        height: 30.0,
        width: (screenWidth * 0.48).ceilToDouble(),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 14,
              width: 28.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: HexColor(labelShapeColor)),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Text(
              labelTitle.toString(),
              style: dialogbuttonStyle(),
            ),
          ],
        ),
      ),
    );
  }

  InkWell dialogLabelPart2(
      {required String labelTitle,
      required String labelShapeColor,
      required String labelIcon,
      required void Function()? onTap}) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 0.0,
          bottom: 0.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: HexColor(CommonColor.dialogBorderColor),
            width: 1.0,
          ),
        ),
        height: 30.0,
        width: (screenWidth * 0.48).ceilToDouble(),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 14,
              width: 28.0,
              child: Container(
                height: 14,
                width: 28.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#15740D"),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: -1,
                        blurRadius: 1,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, left: 6.0, right: 9.0),
                  child: Image.asset(
                    CommonImage.token_received_icons.toString(),
                    height: 8.0,
                    width: 8.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Text(
              labelTitle.toString(),
              style: dialogbuttonStyle(),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    debugPrint('Inside dialog');
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Texts.bookinginfo,
                    style: dialogTitleStyle(),
                  ),
                  dialogLabelPart1(
                    labelShapeColor: CommonColor.bookedColor,
                    labelTitle: Texts.booked,
                    onTap: () {},
                  ),
                  dialogLabelPart1(
                    labelShapeColor: CommonColor.enquiryColor,
                    labelTitle: Texts.Enquiry,
                    onTap: () {},
                  ),
                  dialogLabelPart1(
                    labelShapeColor: CommonColor.onholdColor,
                    labelTitle: Texts.OnHold,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      context: context,
    );
  }

  Container bookPart(BuildContext context) {
    return Container(
      width: screenWidth,
      padding:
          const EdgeInsets.only(left: 11.0, top: 9.0, right: 11.0, bottom: 9.0),
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 2.0),
        ],
      ),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 33,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: ContainerInnerShadow,
            ),
            alignment: Alignment.center,
            child: Text(
              'A-10${index.toString()}',
              style: TextStyle(
                color: HexColor(CommonColor.appActiveColor),
                fontSize: 12.0,
                fontFamily: AppDetails.fontSemiBold,
              ),
            ),
          );
        },
      ),
    );
  }

  double? salesAmnt;
  double? salesLeads;
  double? salesEstimate;

  Obx property_main(BuildContext context) {
    return Obx(
      () => (homepagecontroller.isHomepageLoading.value != true)
          ? CommonWidget().ListviewListingBuilder(
              context: context,
              getItemCount: (homepagecontroller.getAllProjcetsModel
                          .toString()
                          .isNotEmpty &&
                      homepagecontroller.getAllProjcetsModel.toString() !=
                          'null' &&
                      int.parse(homepagecontroller
                              .getAllProjcetsModel!.data!.length
                              .toString()) !=
                          0 &&
                      int.parse(homepagecontroller
                              .getAllProjcetsModel!.data!.length
                              .toString()) >=
                          0)
                  ? 1
                  : 10,
              itemBuilder: (BuildContext context, int xdata) {
                return (homepagecontroller.getAllProjcetsModel
                            .toString()
                            .isNotEmpty &&
                        homepagecontroller.getAllProjcetsModel.toString() !=
                            'null' &&
                        int.parse(homepagecontroller
                                .getAllProjcetsModel!.data!.length
                                .toString()) !=
                            0)
                    ? Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        // height: 82.0,
                        // width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   boxShadow: const [
                        //     BoxShadow(color: Colors.grey, blurRadius: 1),
                        //   ],
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                        child: Container(
                            width: screenWidth,
                            padding: const EdgeInsets.only(
                                left: 11.0, top: 9.0, right: 11.0, bottom: 9.0),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 2.0),
                              ],
                            ),
                            child: (homepagecontroller.selectedTower != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: homepagecontroller
                                            .selectedTowerData!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisExtent: 33,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          // String check =('${homepagecontroller
                                          //     .getAllProjcetsModel!.data![xdata].data_tower![index]
                                          //     .salesAmount}');
                                          if (homepagecontroller
                                                  .selectedTowerData![index]
                                                  .salesAmount !=
                                              null) {
                                            salesAmnt = double.parse(
                                                homepagecontroller
                                                    .selectedTowerData![index]
                                                    .salesAmount
                                                    .toString());
                                          } else {
                                            salesAmnt = 0.0;
                                          }
                                          if (homepagecontroller
                                                  .selectedTowerData![index]
                                                  .leads !=
                                              '0') {
                                            salesLeads = double.parse(
                                                homepagecontroller
                                                    .selectedTowerData![index]
                                                    .leads!);
                                          } else {
                                            salesLeads = 0.0;
                                          }
                                          if (homepagecontroller
                                                  .selectedTowerData![index]
                                                  .estimateItems !=
                                              '0') {
                                            salesEstimate = double.parse(
                                                homepagecontroller
                                                    .selectedTowerData![index]
                                                    .estimateItems!);
                                          } else {
                                            salesEstimate = 0.0;
                                          }

                                          // print("sales_amnt : ${homepagecontroller
                                          //     .getAllProjcetsModel!.data![xdata].data_tower![index]
                                          //     .salesAmount}");
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: ContainerInnerShadow,
                                                color: (salesAmnt! > 0
                                                    ? HexColor(
                                                        CommonColor.bookedColor)
                                                    : (salesLeads! > 0 ||
                                                            salesEstimate! > 0
                                                        ? HexColor(CommonColor
                                                            .enquiryColor)
                                                        : Colors.transparent))),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${homepagecontroller.selectedTowerData![index].blockNumber}',
                                              // '$salesEstimate',
                                              style: TextStyle(
                                                color: (salesAmnt! > 0
                                                    ? Colors.white
                                                    : (salesLeads! > 0 ||
                                                            salesEstimate! > 0
                                                        ? Colors.white
                                                        : HexColor(CommonColor
                                                            .appActiveColor))),
                                                fontSize: 12.0,
                                                fontFamily:
                                                    AppDetails.fontSemiBold,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : CommonWidget().ListviewListingBuilder(
                                    context: context,
                                    getItemCount: 15,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CommonWidget().showShimmer(
                                          leftM: 10,
                                          rightM: 10,
                                          bottomM: 15.0,
                                          shimmerHeight: 100);
                                    },
                                  ))),
                      )
                    : CommonWidget().ListviewListingBuilder(
                        context: context,
                        getItemCount: 15,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 115,
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 11.0, top: 9.0, right: 11.0, bottom: 9.0),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 2.0),
                              ],
                            ),
                            child: Shimmer.fromColors(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              period: const Duration(seconds: 2),
                              baseColor: Colors.black.withOpacity(0.1),
                              highlightColor: Colors.white.withOpacity(0.1),
                            ),
                          );
                        },
                      );
              },
            )
          : Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              // height: 82.0,
              // width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   boxShadow: const [
              //     BoxShadow(color: Colors.grey, blurRadius: 1),
              //   ],
              //   borderRadius: BorderRadius.circular(15.0),
              // ),
              child: Container(
                  width: screenWidth,
                  padding: const EdgeInsets.only(
                      left: 11.0, top: 9.0, right: 11.0, bottom: 9.0),
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 2.0),
                    ],
                  ),
                  child: CommonWidget().ListviewListingBuilder(
                    context: context,
                    getItemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return CommonWidget().showShimmer(
                          leftM: 10,
                          rightM: 10,
                          bottomM: 15.0,
                          shimmerHeight: 100);
                    },
                  )),
            ),
    );
  }

  Obx tasks_main(BuildContext context) {
    return Obx(
      () => (tasksController.isTasksLoading.value != true)
          ? CommonWidget().ListviewListingBuilder(
              context: context,
              getItemCount: (tasksController.getAllTasksModel
                          .toString()
                          .isNotEmpty &&
                      tasksController.getAllTasksModel.toString() != 'null' &&
                      int.parse(tasksController.getAllTasksModel!.data!.length
                              .toString()) !=
                          0 &&
                      int.parse(tasksController.getAllTasksModel!.data!.length
                              .toString()) >=
                          0)
                  ? tasksController.getAllTasksModel!.data!.length
                  : 10,
              itemBuilder: (BuildContext context, int index) {
                return (tasksController.getAllTasksModel
                            .toString()
                            .isNotEmpty &&
                        tasksController.getAllTasksModel.toString() != 'null' &&
                        int.parse(tasksController.getAllTasksModel!.data!.length
                                .toString()) !=
                            0)
                    ? Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: CommonWidget().listingCardDesign(
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
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Text(
                                        tasksController
                                            .getAllTasksModel!.data![index].id!
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
                                        tasksController.getAllTasksModel!
                                            .data![index].type!.type!,
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
                                                displayTasksActionButton(
                                                    context,
                                                    id: int.parse(
                                                      tasksController
                                                          .getAllTasksModel!
                                                          .data![index]
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
                                                CommonColor.appBackColor),
                                            highlightColor: HexColor(
                                                CommonColor.appBackColor),
                                            hoverColor: HexColor(
                                                CommonColor.appBackColor),
                                            focusColor: HexColor(
                                                CommonColor.appBackColor),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tasksController.getAllTasksModel!
                                            .data![index].contact!.name!,
                                        textAlign: TextAlign.left,
                                        style: cartMobileNumberStyle(),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
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
                    leftM: 10, rightM: 10, bottomM: 15.0, shimmerHeight: 100);
              },
            ),
    );
  }

  Row searchPart(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.58,
          margin: const EdgeInsets.only(
            left: 20.0,
          ),
          child: CommonTextFieldSearch(
            controller: searchController,
            hintText: Texts.search_hint,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.search,
            validator: (String? value) {},
            icon: CommonImage.search_icon,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2.0)],
          ),
          height: 30.0,
          width: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              CommonImage.filter_icons,
              height: 12.0,
              width: 12.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  Obx dropDownPart(BuildContext context) {
    return Obx(() => (homepagecontroller.isHomepageLoading.value != true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 2.0),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                  width: 100.0,
                  height: 30.0,
                  // width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Data>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Block',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontFamily: AppDetails.fontSemiBold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: homepagecontroller.getAllProjcetsModel!.data!
                          .map((Data item) => DropdownMenuItem<Data>(
                                onTap: () {
                                  // setState(() {
                                  //   tap = false;
                                  // });
                                },
                                value: item,
                                child: Text(
                                  "Block: ${item.tower}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontFamily: AppDetails.fontSemiBold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: homepagecontroller.selectedTower,
                      onChanged: (value) {
                        // tap == true
                        //     ? setState(() {
                        //   // _selectedAccounthead = "hello";
                        //   Customer_account_head_controller.text =
                        //   _selectedAccounthead!.accountHeadName!;
                        // })
                        //     : setState(() {
                        //   _selectedAccounthead = value;
                        //   Customer_account_head_controller.text =
                        //   _selectedAccounthead!.accountHeadName!;
                        // });
                        setState(() {
                          homepagecontroller.selectedTower = value;
                          homepagecontroller.selectedTowerData =
                              homepagecontroller.selectedTower!.data_tower!;
                        });
                        // Customer_account_head_controller.text =
                        // _selectedAccounthead!.accountHeadName!;

                        print(homepagecontroller.selectedTower!.tower);
                        print(homepagecontroller.selectedTowerData!.length);
                      },
                      iconSize: 25,
                      icon: SvgPicture.asset(CommonImage.dropdown_svg),
                      iconEnabledColor: Color(0xff007DEF),
                      iconDisabledColor: Color(0xff007DEF),
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor(CommonColor.appBackColor),
                      ),
                      buttonElevation: 0,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 15, right: 14),
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
                      offset: const Offset(0, 0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Image.asset(
                  CommonImage.exclamation_icons,
                  height: 14.0,
                  width: 14.0,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 2.0),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 0, right: 18, left: 18),
                  width: 100.0,
                  height: 30.0,
                  // width: MediaQuery.of(context).size.width,
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Image.asset(
                  CommonImage.exclamation_icons,
                  height: 14.0,
                  width: 14.0,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )));
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
                        const BoxShadow(
                          color: Color(0x17000000),
                          blurRadius: 1.0,
                        ),
                      ],
                color: Colors.white,
                border: Border.all(
                    color: (_indexData == index)
                        ? HexColor(CommonColor.appActiveColor)
                        : HexColor("#ffffff")),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  _viewData[index],
                  style: TextStyle(
                      fontFamily: "GR",
                      color: _indexData == index
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

  SizedBox dataSlider(BuildContext context) {
    return SizedBox(
      height: 140.0,
      width: screenWidth,
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  ),
                ]),
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 5.0, top: 5.0),
            width: 300.0,
            height: 100,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hellos',
                    style: TextStyle(
                        fontFamily: AppDetails.fontBold,
                        fontSize: 14.0,
                        color: HexColor(CommonColor.textDarkColor)),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '₹1234,455,00.00',
                    style: TextStyle(
                      fontFamily: AppDetails.fontBold,
                      fontSize: 14.0,
                      color: HexColor(CommonColor.amountColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        // '₹ ${oCcy.format(double.parse(ExpenseData[index].totalAmt!.toDouble().toString()))}',
                        Texts.Revenue,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.0,
                          color: HexColor(CommonColor.subHeaderColor),
                          fontFamily: AppDetails.fontSemiBold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        Texts.Expenses,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.0,
                          color: HexColor(CommonColor.subHeaderColor),
                          fontFamily: AppDetails.fontSemiBold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        // '₹ ${oCcy.format(double.parse(ExpenseData[index].totalAmt!.toDouble().toString()))}',
                        "₹123,34,00.00",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.0,
                          color: HexColor(CommonColor.textDarkColor),
                          fontFamily: AppDetails.fontSemiBold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "₹123,34,00.00",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.0,
                          color: HexColor(CommonColor.textDarkColor),
                          fontFamily: AppDetails.fontSemiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
