import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/estimate/controller/estimateshowcustomercontroller.dart';
import 'package:tring/screens/estimate/ui/estimate_list.dart';
import 'package:tring/screens/estimate/ui/selectFloor.dart';
import 'package:tring/screens/estimate/ui/selectNumber.dart';
import 'package:tring/screens/estimate/ui/selectTown.dart';

import 'estimate_select_customer.dart';

class EditEstimate extends StatefulWidget {
  final int estimate_id;
  final String customer_name;
  final String customer_number;
  const EditEstimate({Key? key, required this.estimate_id, required this.customer_name, required this.customer_number}) : super(key: key);

  @override
  State<EditEstimate> createState() => _EditEstimateState();
}

class _EditEstimateState extends State<EditEstimate> {
  setFlatNumber({required String selectFlat, required int selectFlatId}) {
    estimateShowCustomerDetailsController.selectFlatIndexId[int.parse(
        estimateShowCustomerDetailsController.selectFlatIndex.value
            .toString())] = selectFlatId.toString();
    debugPrint(
        'Inside the Set Flat Number ${selectFlat.toString()} = ${selectFlatId.toString()}');
    debugPrint(
        '1-1-1-1-1-1-1- Values ${estimateShowCustomerDetailsController.selectFlatIndex.value.toString()}');
    estimateShowCustomerDetailsController
        .flatNoController[int.parse(estimateShowCustomerDetailsController
        .selectFlatIndex.value
        .toString())]
        .text = selectFlat.toString();
  }

