import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/sales/controller/salescontroller.dart';
import 'package:tring/screens/sales/ui/selectFlat/salesSelectFloor.dart';
import 'package:tring/screens/sales/ui/selectFlat/salesSelectNumber.dart';
import 'package:tring/screens/sales/ui/selectFlat/salesSelectTown.dart';

class EditSales extends StatefulWidget {
  final int sales_id;
  final int customer_id;
  final String contact_name;
  final String contact_no;
  final num invoice_no;
  final String invoice_date;

  const EditSales(
      {Key? key,
      required this.sales_id,
      required this.contact_name,
      required this.contact_no,
        required this.customer_id, required this.invoice_no, required this.invoice_date})
      : super(key: key);

  @override
  State<EditSales> createState() => _EditSalesState();
}

class _EditSalesState extends State<EditSales> {
  selectTowerBottomSheet(BuildContext context) {
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
            return SelectSalesTown();
          },
        );
      },
    );
  }

  selectSalesFloorBottomSheet(BuildContext context,
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
            return SelectSalesFloor(
              getSelectTownValue: selectFloorName,
              getSelectedTownIndex: selectedTowerIndex.toString(),
            );
          },
        );
      },
    );
  }

  selectSalesFloorNumberBottomSheet(
    BuildContext context, {
    required String getSalesSelectFloorValue,
    required String getSalesSelectTownValue,
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
        return StatefulBuilder(
          builder: (context, state) {
            return SelectSalesNumber(
              getSelectTownValue: getSalesSelectTownValue,
              getSelectFloorValue: getSalesSelectFloorValue,
              getSelectedFloorIndexId: getSelectedFloorIndex,
            );
          },
        );
      },
    );
  }

  showSalesDetailsDialog(
    BuildContext context,
  ) {
    setState(() {
      salesDetailsController.saleseEstimateDateDialogController.text =
          showInvoiceDate.toString();
      salesDetailsController.salesEstimateNoDialogController.text =
          "estimateNo.toString()";
    });
    CommonWidget().showalertDialog(
      context: context,
      getMyWidget: Container(
        child: Column(
          children: <Widget>[
            Text(
              Texts.salesDetails,
              style: dialogTitleStyle(),
            ),
            const SizedBox(
              height: 14.0,
            ),
            CommonTextFieldLabel(
              controller:
                  salesDetailsController.salesEstimateNoDialogController,
              validator: (value) {},
              onChanged: (value) {
                setState(() {
                  // widget.estimateNo = value.toString();
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
              controller:
                  salesDetailsController.saleseEstimateDateDialogController,
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

  setFlatNumber({required String selectFlat, required int selectFlatId}) {
    debugPrint(
        'Inside the Set Flat Number ${selectFlat.toString()} = ${selectFlatId.toString()}');
    salesDetailsController.flatNoController.text = selectFlat.toString();
    salesDetailsController.selectFlatId.value = selectFlatId;
  }

  late double screenHeight, screenWidth;

  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final salesDetailsController = Get.put(SalesController());
  String dropdownvalue1 = "One";

  String date = "";
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
        salesDetailsController.salesEstimateNoDialogController.text =
            showInvoiceDate.toString();
      });
    }
  }

  int selectFlatId = 0;

  @override
  void initState() {
    // activityController.task_typeController.text = widget.taskType_name;
    // activityController.associated_lead_Controller.text = widget.customer_name;
    super.initState();
    salesDetailsController.GetSalesById(
        salesId: widget.sales_id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.addNewSales,
      bodyWidget: Scaffold(
        backgroundColor: HexColor(CommonColor.appBackColor),
        key: _globalKey,
        drawer: DrawerScreen(),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
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
                  '₹ ${salesDetailsController.showSalesBillTotal.value.toString()}',
                  style: cartNameStyle(),
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Texts.TotalSales,
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
                    showLoader(context);
                    salesDetailsController
                        .storeSalesbyID(
                        invoideDate: widget.invoice_date,
                      inVoiceNumber: widget.invoice_no,
                      context: context,
                      salesId: widget.sales_id,
                        contact_id: widget.customer_id

                    );
                  },
                ),
              ),
            ),
          ),
        ),
        body: GetBuilder<SalesController>(builder: (values) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(Texts.addNewSales, style: screenHeader()),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CommonWidget().listingCardDesign(
                  context: context,
                  getWidget: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 13.0, bottom: 4.0),
                              child: Text(
                                widget.contact_name,
                                textAlign: TextAlign.left,
                                style: cartNameStyle(),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () => showSalesDetailsDialog(context),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, top: 13.0, bottom: 4.0),
                                child: Text(
                                  'Estimate No. ${"estimateNo.toString()"}',
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, bottom: 13.0),
                              child: Text(
                                widget.contact_no,
                                textAlign: TextAlign.left,
                                style: cartMobileNumberStyle(),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () => showSalesDetailsDialog(context),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, bottom: 13.0),
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
                CommonWidget().ListviewListingBuilder(
                  context: context,
                  getItemCount: 1,
                  itemBuilder: (context, index) {
                    return CommonWidget().listingCardDesign(
                      context: context,
                      getWidget: Container(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Bill-${index + 1}',
                                  textAlign: TextAlign.left,
                                  style: estimateLabelStyle(),
                                ),
                              ],
                            ),

                            //brokerName and sales
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Sales By Employee",
                                    textInputType: TextInputType.text,
                                    controller: salesDetailsController
                                        .salesByEmployeeController,
                                    hintText: "Sales By Employee",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: "Broker Name",
                                    textInputType: TextInputType.text,
                                    controller: salesDetailsController
                                        .salesBrokerNameController,
                                    hintText: "Broker Name",
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .salesByEmployeeController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorOneSideMessage(
                                                errorMessage:
                                                    salesDetailsController
                                                        .salesByEmployeeError
                                                        .toString(),
                                              )
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .salesBrokerNameController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorOneSideMessage(
                                                    errorMessage:
                                                        salesDetailsController
                                                            .brokerNameError)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            // const SizedBox(
                            //   height: 20.0,
                            // ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0,
                                        right: 0.0,
                                        top: 0.0,
                                        bottom: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: ContainerInnerShadow,
                                      ),
                                      width: screenWidth,
                                      height: 42.0,
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          labelText: Texts.Typeofsale,
                                          labelStyle: TextStyle(
                                            fontFamily: AppDetails.fontSemiBold,
                                            color: HexColor(
                                                CommonColor.subHeaderColor),
                                            fontSize: 10.0,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 5.0, left: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            iconSize: 20,
                                            hint: Text(
                                                Texts.Typeofsale.toString()),
                                            isExpanded: true,
                                            value: salesDetailsController
                                                .typeofSales.value,
                                            elevation: 4,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue1 = newValue!;
                                                salesDetailsController
                                                    .typeofSales
                                                    .value = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Booked with Token',
                                              'Property on Hold',
                                              'Sale',
                                              'Resell'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: AppDetails
                                                          .fontSemiBold,
                                                      fontSize: 12.0),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.FlatNo,
                                    textInputType: TextInputType.number,
                                    controller: values.flatNoController,
                                    hintText: Texts.FlatNo,
                                    textInputAction: TextInputAction.next,
                                    onTap: () =>
                                        selectTowerBottomSheet(context),
                                    readOnly: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController.typeofSales
                                                    .toString() ==
                                                "One")
                                            ? CommonWidget().showSalesErrorMessage(
                                                errorMessage:
                                                    salesDetailsController
                                                        .typeOfSalesErrorMessage)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .flatNoController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorMessage(
                                                    errorMessage:
                                                        salesDetailsController
                                                            .flatnoErrorMessage)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.Sqft,
                                    textInputType: TextInputType.number,
                                    controller:
                                        salesDetailsController.sqftController,
                                    hintText: Texts.Sqft,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      salesDetailsController
                                          .countSalesBillAmount();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.PriceperSqft,
                                    textInputType: TextInputType.number,
                                    controller: salesDetailsController
                                        .priceperSqftController,
                                    hintText: Texts.PriceperSqft,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      salesDetailsController.countBasicAmount();
                                      salesDetailsController
                                          .countSalesBillAmount();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .sqftController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorOneSideMessage(
                                                    errorMessage:
                                                        salesDetailsController
                                                            .sqftErroMessage)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .priceperSqftController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorOneSideMessage(
                                                    errorMessage:
                                                        salesDetailsController
                                                            .pricePerSqErrorMessage)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.BasicAmount,
                                    textInputType: TextInputType.number,
                                    controller: salesDetailsController
                                        .basicAmountController,
                                    hintText: Texts.BasicAmount,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      salesDetailsController
                                          .countSalesBillAmount();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.GST,
                                    textInputType: TextInputType.number,
                                    controller:
                                        salesDetailsController.gstController,
                                    hintText: Texts.GST,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      salesDetailsController
                                          .countSalesBillAmount();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Obx(
                                  () => (salesDetailsController
                                              .isSalesCheckFormValidation
                                              .value ==
                                          true)
                                      ? (salesDetailsController
                                              .priceperSqftController.text
                                              .trim()
                                              .toString()
                                              .isEmpty)
                                          ? CommonWidget()
                                              .showSalesErrorOneSideMessage(
                                                  errorMessage:
                                                      salesDetailsController
                                                          .pricePerSqErrorMessage)
                                          : Container()
                                      : Container(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.OtherCharges,
                                    textInputType: TextInputType.number,
                                    controller: salesDetailsController
                                        .otherChargesController,
                                    hintText: Texts.OtherCharges,
                                    textInputAction: TextInputAction.next,
                                    onTap: () =>
                                        gotoSalesOtherChargesScreen(context),
                                    onChanged: (value) {
                                      salesDetailsController
                                          .countSalesBillAmount();
                                    },
                                    readOnly: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.HomeLoanCharges,
                                    textInputType: TextInputType.number,
                                    controller: salesDetailsController
                                        .homeLoanChargeController,
                                    hintText: Texts.HomeLoanCharges,
                                    textInputAction: TextInputAction.done,
                                    onTap: () =>
                                        gotoSalesHomeLoanChargesScreen(context),
                                    readOnly: true,
                                    onChanged: (value) {
                                      salesDetailsController
                                          .countSalesBillAmount();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .otherChargesController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorOneSideMessage(
                                                    errorMessage:
                                                        salesDetailsController
                                                            .otherChargesErrorMessage)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                                Flexible(
                                  child: Obx(
                                    () => (salesDetailsController
                                                .isSalesCheckFormValidation
                                                .value ==
                                            true)
                                        ? (salesDetailsController
                                                .homeLoanChargeController.text
                                                .trim()
                                                .toString()
                                                .isEmpty)
                                            ? CommonWidget()
                                                .showSalesErrorOneSideMessage(
                                                    errorMessage:
                                                        salesDetailsController
                                                            .homeLoanErrorMessage)
                                            : Container()
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 21.0,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
