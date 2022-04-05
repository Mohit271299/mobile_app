import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/product/controller/Productcontroller.dart';
import 'package:tring/screens/product/ui/Product_list.dart';

import '../../drawer/ui/drawerscreen.dart';
import '../controller/Productcontroller.dart';

class EditProducts extends StatefulWidget {
  final int product_id;
  const EditProducts({Key? key, required this.product_id}) : super(key: key);
  @override
  State<EditProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  late double screenHeight, screenWidth;
  ProductController productControllers =
      Get.put(ProductController(), tag: ProductController().toString());

  @override
  void initState() {
    super.initState();
    productControllers.GetproductById(
        context: context, productId: widget.product_id);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return CommonWidget().CommonCustomerAppBar(
      labelText: Texts.addProduct,
      bodyWidget: Scaffold(
        drawerScrimColor: HexColor(CommonColor.appBackColor),
        drawer: DrawerScreen(),
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
                  child: Text(Texts.addProduct, style: screenHeader()),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              CommonWidget().listingCardDesign(
                getWidget: Container(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Product Details',
                            textAlign: TextAlign.left,
                            style: estimateLabelStyle(),
                          ),
                        ],
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Product Name",
                        textInputType: TextInputType.text,
                        controller: productControllers.productNameController,
                        hintText: "Product Name",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "HSN Code",
                        textInputType: TextInputType.text,
                        controller: productControllers.productHSNCodeController,
                        hintText: "HSN Code",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Product Qty",
                        textInputType: TextInputType.number,
                        controller:
                            productControllers.productProductQtyController,
                        hintText: "Product Qty",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      // Product Description
                      CommonTextFieldTextArea(
                        maxLines: 3,
                        validator: (String? value) {},
                        labelText: "Product Description",
                        textInputType: TextInputType.text,
                        controller:
                            productControllers.productDescriptionController,
                        hintText: "Product description",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Product Unit",
                        textInputType: TextInputType.number,
                        controller: productControllers.productUnitController,
                        hintText: "Product Unit",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Purchase Price",
                        textInputType: TextInputType.number,
                        controller:
                            productControllers.productPurchasePriceController,
                        hintText: "Purchase Price",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "GST Purchase(%)",
                        textInputType: TextInputType.number,
                        controller:
                            productControllers.productGSTPurchaseController,
                        hintText: "GST Purchase(%)",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "Sales Price",
                        textInputType: TextInputType.number,
                        controller:
                            productControllers.productSalesPriceController,
                        hintText: "Sales Price",
                        textInputAction: TextInputAction.next,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      CommonTextFieldLabel(
                        validator: (String? value) {},
                        labelText: "GST Sales(%)",
                        textInputType: TextInputType.number,
                        controller:
                            productControllers.productGSTSalesController,
                        hintText: "GST Sales(%)",
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      CommonWidget().CommonButton(
                        context: context,
                        buttonText: Texts.Save,
                        onPressed: () {
                          showLoader(context);
                          productControllers
                              .addProductById(
                                  productId: widget.product_id,
                                  context: context)
                              .then((value) {
                            hideLoader(context);
                            if (value != 'null') {
                              if (value != 'fail') {
                                ProductsListState().initState();
                                Navigator.pop(context);
                              }
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
