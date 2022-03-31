import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'header_model.dart';

class custom_header extends StatelessWidget {
  final Widget data;
  final String? burger;
  final String? back;
  final String? route;
  final VoidCallback? drawertap;
  final VoidCallback? backtap;
  final String? backRoute;
  final String? labelText;
  final String? showtext;

  const custom_header({
    Key? key,
    required this.data,
    this.drawertap,
    this.backtap,
    this.burger,
    this.back,
    this.route,
    this.backRoute,
    this.labelText,
    this.showtext,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Container(
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: ColorUtils.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                ),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      (burger != null
                          ? Scaffold.of(context).openDrawer()
                          : Get.toNamed(backRoute!));
                    },
                    icon: (burger != null
                        ? SvgPicture.asset(
                            burger!,
                            color: Colors.black,
                          )
                        : SvgPicture.asset(
                            back!,
                            color: Colors.black,
                          ))),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 37,
                    icon: Image.asset(AssetUtils.userPng),
                    onPressed: () {
                      Get.toNamed(BindingUtils.user_profile_ScreenRoute);
                    },
                  ),
                ),
              ],
              // title: Text('List', style: TextStyle(color: Colors.green)),
              // backgroundColor: ColorUtils.ogback,

              // floating: true,
              // pinned: true,
              // snap: false,
              // forceElevated: true,
              // flexibleSpace: FlexibleSpaceBar(
              //   title: Container(
              //       alignment: Alignment.bottomLeft,
              //       child: Text(
              //         'Purchase',
              //         style: TextStyle(fontSize: 20, color: Colors.green),
              //       )),
              // ),
              //
              // bottom: PreferredSize(
              //   preferredSize: Size.fromHeight(30),
              //   child: TabBar(
              //     isScrollable: false,
              //     indicatorColor: Colors.transparent,
              //     controller: _tabController,
              //     tabs: [
              //       Text(''),
              //     ],
              //   ),
              // ),
              //
              backgroundColor: ColorUtils.whiteColor_2,
              primary: true,
              pinned: true,
              expandedHeight: 70,
              centerTitle: true,
              title: header_model(
                  child: Container(
                alignment: Alignment.center,
                child: Text(
                  labelText!,
                  style: FontStyleUtility.h15B(
                    fontColor: ColorUtils.blackColor,
                  ),
                ),
              )),
            )
          ];
        },
        body: data);
  }
}

// class _custom_headerState extends State<custom_header>
//     with SingleTickerProviderStateMixin {
//   GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _globalKey,
//       drawer: DrawerScreen(),
//       body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 leading: Container(
//                   margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(7),
//                     color: ColorUtils.whiteColor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0x17000000),
//                         blurRadius: 10.0,
//                         offset: Offset(0.0, 0.75),
//                       ),
//                     ],
//                   ),
//                   child: IconButton(
//                       padding: EdgeInsets.zero,
//                       onPressed: () {
//                         _globalKey!.currentState?.openDrawer();
//                       },
//                       icon: (widget.burger!.isNotEmpty
//                           ? SvgPicture.asset(
//                               widget.burger!,
//                               color: Colors.black,
//                             )
//                           : SvgPicture.asset(
//                               widget.back!,
//                               color: Colors.black,
//                             ))),
//                 ),
//                 actions: [
//                   Container(
//                     margin: EdgeInsets.only(right: 20),
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       iconSize: 37,
//                       icon: Image.asset(AssetUtils.userPng),
//                       onPressed: () {
//                         Get.toNamed(BindingUtils.user_profile_ScreenRoute);
//                       },
//                     ),
//                   ),
//                 ],
//                 // title: Text('List', style: TextStyle(color: Colors.green)),
//                 // backgroundColor: ColorUtils.ogback,
//
//                 // floating: true,
//                 // pinned: true,
//                 // snap: false,
//                 // forceElevated: true,
//                 // flexibleSpace: FlexibleSpaceBar(
//                 //   title: Container(
//                 //       alignment: Alignment.bottomLeft,
//                 //       child: Text(
//                 //         'Purchase',
//                 //         style: TextStyle(fontSize: 20, color: Colors.green),
//                 //       )),
//                 // ),
//                 //
//                 // bottom: PreferredSize(
//                 //   preferredSize: Size.fromHeight(30),
//                 //   child: TabBar(
//                 //     isScrollable: false,
//                 //     indicatorColor: Colors.transparent,
//                 //     controller: _tabController,
//                 //     tabs: [
//                 //       Text(''),
//                 //     ],
//                 //   ),
//                 // ),
//                 //
//                 backgroundColor: ColorUtils.ogback,
//                 primary: true,
//                 pinned: true,
//                 expandedHeight: 70,
//                 centerTitle: true,
//                 title: header_model(
//                     child: Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Purchase',
//                     style: FontStyleUtility.h15B(
//                       fontColor: ColorUtils.blackColor,
//                     ),
//                   ),
//                 )),
//               )
//             ];
//           },
//           body: widget.data),
//     );
//   }
// }
