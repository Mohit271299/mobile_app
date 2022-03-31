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
import 'package:tring/screens/sales/controller/salescontroller.dart';

class SalesHomeLoan extends StatefulWidget {
  int index;

  SalesHomeLoan({required this.index});

  @override
  SalesHomeLoanState createState() => SalesHomeLoanState();
}

class SalesHomeLoanState extends State<SalesHomeLoan> {
  late double screenHeight, screenWidth;
  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  final salesController = Get.find<SalesController>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.homeLoad,
      bodyWidget: Scaffold(
        backgroundColor: HexColor(CommonColor.appBackColor),
        key: _globalKey,
        drawer: DrawerScreen(),
        body: Obx(
          () => (salesController.isTrue.value)
              ? SingleChildScrollView(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                                controller: salesController
                                    .salesHomeLoanLoanAmountController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.LoanAmount,
                                hintText: Texts.LoanAmount,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanLoanAmountError
                                  //       .value = true;
                                  // } else {
                                  //   salesController
                                  //       .isSalesHomeLoanLoanAmountError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanLoanAmountError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.LoanAmount.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanInterestChargesController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.InterestCharges,
                                hintText: Texts.InterestCharges,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanInsuranceFeeError
                                  //       .value = true;
                                  // } else {
                                  //   salesController
                                  //       .isSalesHomeLoanInsuranceFeeError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanInsuranceFeeError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.InterestCharges.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanLoanProcessingFee,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.LoanProcessingFee,
                                hintText: Texts.LoanProcessingFee,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController.isSalesHomeLoanLoanProError
                                  //       .value = true;
                                  // } else {
                                  //   salesController.isSalesHomeLoanLoanProError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanLoanProError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.LoanProcessingFee.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanPrepaymentChargesController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.PrepaymentCharges,
                                hintText: Texts.PrepaymentCharges,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanPrepaymentChargesError
                                  //       .value = true;
                                  // } else {
                                  //   salesController
                                  //       .isSalesHomeLoanPrepaymentChargesError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanPrepaymentChargesError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.PrepaymentCharges.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanLatePaymentChargesController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.LatePaymentCharges,
                                hintText: Texts.LatePaymentCharges,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanLatePaymentChargesError
                                  //       .value = true;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanLatePaymentChargesError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.PrepaymentCharges.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanApplicationProcessingController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.ApplicationProcessingFee,
                                hintText: Texts.ApplicationProcessingFee,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanApplicationProcessingError
                                  //       .value = true;
                                  // } else {
                                  //   salesController
                                  //       .isSalesHomeLoanApplicationProcessingError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanApplicationProcessingError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.ApplicationProcessingFee.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanBrokerageChargesController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.BrokerageCharges,
                                hintText: Texts.BrokerageCharges,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanBrokerageChargesError
                                  //       .value = true;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanBrokerageChargesError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.BrokerageCharges.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanInsuranceFeeController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.InsuranceFee,
                                hintText: Texts.InsuranceFee,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanInsuranceFeeError
                                  //       .value = true;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanInsuranceFeeError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.InsuranceFee.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanMortgageChargesController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                labelText: Texts.MortgageCharges,
                                hintText: Texts.MortgageCharges,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanMortgageChargesError
                                  //       .value = true;
                                  // } else {
                                  //   salesController
                                  //       .isSalesHomeLoanMortgageChargesError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanMortgageChargesError
                                                .value ==
                                            false)
                                        ? CommonWidget().showEstimateErrorMessage(
                                            errorMessage:
                                                'Please enter ${Texts.InsuranceFee.toString().toLowerCase()}.')
                                        : Container()
                                    : Container(),
                              ),
                              spaceDefault(),
                              CommonTextFieldLabel(
                                controller: salesController
                                    .salesHomeLoanOtherChargesController,
                                validator: (value) {},
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                labelText: Texts.OtherCharges,
                                hintText: Texts.OtherCharges,
                                onChanged: (value) {
                                  salesController.countHomeLoanCharges();
                                  // if (int.parse(value.length.toString()) != 0) {
                                  //   salesController
                                  //       .isSalesHomeLoanOtherChargesError
                                  //       .value = true;
                                  // } else {
                                  //   salesController
                                  //       .isSalesHomeLoanOtherChargesError
                                  //       .value = false;
                                  // }
                                },
                              ),
                              Obx(
                                () => (salesController
                                            .isSalesCheckHomeLoanValidation
                                            .value ==
                                        true)
                                    ? (salesController
                                                .isSalesHomeLoanOtherChargesError
                                                .value ==
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
                            '₹ ${salesController.showHomeLoanChargesTotal.value.toString()}',
                            style: cartNameStyle(),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  Texts.TotalHomeLoanChanges,
                                  maxLines: 4,
                                  style: totalEstimateLabelStyle(),
                                ),
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
                                salesController.countHomeLoanCharges();
                                salesController.homeLoanChargeController.text = salesController.showHomeLoanChargesTotal.value.toString();
                                salesController.countSalesBillAmount();
                                Navigator.pop(context);

                              }
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Text(''),
        ),
      ),
    );
  }

  SizedBox spaceDefault() => const SizedBox(
        height: 10.0,
      );
}
