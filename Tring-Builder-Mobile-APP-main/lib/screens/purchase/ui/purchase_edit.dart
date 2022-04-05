import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/product/controller/Productcontroller.dart';
import 'package:tring/screens/purchase/controller/purchasecontroller.dart';


class EditPurchase extends StatefulWidget {
  const EditPurchase({Key? key}) : super(key: key);

  @override
  State<EditPurchase> createState() => _EditPurchaseState();
}

class _EditPurchaseState extends State<EditPurchase> {
  PusrhcaseController pusrhcaseController =
  Get.put(PusrhcaseController(), tag: PusrhcaseController().toString());
  ProductController productController =
  Get.put(ProductController(), tag: ProductController().toString());

  @override
  void initState() {
    productController.getAllProduceFromAPI();
    super.initState();
  }

  showSalesDetailsDialog(
      BuildContext context,
      ) {
    setState(() {
      pusrhcaseController.purchaseDateDialogController.text =
          showInvoiceDate.toString();
      pusrhcaseController.purchaseDateDialogController.text =
          "widget.customerPurchaseNo";
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
              controller: pusrhcaseController.purchaseDateDialogController,
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
              controller: pusrhcaseController.purchaseNoDialogController,
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

  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  String dropdownvalue1 = "One";

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
        pusrhcaseController.purchaseDateDialogController.text =
            showInvoiceDate.toString();
      });
    }
  }

  DateTime selectedDueDate = DateTime.now();
  String showDueDate =
  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  selectSalesDuDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        showDueDate = DateFormat('yyyy-MM-dd').format(selected).toString();
      });
    }
  }

  final TextEditingController searchController = TextEditingController();

  void displayBottomSheet(BuildContext context,
      {required int selectedProductIndex}) {
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
            return Container(
              padding:
              const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          Texts.SelectProduct,
                          style: dialogTitleStyle(),
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            Texts.AddProduct,
                            style: linkTextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldSearch(
                    controller: searchController,
                    validator: (value) {},
                    icon: CommonImage.search_icon,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    hintText: Texts.search_hint,
                  ),
                  const SizedBox(
                    height: 21.0,
                  ),
                  Obx(
                        () => (productController.isProductLoading.value == false &&
                        productController.getAllProductModel
                            .toString()
                            .isNotEmpty &&
                        productController.getAllProductModel.toString() !=
                            'null' &&
                        int.parse(productController
                            .getAllProductModel!.data!.length
                            .toString()) !=
                            0 &&
                        int.parse(productController
                            .getAllProductModel!.data!.length
                            .toString()) >=
                            0)
                        ? Flexible(
                      child:
                      CommonWidget().ListviewListingBuilderWithScroll(
                        context: context,
                        getItemCount: productController
                            .getAllProductModel!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            highlightColor:
                            HexColor(CommonColor.appBackColor),
                            splashColor:
                            HexColor(CommonColor.appBackColor),
                            focusColor:
                            HexColor(CommonColor.appBackColor),
                            hoverColor:
                            HexColor(CommonColor.appBackColor),
                            onTap: () {
                              debugPrint('0000000000----- Inside the index ${index.toString()}');
                              pusrhcaseController
                                  .selectProductNameId[selectedProductIndex] =
                                  productController
                                      .getAllProductModel!.data![index].id
                                      .toString();
                              pusrhcaseController
                                  .selectPurchaseProductNameController[
                              selectedProductIndex]
                                  .text =
                                  productController.getAllProductModel!
                                      .data![index].name
                                      .toString();
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 15.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: HexColor(
                                      CommonColor.dialogBorderColor,
                                    ),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              width: screenWidth,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0,
                                          top: 18.0,
                                          bottom: 18.0),
                                      child: Text(
                                        productController
                                            .getAllProductModel!
                                            .data![index]
                                            .name
                                            .toString(),
                                        maxLines: 2,
                                        style: cartNameStyle(),
                                      ),
                                    ),
                                  ),
                                  // Flexible(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 18.0,
                                  //         bottom: 18.0,
                                  //         right: 18.0),
                                  //     child: Text(
                                  //       productController
                                  //           .getAllProductModel!
                                  //           .data![index]
                                  //           .mobileNo
                                  //           .toString(),
                                  //       style: cartMobileNumberStyle(),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        : CommonWidget().ListviewListing(
                      context: context,
                      getItemCount: 16,
                      getWidets: CommonWidget().showShimmer(
                        shimmerHeight: 50,
                        leftM: 0.0,
                        rightM: 0.0,
                        bottomM: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
              height: screenHeight * 0.6,
              width: screenWidth,
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
      labelText: Texts.addNewPurchase,
      bodyWidget: Scaffold(
        backgroundColor: HexColor(CommonColor.appBackColor),
        key: _globalKey,
        drawer: DrawerScreen(),
        bottomNavigationBar: Container(
            height: 170,
            width: screenWidth,
            margin:
            const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                CommonWidget().listingCardDesign(
                  context: context,
                  getWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'Total Taxable Value :- ${pusrhcaseController.totalTaxableValue.value.toString()}'),
                      Text(
                          'Total Tax :- ${pusrhcaseController.totalTax.value.toString()}'),
                      Text(
                          'Total Amount  :- ${pusrhcaseController.totalAmount.value.toString()}'),
                    ],
                  ),
                ),
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
                      '₹ ${pusrhcaseController.totalAmount.value.toString()}',
                      style: cartNameStyle(),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Texts.TotalPurchase,
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
                          pusrhcaseController
                              .storePurchase(
                              contactId: "widget.customerId",
                              invoiceDates: showInvoiceDate.toString(),
                              dueDates: showDueDate.toString())
                              .then(
                                (value) {
                              hideLoader(context);
                              if (value != null) {
                                if (value != 'fail') {
                                  Navigator.pop(context);
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
                              "widget.customerName",
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
                                'Purchase No. widget.customerPurchaseNo',
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
                            padding:
                            const EdgeInsets.only(left: 15.0, bottom: 13.0),
                            child: Text(
                              "widget.customerMobileNo",
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
                                  right: 15.0, bottom: 0.0),
                              child: Text(
                                'Invoice Date. ${showInvoiceDate.toString()}',
                                textAlign: TextAlign.right,
                                style: estimateStyle(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => selectSalesDuDate(context),
                        child: Padding(
                          padding:
                          const EdgeInsets.only(right: 15.0, bottom: 0.0),
                          child: Text(
                            'Dur Date. ${showDueDate.toString()}',
                            textAlign: TextAlign.right,
                            style: estimateStyle(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonTextFieldLabel(
                        validator: (String? value) {},
                        textInputType: TextInputType.number,
                        controller:
                        pusrhcaseController.purchaseBillNoController,
                        hintText: Texts.productBillNo,
                        textInputAction: TextInputAction.next,
                        labelText: Texts.productBillNo,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonTextFieldTextArea(
                        validator: (String? value) {},
                        textInputType: TextInputType.text,
                        controller:
                        pusrhcaseController.purchaseDescriptionController,
                        hintText: Texts.productDescription,
                        textInputAction: TextInputAction.done,
                        maxLines: 3,
                        labelText: Texts.productDescription,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                    () => CommonWidget().ListviewListingBuilder(
                  context: context,
                  bottomSpace: 10,
                  getItemCount: pusrhcaseController.lengthOfEstimate.value,
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
                                  'Product - ${index + 1}',
                                  textAlign: TextAlign.left,
                                  style: estimateLabelStyle(),
                                ),
                                (pusrhcaseController.lengthOfEstimate.value !=
                                    1)
                                    ? Container(
                                  height: 25,
                                  width: 25,
                                  child: InkWell(
                                    onTap: () {
                                      pusrhcaseController
                                          .removeEstimateForm(
                                          removeFromIndex: index);
                                    },
                                    child: SizedBox(
                                      height: 18.0,
                                      width: 18.0,
                                      child: Image.asset(
                                          CommonImage.close_icon),
                                    ),
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
                                    labelText: Texts.productName,
                                    textInputType: TextInputType.text,
                                    controller: pusrhcaseController
                                        .selectPurchaseProductNameController[
                                    index],
                                    hintText: Texts.productName,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {
                                      displayBottomSheet(
                                        context,
                                        selectedProductIndex: index,
                                      );
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
                                    labelText: Texts.HSN,
                                    textInputType: TextInputType.text,
                                    controller: pusrhcaseController
                                        .purchasesHsnControllers[index],
                                    hintText: Texts.HSN,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      pusrhcaseController.calculatePurchase(
                                          selectedIndex: index);
                                      // if (value.toString().isNotEmpty &&
                                      //     int.parse(value.length.toString()) !=
                                      //         0) {
                                      //
                                      // }
                                    },
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
                                    labelText: Texts.QTY,
                                    textInputType: TextInputType.number,
                                    controller: pusrhcaseController
                                        .purchasesQtyControllers[index],
                                    hintText: Texts.QTY,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      pusrhcaseController.calculatePurchase(
                                          selectedIndex: index);
                                      // if (value.toString().isNotEmpty &&
                                      //     int.parse(value.length.toString()) !=
                                      //         0) {
                                      //
                                      // }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.Unit,
                                    textInputType: TextInputType.number,
                                    controller: pusrhcaseController
                                        .purchasesUnitControllers[index],
                                    hintText: Texts.Unit,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      pusrhcaseController.calculatePurchase(
                                          selectedIndex: index);
                                      // if (value.toString().isNotEmpty &&
                                      //     int.parse(value.length.toString()) !=
                                      //         0) {
                                      //
                                      // }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Flexible(
                            //       child: Obx(
                            //         () => (pusrhcaseController
                            //                     .isSalesCheckFormValidation
                            //                     .value ==
                            //                 true)
                            //             ? (pusrhcaseController
                            //                     .sqftController.text
                            //                     .trim()
                            //                     .toString()
                            //                     .isEmpty)
                            //                 ? CommonWidget()
                            //                     .showSalesErrorOneSideMessage(
                            //                         errorMessage:
                            //                             pusrhcaseController
                            //                                 .sqftErroMessage)
                            //                 : Container()
                            //             : Container(),
                            //       ),
                            //     ),
                            //     Flexible(
                            //       child: Obx(
                            //         () => (pusrhcaseController
                            //                     .isSalesCheckFormValidation
                            //                     .value ==
                            //                 true)
                            //             ? (pusrhcaseController
                            //                     .priceperSqftController.text
                            //                     .trim()
                            //                     .toString()
                            //                     .isEmpty)
                            //                 ? CommonWidget()
                            //                     .showSalesErrorOneSideMessage(
                            //                         errorMessage:
                            //                             pusrhcaseController
                            //                                 .pricePerSqErrorMessage)
                            //                 : Container()
                            //             : Container(),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.Rate,
                                    textInputType: TextInputType.number,
                                    controller: pusrhcaseController
                                        .purchasesRateControllers[index],
                                    hintText: Texts.Rate,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      pusrhcaseController.calculatePurchase(
                                          selectedIndex: index);
                                      // if (value.toString().isNotEmpty &&
                                      //     int.parse(value.length.toString()) !=
                                      //         0) {
                                      //
                                      // }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.Discount,
                                    textInputType: TextInputType.number,
                                    controller: pusrhcaseController
                                        .purchasesDiscountControllers[index],
                                    hintText: Texts.Discount,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    onChanged: (value) {
                                      pusrhcaseController.calculatePurchase(
                                          selectedIndex: index);
                                      // if (value.toString().isNotEmpty &&
                                      //     int.parse(value.length.toString()) !=
                                      //         0) {
                                      //
                                      // }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: <Widget>[
                            //     Obx(
                            //       () => (pusrhcaseController
                            //                   .isSalesCheckFormValidation
                            //                   .value ==
                            //               true)
                            //           ? (pusrhcaseController
                            //                   .priceperSqftController.text
                            //                   .trim()
                            //                   .toString()
                            //                   .isEmpty)
                            //               ? CommonWidget()
                            //                   .showSalesErrorOneSideMessage(
                            //                       errorMessage:
                            //                           pusrhcaseController
                            //                               .pricePerSqErrorMessage)
                            //               : Container()
                            //           : Container(),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.taxableValue,
                                    textInputType: TextInputType.number,
                                    controller: pusrhcaseController
                                        .purchasesTaxableValueControllers[
                                    index],
                                    hintText: Texts.taxableValue,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {},
                                    readOnly: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: CommonTextFieldLabel(
                                    validator: (String? value) {},
                                    labelText: Texts.tax,
                                    textInputType: TextInputType.number,
                                    controller: pusrhcaseController
                                        .purchasesTaxControllers[index],
                                    hintText: Texts.tax,
                                    textInputAction: TextInputAction.done,
                                    onTap: () {},
                                    onChanged: (value) {
                                      pusrhcaseController.calculatePurchase(
                                          selectedIndex: index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Flexible(
                            //       child: Obx(
                            //         () => (pusrhcaseController
                            //                     .isSalesCheckFormValidation
                            //                     .value ==
                            //                 true)
                            //             ? (pusrhcaseController
                            //                     .otherChargesController.text
                            //                     .trim()
                            //                     .toString()
                            //                     .isEmpty)
                            //                 ? CommonWidget()
                            //                     .showSalesErrorOneSideMessage(
                            //                         errorMessage:
                            //                             pusrhcaseController
                            //                                 .otherChargesErrorMessage)
                            //                 : Container()
                            //             : Container(),
                            //       ),
                            //     ),
                            //     Flexible(
                            //       child: Obx(
                            //         () => (pusrhcaseController
                            //                     .isSalesCheckFormValidation
                            //                     .value ==
                            //                 true)
                            //             ? (pusrhcaseController
                            //                     .homeLoanChargeController.text
                            //                     .trim()
                            //                     .toString()
                            //                     .isEmpty)
                            //                 ? CommonWidget()
                            //                     .showSalesErrorOneSideMessage(
                            //                         errorMessage:
                            //                             pusrhcaseController
                            //                                 .homeLoanErrorMessage)
                            //                 : Container()
                            //             : Container(),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                onTap: () => pusrhcaseController.addEstimateForm(),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 30,
                    width: screenWidth * 0.31,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                          Texts.addPurchase,
                          style: linkTextStyle(fontSizes: 12.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
