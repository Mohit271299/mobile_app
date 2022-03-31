import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/custom_widgets/drawer_feild_custom_wid.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'dashboard_class_widget.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Color _textColor = ColorUtils.black_light_Color;
  Color _textColor2 = ColorUtils.black_light_Color;
  Color _textColor3 = ColorUtils.black_light_Color;
  String selectDrawerItem = 'Dashboard';
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 1.9,
      margin: EdgeInsets.only(top: 90, left: 15, bottom: 90),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
          bottom: Radius.circular(20),
        ),
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 40),
                    child: Text(
                      'Magnet App',
                      style: TextStyle(
                        fontFamily: "GR",
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: HexColor("#485056"),
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Get.offAll(DashboardPage(0));
                //     setState(() {
                //       selectDrawerItem = "Dashboard";
                //     });
                //   },
                //   child: DrawerFieldCustomWidget(
                //     imageUrl: (selectDrawerItem == "Dashboard")
                //         ? AssetUtils.select_dashboard
                //         : AssetUtils.unselect_dashboard,
                //     lablename: 'Dashboard',
                //   ),
                // ),
                // SizedBox(
                //   height: 5.0,
                // ),
                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                      dense: true ,
                      child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      tilePadding: EdgeInsets.zero,
                      title: GestureDetector(
                        onTap: () {
                          Get.offAll(DashboardPage(0));
                          setState(() {
                            selectDrawerItem = "Dashboard";
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Image.asset(
                                  (selectDrawerItem == "Dashboard")
                                      ? AssetUtils.select_dashboard
                                      : AssetUtils.unselect_dashboard,
                                  color: ColorUtils.black_light_Color,
                                  height: 24.0,
                                  width: 24.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: Text(
                                  "Dashboard",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#485056"),
                                      fontFamily: "GR"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const SizedBox(),
                    ),
                  ),
                ),

                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48,top: 0.0,bottom: 0.0),
                      // tilePadding: EdgeInsets.only(left: 10),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          if (expanded) {
                            _textColor = Colors.blue;
                          } else {
                            _textColor = ColorUtils.black_light_Color;
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child:Container(
                              child: Image.asset(
                                AssetUtils.select_master,
                                color: _textColor,
                                height: 24.0,
                                width: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(
                                " Masters",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor("#485056"),
                                    fontFamily: "GR"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Company',
                            style: FontStyleUtility.h12(
                              fontColor: ColorUtils.black_light_Color_2,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {

                            Get.toNamed(BindingUtils.ledgerScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ledger',
                              style: FontStyleUtility.h12(
                                fontColor: ColorUtils.black_light_Color_2,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                BindingUtils.product_service_ScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Product/Service',
                              style: FontStyleUtility.h12(
                                fontColor: ColorUtils.black_light_Color_2,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(BindingUtils.inquiry_Screen_Route);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'inquiry',
                              style: FontStyleUtility.h12(
                                fontColor: ColorUtils.black_light_Color_2,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Employee',
                            style: FontStyleUtility.h12(
                              fontColor: ColorUtils.black_light_Color_2,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 5.0,
                // ),
                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      // tilePadding: EdgeInsets.only(left: 10),
                      title: GestureDetector(
                        onTap: () {
                          Get.toNamed(BindingUtils.sales_ScreenRoute);
                          setState(() {
                            selectDrawerItem = "sales";
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                (selectDrawerItem == "sales")
                                    ? AssetUtils.selectSales
                                    : AssetUtils.unselectSales,
                                color: ColorUtils.black_light_Color,
                                height: 24.0,
                                width: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Sales",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#485056"),
                                      fontFamily: "GR"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const SizedBox(),
                    ),
                  ),
                ),

                // InkWell(
                //   onTap: () {
                //     Get.toNamed(BindingUtils.sales_ScreenRoute);
                //     setState(() {
                //       selectDrawerItem = "sales";
                //     });
                //   },
                //   child: DrawerFieldCustomWidget(
                //     imageUrl: (selectDrawerItem == "sales")
                //         ? AssetUtils.selectSales
                //         : AssetUtils.unselectSales,
                //     lablename: 'Sales',
                //   ),
                // ),
                // setSpace(),

                // SizedBox(height: screenSize.height * 0.02),
                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      // tilePadding: EdgeInsets.only(left: 10),
                      title: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectDrawerItem = "purchase";
                          });
                          Get.toNamed(BindingUtils.purchaseRoute);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                (selectDrawerItem == "purchase")
                                    ? AssetUtils.selectPurchase
                                    : AssetUtils.unselectPurchase,
                                color: ColorUtils.black_light_Color,
                                height: 24.0,
                                width: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Purchase",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#485056"),
                                      fontFamily: "GR"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const SizedBox(),
                    ),
                  ),
                ),

                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       selectDrawerItem = "purchase";
                //     });
                //     Get.toNamed(BindingUtils.purchaseRoute);
                //   },
                //   child: DrawerFieldCustomWidget(
                //     imageUrl: (selectDrawerItem == "purchase")
                //         ? AssetUtils.selectPurchase
                //         : AssetUtils.unselectPurchase,
                //     lablename: 'Purchase',
                //   ),
                // ),
                // setSpace(),
                // SizedBox(
                //   height: 5.0,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.8),
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          if (expanded) {
                            _textColor2 = Colors.blue;
                          } else {
                            _textColor2 = ColorUtils.black_light_Color;
                          }
                        });
                      },
                      tilePadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              AssetUtils.select_dataentry,
                              color: _textColor2,
                              height: 24.0,
                              width: 24.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Data Entry",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#485056"),
                                  fontFamily: "GR"),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(BindingUtils.cash_bankScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Cash & Bank entry',
                                style: FontStyleUtility.h12(
                                  fontColor: ColorUtils.black_light_Color_2,
                                  fontWeight: FWT.semiBold,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(BindingUtils.expanses_ScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Epenses',
                                style: FontStyleUtility.h12(
                                  fontColor: ColorUtils.black_light_Color_2,
                                  fontWeight: FWT.semiBold,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(BindingUtils.journal_Screen_Route);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Journal',
                                style: FontStyleUtility.h12(
                                  fontColor: ColorUtils.black_light_Color_2,
                                  fontWeight: FWT.semiBold,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(BindingUtils.credit_debit_Screen_Route);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Credit/Debit card',
                                style: FontStyleUtility.h12(
                                  fontColor: ColorUtils.black_light_Color_2,
                                  fontWeight: FWT.semiBold,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                BindingUtils.sales_purchase_Screen_Route);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Sales/Purchase Order',
                                style: FontStyleUtility.h12(
                                  fontColor: ColorUtils.black_light_Color_2,
                                  fontWeight: FWT.semiBold,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // setSpace(),
                // SizedBox(
                //   height: 5.0,
                // ),
                //
                // InkWell(
                //   onTap: () => setState(() {
                //     selectDrawerItem = "report";
                //   }),
                //   child: DrawerFieldCustomWidget(
                //     imageUrl: (selectDrawerItem == 'report')
                //         ? AssetUtils.select_report
                //         : AssetUtils.unselect_report,
                //     lablename: 'Reports',
                //   ),
                // ),
                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      // tilePadding: EdgeInsets.only(left: 10),

                      title: GestureDetector(
                        onTap: () => setState(() {
                          selectDrawerItem = "report";
                        }),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                (selectDrawerItem == 'report')
                                    ? AssetUtils.select_report
                                    : AssetUtils.unselect_report,
                                color: ColorUtils.black_light_Color,
                                height: 24.0,
                                width: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Reports",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#485056"),
                                      fontFamily: "GR"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const SizedBox(),
                    ),
                  ),
                ),

                // setSpace()
                // SizedBox(
                //   height: 22.0,
                // ),
                // // SizedBox(height: screenSize.height * 0.02),
                // InkWell(
                //   onTap: () => setState(() {
                //     selectDrawerItem = "taxreport";
                //   }),
                //   child: DrawerFieldCustomWidget(
                //     imageUrl: (selectDrawerItem == "taxreport")
                //         ? AssetUtils.select_txtReport
                //         : AssetUtils.unselect_txtReport,
                //     lablename: 'Tax Reports',
                //   ),
                // ),
                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      // tilePadding: EdgeInsets.only(left: 10),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          if (expanded) {
                            _textColor = Colors.blue;
                          } else {
                            _textColor = ColorUtils.black_light_Color;
                          }
                        });
                      },
                      title: GestureDetector(
                        onTap: () => setState(() {
                          selectDrawerItem = "taxreport";
                        }),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                (selectDrawerItem == "taxreport")
                                    ? AssetUtils.select_txtReport
                                    : AssetUtils.unselect_txtReport,
                                color: _textColor,
                                height: 24.0,
                                width: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Tax Reports",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#485056"),
                                      fontFamily: "GR"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const SizedBox(),
                    ),
                  ),
                ),

                // SizedBox(
                //   height: 15.0,
                // ),
                // setSpace(),
                // SizedBox(height: screenSize.height * 0.02),
                // InkWell(
                //   onTap: () => setState(() {
                //     selectDrawerItem = "settings";
                //   }),
                //   child: DrawerFieldCustomWidget(
                //     imageUrl: (selectDrawerItem == "taxreport")
                //         ? AssetUtils.select_settings
                //         : AssetUtils.unselect_settings,
                //     lablename: 'Setting',
                //   ),
                // ),

                SizedBox(
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 48),
                      // tilePadding: EdgeInsets.only(left: 10),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          if (expanded) {
                            _textColor3 = Colors.blue;
                          } else {
                            _textColor3 = ColorUtils.black_light_Color;
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              AssetUtils.select_settings,
                              color: _textColor,
                              height: 24.0,
                              width: 24.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor("#485056"),
                                    fontFamily: "GR"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Company',
                            style: FontStyleUtility.h12(
                              fontColor: ColorUtils.black_light_Color_2,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed(BindingUtils.ledgerScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sales',
                              style: FontStyleUtility.h12(
                                fontColor: ColorUtils.black_light_Color_2,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed( BindingUtils.product_service_ScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Profile Settings',
                              style: FontStyleUtility.h12(
                                fontColor: ColorUtils.black_light_Color_2,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // Get.toNamed(BindingUtils.inquiry_Screen_Route);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Subscription',
                              style: FontStyleUtility.h12(
                                fontColor: ColorUtils.black_light_Color_2,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Employee',
                            style: FontStyleUtility.h12(
                              fontColor: ColorUtils.black_light_Color_2,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox setSpace() => SizedBox(
        height: screenHeight * 0.01,
      );
}
