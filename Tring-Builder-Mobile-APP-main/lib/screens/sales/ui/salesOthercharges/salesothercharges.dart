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
import 'package:tring/screens/sales/controller/salescontroller.dart';

class SalesOtherChanges extends StatefulWidget {
  int index;

  SalesOtherChanges({required this.index});

  @override
  SalesOtherChangesState createState() => SalesOtherChangesState();
}

class SalesOtherChangesState extends State<SalesOtherChanges> {
  late double screenHeight, screenWidth;

  final salesController = Get.find<SalesController>();

  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('******************** Other Changes Index ${widget.index}');
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return CommonWidget().CommonCustomerAppBar(
      labelText: 'Other Charges',
      bodyWidget: Scaffold(
        backgroundColor: HexColor(CommonColor.appBackColor),
        key: _globalKey,
        drawer: DrawerScreen(),
        body: Obx(() => (salesController.isTrue.value)
            ? SingleChildScrollView(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                              controller:
                                  salesController.salesOtherParkingController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.Parking,
                              hintText: Texts.Parking,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // salesController.showOtherChargesTotal.value += double.parse(value.toString());
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherParkingError.value = true;
                                // }
                                // else{
                                //   salesController
                                //       .isSalesOtherParkingError.value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherParkingError.value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage: 'Please enter Parking.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherMaintenanceController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.MaintenanceDeposite,
                              hintText: Texts.MaintenanceDeposite,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController.isSalesOtherMaintenanceError
                                //       .value = true;
                                // }
                                // else{
                                //   salesController.isSalesOtherMaintenanceError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherMaintenanceError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter maintenance deposite.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherPreferentialController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.PreferentialLocationCharges,
                              hintText: Texts.PreferentialLocationCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController.isSalesOtherPreferentialError
                                //       .value = true;
                                // }
                                // else{
                                //   salesController.isSalesOtherPreferentialError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherPreferentialError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter Preferential Location Chanrges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherRegistrationController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.RegistrationFee,
                              hintText: Texts.RegistrationFee,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController.isSalesOtherRegistrationError
                                //       .value = true;
                                // } else {
                                //   salesController.isSalesOtherRegistrationError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherRegistrationError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter registration fee.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller:
                                  salesController.salesOtherStampController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.StampDuty,
                              hintText: Texts.StampDuty,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController.isSalesOtherStampError.value =
                                //       true;
                                // } else {
                                //   salesController.isSalesOtherStampError.value =
                                //       false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherStampError.value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter stamp duty.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller:
                                  salesController.salesOtherBrokerageController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.BrokerageCharges,
                              hintText: Texts.BrokerageCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherBrokerageError.value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherBrokerageError.value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController.isSalesOtherBrokerageError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter brokerage charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherTitleSalesController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.TitleSalesDeed,
                              hintText: Texts.TitleSalesDeed,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherTitleSalesError.value = true;
                                // } else {
                                //   salesController.isSalesOtherTitleSalesError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController.isSalesOtherTitleSalesError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter title or sales deed charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller:
                                  salesController.salesOtherNotaryController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.NotaryCharges,
                              hintText: Texts.NotaryCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherNotaryError.value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherNotaryError.value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherNotaryError.value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter notary & franking charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller:
                                  salesController.salesOtherMortgageController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.MortgageCharges,
                              hintText: Texts.MortgageCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherMortgageError.value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherMortgageError.value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController.isSalesOtherMortgageError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter mortgage charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller:
                                  salesController.salesOtherOtherController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.OtherCharges,
                              hintText: Texts.OtherCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController.isSalesOtherOtherError.value =
                                //       true;
                                // } else {
                                //   salesController.isSalesOtherOtherError.value =
                                //       false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherOtherError.value ==
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
                              controller: salesController
                                  .salesOtherChargesClubmembershipController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.ClubMembership,
                              hintText: Texts.ClubMembership,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesClubmembershipError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesClubmembershipError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesClubmembershipError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter club membership.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesCivicamentialController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.CivicAmenitiesCharges,
                              hintText: Texts.CivicAmenitiesCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesCivicamentialError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesCivicamentialError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesCivicamentialError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter civic amenities charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesExternalDevelopmentController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.ExternalDevelopmentCharges,
                              hintText: Texts.ExternalDevelopmentCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesExternalDevelopmentError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesExternalDevelopmentError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesExternalDevelopmentError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter external development charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesInfrastructureDevelopmentController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.InfrastructureDevelopmentCharges,
                              hintText: Texts.InfrastructureDevelopmentCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesInfrastructureDevelopmentError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesInfrastructureDevelopmentError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesInfrastructureDevelopmentError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter infrastructure development charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesOverheadController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.OverheadCharges,
                              hintText: Texts.OverheadCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesOverheadError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesOverheadError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesOverheadError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter overhead charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesInsuranceController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.InsuranceFee,
                              hintText: Texts.InsuranceFee,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesInsuranceError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesInsuranceError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesInsuranceError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter insurance fee.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesUtilityController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.UtilityCharges,
                              hintText: Texts.UtilityCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesUtilityError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesUtilityError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesUtilityError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter utility charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesHomeInspectionController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.HomeInspectionCost,
                              hintText: Texts.HomeInspectionCost,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesHomeInspectionError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesHomeInspectionError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesHomeInspectionError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter home inspection cost.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesInteriorsController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.Interiors,
                              hintText: Texts.Interiors,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesInteriorsError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesInteriorsError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesInteriorsError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter interiors.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesPlumbingController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.Plumbing,
                              hintText: Texts.Plumbing,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesPlumbingError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesPlumbingError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesPlumbingError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter plumbing.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesFurnitureController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.Furniture,
                              hintText: Texts.Furniture,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesFurnitureError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesFurnitureError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesFurnitureError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter furniture.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesElectricWorkController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.ElectricWork,
                              hintText: Texts.ElectricWork,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesElectricWorkError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesElectricWorkError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesElectricWorkError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter electric work.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesMiscellaneousController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.MiscellaneousCharges,
                              hintText: Texts.MiscellaneousCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesMiscellaneousError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesMiscellaneousError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesMiscellaneousError
                                              .value ==
                                          false)
                                      ? CommonWidget().showEstimateErrorMessage(
                                          errorMessage:
                                              'Please enter miscellaneous charges.')
                                      : Container()
                                  : Container(),
                            ),
                            spaceDefault(),
                            CommonTextFieldLabel(
                              controller: salesController
                                  .salesOtherChargesBrokerageController,
                              validator: (value) {},
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              labelText: Texts.BrokerageCharges,
                              hintText: Texts.BrokerageCharges,
                              onChanged: (value) {
                                salesController.countOtherCharges();
                                // if (int.parse(value.length.toString()) != 0) {
                                //   salesController
                                //       .isSalesOtherChargesBrokerageError
                                //       .value = true;
                                // } else {
                                //   salesController
                                //       .isSalesOtherChargesBrokerageError
                                //       .value = false;
                                // }
                              },
                            ),
                            Obx(
                              () => (salesController
                                          .isCheckSalesValidation.value ==
                                      true)
                                  ? (salesController
                                              .isSalesOtherChargesBrokerageError
                                              .value ==
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
                          '₹ ${salesController.showOtherChargesTotal.value.toString()}',
                          // '₹ ${double.tryParse(salesController.salesOtherParkingController.text.toString())! + double.tryParse(salesController.salesOtherMaintenanceController.text.toString())!} ',
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
                            // onPressed: () => salesController
                            //     .isCheckSalesValidation.value = true,
                            onPressed: () {
                              salesController.countOtherCharges();

                              salesController.otherChargesController.text =
                                  salesController.showOtherChargesTotal.value
                                      .toString();
                              salesController.countSalesBillAmount();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Text('test')),
      ),
    );
  }

  SizedBox spaceDefault() => const SizedBox(
        height: 10.0,
      );
}
