import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/estimate/controller/estimateshowcustomercontroller.dart';
import 'package:tring/screens/estimate/ui/estimatefilter.dart';

import 'estimate_select_customer.dart';

class EstimateList extends StatefulWidget {
  const EstimateList({Key? key}) : super(key: key);

  @override
  _EstimateListState createState() => _EstimateListState();
}

class _EstimateListState extends State<EstimateList> {
  late double screenHeight, screenWidth;
  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();

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
            return const EstimateSelectCustomer();
          },
        );
      },
    );
  }

  displayFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return EstimateFilter();
          },
        );
      },
    );
  }

  final estimateController = Get.put(EstimateShowCustomeController());

  @override
  void initState() {
    estimateController.getAllEstimateFromAPI();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.estimates,
      bodyWidget: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor(CommonColor.appActiveColor),
          onPressed: () => displayBottomSheet(context),
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
            children: <Widget>[
              InkWell(
                onTap: () => CommonWidget().hideFocusKeyBoard(context),
                child: Container(
                  width: screenWidth,
                  child: Text(Texts.estimates, style: screenHeader()),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (screenHeight * 0.29).ceilToDouble(),
                    child: CommonTextFieldSearch(
                      controller: searchController,
                      validator: (value) {},
                      icon: CommonImage.search_icon,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      hintText: Texts.search_hint,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  InkWell(
                      onTap: () => displayFilterBottomSheet(context),
                      child: SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: CommonWidget().filterAndSortCard(
                          context: context,
                          onTap: () => displayFilterBottomSheet(context),
                          itemIcon: CommonImage.sort_icons,
                        ),
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  CommonWidget().filterAndSortCard(
                    context: context,
                    onTap: () {},
                    itemIcon: CommonImage.filter_icons,
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Obx(
                () => (estimateController.isEstimateLoading.value != true)
                    ? CommonWidget().ListviewListingBuilder(
                        context: context,
                        getItemCount: (estimateController.getEstimateModel
                                    .toString()
                                    .isNotEmpty &&
                                estimateController.getEstimateModel
                                        .toString() !=
                                    'null' &&
                                int.parse(estimateController
                                        .getEstimateModel!.data!.length
                                        .toString()) !=
                                    0 &&
                                int.parse(estimateController
                                        .getEstimateModel!.data!.length
                                        .toString()) >=
                                    0)
                            ? estimateController.getEstimateModel!.data!.length
                            : 10,
                        itemBuilder: (BuildContext context, int index) {
                          return (estimateController.getEstimateModel
                                      .toString()
                                      .isNotEmpty &&
                                  estimateController.getEstimateModel
                                          .toString() !=
                                      'null' &&
                                  int.parse(estimateController
                                          .getEstimateModel!.data!.length
                                          .toString()) !=
                                      0)
                              ? CommonWidget().listingCardDesign(
                                  context: context,
                                  getWidget: Container(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 12.0, right: 12.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                '#${estimateController.getEstimateModel!.data![index].estimateNo.toString()}',
                                                style: cartIdDateStyle()),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: Text(
                                                  '${estimateController.getEstimateModel!.data![index].estimateDate.toString()}',
                                                  style: cartIdDateStyle()),
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
                                                estimateController
                                                    .getEstimateModel!
                                                    .data![index]
                                                    .contact!
                                                    .name
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
                                                  '₹ ${estimateController.getEstimateModel!.data![index].totalAmount.toString()}',
                                                  maxLines: 1,
                                                  style: cartNameStyle(),
                                                ),
                                                const SizedBox(
                                                  width: 18.0,
                                                ),
                                                Container(
                                                  height: 17.0,
                                                  width: 17.0,
                                                  child: InkWell(
                                                    child: const Icon(
                                                      Icons.more_vert,
                                                      size: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                    onTap: () =>
                                                        displaySalesActionButton(
                                                            context,
                                                            id: int.parse(
                                                              estimateController
                                                                  .getEstimateModel!
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                            ),
                                                            listIndex: index),
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
                                            SizedBox(
                                              width: screenWidth / 3.8,
                                              child: Text(
                                                estimateController
                                                    .getEstimateModel!
                                                    .data![index]
                                                    .contact!
                                                    .mobileNo
                                                    .toString(),
                                                style: cartMobileNumberStyle(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth / 2,
                                              child: CommonWidget()
                                                  .GridViewBlockListingBuilder(
                                                crossAxisSpacingSize: 4,
                                                context: context,
                                                getCrossCount: 3,
                                                getItemCount: estimateController
                                                    .getEstimateModel!
                                                    .data![index]
                                                    .estimateItems!
                                                    .length,
                                                mainAxisExtentSize: 33,
                                                mainAxisSpacingSize: 5,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int indexs) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    height: 16.0,
                                                    width: 38.0,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(
                                                          CommonColor
                                                              .blockBackColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                    child: Text(
                                                      estimateController
                                                          .getEstimateModel!
                                                          .data![index]
                                                          .estimateItems![
                                                              indexs]
                                                          .flat!
                                                          .blockNumber
                                                          .toString(),
                                                      style: cartBlockStyle(),
                                                    ),
                                                  );
                                                },
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
                        getItemCount: 10,
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
        ),
      ),
    );
  }
}
