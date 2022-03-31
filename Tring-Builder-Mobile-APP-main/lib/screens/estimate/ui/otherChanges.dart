import 'package:flutter/cupertino.dart'; // ignore:file_names
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

class OtherChanges extends StatefulWidget {
  int index;

  OtherChanges({required this.index});

  @override
  OtherChangesState createState() => OtherChangesState();
}

class OtherChangesState extends State<OtherChanges> {
  late double screenHeight, screenWidth;

  final estimateShowCustomerController =
      Get.find<EstimateShowCustomeController>();

  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('******************** Other Changes Index ${widget.index}');
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
                Container(
                  child: Text(Texts.OtherCharges, style: screenHeader()),
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
                          Texts.FrequentlyUsed,
                          style: drawerSubHeaderStyle(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyGstController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.GST,
                          hintText: Texts.GST,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [0] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage: 'Please enter GST.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyParkingController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.Parking,
                          hintText: Texts.Parking,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [1] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage: 'Please enter Parking.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherFrequentlyMaintenanceController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.MaintenanceDeposite,
                          hintText: Texts.MaintenanceDeposite,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][2] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [2] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter maintenance deposite.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherFrequentlyPreferentialController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.PreferentialLocationCharges,
                          hintText: Texts.PreferentialLocationCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][3] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [3] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter preferential location charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherFrequentlyRegistationController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.RegistrationFee,
                          hintText: Texts.RegistrationFee,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][4] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [4] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter registration fee.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyStampController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.StampDuty,
                          hintText: Texts.StampDuty,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][5] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [5] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage: 'Please enter stamp duty.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyBrokerageController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.BrokerageCharges,
                          hintText: Texts.BrokerageCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][6] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [6] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter brokerage charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherFrequentlyTitleSalesController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.TitleSalesDeed,
                          hintText: Texts.TitleSalesDeed,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][7] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [7] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter title or sales deed charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyNotaryController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.NotaryCharges,
                          hintText: Texts.NotaryCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][8] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [8] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter notary & franking charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyMortgageController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.MortgageCharges,
                          hintText: Texts.MortgageCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][9] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [9] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter mortgage charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherFrequentlyOtherController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.OtherCharges,
                          hintText: Texts.OtherCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //       .frequentlyFormCheck[widget.index][10] = true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .frequentlyFormCheck[widget.index]
                                          [10] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter other charges.')
                                  : Container()
                              : Container(),
                        )
                      ],
                    ),
                  ),
                ),
                spaceDefault(),
                CommonWidget().listingCardDesign(
                  context: context,
                  getWidget: Container(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 18.0, bottom: 15.0, right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Texts.OtherCharges,
                          style: drawerSubHeaderStyle(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherClubmembershipController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.ClubMembership,
                          hintText: Texts.ClubMembership,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][0] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][0] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter club membership.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherCivicamentialController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.CivicAmenitiesCharges,
                          hintText: Texts.CivicAmenitiesCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][1] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][1] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter civic amenities charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherExternalDevelopmentController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.ExternalDevelopmentCharges,
                          hintText: Texts.ExternalDevelopmentCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][2] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][2] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter external development charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherInfrastructureDevelopmentController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.InfrastructureDevelopmentCharges,
                          hintText: Texts.InfrastructureDevelopmentCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][3] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][3] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter infrastructure development charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherChargeOtherOverheadController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.OverheadCharges,
                          hintText: Texts.OverheadCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][4] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][4] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter overhead charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherInsuranceController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.InsuranceFee,
                          hintText: Texts.InsuranceFee,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][5] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][5] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter insurance fee.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherChargeOtherUtilityController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.UtilityCharges,
                          hintText: Texts.UtilityCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][6] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][6] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter utility charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherHomeInspectionController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.HomeInspectionCost,
                          hintText: Texts.HomeInspectionCost,
                          onChanged: (value) {
                            //
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][7] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter home inspection cost.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherInteriorsController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.Interiors,
                          hintText: Texts.Interiors,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][8] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][8] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage: 'Please enter interiors.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                              .otherChargeOtherPlumbingController[widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.Plumbing,
                          hintText: Texts.Plumbing,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][9] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][9] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage: 'Please enter plumbing.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherFurnitureController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.Furniture,
                          hintText: Texts.Furniture,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][10] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][10] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage: 'Please enter furniture.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherElectricWorkController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.ElectricWork,
                          hintText: Texts.ElectricWork,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][11] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][11] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter electric work.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherMiscellaneousController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.MiscellaneousCharges,
                          hintText: Texts.MiscellaneousCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][12] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][12] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter miscellaneous charges.')
                                  : Container()
                              : Container(),
                        ),
                        spaceDefault(),
                        CommonTextFieldLabel(
                          controller: estimateShowCustomerController
                                  .otherChargeOtherBrokerageController[
                              widget.index],
                          validator: (value) {},
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelText: Texts.BrokerageCharges,
                          hintText: Texts.BrokerageCharges,
                          onChanged: (value) {
                            estimateShowCustomerController
                                .getSubTotalOtherCharges(
                              indexs: int.parse(widget.index.toString()),
                            );
                            // if (value.length != 0) {
                            //   estimateShowCustomerController
                            //           .otherChargesFormCheck[widget.index][13] =
                            //       true;
                            // }
                          },
                        ),
                        Obx(
                          () => (estimateShowCustomerController
                                      .isCheckFrequentlyValidation.value ==
                                  true)
                              ? (estimateShowCustomerController
                                              .otherChargesFormCheck[
                                          widget.index][13] ==
                                      false)
                                  ? CommonWidget().showEstimateErrorMessage(
                                      errorMessage:
                                          'Please enter brokerage charges.')
                                  : Container()
                              : Container(),
                        ),
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
                      '₹ ${estimateShowCustomerController.showOtherChargesTotal[int.parse(widget.index.toString())].toString()}',
                      style: cartNameStyle(),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Texts.TotalOtherCharges,
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
                        // onPressed: () => estimateShowCustomerController.isCheckFrequentlyValidation.value = true,
                        onPressed: () {
                          // estimateShowCustomerController
                          //     .getEstimateTotal.value = 0.0;

                          // estimateShowCustomerController.countOtherCharges(
                          //   selectOtherChargesIndex:
                          //       int.parse(widget.index.toString()),
                          // );
                          estimateShowCustomerController
                                  .otherChargesController[
                                      int.parse(widget.index.toString())]
                                  .text =
                              estimateShowCustomerController
                                  .showOtherChargesTotal[
                                      int.parse(widget.index.toString())]
                                  .toString();
                          estimateShowCustomerController.countBasicAmount(
                              selectedIndex: widget.index);

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
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
