import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; //ignore: file_names
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/product/ui/products_edit.dart';
import 'package:tring/screens/purchase/controller/purchasecontroller.dart';
import 'package:tring/screens/sales/controller/salescontroller.dart';
import 'package:tring/screens/sales/ui/sales_select_customer.dart';

import '../controller/Productcontroller.dart';
import 'Product_select_customer.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  ProductsListState createState() => ProductsListState();
}

//ignore: file_names
class ProductsListState extends State<ProductsList> {
  void displayBottomSheet(BuildContext context) {
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
            return const ProductSelectCustomer();
          },
        );
      },
    );
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
          builder: (context,StateSetter state) {
            return Container(
              height: screenHeight * 0.24,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Get.to(EditProducts(product_id: id,));
                    },
                    child: Container(
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
  final GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  void initState(){
    productController.getAllProduceFromAPI();
    super.initState();
  }

  final productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.product,
      bodyWidget: Scaffold(
        drawerScrimColor: HexColor(CommonColor.appBackColor),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor(CommonColor.appActiveColor),
          onPressed: () => gotoAddProductScreen(context),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => CommonWidget().hideFocusKeyBoard(context),
                child: Container(
                  width: screenWidth,
                  child: Text(Texts.product, style: screenHeader()),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Obx(
                () => (productController.isProductLoading.value != true)
                    ? CommonWidget().ListviewListingBuilder(
                        context: context,
                        getItemCount: (productController.getAllProductModel
                                    .toString()
                                    .isNotEmpty &&
                                productController.getAllProductModel
                                        .toString() !=
                                    'null' &&
                                int.parse(productController
                                        .getAllProductModel!.data!.length
                                        .toString()) !=
                                    0 &&
                                int.parse(productController
                                        .getAllProductModel!.data!.length
                                        .toString()) >=
                                    0)
                            ? productController.getAllProductModel!.data!.length
                            : 10,
                        itemBuilder: (BuildContext context, int index) {
                          return (productController.getAllProductModel
                                      .toString()
                                      .isNotEmpty &&
                                  productController.getAllProductModel
                                          .toString() !=
                                      'null' &&
                                  int.parse(productController
                                          .getAllProductModel!.data!.length
                                          .toString()) !=
                                      0)
                              ? CommonWidget().listingCardDesign(
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
                                                  '#${productController.getAllProductModel!.data![index].name.toString()}',
                                                  style: cartIdDateStyle(),
                                                ),
                                                const SizedBox(
                                                  width: 11.0,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: Text(
                                                productController
                                                    .getAllProductModel!
                                                    .data![index]
                                                    .id!
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
                                                productController
                                                    .getAllProductModel!
                                                    .data![index]
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
                                                        displaySalesActionButton(
                                                            context,
                                                            id: int.parse(
                                                              productController
                                                                  .getAllProductModel!
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
                                                        CommonColor
                                                            .appBackColor),
                                                    highlightColor: HexColor(
                                                        CommonColor
                                                            .appBackColor),
                                                    hoverColor: HexColor(
                                                        CommonColor
                                                            .appBackColor),
                                                    focusColor: HexColor(
                                                        CommonColor
                                                            .appBackColor),
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
                                            Flexible(
                                              child: Text(
                                                productController
                                                    .getAllProductModel!
                                                    .data![index]
                                                    .hsnCode
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: cartMobileNumberStyle(),
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
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
