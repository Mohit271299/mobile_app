import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/screen/blog/blogDetails_screen.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/widgets/drawer_class.dart';

import '../../pagination/controller_class.dart';
import '../../pagination/route_name.dart';
import '../../utils/asset_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/txt_style.dart';
import '../../widgets/custom_appbar.dart';

class Blog_screen extends StatefulWidget {
  const Blog_screen({Key? key}) : super(key: key);

  @override
  Blog_screenState createState() => Blog_screenState();
}

class Blog_screenState extends State<Blog_screen> {
  final _blog_screen_controller = Get.put(blog_screen_controller());
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();
  String long_text =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.reference().child("Posts");
    super.initState();
  }

  var dbRef;
  List lists_blogs = [];

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
          backRoute: BindingUtils.dashboard_route,
          back: AssetUtils.drawer_back,
        ),
      ),
      body: back_image(
        body_container: Container(
          margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: (screenSize.height * 0.02).ceilToDouble()),
                FutureBuilder(
                    future:
                        dbRef.orderByChild("fileType").equalTo("Blog").once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        lists_blogs.clear();
                        Map<dynamic, dynamic> values = snapshot.data!.value;
                        values.forEach((key, values) {
                          lists_blogs.add(values);
                        });
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: lists_blogs.length,
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTileTheme(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  horizontalTitleGap: 0.0,
                                  minLeadingWidth: 0,
                                  minVerticalPadding: 0,
                                  child: ExpansionTile(
                                    childrenPadding: const EdgeInsets.only(
                                        left: 15, right: 15, bottom: 15),
                                    textColor: ColorUtils.black,
                                    initiallyExpanded: true,
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
                                      lists_blogs[index]['title'].toString(),
                                      style: FontStyleUtility.h16(
                                          fontColor: ColorUtils.black,
                                          fontWeight: FWT.semiBold),
                                    ),
                                    subtitle: Text(
                                      lists_blogs[index]['description']
                                          .toString(),
                                      style: FontStyleUtility.h12(
                                          fontColor:
                                              ColorUtils.black.withOpacity(0.6),
                                          fontWeight: FWT.semiBold),
                                    ),
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(Blog_details_screen(
                                            Blog_title: lists_blogs[index]
                                                    ['title']
                                                .toString(),
                                            Blog_subtitle: lists_blogs[index]
                                                    ['description']
                                                .toString(),
                                            Blog_content: lists_blogs[index]
                                                    ['content']
                                                .toString(),
                                          ));
                                        },
                                        child: Text(
                                          lists_blogs[index]['content']
                                              .toString(),
                                          maxLines: 3,

                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                          style: FontStyleUtility.h14(
                                              fontColor: ColorUtils.black,
                                              fontWeight: FWT.lightBold),
                                        ),
                                      ),
                                    ],
                                    trailing: const SizedBox.shrink(),
                                  ),
                                ),
                              );
                            });
                      }
                      return CircularProgressIndicator();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