  DateTime selectedDate = DateTime.now();
  String showInvoiceDate =
  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  selectSalesInvoiceDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        showInvoiceDate = DateFormat('yyyy-MM-dd').format(selected).toString();
        estimateShowCustomerDetailsController
            .estimateEstimateDateDialogController
            .text = showInvoiceDate.toString();
      });
    }
  }

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
            return EstimateSelectCustomer();
          },
        );
      },
    );
  }

  selectTowerBottomSheet(BuildContext context, {required int selectFlatIndex}) {
    estimateShowCustomerDetailsController.selectFlatIndex.value =
        selectFlatIndex;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return SelectTown();
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
            return SelectFloor(
              getSelectTownValue: selectFloorName,
              getSelectedTownIndex: selectedTowerIndex.toString(),
            );
          },
        );
      },
    );
  }

  selectFloorNumberBottomSheet(
      BuildContext context, {
        required String getEstimateSelectFloorValue,
        required String getEstimateSelectTownValue,
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
          return StatefulBuilder(builder: (context, state) {
            return SelectNumber(
              getEstimateSelectTownValue: getEstimateSelectTownValue,
              getEstimateSelectFloorValue: getEstimateSelectFloorValue,
              getSelectedFloorIndexId: getSelectedFloorIndex,
            );
          });
        });
  }

  showEstimateDetailsDialog(
      BuildContext context,
      ) {
    setState(() {
      estimateShowCustomerDetailsController.estimateEstimateDateDialogController
          .text = showInvoiceDate.toString();
      estimateShowCustomerDetailsController.estimateEstimateNoDialogController
          .text = "widget.customerEstimateNo.toString()";
    });
    CommonWidget().showalertDialog(
      context: context,
      getMyWidget: Container(
        child: Column(
          children: <Widget>[
            Text(
              Texts.estimatesDetails,
              style: dialogTitleStyle(),
            ),
            const SizedBox(
              height: 14.0,
            ),
            CommonTextFieldLabel(
              controller: estimateNoDialogController,
              validator: (value) {},
              onChanged: (value) {
                setState(() {
                  // widget.customerEstimateNo = value.toString();
                });
              },
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              labelText: Texts.estimatesNo,
              hintText: Texts.estimatesNo,
            ),
            const SizedBox(
              height: 11.0,
            ),
            CommonTextFieldLabelIcon(
              icon: CommonImage.date_icon,
              controller: estimateShowCustomerDetailsController
                  .estimateEstimateDateDialogController,
              validator: (value) {},
              onTap: () => selectSalesInvoiceDate(context),
              readOnly: true,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              labelText: Texts.estimatesDate,
              hintText: Texts.estimatesDate,
            ),
          ],
        ),
      ),
    );
  }

  late double screenHeight, screenWidth;
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController sqftController = TextEditingController();
  final TextEditingController pricePerSqController = TextEditingController();
  final TextEditingController basicAmountController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController otherChargesController = TextEditingController();
  final TextEditingController homeLoanChargesController =
  TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final estimateShowCustomerDetailsController =
  Get.put(EstimateShowCustomeController());

  @override
  void initState() {
    estimateShowCustomerDetailsController.GetSalesById(estimateId: widget.estimate_id, context: context);
    super.initState();
  }

  final TextEditingController estimateNoDialogController =
  TextEditingController();
  final TextEditingController estimateDateDialogController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        debugPrint('11-11-11-11-11- Inside the Back');
        // estimateShowCustomerDetailsController.cleanAll();
        // Get.back();
        return false;
      },
      child: CommonWidget().CommonCustomerAppBar(
        labelText: Texts.estimates,
        bodyWidget: Scaffold(
          bottomNavigationBar: Container(
            margin:
            const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            color: Colors.transparent,
            child: CommonWidget().listingCardDesign(
              context: context,
              getWidget: ListTile(
                contentPadding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 20.0, right: 13.0),
                visualDensity: const VisualDensity(
                  vertical: -4.0,
                  horizontal: -4.0,
                ),
                title: Obx(
                      () => Text(
                    '₹ ${estimateShowCustomerDetailsController.getEstimateTotal.value.toString()}',
                    style: cartNameStyle(),
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Total Estimate',
                      style: totalEstimateLabelStyle(),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      height: 14.0,
                      width: 14.0,
                      child: Image.asset(
                        CommonImage.exclamation_icons,
                        height: 14.0,
                        width: 14.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  height: 40.0,
                  width: 108,
                  child: CommonWidget().CommonButton(
                    context: context,
                    buttonText: Texts.Save,
                    onPressed: () {
                      for (int i = 0;
                      i <
                          estimateShowCustomerDetailsController
                              .lengthOfEstimate.value;
                      i++) {
                        if (estimateShowCustomerDetailsController
                            .flatNoController[i].text
                            .toString()
                            .isEmpty ||
                            estimateShowCustomerDetailsController
                                .sqftController[i].text
                                .toString()
                                .isEmpty ||
                            estimateShowCustomerDetailsController
                                .pricePerSqController[i].text
                                .toString()
                                .isEmpty ||
                            estimateShowCustomerDetailsController
                                .basicAmountController[i].text
                                .toString()
                                .isEmpty ||
                            estimateShowCustomerDetailsController
                                .gstController[i].text
                                .toString()
                                .isEmpty ||
                            estimateShowCustomerDetailsController
                                .otherChargesController[i].text
                                .toString()
                                .isEmpty ||
                            estimateShowCustomerDetailsController
                                .homeLoanChargesController[i].text
                                .toString()
                                .isEmpty) {
                          estimateShowCustomerDetailsController
                              .isCheckEstimateValidation.value = true;
                        } else {
                          estimateShowCustomerDetailsController
                              .isCheckEstimateValidation.value = false;
                        }
                      }

                      if (estimateShowCustomerDetailsController
                          .isCheckEstimateValidation.value ==
                          false) {
                        showLoader(context);
                        estimateShowCustomerDetailsController
                            .checkValidationEstimate(context,
                            estimateDates: showInvoiceDate,
                            contactId: '1',
                            estimateNo:
                            "widget.customerEstimateNo.toString()")
                            .then((value) {
                          hideLoader(context);
                          // estimateShowCustomerDetailsController.cleanAll();
                          Get.to(const EstimateList());
                          if (value != null) {
                            if (value != 'fail') {}
                          }
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: HexColor(CommonColor.appBackColor),
          key: _globalKey,
          drawer: DrawerScreen(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(Texts.estimates, style: screenHeader()),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                showEstimateUserDetails(context),
                Obx(
                      () => CommonWidget().ListviewListingBuilder(
                    bottomSpace: 10.0,
                    context: context,
                    getItemCount: estimateShowCustomerDetailsController
                        .getIdEstimateModelList.value.data!.estimateItems!.length,
                    itemBuilder: (context, index) {
                      return CommonWidget().listingCardDesign(
                        context: context,
                        getWidget: Container(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Estimate-${index + 1}',
                                    textAlign: TextAlign.left,
                                    style: estimateLabelStyle(),
                                  ),
                                  (estimateShowCustomerDetailsController
                                      .lengthOfEstimate.value !=
                                      1)
                                      ? InkWell(
                                    onTap: () {
                                      estimateShowCustomerDetailsController
                                          .removeEstimateForm(
                                          removeFormIndex: index);
                                      RxDouble test = 0.0.obs;
                                      estimateShowCustomerDetailsController
                                          .getEstimateTotal.value = 0.0;
                                      for (var element
                                      in estimateShowCustomerDetailsController
                                          .totalAmountController) {
                                        debugPrint(
                                            '11-11-11-11-11-11- Remove ${element.text.toString()}');
                                        test.value += double.parse(
                                            element.text.toString());
                                        estimateShowCustomerDetailsController
                                            .getEstimateTotal.value +=
                                            double.parse(
                                                element.text.toString());
                                      }
                                    },
                                    child: SizedBox(
                                      height: 18.0,
                                      width: 18.0,
                                      child: Image.asset(
                                          CommonImage.close_icon),
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: CommonTextFieldLabel(
                                      validator: (String? value) {},
                                      labelText: Texts.FlatNo,
                                      textInputType: TextInputType.text,
                                      controller:
                                      estimateShowCustomerDetailsController
                                          .flatNoController[index],
                                      hintText: Texts.FlatNo,
                                      textInputAction: TextInputAction.next,
                                      readOnly: true,
                                      onTap: () => selectTowerBottomSheet(
                                        context,
                                        selectFlatIndex: index,
                                      ),
                                      onChanged: (value) {
                                        if (int.parse(
                                            value.length.toString()) !=
                                            0) {
                                          estimateShowCustomerDetailsController
                                              .estimateFormCheck[index][0] =
                                          true;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Flexible(
                                    child: CommonTextFieldLabel(
                                      validator: (String? value) {},
                                      labelText: Texts.Sqft,
                                      textInputType: TextInputType.number,
                                      controller:
                                      estimateShowCustomerDetailsController
                                          .sqftController[index],
                                      hintText: Texts.Sqft,
                                      textInputAction: TextInputAction.next,
                                      onTap: () {},
                                      onChanged: (value) {
                                        if (int.parse(
                                            value.length.toString()) !=
                                            0) {
                                          estimateShowCustomerDetailsController
                                              .estimateFormCheck[index][1] =
                                          true;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Obx(
                                          () => (estimateShowCustomerDetailsController
                                          .isCheckEstimateValidation
                                          .value ==
                                          true)
                                          ? (estimateShowCustomerDetailsController
                                          .estimateFormCheck[
                                      index][0] ==
                                          false)
                                          ? CommonWidget()
                                          .showEstimateErrorMessage(
                                          errorMessage:
                                          'Please enter FlatNo.')
                                          : Container()
                                          : Container(),
                                    ),
                                  ),
                                  Flexible(
                                    child: Obx(
                                          () => (estimateShowCustomerDetailsController
                                          .isCheckEstimateValidation
                                          .value ==
                                          true)
                                          ? (estimateShowCustomerDetailsController
                                          .estimateFormCheck[
                                      index][1] ==
                                          false)
                                          ? CommonWidget()
                                          .showEstimateErrorMessage(
                                          errorMessage:
                                          'Please enter FlatNo.')
                                          : Container()
                                          : Container(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // Row(
                              //   children: <Widget>[
                              //     Flexible(
                              //       child: CommonTextFieldLabel(
                              //         validator: (String? value) {},
                              //         labelText: Texts.PriceperSqft,
                              //         textInputType: TextInputType.number,
                              //         controller:
                              //         estimateShowCustomerDetailsController
                              //             .pricePerSqController[index],
                              //         hintText: Texts.PriceperSqft,
                              //         textInputAction: TextInputAction.next,
                              //         onTap: () {},
                              //         onChanged: (value) {
                              //           if (int.parse(
                              //               value.length.toString()) !=
                              //               0) {
                              //             estimateShowCustomerDetailsController
                              //                 .estimateFormCheck[index][2] =
                              //             true;
                              //           }
                              //           estimateShowCustomerDetailsController
                              //               .countBasicAmount(
                              //               selectedIndex: index);
                              //         },
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 15.0,
                              //     ),
                              //     Flexible(
                              //       child: CommonTextFieldLabel(
                              //         validator: (String? value) {},
                              //         labelText: Texts.BasicAmount,
                              //         textInputType: TextInputType.number,
                              //         controller:
                              //         estimateShowCustomerDetailsController
                              //             .basicAmountController[index],
                              //         hintText: Texts.BasicAmount,
                              //         textInputAction: TextInputAction.next,
                              //         onTap: () {},
                              //         onChanged: (value) {
                              //           if (int.parse(
                              //               value.length.toString()) !=
                              //               0) {
                              //             estimateShowCustomerDetailsController
                              //                 .estimateFormCheck[index][3] =
                              //             true;
                              //           }
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: <Widget>[
                              //     Flexible(
                              //       child: Obx(
                              //             () => (estimateShowCustomerDetailsController
                              //             .isCheckEstimateValidation
                              //             .value ==
                              //             true)
                              //             ? (estimateShowCustomerDetailsController
                              //             .estimateFormCheck[
                              //         index][2] ==
                              //             false)
                              //             ? CommonWidget()
                              //             .showEstimateErrorMessage(
                              //             errorMessage:
                              //             'Please enter Price per sq.ft.')
                              //             : Container()
                              //             : Container(),
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: Obx(
                              //             () => (estimateShowCustomerDetailsController
                              //             .isCheckEstimateValidation
                              //             .value ==
                              //             true)
                              //             ? (int.parse(estimateShowCustomerDetailsController
                              //             .basicAmountController[
                              //         index]
                              //             .text
                              //             .length
                              //             .toString()) ==
                              //             0 &&
                              //             estimateShowCustomerDetailsController
                              //                 .basicAmountController[
                              //             index]
                              //                 .text
                              //                 .toString()
                              //                 .isEmpty)
                              //             ? CommonWidget()
                              //             .showEstimateErrorMessage(
                              //             errorMessage:
                              //             'Please enter Basic amount.')
                              //             : Container()
                              //             : Container(),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     Flexible(
                              //       child: CommonTextFieldLabel(
                              //         validator: (String? value) {},
                              //         labelText: Texts.GST,
                              //         textInputType: TextInputType.number,
                              //         controller:
                              //         estimateShowCustomerDetailsController
                              //             .gstController[index],
                              //         hintText: Texts.GST,
                              //         textInputAction: TextInputAction.next,
                              //         onTap: () {},
                              //         onChanged: (value) {
                              //           if (int.parse(
                              //               value.length.toString()) !=
                              //               0) {
                              //             estimateShowCustomerDetailsController
                              //                 .estimateFormCheck[index][4] =
                              //             true;
                              //           }
                              //           estimateShowCustomerDetailsController
                              //               .countBasicAmount(
                              //               selectedIndex: index);
                              //         },
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 15.0,
                              //     ),
                              //     Flexible(
                              //       child: CommonTextFieldLabel(
                              //         validator: (String? value) {},
                              //         labelText: Texts.OtherCharges,
                              //         textInputType: TextInputType.number,
                              //         controller:
                              //         estimateShowCustomerDetailsController
                              //             .otherChargesController[index],
                              //         readOnly: true,
                              //         hintText: Texts.OtherCharges,
                              //         textInputAction: TextInputAction.next,
                              //         onTap: () => gotoOnChangesScreen(context,
                              //             index: index),
                              //         onChanged: (value) {
                              //           // if (int.parse(value.length.toString()) != 0) {
                              //           //   estimateShowCustomerDetailsController
                              //           //       .estimateFormCheck[index][5] = true;
                              //           // }
                              //           estimateShowCustomerDetailsController
                              //               .countBasicAmount(
                              //               selectedIndex: index);
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: <Widget>[
                              //     Flexible(
                              //       child: Obx(
                              //             () => (estimateShowCustomerDetailsController
                              //             .isCheckEstimateValidation
                              //             .value ==
                              //             true)
                              //             ? (int.parse(estimateShowCustomerDetailsController
                              //             .gstController[index]
                              //             .text
                              //             .length
                              //             .toString()) ==
                              //             0 &&
                              //             estimateShowCustomerDetailsController
                              //                 .gstController[index].text
                              //                 .toString()
                              //                 .isEmpty)
                              //             ? CommonWidget()
                              //             .showEstimateErrorMessage(
                              //             errorMessage:
                              //             'Please enter GST.')
                              //             : Container()
                              //             : Container(),
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: Obx(
                              //             () => (estimateShowCustomerDetailsController
                              //             .isCheckEstimateValidation
                              //             .value ==
                              //             true)
                              //             ? (int.parse(estimateShowCustomerDetailsController
                              //             .otherChargesController[
                              //         index]
                              //             .text
                              //             .length
                              //             .toString()) ==
                              //             0 &&
                              //             estimateShowCustomerDetailsController
                              //                 .otherChargesController[
                              //             index]
                              //                 .text
                              //                 .toString()
                              //                 .isEmpty)
                              //             ? CommonWidget()
                              //             .showEstimateErrorMessage(
                              //             errorMessage:
                              //             'Please enter Other Charges.')
                              //             : Container()
                              //             : Container(),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     Flexible(
                              //       child: CommonTextFieldLabel(
                              //         validator: (String? value) {},
                              //         labelText: Texts.HomeLoanCharges,
                              //         textInputType: TextInputType.number,
                              //         controller:
                              //         estimateShowCustomerDetailsController
                              //             .homeLoanChargesController[index],
                              //         hintText: Texts.HomeLoanCharges,
                              //         textInputAction: TextInputAction.next,
                              //         readOnly: true,
                              //         onTap: () =>
                              //             gotoHomeLoanScreen(indexs: index),
                              //         onChanged: (value) {
                              //           if (int.parse(
                              //               estimateShowCustomerDetailsController
                              //                   .homeLoanChargesController[
                              //               index]
                              //                   .text
                              //                   .length
                              //                   .toString()) !=
                              //               0) {
                              //             estimateShowCustomerDetailsController
                              //                 .estimateFormCheck[index][5] =
                              //             true;
                              //           }
                              //         },
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 15.0,
                              //     ),
                              //     Flexible(
                              //       child: CommonTextFieldLabel(
                              //         validator: (String? value) {},
                              //         labelText: Texts.TotalAmount,
                              //         textInputType: TextInputType.number,
                              //         readOnly: true,
                              //         controller:
                              //         estimateShowCustomerDetailsController
                              //             .totalAmountController[index],
                              //         hintText: Texts.TotalAmount,
                              //         textInputAction: TextInputAction.next,
                              //         onTap: () {},
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Obx(
                                    () => (estimateShowCustomerDetailsController
                                    .isCheckEstimateValidation.value ==
                                    true)
                                    ? (int.parse(estimateShowCustomerDetailsController
                                    .totalAmountController[
                                index]
                                    .text
                                    .length
                                    .toString()) ==
                                    0 &&
                                    estimateShowCustomerDetailsController
                                        .totalAmountController[index]
                                        .text
                                        .toString()
                                        .isEmpty)
                                    ? CommonWidget().showEstimateErrorMessage(
                                    errorMessage:
                                    'Please enter Home loan charges.')
                                    : Container()
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  highlightColor: HexColor(CommonColor.appBackColor),
                  splashColor: HexColor(CommonColor.appBackColor),
                  focusColor: HexColor(CommonColor.appBackColor),
                  hoverColor: HexColor(CommonColor.appBackColor),
                  onTap: () =>
                      estimateShowCustomerDetailsController.addEstimateForm(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: HexColor(CommonColor.appActiveColor),
                          shape: BoxShape.circle,
                        ),
                        height: 18.0,
                        width: 18.0,
                        child: const Icon(
                          Icons.add,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        Texts.AddEstimate,
                        style: linkTextStyle(fontSizes: 12.0),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container showEstimateUserDetails(BuildContext context) {
    return Container(
      child: CommonWidget().listingCardDesign(
        context: context,
        getWidget: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: InkWell(
                    onTap: () => displayBottomSheet(context),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 13.0, bottom: 4.0),
                      child: Text(
                        widget.customer_name.toString(),
                        textAlign: TextAlign.left,
                        style: cartNameStyle(),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () => showEstimateDetailsDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, top: 13.0, bottom: 4.0),
                      child: Text(
                        'Estimate No. "${widget.customer_number.toString()}',
                        textAlign: TextAlign.right,
                        style: estimateStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: InkWell(
                    onTap: () => displayBottomSheet(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 13.0),
                      child: Text(
                        widget.customer_number.toString(),
                        textAlign: TextAlign.left,
                        style: cartMobileNumberStyle(),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () => showEstimateDetailsDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 13.0),
                      child: Text(
                        showInvoiceDate.toString(),
                        textAlign: TextAlign.right,
                        style: estimateStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}