import 'package:flutter/cupertino.dart'; // ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/estimate/controller/estimateshowcustomercontroller.dart';

class HomeLoadCharges extends StatefulWidget {
  int index;

  HomeLoadCharges({required this.index});

  @override
  HomeLoadChargesState createState() => HomeLoadChargesState();
}

class HomeLoadChargesState extends State<HomeLoadCharges> {
  late double screenHeight, screenWidth;
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  final estimateShowCustomerController =
      Get.find<EstimateShowCustomeController>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor(CommonColor.appBackColor),
      key: _globalKey,
      drawer: DrawerScreen(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor(CommonColor.appBackColor),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          CommonWidget().appBarAction(),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  hoverColor: HexColor(CommonColor.appBackColor),
                  focusColor: HexColor(CommonColor.appBackColor),
                  splashColor: HexColor(CommonColor.appBackColor),
                  highlightColor: HexColor(CommonColor.appBackColor),
                  onTap: () => CommonWidget().hideFocusKeyBoard(context),
                  child: Container(
                    width: screenWidth,
                    child: Text(
                      Texts.homeLoad,
                      style: screenHeader(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CommonWidget().listingCardDesign(
                  context: context,
                  getWidget: Container(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 18.0, bottom: 15.0, right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Texts.homeLoad,
                          style: drawerSubHeaderStyle(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanLoanAmountController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.LoanAmount,
                          hintText: Texts.LoanAmount,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][0] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][0] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.LoanAmount.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanInterestChargesController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.InterestCharges,
                          hintText: Texts.InterestCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][1] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][1] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.InterestCharges.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanLoanProcessingFee[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.LoanProcessingFee,
                          hintText: Texts.LoanProcessingFee,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][2] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][2] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.LoanProcessingFee.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .homeLoanPrepaymentChargesController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.PrepaymentCharges,
                          hintText: Texts.PrepaymentCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][3] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][3] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.PrepaymentCharges.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .homeLoanLatePaymentChargesController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.LatePaymentCharges,
                          hintText: Texts.LatePaymentCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][4] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][4] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.PrepaymentCharges.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .homeLoanApplicationProcessingController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.ApplicationProcessingFee,
                          hintText: Texts.ApplicationProcessingFee,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][5] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][5] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.ApplicationProcessingFee.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanBrokerageChargesController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.BrokerageCharges,
                          hintText: Texts.BrokerageCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][6] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][6] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.BrokerageCharges.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanInsuranceFeeController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.InsuranceFee,
                          hintText: Texts.InsuranceFee,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][7] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][7] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.InsuranceFee.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanMortgageChargesController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.MortgageCharges,
                          hintText: Texts.MortgageCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][8] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][8] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.InsuranceFee.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .homeLoanOtherChargesController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          labelText: Texts.OtherCharges,
                          hintText: Texts.OtherCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalHomeLoanCharges(
                                    index: widget.index);
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .homeLoanFormCheck[widget.index][9] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckHomeLoanValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                          .homeLoanFormCheck[widget.index][9] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter ${Texts.OtherCharges.toString().toLowerCase()}.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                      ],
                    ),
                  ),
                ),
                spaceDefault(),
                CommonWidget().listingCardDesign(
                  context: context,
                  getWidget: ListTile(
                    contentPadding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 20.0, right: 13.0),
                    visualDensity: const VisualDensity(
                      vertical: -4.0,
                      horizontal: -4.0,
                    ),
                    title: Text(
                      '₹ ${estimateShowCustomerController.showHomeLoanTotal[int.parse(widget.index.toString())].toString()}',
                      style: cartNameStyle(),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Texts.TotalHomeLoanChanges,
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
                          // estimateShowCustomerController
                          //     .isCheckHomeLoanValidation.value = true,

                          estimateShowCustomerController
                                  .homeLoanChargesController[
                                      int.parse(widget.index.toString())]
                                  .text =
                              estimateShowCustomerController.showHomeLoanTotal[
                                  int.parse(widget.index.toString())].toString();

                          estimateShowCustomerController.countBasicAmount(
                              selectedIndex: widget.index);

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox spaceDefault() => const SizedBox(
        height: 10.0,
      );
}
