import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/utils/txt_file.dart';

import '../../pagination/controller_class.dart';
import '../../pagination/route_name.dart';
import '../../utils/asset_utils.dart';
import '../../utils/back_image.dart';
import '../../utils/color_utils.dart';
import '../../utils/txt_style.dart';
import '../../widgets/custom_appbar.dart';
import '../video_details/videoDetail_screen.dart';

class videoListingScreen extends StatefulWidget {
  const videoListingScreen({Key? key}) : super(key: key);

  @override
  _videoListingScreenState createState() => _videoListingScreenState();
}

class _videoListingScreenState extends State<videoListingScreen> {
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  final _videolisting_controller = Get.put(videolisting_controller());

  @override
  void initState() {
    // getData();
    super.initState();
  }

  final dbRef = FirebaseDatabase.instance.reference().child("Posts");
  Future<DataSnapshot>? event;
  Query? query;
  List lists = [];

  // getData() async {
  //   debugPrint('values1111');
  //   _databaseReference = FirebaseDatabase.instance.reference().child("Posts");
  //   query = _databaseReference.orderByChild("fileType").equalTo("Video");
  //
  //   event = query!.get();
  //
  //   print("event");
  //   // print(event!.value[' path']);
  //   print(event);
  //
  //   // _databaseReference!.orderByChild("fileType").equalTo("images").get().then((DataSnapshot dataSnapshot) {
  //   //   Map<dynamic, dynamic> values = dataSnapshot.value;
  //   //   print(values[" path"]);
  //   //
  //   //   debugPrint('values2222s');
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: globalKey,
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: custom_appbar(
          keys: globalKey,
          // drawertap : () {
          //   print("object");
          //   globalKey!.currentState!.openDrawer();
          // },
          title: "DashBoard",
          burger: AssetUtils.drawer_png,
        ),
      ),
      body: back_image(
        body_container: Container(
            margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: FutureBuilder(
                future: dbRef.orderByChild("fileType").equalTo("Video").once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    lists.clear();
                    Map<dynamic, dynamic> values = snapshot.data!.value;
                    values.forEach((key, values) {
                      lists.add(values);
                    });
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: lists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              print('tapped');
                              // audioPlayer.pause();
                              Get.to(VideoDetails(
                                video_url: lists[index]["path"].toString(),
                                video_title: lists[index]["title"].toString(),
                                video_subtitle: lists[index]["description"].toString(),
                              ));
                              // Get.toNamed(BindingUtils.video_route);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: screenSize.width,
                              height: (screenSize.height * 0.33).ceilToDouble(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x17000000),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 0.75),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              lists[index]["tPath"].toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                          alignment: FractionalOffset.bottomLeft,
                                          // margin: EdgeInsets.only(top: 50),
                                          child: Container(
                                            color: ColorUtils.white,
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              // tileColor: ColorUtils.orangeBack,
                                              leading: SizedBox(
                                                height: 50,
                                                child: Container(
                                                  // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                                  child: IconButton(
                                                    padding:
                                                    new EdgeInsets.all(0.0),
                                                    // iconSize: 50,
                                                    icon: Image.asset(
                                                      AssetUtils.reddit_png,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                lists[index]["title"].toString(),
                                                style: FontStyleUtility.h16(
                                                    fontColor: ColorUtils.black,
                                                    fontWeight: FWT.semiBold),
                                              ),
                                              subtitle: Text(
                                                lists[index]["description"]
                                                    .toString(),
                                                style: FontStyleUtility.h12(
                                                    fontColor: ColorUtils.black
                                                        .withOpacity(0.6),
                                                    fontWeight: FWT.semiBold),
                                              ),
                                              trailing: SizedBox.shrink(),
                                            ),
                                          )),
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      bottom: 85.0,
                                      child: Center(
                                        child: Image.asset(
                                          'assets/png/player.png',
                                          height: 80,
                                          // width: 80,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return CircularProgressIndicator();
                })),
      ),
    );
  }
}
