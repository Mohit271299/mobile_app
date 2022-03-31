import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../pagination/controller_class.dart';

import '../../utils/asset_utils.dart';
import '../../utils/back_image.dart';
import '../../utils/color_utils.dart';
import '../../utils/shimmer_list.dart';
import '../../utils/txt_style.dart';
import '../../widgets/audio_class_model.dart';
import '../../widgets/drawer_class.dart';
import '../blog/blogDetails_screen.dart';
import '../video_details/videoDetail_screen.dart';

class testing_home extends StatefulWidget {
  const testing_home({Key? key}) : super(key: key);

  @override
  testing_homeState createState() => testing_homeState();
}

class testing_homeState extends State<testing_home> {
  final _homepage_screen_controller = Get.put(homepage_screen_controller());

  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isEnd = false;
  final List<FeedModel> list = [];

  ScrollController? _controller;

  _scrollListener() async {
    var position = _controller!.offset /
        (_controller!.position.maxScrollExtent -
            _controller!.position.minScrollExtent);
    if (position > 0.5 && !_controller!.position.outOfRange) {
      await _getMoreData(list.length);
    }
  }

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.reference().child("Posts");
    getData();
    super.initState();
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getMoreData(list.length);
  }

  var dbRef;
  final home_controller = homepage_screen_controller();

  List<FeedModel> list_final = [];

  getData() async {
    setState(() {
      isLoading = true;
    });
    await dbRef.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> values = dataSnapshot.value;
      print(values);
      values.forEach((key, values) {
        // home_controller.final_data_list_2.add(values);
        final vartest = FeedModel(
            values["id"],
            values["postType"],
            values["fileType"],
            values["size"],
            values["path"],
            values["title"],
            values["description"],
            values["datetime"],
            values["tPath"]);
        list_final.add(vartest);
      });
      setState(() {
        isLoading = false;
      });
      print(list_final);
      print(list_final.length);
      // print(values);
    });
    await _getMoreData(list.length);
  }

  Future<List<FeedModel>> getPostList(int index) async {
    debugPrint("data.length.toString()");

    debugPrint(list_final.length.toString());
    print(index);
    List<FeedModel> l = [];
    for (var i = index; i < index + 5 && i < list_final.length; i++) {
      l.add(list_final[i]);
    }
    debugPrint("l.length.toString()");
    debugPrint(l.length.toString());
    await Future.delayed(Duration(seconds: 1));
    return l;
  }

  Future<void> _getMoreData(int index) async {
    print('inside get more data');
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var tlist = await getPostList(index);

      setState(() {
        if (tlist.length == 0) {
          isEnd = true;
        } else {
          list.addAll(tlist);
          index = list.length;
        }

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(height: (screenSize.height * 0.118)),
                  // Text( (screenSize.height * 0.118).toString()),
                  // FutureBuilder(
                  //     future: dbRef.once(),
                  //     builder:
                  //         (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  //       if (snapshot.hasData) {
                  //         home_controller.final_data_list.clear();
                  //         Map<dynamic, dynamic> values = snapshot.data!.value;
                  //         values.forEach((key, values) {
                  //           home_controller.final_data_list.add(values);
                  //         });
                  //         return ListView.builder(
                  //             physics: NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             reverse: true,
                  //             itemCount: home_controller.final_data_list.length,
                  //             padding: EdgeInsets.only(top: 10, bottom: 0),
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 width: screenSize.width,
                  //                 child: Column(
                  //                   children: [
                  //                     Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Text(home_controller.final_data_list[index]["title"]
                  //                             .toString()),
                  //                         SizedBox(
                  //                           width: 10,
                  //                         ),
                  //                         Text(home_controller.final_data_list[index]["fileType"]
                  //                             .toString()),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             });
                  //       }
                  //       return CircularProgressIndicator();
                  //     }),

                  // ??????????????????????????????????????????????????????????????????
                  Container(
                    child: (list[index].fileType.toString() == 'Video'
                        ? GestureDetector(
                            onTap: () {
                              print('tapped');
                              // audioPlayer.pause();
                              // MaterialPageRoute>Na
                              Get.to(VideoDetails(
                                video_url: list[index].path.toString(),
                                video_title: list[index].title.toString(),
                                video_subtitle:
                                    list[index].description.toString(),
                              ));
                              // Get.toNamed(BindingUtils.video_route);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: screenSize.width,
                              height: (screenSize.height * 0.33).ceilToDouble(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: <Widget>[
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x17000000),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 0.75),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              list[index].tPath.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                          alignment:
                                              FractionalOffset.bottomLeft,
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
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    // iconSize: 50,
                                                    icon: Image.asset(
                                                      AssetUtils.reddit_png,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                list[index].title.toString(),
                                                style: FontStyleUtility.h16(
                                                    fontColor: ColorUtils.black,
                                                    fontWeight: FWT.semiBold),
                                              ),
                                              subtitle: Text(
                                                list[index].description,
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
                                          // width: 0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : (list[index].fileType.toString() == 'images'
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Image.network(
                                        list[index].path.toString(),
                                        fit: BoxFit.contain,
                                      )),
                                      Container(
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
                                            list[index].title.toString(),
                                            style: FontStyleUtility.h16(
                                                fontColor: ColorUtils.black,
                                                fontWeight: FWT.semiBold),
                                          ),
                                          subtitle: Text(
                                            list[index].description.toString(),
                                            style: FontStyleUtility.h12(
                                                fontColor: ColorUtils.black
                                                    .withOpacity(0.6),
                                                fontWeight: FWT.semiBold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : (list[index].fileType.toString() == 'Audio'
                                ? AudioListingscreen(
                                    audio_url: list[index].path,
                                    subtitle: list[index].description,
                                    title: list[index].title,
                                  )
                                : (list[index].fileType.toString() == 'Blog'
                                    ? Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ExpansionTile(
                                          tilePadding: EdgeInsets.zero,
                                          childrenPadding:
                                              const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 15),
                                          textColor: ColorUtils.black,
                                          initiallyExpanded: true,
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
                                            list[index].title.toString(),
                                            style: FontStyleUtility.h16(
                                                fontColor: ColorUtils.black,
                                                fontWeight: FWT.semiBold),
                                          ),
                                          subtitle: Text(
                                            list[index].description.toString(),
                                            style: FontStyleUtility.h12(
                                                fontColor: ColorUtils.black
                                                    .withOpacity(0.6),
                                                fontWeight: FWT.semiBold),
                                          ),
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(Blog_details_screen(
                                                  Blog_title: list[index]
                                                      .title
                                                      .toString(),
                                                  Blog_subtitle: list[index]
                                                      .description
                                                      .toString(),
                                                  Blog_content: list[index]
                                                      .description
                                                      .toString(),
                                                ));
                                              },
                                              child: Text(
                                                list[index]
                                                    .description
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
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          print('tapped');
                                          // audioPlayer.pause();
                                          // MaterialPageRoute>Na
                                          Get.to(VideoDetails(
                                            video_url:
                                                list[index].path.toString(),
                                            video_title:
                                                list[index].title.toString(),
                                            video_subtitle: list[index]
                                                .description
                                                .toString(),
                                          ));
                                          // Get.toNamed(BindingUtils.video_route);
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          width: screenSize.width,
                                          height: (screenSize.height * 0.33)
                                              .ceilToDouble(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Stack(
                                              children: <Widget>[
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x17000000),
                                                        blurRadius: 10.0,
                                                        offset:
                                                            Offset(0.0, 0.75),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          list[index]
                                                              .tPath
                                                              .toString()),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Container(
                                                      alignment:
                                                          FractionalOffset
                                                              .bottomLeft,
                                                      // margin: EdgeInsets.only(top: 50),
                                                      child: Container(
                                                        color: ColorUtils.white,
                                                        child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          // tileColor: ColorUtils.orangeBack,
                                                          leading: SizedBox(
                                                            height: 50,
                                                            child: Container(
                                                              // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                                              child: IconButton(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                // iconSize: 50,
                                                                icon:
                                                                    Image.asset(
                                                                  AssetUtils
                                                                      .reddit_png,
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ),
                                                          ),
                                                          title: Text(
                                                            list[index]
                                                                .title
                                                                .toString(),
                                                            style: FontStyleUtility.h16(
                                                                fontColor:
                                                                    ColorUtils
                                                                        .black,
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          subtitle: Text(
                                                            list[index]
                                                                .title
                                                                .toString(),
                                                            style: FontStyleUtility.h12(
                                                                fontColor: ColorUtils
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          trailing:
                                                              SizedBox.shrink(),
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
                                                      height: 150,
                                                      width: 150,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))))),
                  )
                  // ListView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     reverse: true,
                  //     itemCount: list.length,
                  //     padding: EdgeInsets.only(top: 10, bottom: 0),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       // if (home_controller.final_data_list[index]["fileType"].toString() == 'Audio') {
                  //       //   print("values");
                  //       //   print(home_controller.final_data_list[index]["path"]);
                  //       //
                  //       //   lists_audio.add(home_controller.final_data_list[index]["path"]);
                  //       //
                  //       //   // lists_audio.insert(index, );
                  //       //   print("index :$index");
                  //       //   print("lists_audio.length");
                  //       //   print(lists_audio);
                  //       //   setupPlaylist(19);
                  //       //
                  //       // }
                  //       if(isLoading){
                  //         return shimmer_list();
                  //       }else{
                  //         return (list[index].fileType
                  //             .toString() ==
                  //             'Video'
                  //             ? GestureDetector(
                  //           onTap: () {
                  //             print('tapped');
                  //             // audioPlayer.pause();
                  //             // MaterialPageRoute>Na
                  //             Get.to(VideoDetails(
                  //               video_url: list[index].path
                  //                   .toString(),
                  //               video_title: list[index].title
                  //                   .toString(),
                  //               video_subtitle: list[index].description
                  //                   .toString(),
                  //             ));
                  //             // Get.toNamed(BindingUtils.video_route);
                  //           },
                  //           child: Container(
                  //             margin:
                  //             const EdgeInsets.only(bottom: 10),
                  //             width: screenSize.width,
                  //             height: (screenSize.height * 0.33)
                  //                 .ceilToDouble(),
                  //             child: ClipRRect(
                  //               borderRadius:
                  //               BorderRadius.circular(10),
                  //               child: Stack(
                  //                 children: <Widget>[
                  //                   DecoratedBox(
                  //                     decoration: BoxDecoration(
                  //                       boxShadow: const [
                  //                         BoxShadow(
                  //                           color:
                  //                           Color(0x17000000),
                  //                           blurRadius: 10.0,
                  //                           offset:
                  //                           Offset(0.0, 0.75),
                  //                         ),
                  //                       ],
                  //                       image: DecorationImage(
                  //                         image: NetworkImage(
                  //                             list[
                  //                             index]
                  //                                 .tpath
                  //                                 .toString()),
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                     child: Container(
                  //                         alignment:
                  //                         FractionalOffset
                  //                             .bottomLeft,
                  //                         // margin: EdgeInsets.only(top: 50),
                  //                         child: Container(
                  //                           color: ColorUtils.white,
                  //                           child: ListTile(
                  //                             contentPadding:
                  //                             EdgeInsets.zero,
                  //                             // tileColor: ColorUtils.orangeBack,
                  //                             leading: SizedBox(
                  //                               height: 50,
                  //                               child: Container(
                  //                                 // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  //                                 child: IconButton(
                  //                                   padding:
                  //                                   const EdgeInsets
                  //                                       .all(
                  //                                       0.0),
                  //                                   // iconSize: 50,
                  //                                   icon:
                  //                                   Image.asset(
                  //                                     AssetUtils
                  //                                         .reddit_png,
                  //                                   ),
                  //                                   onPressed:
                  //                                       () {},
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             title: Text(
                  //                               list[
                  //                               index]
                  //                                   .title
                  //                                   .toString(),
                  //                               style: FontStyleUtility.h16(
                  //                                   fontColor:
                  //                                   ColorUtils
                  //                                       .black,
                  //                                   fontWeight: FWT
                  //                                       .semiBold),
                  //                             ),
                  //                             subtitle: Text(
                  //                               list[
                  //                               index].datetime,
                  //                               style: FontStyleUtility.h12(
                  //                                   fontColor: ColorUtils
                  //                                       .black
                  //                                       .withOpacity(
                  //                                       0.6),
                  //                                   fontWeight: FWT
                  //                                       .semiBold),
                  //                             ),
                  //                             trailing:
                  //                             SizedBox.shrink(),
                  //                           ),
                  //                         )),
                  //                   ),
                  //                   Positioned(
                  //                     top: 0.0,
                  //                     left: 0.0,
                  //                     right: 0.0,
                  //                     bottom: 85.0,
                  //                     child: Center(
                  //                       child: Image.asset(
                  //                         'assets/png/player.png',
                  //                         height: 80,
                  //                         // width: 0,
                  //                         fit: BoxFit.fill,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //             : (list[index].fileType
                  //             .toString() ==
                  //             'images'
                  //             ? Container(
                  //           margin: const EdgeInsets.only(
                  //               bottom: 10),
                  //           child: ClipRRect(
                  //             borderRadius:
                  //             BorderRadius.circular(10),
                  //             child: Column(
                  //               children: [
                  //                 Container(
                  //                     child: Image.network(
                  //                       list[index]
                  //                           .path
                  //                           .toString(),
                  //                       fit: BoxFit.contain,
                  //                     )),
                  //                 Container(
                  //                   color: ColorUtils.white,
                  //                   child: ListTile(
                  //                     contentPadding:
                  //                     EdgeInsets.zero,
                  //                     // tileColor: ColorUtils.orangeBack,
                  //                     leading: SizedBox(
                  //                       height: 50,
                  //                       child: Container(
                  //                         // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  //                         child: IconButton(
                  //                           padding:
                  //                           new EdgeInsets
                  //                               .all(0.0),
                  //                           // iconSize: 50,
                  //                           icon: Image.asset(
                  //                             AssetUtils
                  //                                 .reddit_png,
                  //                           ),
                  //                           onPressed: () {},
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     title: Text(
                  //                       list[
                  //                       index].title
                  //                           .toString(),
                  //                       style: FontStyleUtility
                  //                           .h16(
                  //                           fontColor:
                  //                           ColorUtils
                  //                               .black,
                  //                           fontWeight: FWT
                  //                               .semiBold),
                  //                     ),
                  //                     subtitle: Text(
                  //                       list[
                  //                       index].description
                  //                           .toString(),
                  //                       style: FontStyleUtility.h12(
                  //                           fontColor: ColorUtils
                  //                               .black
                  //                               .withOpacity(
                  //                               0.6),
                  //                           fontWeight:
                  //                           FWT.semiBold),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //             : (list[index]
                  //             .fileType
                  //             .toString() ==
                  //             'Audio'
                  //             ? AudioListingscreen(
                  //           audio_url: list[index]
                  //               .path,
                  //           subtitle: list[index]
                  //               .description,
                  //           title: list[index]
                  //               .title,
                  //         )
                  //             : (list[index]
                  //             .fileType
                  //             .toString() ==
                  //             'Blog'
                  //             ? Container(
                  //           margin: EdgeInsets.only(
                  //               bottom: 10),
                  //           decoration: BoxDecoration(
                  //               color: ColorUtils.white,
                  //               borderRadius:
                  //               BorderRadius
                  //                   .circular(10)),
                  //           child: ExpansionTile(
                  //             tilePadding:
                  //             EdgeInsets.zero,
                  //             childrenPadding:
                  //             const EdgeInsets.only(
                  //                 left: 15,
                  //                 right: 15,
                  //                 bottom: 15),
                  //             textColor:
                  //             ColorUtils.black,
                  //             initiallyExpanded: true,
                  //             leading: SizedBox(
                  //               height: 50,
                  //               child: Container(
                  //                 // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  //                 child: IconButton(
                  //                   padding:
                  //                   new EdgeInsets
                  //                       .all(0.0),
                  //                   // iconSize: 50,
                  //                   icon: Image.asset(
                  //                     AssetUtils
                  //                         .reddit_png,
                  //                   ),
                  //                   onPressed: () {},
                  //                 ),
                  //               ),
                  //             ),
                  //             title: Text(
                  //               list[
                  //               index].title
                  //                   .toString(),
                  //               style: FontStyleUtility
                  //                   .h16(
                  //                   fontColor:
                  //                   ColorUtils
                  //                       .black,
                  //                   fontWeight: FWT
                  //                       .semiBold),
                  //             ),
                  //             subtitle: Text(
                  //               list[
                  //               index]
                  //                   .description
                  //                   .toString(),
                  //               style: FontStyleUtility.h12(
                  //                   fontColor: ColorUtils
                  //                       .black
                  //                       .withOpacity(
                  //                       0.6),
                  //                   fontWeight:
                  //                   FWT.semiBold),
                  //             ),
                  //             children: [
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   Get.to(
                  //                       Blog_details_screen(
                  //                         Blog_title: list[
                  //                         index]
                  //                             .title
                  //                             .toString(),
                  //                         Blog_subtitle:
                  //                         list[
                  //                         index]
                  //                             .description
                  //                             .toString(),
                  //                         Blog_content: list[
                  //                         index].description
                  //                             .toString(),
                  //                       ));
                  //                 },
                  //                 child: Text(
                  //                   list[
                  //                   index]
                  //                       .description
                  //                       .toString(),
                  //                   maxLines: 3,
                  //                   overflow:
                  //                   TextOverflow
                  //                       .ellipsis,
                  //                   textAlign: TextAlign
                  //                       .justify,
                  //                   style: FontStyleUtility.h14(
                  //                       fontColor:
                  //                       ColorUtils
                  //                           .black,
                  //                       fontWeight: FWT
                  //                           .lightBold),
                  //                 ),
                  //               ),
                  //             ],
                  //             trailing: const SizedBox
                  //                 .shrink(),
                  //           ),
                  //         )
                  //             : GestureDetector(
                  //           onTap: () {
                  //             print('tapped');
                  //             // audioPlayer.pause();
                  //             // MaterialPageRoute>Na
                  //             Get.to(VideoDetails(
                  //               video_url:
                  //               list[
                  //               index]
                  //                   .path
                  //                   .toString(),
                  //               video_title:
                  //               list[
                  //               index]
                  //                   .title
                  //                   .toString(),
                  //               video_subtitle:
                  //               list[
                  //               index].description
                  //                   .toString(),
                  //             ));
                  //             // Get.toNamed(BindingUtils.video_route);
                  //           },
                  //           child: Container(
                  //             margin:
                  //             const EdgeInsets.only(
                  //                 bottom: 10),
                  //             width: screenSize.width,
                  //             height:
                  //             (screenSize.height *
                  //                 0.33)
                  //                 .ceilToDouble(),
                  //             child: ClipRRect(
                  //               borderRadius:
                  //               BorderRadius
                  //                   .circular(10),
                  //               child: Stack(
                  //                 children: <Widget>[
                  //                   DecoratedBox(
                  //                     decoration:
                  //                     BoxDecoration(
                  //                       boxShadow: const [
                  //                         BoxShadow(
                  //                           color: Color(
                  //                               0x17000000),
                  //                           blurRadius:
                  //                           10.0,
                  //                           offset:
                  //                           Offset(
                  //                               0.0,
                  //                               0.75),
                  //                         ),
                  //                       ],
                  //                       image:
                  //                       DecorationImage(
                  //                         image: NetworkImage(list[
                  //                         index]
                  //                             .tpath
                  //                             .toString()),
                  //                         fit: BoxFit
                  //                             .cover,
                  //                       ),
                  //                     ),
                  //                     child: Container(
                  //                         alignment:
                  //                         FractionalOffset
                  //                             .bottomLeft,
                  //                         // margin: EdgeInsets.only(top: 50),
                  //                         child:
                  //                         Container(
                  //                           color: ColorUtils
                  //                               .white,
                  //                           child:
                  //                           ListTile(
                  //                             contentPadding:
                  //                             EdgeInsets
                  //                                 .zero,
                  //                             // tileColor: ColorUtils.orangeBack,
                  //                             leading:
                  //                             SizedBox(
                  //                               height:
                  //                               50,
                  //                               child:
                  //                               Container(
                  //                                 // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  //                                 child:
                  //                                 IconButton(
                  //                                   padding:
                  //                                   const EdgeInsets.all(0.0),
                  //                                   // iconSize: 50,
                  //                                   icon:
                  //                                   Image.asset(
                  //                                     AssetUtils.reddit_png,
                  //                                   ),
                  //                                   onPressed:
                  //                                       () {},
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             title:
                  //                             Text(
                  //                               list[index].title
                  //                                   .toString(),
                  //                               style: FontStyleUtility.h16(
                  //                                   fontColor:
                  //                                   ColorUtils.black,
                  //                                   fontWeight: FWT.semiBold),
                  //                             ),
                  //                             subtitle:
                  //                             Text(
                  //                               list[index].title
                  //                                   .toString(),
                  //                               style: FontStyleUtility.h12(
                  //                                   fontColor:
                  //                                   ColorUtils.black.withOpacity(0.6),
                  //                                   fontWeight: FWT.semiBold),
                  //                             ),
                  //                             trailing:
                  //                             SizedBox
                  //                                 .shrink(),
                  //                           ),
                  //                         )),
                  //                   ),
                  //                   Positioned(
                  //                     top: 0.0,
                  //                     left: 0.0,
                  //                     right: 0.0,
                  //                     bottom: 85.0,
                  //                     child: Center(
                  //                       child:
                  //                       Image.asset(
                  //                         'assets/png/player.png',
                  //                         height: 150,
                  //                         width: 150,
                  //                         fit: BoxFit
                  //                             .fill,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         )))));
                  //       }
                  //
                  //     })

// ?????????????????????????????????????????????????????????????????????????????????

                  // FutureBuilder(
                  //     future: dbRef
                  //         .orderByChild("fileType")
                  //         .equalTo("Video")
                  //         .once(),
                  //     builder:
                  //         (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  //       if (snapshot.hasData) {
                  //         lists_videos.clear();
                  //         Map<dynamic, dynamic> values = snapshot.data!.value;
                  //         values.forEach((key, values) {
                  //           lists_videos.add(values);
                  //         });
                  //         return ListView.builder(
                  //             physics: NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             reverse: true,
                  //             itemCount: lists_videos.length,
                  //             padding: EdgeInsets.only(top: 10, bottom: 0),
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onTap: () {
                  //                   print('tapped');
                  //                   // audioPlayer.pause();
                  //
                  //                   // MaterialPageRoute>Na
                  //                   Get.to(VideoDetails(
                  //                     video_url: lists_videos[index]["path"]
                  //                         .toString(),
                  //                     video_title: lists_videos[index]
                  //                             ["title"]
                  //                         .toString(),
                  //                     video_subtitle: lists_videos[index]
                  //                             ["description"]
                  //                         .toString(),
                  //                   ));
                  //                   // Get.toNamed(BindingUtils.video_route);
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.only(bottom: 10),
                  //                   width: screenSize.width,
                  //                   height: (screenSize.height * 0.33)
                  //                       .ceilToDouble(),
                  //                   child: ClipRRect(
                  //                     borderRadius: BorderRadius.circular(10),
                  //                     child: DecoratedBox(
                  //                       decoration: BoxDecoration(
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color: Color(0x17000000),
                  //                             blurRadius: 10.0,
                  //                             offset: Offset(0.0, 0.75),
                  //                           ),
                  //                         ],
                  //                         image: DecorationImage(
                  //                           image: NetworkImage(
                  //                               lists_videos[index]["tPath"]
                  //                                   .toString()),
                  //                           fit: BoxFit.cover,
                  //                         ),
                  //                       ),
                  //                       child: Container(
                  //                           alignment:
                  //                               FractionalOffset.bottomLeft,
                  //                           // margin: EdgeInsets.only(top: 50),
                  //                           child: Container(
                  //                             color: ColorUtils.white,
                  //                             child: ListTile(
                  //                               contentPadding:
                  //                                   EdgeInsets.zero,
                  //                               // tileColor: ColorUtils.orangeBack,
                  //                               leading: SizedBox(
                  //                                 height: 50,
                  //                                 child: Container(
                  //                                   // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  //                                   child: IconButton(
                  //                                     padding:
                  //                                         new EdgeInsets.all(
                  //                                             0.0),
                  //                                     // iconSize: 50,
                  //                                     icon: Image.asset(
                  //                                       AssetUtils.reddit_png,
                  //                                     ),
                  //                                     onPressed: () {},
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               title: Text(
                  //                                 lists_videos[index]["title"]
                  //                                     .toString(),
                  //                                 style: FontStyleUtility.h16(
                  //                                     fontColor:
                  //                                         ColorUtils.black,
                  //                                     fontWeight:
                  //                                         FWT.semiBold),
                  //                               ),
                  //                               subtitle: Text(
                  //                                 lists_videos[index]["title"]
                  //                                     .toString(),
                  //                                 style: FontStyleUtility.h12(
                  //                                     fontColor: ColorUtils
                  //                                         .black
                  //                                         .withOpacity(0.6),
                  //                                     fontWeight:
                  //                                         FWT.semiBold),
                  //                               ),
                  //                               trailing: SizedBox.shrink(),
                  //                             ),
                  //                           )),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             });
                  //       }
                  //       return CircularProgressIndicator();
                  //     }),
                  //
                  // .............................................
                  // FutureBuilder(
                  //     future: dbRef
                  //         .orderByChild("fileType")
                  //         .equalTo("Audio")
                  //         .once(),
                  //     builder:
                  //         (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  //       if (snapshot.hasData) {
                  //         lists_audio.clear();
                  //         Map<dynamic, dynamic> values = snapshot.data!.value;
                  //         values.forEach((key, values) {
                  //           lists_audio.add(values);
                  //         });
                  //         return ListView.builder(
                  //             physics: NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: lists_audio.length,
                  //             padding: EdgeInsets.only(top: 0, bottom: 0),
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin: EdgeInsets.only(bottom: 10),
                  //                 decoration: BoxDecoration(
                  //                     color: ColorUtils.white,
                  //                     borderRadius:
                  //                         BorderRadius.circular(10)),
                  //                 child: ListTile(
                  //                   visualDensity: const VisualDensity(
                  //                       vertical: 0.0, horizontal: -4.0),
                  //                   contentPadding: EdgeInsets.zero,
                  //                   // contentPadding: EdgeInsets.zero,
                  //                   // tileColor: ColorUtils.orangeBack,
                  //                   leading: SizedBox(
                  //                     height: 50,
                  //                     child: Container(
                  //                       // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  //                       child: IconButton(
                  //                         padding: new EdgeInsets.all(0.0),
                  //                         // iconSize: 50,
                  //                         icon: Image.asset(
                  //                           AssetUtils.reddit_png,
                  //                         ),
                  //                         onPressed: () {},
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   title: Text(
                  //                     "Title Here",
                  //                     style: FontStyleUtility.h16(
                  //                         fontColor: ColorUtils.black,
                  //                         fontWeight: FWT.semiBold),
                  //                   ),
                  //                   subtitle: Text(
                  //                     "subtitel here",
                  //                     style: FontStyleUtility.h12(
                  //                         fontColor: ColorUtils.black
                  //                             .withOpacity(0.6),
                  //                         fontWeight: FWT.semiBold),
                  //                   ),
                  //                   trailing: Container(
                  //                       margin: const EdgeInsets.symmetric(
                  //                           horizontal: 15),
                  //                       child: audioPlayer
                  //                           .builderRealtimePlayingInfos(
                  //                               builder: (context,
                  //                                   realtimePlayingInfos) {
                  //                         if (realtimePlayingInfos != null) {
                  //                           return Container(
                  //                               decoration: BoxDecoration(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(
                  //                                         50),
                  //                                 color: ColorUtils.primary,
                  //                               ),
                  //                               child: circularAudioPlayer(
                  //                                   realtimePlayingInfos,
                  //                                   screenSize.width));
                  //                         } else {
                  //                           return Container();
                  //                         }
                  //                       })),
                  //                 ),
                  //               );
                  //             });
                  //       }
                  //       return CircularProgressIndicator();
                  //     }),

                  //     padding: EdgeInsets.zero,
                  //         future: dbRef
                  //             .orderByChild("fileType")
                  //             .equalTo("images")
                  //             .once(),
                  //         builder: (context,
                  //             AsyncSnapshot<DataSnapshot> snapshot) {
                  //           if (snapshot.hasData) {
                  //             lists_images.clear();
                  //             Map<dynamic, dynamic> values =
                  //                 snapshot.data!.value;
                  //             values.forEach((key, values) {
                  //               lists_images.add(values);
                  //             });
                  //             return ListView.builder(
                  //                 physics: NeverScrollableScrollPhysics(),
                  //                 shrinkWrap: true,
                  //                 reverse: true,
                  //                 itemCount: lists_images.length,
                  //                 padding: EdgeInsets.only(top: 0),
                  //                 itemBuilder:
                  //                     (BuildContext context, int index) {
                  //                   return Card(
                  //                     child: Container(
                  //                       width: screenSize.width,
                  //                       height: (screenSize.height * 0.33)
                  //                           .ceilToDouble(),
                  //                       child: ClipRRect(
                  //                         borderRadius:
                  //                             BorderRadius.circular(10),
                  //                         child: DecoratedBox(
                  //                           decoration: BoxDecoration(
                  //                             image: DecorationImage(
                  //                               image: NetworkImage(
                  //                                   lists_images[index]
                  //                                           ["path"]
                  //                                       .toString()),
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                           ),
                  //                           child: Container(
                  //                               alignment: FractionalOffset
                  //                                   .bottomLeft,
                  //                               // margin: EdgeInsets.only(top: 50),
                  //                               child: Container(
                  //                                 color: ColorUtils.white,
                  //                                 child: ListTile(
                  //                                   contentPadding:
                  //                                       EdgeInsets.zero,
                  //                                   // tileColor: ColorUtils.orangeBack,
                  //                                   leading: IconButton(
                  //                                     icon: Image.asset(
                  //                                       AssetUtils.reddit_png,
                  //                                     ),
                  //                                     onPressed: () {},
                  //                                   ),
                  //                                   title: Text(
                  //                                       lists_images[index]
                  //                                               ["title"]
                  //                                           .toString()),
                  //                                   subtitle: Text(
                  //                                       lists_images[index][
                  //                                               "description"]
                  //                                           .toString()),
                  //                                 ),
                  //                               )),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   );
                  //                 });
                  //           }
                  //           return CircularProgressIndicator();
                  //         })),
                ],
              );
              //   Container(
              //   color: Colors.white,
              //   height: 300,
              //   child: Center(child: Text(list[index].title)),
              // );
            },
            childCount: list.length,
          ),
        ),
        SliverFillRemaining(
            child: Center(
          child: isEnd ? Text('End') : CircularProgressIndicator(),
        )),
      ],
    );
  }

// We will fetch data from this Rest api

}

class FeedModel {
  final String id;
  final String postType;
  final String fileType;
  final String size;
  final String path;
  final String title;
  final String description;
  final String datetime;
  final String tPath;

  FeedModel(this.id, this.postType, this.fileType, this.size, this.path,
      this.title, this.description, this.datetime, this.tPath);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "postType": postType,
      "fileType": fileType,
      "size": size,
      "path": path,
      "title": title,
      "description": description,
      "datetime": datetime,
      "tPath": tPath
    };
  }

  FeedModel.fromMap(Map<String, dynamic> addressMap)
      : id = addressMap["id"],
        postType = addressMap["postType"],
        fileType = addressMap["fileType"],
        size = addressMap["size"],
        path = addressMap["path"],
        title = addressMap["title"],
        description = addressMap["description"],
        datetime = addressMap["datetime"],
        tPath = addressMap["tPath"];
}

// class FeedModel {
//   final String text;
//   FeedModel(this.text);
// }
class Feed {
  static final home_controller = homepage_screen_controller();

  static final data = home_controller.final_data_list_2;

  static Future<List<FeedModel>> getPostList(int index) async {
    debugPrint("data.length.toString()");

    debugPrint(home_controller.final_data_list_2.length.toString());
    List<FeedModel> l = [];
    for (var i = index; i < index + 5 && i < data.length; i++) {
      l.add(data[i]);
    }
    debugPrint("l.length.toString()");
    debugPrint(l.length.toString());
    await Future.delayed(Duration(seconds: 1));
    return l;
  }
}
// class Feed {
//   static final homeController = homepage_screen_controller();
//
//   static final data = homeController.final_data_list_2;
//
//   static Future<List<FeedModel>> getPostList(int index) async {
//     // await homeController.getData();
//     List<FeedModel> l = [];
//     print('object');
//     for (var i = index; i < index + 5 && i < data.length; i++) {
//       l.add(data[i]);
//     }
//     print(l.length);
//     await Future.delayed(Duration(seconds: 1));
//     return l;
//   }
// }
