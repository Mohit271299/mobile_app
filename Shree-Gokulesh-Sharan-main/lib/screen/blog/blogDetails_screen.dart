import 'package:flutter/material.dart';
import 'package:vaishnav_parivar/utils/asset_utils.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';

import '../../pagination/route_name.dart';
import '../../utils/color_utils.dart';
import '../../utils/txt_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/drawer_class.dart';

class Blog_details_screen extends StatefulWidget {
  final String Blog_title;
  final String Blog_subtitle;
  final String Blog_content;
  const Blog_details_screen({Key? key,required this.Blog_title, required this.Blog_subtitle, required this.Blog_content}) : super(key: key);

  @override
  Blog_details_screenState createState() => Blog_details_screenState();
}

class Blog_details_screenState extends State<Blog_details_screen> {
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  String long_text =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: globalKey,
      drawer: DrawerScreen(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: custom_appbar(
          title: "Blog",
          backRoute: BindingUtils.blog_route,
          back: AssetUtils.drawer_back,
        ),
      ),
      body: back_image(
        body_container: Container(
            margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
            child: Column(
              children: [
                SizedBox(height: (screenSize.height * 0.02).ceilToDouble()),
                Container(
                  decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    visualDensity:
                        VisualDensity(vertical: 0.0, horizontal: -4.0),
                    contentPadding: EdgeInsets.zero,
                    // contentPadding: EdgeInsets.zero,
                    // tileColor: ColorUtils.orangeBack,
                    leading: SizedBox(
                      height: 50,
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: IconButton(
                          padding: new EdgeInsets.all(0.0),
                          // iconSize: 50,
                          icon: Image.asset(
                            AssetUtils.reddit_png,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    title: Text(
                      "${widget.Blog_title}",
                      style: FontStyleUtility.h16(
                          fontColor: ColorUtils.black,
                          fontWeight: FWT.semiBold),
                    ),
                    subtitle: Text(
                      widget.Blog_subtitle,
                      style: FontStyleUtility.h12(
                          fontColor: ColorUtils.black.withOpacity(0.6),
                          fontWeight: FWT.semiBold),
                    ),
                    trailing: SizedBox.shrink(),
                  ),
                ),
                SizedBox(height: (screenSize.height * 0.02).ceilToDouble()),
                Container(
                  decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Text(
                      widget.Blog_content,
                      textAlign: TextAlign.justify,
                      style: FontStyleUtility.h14(
                          fontColor: ColorUtils.black, fontWeight: FWT.lightBold),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
