import 'package:flutter/cupertino.dart'; // ignore:file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/estimate/controller/estimateshowcustomercontroller.dart';
import 'package:tring/screens/estimate/ui/estimate_show_customer_details.dart';

class SelectTown extends StatefulWidget {
  @override
  SelectTownState createState() => SelectTownState();
}

// ignore: file_names
class SelectTownState extends State<SelectTown> {
  EstimateShowCustomeController estimateCustomerDetails = Get.put(
    EstimateShowCustomeController(),
    tag: EstimateShowCustomeController().toString(),
  );

  @override
  void initState() {
    estimateCustomerDetails.getAllTownFromApi();
    super.initState();
  }

  late double screenHeight, screenWidth;

  int selectSalesIndex = 0;
  String selectSalesTowerName = '';
  List<String> alphabet = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];

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
                    Texts.SelectTower,
                    style: cartNameStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 54.0, right: 54.0),
              child: Obx(
                () => (estimateCustomerDetails.isTowerLoading.value == false &&
                        int.parse(estimateCustomerDetails
                                .getSelectTown!.data!.length
                                .toString()) !=
                            0)
                    ? CommonWidget().GridViewBlockListingBuilder(
                        context: context,
                        getItemCount:
                            estimateCustomerDetails.getSelectTown!.data!.length,
                        getCrossCount: 4,
                        mainAxisExtentSize: 34,
                        crossAxisSpacingSize: 9,
                        mainAxisSpacingSize: 10,
                        itemBuilder: (BuildContext, index) {
                          return InkWell(
                            onTap: () => setState(
                              () {
                                selectSalesTowerName = estimateCustomerDetails
                                    .getSelectTown!.data![index].tower
                                    .toString();
                                selectSalesIndex = index;
                                Navigator.pop(context);
                                EstimateSelectCustomerDetailsState()
                                    .selectFloorBottomSheet(
                                  context,
                                  selectFloorName: selectSalesTowerName,
                                  selectedTowerIndex: int.parse(
                                    estimateCustomerDetails
                                        .getSelectTown!.data![index].id
                                        .toString(),
                                  ),
                                );
                              },
                            ),
                            child: Container(
                              height: 34,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (selectSalesIndex == index)
                                    ? HexColor(CommonColor.appActiveColor)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: ContainerInnerShadow,
                              ),
                              child: Text(
                                alphabet[index].toUpperCase(),
                                style: cartNameStyle(
                                  textColor: (selectSalesIndex == index)
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
            ),
          ],
        ),
      ),
    );
  }
}
