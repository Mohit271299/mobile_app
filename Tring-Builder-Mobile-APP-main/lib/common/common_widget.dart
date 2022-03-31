import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/header_model.dart';

import 'common_image.dart';
import 'common_style.dart';

class CommonWidget {
  hideFocusKeyBoard(c) {
    FocusScope.of(c).requestFocus(FocusNode());
  }

  iconButton({
    required BuildContext context,
    required String buttonLabel,
    required String buttonIcon,
    String activeColor = CommonColor.appActiveColor,
    required void Function()? onPress,
    String buttonLabelColor = "#FFFFFF",
  }) =>
      ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        height: 50.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: HexColor(activeColor.toString()),
          onPressed: onPress,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                buttonIcon.toString(),
                height: 19,
                width: 17.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                buttonLabel.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: AppDetails.fontSemiBold,
                  color: HexColor(buttonLabelColor),
                ),
              )
            ],
          ),
        ),
      );

  appBarAction() => InkWell(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 15.0, bottom: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Image.network(
              "https://www.tompetty.com/sites/g/files/g2000007521/f/sample_01.jpg",
              height: 37.0,
              width: 37.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  appBarLeading({
    required String appTitle,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 18.0, bottom: 18.0, right: 10.0),
        child: InkWell(
          child: Image.asset(
            CommonImage.drawer_icon,
            height: 17,
            width: 20.0,
            fit: BoxFit.fill,
          ),
        ),
      );

  filterAndSortCard(
          {required String itemIcon,
          required Function? onTap,
          required BuildContext context}) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 2),
            ]),
        height: 30.0,
        width: 30.0,
        child: InkWell(
          onTap: () => onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              itemIcon,
              height: 12,
              width: 14.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  listingCardDesign(
          {required BuildContext context, required Widget getWidget}) =>
      Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        // height: 82.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 1),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: getWidget,
      );

  ListviewListing(
          {required BuildContext context,
          required int getItemCount,
          required Widget getWidets}) =>
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 80.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return getWidets;
        },
        itemCount: getItemCount,
      );

  ListviewListingBuilder({
    required BuildContext context,
    required int getItemCount,
  ScrollPhysics? physics = const NeverScrollableScrollPhysics(),
    required Widget Function(BuildContext, int) itemBuilder,
    double bottomSpace = 80.0,
  }) =>
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: bottomSpace),
        physics: physics,
        itemBuilder: itemBuilder,
        itemCount: getItemCount,
      );


  ListviewListingBuilderWithScroll({
    required BuildContext context,
    required int getItemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    double bottomSpace = 80.0,
  }) =>
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: bottomSpace),
        itemBuilder: itemBuilder,
        itemCount: getItemCount,
      );

  GridViewBlockListing({
    required BuildContext context,
    required int getItemCount,
    required Widget getWidets,
    required int getCrossCount,
    required double mainAxisExtentSize,
    required double crossAxisSpacingSize,
    required double mainAxisSpacingSize,
  }) =>
      GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 15.0, right: 15.0),
        itemCount: getItemCount,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossCount,
          mainAxisExtent: mainAxisExtentSize,
          crossAxisSpacing: crossAxisSpacingSize,
          mainAxisSpacing: mainAxisSpacingSize,
        ),
        itemBuilder: (context, index) {
          return getWidets;
        },
      );

  GridViewBlockListingBuilder({
    required BuildContext context,
    required int getItemCount,
    required int getCrossCount,
    required double mainAxisExtentSize,
    required double crossAxisSpacingSize,
    required double mainAxisSpacingSize,
    required Widget Function(BuildContext, int) itemBuilder,
  }) =>
      GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 15.0, right: 15.0),
        itemCount: getItemCount,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossCount,
          mainAxisExtent: mainAxisExtentSize,
          crossAxisSpacing: crossAxisSpacingSize,
          mainAxisSpacing: mainAxisSpacingSize,
        ),
        itemBuilder: itemBuilder,
      );

  CommonButton(
          {required String buttonText,
          required void Function()? onPressed,
          required BuildContext context}) =>
      ButtonTheme(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText.toString(),
            style: buttonTextStyle(),
          ),
        ),
      );

  CommonNoButton(
          {required String buttonText,
          required void Function()? onPressed,
          required BuildContext context}) =>
      ButtonTheme(
        child: RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: HexColor(CommonColor.appActiveColor),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText.toString(),
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 15.0,
              fontFamily: AppDetails.fontSemiBold,
              color: Colors.black,
            ),
          ),
        ),
      );

  showalertDialog(
          {required BuildContext context, required Widget getMyWidget}) =>
      showDialog(
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: getMyWidget,
              ),
            ],
          ),
        ),
        context: context,
      );

  showToaster({required String msg}) => Fluttertoast.showToast(
        msg: msg.toString(),
        textColor: Colors.white,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

  showErrorMessage({required String errorMessage}) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
            top: 0.0, left: 38.0, right: 38.0, bottom: 10.0),
        child: Text(
          errorMessage.toString(),
          style: errorTextStyle(),
        ),
      );

  addContactshowErrorMessage({required String errorMessage}) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
            top: 0.0, left: 25, right: 38.0, bottom: 10.0),
        child: Text(
          errorMessage.toString(),
          style: errorTextStyle(),
        ),
      );

  showEstimateErrorMessage({required String errorMessage}) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
            top: 5.0, left: 5.0, right: 38.0, bottom: 10.0),
        child: Text(
          errorMessage.toString(),
          style: errorTextStyle(),
        ),
      );

  showSalesErrorMessage({required String errorMessage}) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
            top: 0.0, left: 5.0, right: 38.0, bottom: 0.0),
        child: Text(
          errorMessage.toString(),
          style: errorTextStyle(),
        ),
      );

  showSalesErrorOneSideMessage({required String errorMessage}) => Container(
        alignment: Alignment.centerLeft,
        margin:
            const EdgeInsets.only(top: 5.0, left: 5.0, right: 0.0, bottom: 0.0),
        child: Text(
          errorMessage.toString(),
          style: errorTextStyle(),
        ),
      );

  appBarShapeBox({
    required BuildContext context,
  }) =>
      InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(
              left: 18.0, top: 15.0, bottom: 5.0, right: 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: [
              BoxShadow(
                color: HexColor(CommonColor.appActiveColor),
              ),
              const BoxShadow(
                color: Colors.white,
                spreadRadius: 0.0,
                blurRadius: 2,
              )
            ],
          ),
          height: 40.0,
          alignment: Alignment.center,
          width: 40.0,
          padding: EdgeInsets.only(left: 5.0),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 14.0,
            color: Colors.black,
          ),
        ),
      );

  showShimmer({
    double shimmerHeight = 115,
    double shimmerWidth = double.infinity,
    double leftM = 20,
    double rightM = 20,
    double bottomM = 10,
  }) =>
      Container(
        height: shimmerHeight,
        width: shimmerWidth,
        margin: EdgeInsets.only(left: leftM, right: rightM, bottom: bottomM),
        child: Shimmer.fromColors(
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          period: const Duration(seconds: 2),
          baseColor: Colors.black.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.1),
        ),
      );

  CommonCustomerAppBar({required String labelText,required Widget bodyWidget}) => NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: appBarShapeBox(context: context),
              actions: [
                CommonWidget().appBarAction(),
              ],
              backgroundColor: HexColor(CommonColor.appBackColor),
              primary: true,
              pinned: true,
              expandedHeight: 70,
              centerTitle: true,
              elevation: 0.0,
              title: header_model(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    labelText.toString(),
                    style: screenHeader(),
                  ),
                ),
              ),
            )
          ];
        },
        body: bodyWidget,
      );
}
