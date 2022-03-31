import 'package:flutter/cupertino.dart'; // ignore:file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/estimate/ui/estimate_show_customer_details.dart';
import 'package:tring/screens/estimate/ui/selectTown.dart';
import 'package:tring/screens/sales/controller/salescontroller.dart';
import 'package:tring/screens/sales/ui/sales_show_customer_details.dart';

import '../leads_add_screen.dart';

class LeadsSelectNumber extends StatefulWidget {
  String getSelectTownValue;
  String getSelectFloorValue;
  int getSelectedFloorIndexId;

  LeadsSelectNumber(
      {required this.getSelectTownValue,
      required this.getSelectFloorValue,
      required this.getSelectedFloorIndexId});

  @override
  _LeadsSelectNumberState createState() => _LeadsSelectNumberState();
}

// ignore: file_names
class _LeadsSelectNumberState extends State<LeadsSelectNumber> {
  SalesController salesController =
      Get.put(SalesController(), tag: SalesController().toString());

  @override
  void initState() {
    salesController.getSelectFlatFromApi(
      getSelectedFlatIndex: int.parse(
        widget.getSelectedFloorIndexId.toString(),
      ),
    );
    super.initState();
  }

  late double screenHeight, screenWidth;
  int selectFloorIndex = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.445,
      width: screenWidth,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text((screenHeight * 0.445).ceilToDouble().toString()),
            Container(
              padding: const EdgeInsets.only(left: 29.0, top: 24.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(vertical: -4.0, horizontal: -4.0),
                leading: InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          CommonImage.back_arrow_icon,
                          width: 5.0,
                          height: 12.0,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: screenWidth / 5),
                  child: Text(
                    Texts.SelectFloor,
                    style: cartNameStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              '${widget.getSelectTownValue.toUpperCase().toString()}-${widget.getSelectFloorValue.toString()}',
              style: linkTextStyle(
                fontSizes: 17.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 54.0, right: 54.0, top: 15.0),
              child: Obx(
                () => (salesController.isFlatLoading.value == false &&
                        int.parse(salesController.getSelectFlat!.data!.length
                                .toString()) !=
                            0)
                    ? CommonWidget().GridViewBlockListingBuilder(
                        context: context,
                        getItemCount:
                            salesController.getSelectFlat!.data!.length,
                        getCrossCount: 4,
                        mainAxisExtentSize: 34,
                        crossAxisSpacingSize: 9,
                        mainAxisSpacingSize: 10,
                        itemBuilder: (BuildContext, index) {
                          return InkWell(
                            onTap: () => setState(
                              () {
                                selectFloorIndex = index;

                                LeadsAddScreenState().setFlatNumber(
                                  selectFlat: salesController
                                      .getSelectFlat!.data![index].blockNumber
                                      .toString(), selectFlatId: salesController
                                    .getSelectFlat!.data![index].id!,
                                );
                                salesController.selectFlatId.value =
                                    salesController
                                        .getSelectFlat!.data![index].id!;
                                salesController.flatNoController.text =
                                    salesController
                                        .getSelectFlat!.data![index].blockNumber
                                        .toString();

                                Navigator.pop(context);
                              },
                            ),
                            child: Container(
                              height: 34,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (selectFloorIndex == index)
                                    ? HexColor(CommonColor.appActiveColor)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: ContainerInnerShadow,
                              ),
                              child: Text(
                                salesController
                                    .getSelectFlat!.data![index].blockNumber
                                    .toString(),
                                style: cartNameStyle(
                                  textColor: (selectFloorIndex == index)
                                      ? CommonColor.textfieldBorder
                                      : CommonColor.textDarkColor,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : CommonWidget().GridViewBlockListingBuilder(
                        context: context,
                        getItemCount: 50,
                        getCrossCount: 3,
                        mainAxisExtentSize: 40,
                        crossAxisSpacingSize: 0,
                        mainAxisSpacingSize: 0,
                        itemBuilder: (BuildContext, index) {
                          return CommonWidget().showShimmer(
                              shimmerHeight: 60, shimmerWidth: 200);
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
