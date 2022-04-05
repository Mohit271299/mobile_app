import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/authentication/login/controller/logincontroller.dart';

import '../../payment/ui/payment_listing.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String selectDrawerItem = 'Dashnoard';
  late double screenHeight;
  final loginControllers = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 1.9,
      margin: const EdgeInsets.only(top: 93, left: 15, bottom: 72),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
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
                    margin: const EdgeInsets.only(top: 30, bottom: 40),
                    child: Text(
                      'Tring App India',
                      style: TextStyle(
                          fontFamily: AppDetails.fontSemiBold,
                          fontSize: 20.0,
                          color: HexColor(CommonColor.appBarTitleColor)),
                    ),
                  ),
                ),
                drawerItem(
                  itemIcon: CommonImage.sales_icons,
                  itemName: Texts.sales,
                  onTap: () {
                    Navigator.pop(context);
                    gotoSalesListScreen(context);
                  },
                ),
                drawerItem(
                  itemIcon: CommonImage.sales_icons,
                  itemName: Texts.purchases,
                  onTap: () {
                    Navigator.pop(context);
                    gotoPurcahsesListScreen(context);
                  },
                ),

                drawerItem(
                    itemIcon: CommonImage.estimate_icons,
                    itemName: Texts.estimates,
                    onTap: () {
                      Navigator.pop(context);
                      gotoEstimateListScreen(context);
                    }),
                drawerItem(
                    itemIcon: CommonImage.sales_icons,
                    itemName: Texts.product,
                    onTap: () {
                      Navigator.pop(context);
                      gotoProductListScreen(context);
                    }),
                drawerItem(
                  itemIcon: CommonImage.tasks_icons,
                  itemName: Texts.tasks,
                  onTap: () {
                    Navigator.pop(context);
                    gotoTasksListScreen(context);
                  },
                ),
                drawerItem(
                  itemIcon: CommonImage.leads_icons,
                  itemName: Texts.leads,
                  onTap: () {
                    Navigator.pop(context);
                    gotoLeadsListScreen(context);
                  },
                ),
                drawerItem(
                  itemIcon: CommonImage.activity_icons,
                  itemName: Texts.activity,
                  onTap: () {
                    Navigator.pop(context);
                    gotoAcvityListScreen(context);
                  },
                ),
                drawerItem(
                  itemIcon: CommonImage.contact_icons,
                  itemName: Texts.contact,
                  onTap: () => gotoContactScreen(context),
                ),
                drawerHeader(
                  drawerHeaderTitle: Texts.payment,
                ),
                drawerItem(
                  itemIcon: CommonImage.contact_icons,
                  itemName: Texts.payment,
                  onTap: () {
                    Get.to(paymentListing());
                  },
                ),
                drawerHeader(
                  drawerHeaderTitle: Texts.reports,
                ),
                drawerItem(
                  itemIcon: CommonImage.activity_icons,
                  itemName: Texts.activity,
                  onTap: () {},
                ),
                SizedBox(
                  height: (screenHeight * 0.1).ceilToDouble(),
                ),
                drawerItem(
                  itemIcon: CommonImage.logout_icons,
                  itemName: Texts.logout,
                  onTap: () => CommonWidget().showalertDialog(
                    context: context,
                    getMyWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Logout',
                          style: TextStyle(
                              fontFamily: AppDetails.fontSemiBold,
                              fontSize: 19,
                              color: Colors.black),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: AppDetails.fontMedium,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: <Widget>[
                            CommonWidget().CommonButton(
                              buttonText: 'Yes',
                              onPressed: () {
                                showLoader(context);
                                loginControllers.logoutUser(context);
                                hideLoader(context);
                              },
                              context: context,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            CommonWidget().CommonNoButton(
                              buttonText: 'No',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              context: context,
                            ),
                          ],
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

  Padding drawerHeader({required String drawerHeaderTitle}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
      child: Text(
        drawerHeaderTitle.toString(),
        style: drawerSubHeaderStyle(),
      ),
    );
  }

  InkWell drawerItem({
    required String itemIcon,
    required String itemName,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap!,
      child: ListTile(
        contentPadding: const EdgeInsets.only(
            left: 20.0, right: 0.0, top: 0.0, bottom: 0.0),
        visualDensity: const VisualDensity(vertical: -4.0, horizontal: -4.0),
        leading: Image.asset(
          itemIcon,
          height: 25.0,
          width: 25.0,
          fit: BoxFit.fill,
        ),
        title: Text(
          itemName.toString(),
          style: drawerStyle(),
        ),
      ),
    );
  }

  SizedBox setSpace() => SizedBox(
        height: screenHeight * 0.01,
      );
}
