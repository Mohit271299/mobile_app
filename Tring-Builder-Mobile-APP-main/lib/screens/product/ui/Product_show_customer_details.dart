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
import 'package:tring/screens/sales/controller/salescontroller.dart';

class PurchaseShowCustomerDetails extends StatefulWidget {
  const PurchaseShowCustomerDetails({Key? key}) : super(key: key);

  @override
  PurchaseShowCustomerDetailsState createState() =>
      PurchaseShowCustomerDetailsState();
}

class PurchaseShowCustomerDetailsState extends State<PurchaseShowCustomerDetails> {
  showSalesDetailsDialog(
    BuildContext context,
  ) {
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
              controller: salesDetailsController.estimateNoDialogController,
              validator: (value) {},
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
              controller: salesDetailsController.estimateDateDialogController,
              validator: (value) {},
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
  final salesDetailsController = Get.put(SalesController());
  String dropdownvalue1 = "One";

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
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: HexColor(CommonColor.appBackColor),
        //   leading: CommonWidget().appBarShapeBox(context: context),
        //   actions: [
        //     CommonWidget().appBarAction(),
        //   ],
        // ),
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
              title: Text(
                '₹12,23,330',
                style: cartNameStyle(),
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
                  onPressed: () => salesDetailsController
                      .isSalesCheckFormValidation.value = true,
                  // CommonWidget().showalertDialog(
                  //   context: context,
                  //   getMyWidget: Column(
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 16.0,
                  //             bottom: 14.0),
                  //         child: Text(
                  //           Texts.SalesDetails,
                  //           style: cartNameStyle(),
                  //         ),
                  //       ),
                  //       CommonTextFieldLabel(
                  //         controller: salesDetailsController
                  //             .invoiceNoController,
                  //         validator: (value) {},
                  //         textInputType: TextInputType.number,
                  //         textInputAction: TextInputAction.next,
                  //         labelText: Texts.InvoiceNo,
                  //         hintText: Texts.InvoiceNo,
                  //       ),
                  //       const SizedBox(
                  //         height: 11.0,
                  //       ),
                  //       CommonTextFieldLabelIcon(
                  //         icon: CommonImage.date_icon,
                  //         controller:
                  //         salesDetailsController.invoiceDateController,
                  //         validator: (value) {},
                  //         textInputType: TextInputType.number,
                  //         textInputAction: TextInputAction.next,
                  //         labelText: Texts.InvoiceDate,
                  //         hintText: Texts.InvoiceDate,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(Texts.addNewPurchase, style: screenHeader()),
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
                              'Devang Vadaliya',
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
                                'Estimate No. 12',
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
                              '9998979695',
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
                                '20/02/2022',
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
                              // SizedBox(
                              //   height: 18.0,
                              //   width: 18.0,
                              //   child: Image.asset(CommonImage.close_icon),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
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
                                            'One',
                                            'Two',
                                            'Free',
                                            'Four'
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
                                                    fontSize: 14.0),
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
                                  controller:
                                      salesDetailsController.flatNoController,
                                  hintText: Texts.FlatNo,
                                  textInputAction: TextInputAction.next,
                                  onTap: () {},
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
                                  hintText: Texts.OtherCharges,
                                  textInputAction: TextInputAction.next,
                                  onTap: () {},
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
                                  onTap: () {},
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
                                  onTap: () {},
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
        ),
      ),
    );
  }
}
