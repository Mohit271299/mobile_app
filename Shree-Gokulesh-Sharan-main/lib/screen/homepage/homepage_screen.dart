// ignore_for_file: unnecessary_null_comparison

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vaishnav_parivar/screen/Auth/controller/forceupdateController.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/shimmer_list.dart';
import 'package:vaishnav_parivar/widgets/drawer_class.dart';

// import 'package:video_player/video_player.dart';

import '../../pagination/controller_class.dart';
import '../../utils/asset_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/txt_style.dart';
import '../../widgets/audio_class_model.dart';
import '../blog/blogDetails_screen.dart';
import '../video_details/videoDetail_screen.dart';
import 'homepage_testimg.dart';

class Homepage_screen extends StatefulWidget {
  const Homepage_screen({Key? key}) : super(key: key);

  @override
  _Homepage_screenState createState() => _Homepage_screenState();
}

class _Homepage_screenState extends State<Homepage_screen> {
  final _homepage_screen_controller = Get.put(homepage_screen_controller());

  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  final home_controller = homepage_screen_controller();

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.reference().child("Posts");
    // setupPlaylist(Url);
    getData();
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    super.initState();
  }

  var dbRef;

  // final dbRef = FirebaseDatabase.instance.reference().child("Posts");
  Future<DataSnapshot>? event;
  Query? query;
  List lists_videos = [];
  List lists_images = [];
  List lists_audio = [];

  // List home_controller.final_data_list = [];
  String uri =
      'https://firebasestorage.googleapis.com/v0/b/shree-gokulesh-sharan.appspot.com/o/audios%2F2022-03-21%2014%3A48%3A29.816875?alt=media&token=ae52b076-22c4-4cf0-a8e6-7ad83a9437a0';

  setupPlaylist(int i) async {
    debugPrint("i111111111111");
    debugPrint(i.toString());
    await audioPlayer.open(Audio(AssetUtils.aud_test1),
        autoStart: false,
        playInBackground: PlayInBackground.disabledRestoreOnForeground);
  }

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getMoreData(list.length);
  }

  List<FeedModel> list_firebase = [];

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
        list_firebase.add(vartest);
      });
      setState(() {
        isLoading = false;
      });
      print(list_firebase);
      print(list_firebase.length);
      // print(values);
    });
    await _getMoreData(list.length);
  }

  Future<List<FeedModel>> getPostList(int index) async {
    debugPrint("data.length.toString()");

    debugPrint(list_firebase.length.toString());
    print(index);
    List<FeedModel> l = [];
    for (var i = index; i < index + 5 && i < list_firebase.length; i++) {
      l.add(list_firebase[i]);
    }
    debugPrint("l.length.toString()");
    debugPrint(l.length.toString());
    await Future.delayed(Duration(microseconds: 50));
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

  bool playing = false;

  String long_text =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

  Widget circularAudioPlayer(
      RealtimePlayingInfos realtimePlayingInfos, double screenWidth) {
    return CircularPercentIndicator(
      arcType: ArcType.FULL,
      backgroundColor: ColorUtils.primary,
      // fillColor:primaryColor ,
      progressColor: ColorUtils.orangeLight,
      radius: 20,
      center: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        color: ColorUtils.white,
        iconSize: 20,
        icon: Padding(
          padding: EdgeInsets.zero,
          child: Icon(realtimePlayingInfos.isPlaying
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded),
        ),
        onPressed: () => audioPlayer.playOrPause(),
      ),
      percent: realtimePlayingInfos.currentPosition.inSeconds /
          realtimePlayingInfos.duration.inSeconds,
    );
  }

  var new_one;

  final forceUpdateController = Get.find<ForceUpdateController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    debugPrint(
        'Force Update Value ${forceUpdateController.forceUpdateTitle.value}');
    debugPrint(
        'Force Update Value ${forceUpdateController.forceUpdateMessage.value}');
    debugPrint(
        'Force Update Value ${forceUpdateController.isAndroidForceUpdate.value}');
    debugPrint(
        'Force Update Value ${forceUpdateController.isIosForceUpdate.value}');
    return GetBuilder<homepage_screen_controller>(
      init: _homepage_screen_controller,
      builder: (ctx) {
        return Stack(
          children: <Widget>[
            Scaffold(
              key: _globalKey,
              drawer: DrawerScreen(),
              body: back_image(
                body_container: Container(
                    margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
                    child: CustomScrollView(
                      controller: _controller,
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Column(
                                children: [
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
                                    child: (list[index].fileType.toString() ==
                                            'Video'
                                        ? GestureDetector(
                                            onTap: () {
                                              print('tapped');
                                              // audioPlayer.pause();
                                              // MaterialPageRoute>Na
                                              Get.to(VideoDetails(
                                                video_url:
                                                    list[index].path.toString(),
                                                video_title: list[index]
                                                    .title
                                                    .toString(),
                                                video_subtitle: list[index]
                                                    .description
                                                    .toString(),
                                              ));
                                              // Get.toNamed(BindingUtils.video_route);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
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
                                                            color: Color(
                                                                0x17000000),
                                                            blurRadius: 10.0,
                                                            offset: Offset(
                                                                0.0, 0.75),
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
                                                            color: ColorUtils
                                                                .white,
                                                            child: ListTile(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              // tileColor: ColorUtils.orangeBack,
                                                              leading: SizedBox(
                                                                height: 50,
                                                                child:
                                                                    Container(
                                                                  // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                                                  child:
                                                                      IconButton(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            0.0),
                                                                    // iconSize: 50,
                                                                    icon: Image
                                                                        .asset(
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
                                                                    fontWeight:
                                                                        FWT.semiBold),
                                                              ),
                                                              subtitle: Text(
                                                                list[index]
                                                                    .description,
                                                                style: FontStyleUtility.h12(
                                                                    fontColor: ColorUtils
                                                                        .black
                                                                        .withOpacity(
                                                                            0.6),
                                                                    fontWeight:
                                                                        FWT.semiBold),
                                                              ),
                                                              trailing: SizedBox
                                                                  .shrink(),
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
                                        : (list[index].fileType.toString() ==
                                                'images'
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: list[index]
                                                              .path
                                                              .toString(),
                                                          fit: BoxFit.contain,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Container(
                                                                  height: 100,
                                                                  child: Container(
                                                                      margin: EdgeInsets.symmetric(vertical: 30),
                                                                      child: CircularProgressIndicator(
                                                                        color: ColorUtils
                                                                            .primary,
                                                                      ))),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                        // Image.network(
                                                        //   list[index].path.toString(),
                                                        //   fit: BoxFit.contain,
                                                        // )
                                                      ),
                                                      Container(
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
                                                                    new EdgeInsets
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
                                                                .description
                                                                .toString(),
                                                            style: FontStyleUtility.h12(
                                                                fontColor: ColorUtils
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : (list[index]
                                                        .fileType
                                                        .toString() ==
                                                    'Audio'
                                                ? AudioListingscreen(
                                                    audio_url: list[index].path,
                                                    subtitle:
                                                        list[index].description,
                                                    title: list[index].title,
                                                  )
                                                : (list[index]
                                                            .fileType
                                                            .toString() ==
                                                        'Blog'
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: ColorUtils
                                                                .white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: ExpansionTile(
                                                          tilePadding:
                                                              EdgeInsets.zero,
                                                          childrenPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  bottom: 15),
                                                          textColor:
                                                              ColorUtils.black,
                                                          initiallyExpanded:
                                                              true,
                                                          leading: SizedBox(
                                                            height: 50,
                                                            child: Container(
                                                              // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                                              child: IconButton(
                                                                padding:
                                                                    new EdgeInsets
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
                                                                .description
                                                                .toString(),
                                                            style: FontStyleUtility.h12(
                                                                fontColor: ColorUtils
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontWeight: FWT
                                                                    .semiBold),
                                                          ),
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(
                                                                    Blog_details_screen(
                                                                  Blog_title: list[
                                                                          index]
                                                                      .title
                                                                      .toString(),
                                                                  Blog_subtitle: list[
                                                                          index]
                                                                      .description
                                                                      .toString(),
                                                                  Blog_content: list[
                                                                          index]
                                                                      .description
                                                                      .toString(),
                                                                ));
                                                              },
                                                              child: Text(
                                                                list[index]
                                                                    .description
                                                                    .toString(),
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style: FontStyleUtility.h14(
                                                                    fontColor:
                                                                        ColorUtils
                                                                            .black,
                                                                    fontWeight:
                                                                        FWT.lightBold),
                                                              ),
                                                            ),
                                                          ],
                                                          trailing:
                                                              const SizedBox
                                                                  .shrink(),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          print('tapped');
                                                          // audioPlayer.pause();
                                                          // MaterialPageRoute>Na
                                                          Get.to(VideoDetails(
                                                            video_url:
                                                                list[index]
                                                                    .path
                                                                    .toString(),
                                                            video_title:
                                                                list[index]
                                                                    .title
                                                                    .toString(),
                                                            video_subtitle:
                                                                list[index]
                                                                    .description
                                                                    .toString(),
                                                          ));
                                                          // Get.toNamed(BindingUtils.video_route);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10),
                                                          width:
                                                              screenSize.width,
                                                          height: (screenSize
                                                                      .height *
                                                                  0.33)
                                                              .ceilToDouble(),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                DecoratedBox(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Color(
                                                                            0x17000000),
                                                                        blurRadius:
                                                                            10.0,
                                                                        offset: Offset(
                                                                            0.0,
                                                                            0.75),
                                                                      ),
                                                                    ],
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(list[
                                                                              index]
                                                                          .tPath
                                                                          .toString()),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  child: Container(
                                                                      alignment: FractionalOffset.bottomLeft,
                                                                      // margin: EdgeInsets.only(top: 50),
                                                                      child: Container(
                                                                        color: ColorUtils
                                                                            .white,
                                                                        child:
                                                                            ListTile(
                                                                          contentPadding:
                                                                              EdgeInsets.zero,
                                                                          // tileColor: ColorUtils.orangeBack,
                                                                          leading:
                                                                              SizedBox(
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Container(
                                                                              // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                                                              child: IconButton(
                                                                                padding: const EdgeInsets.all(0.0),
                                                                                // iconSize: 50,
                                                                                icon: Image.asset(
                                                                                  AssetUtils.reddit_png,
                                                                                ),
                                                                                onPressed: () {},
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            list[index].title.toString(),
                                                                            style:
                                                                                FontStyleUtility.h16(fontColor: ColorUtils.black, fontWeight: FWT.semiBold),
                                                                          ),
                                                                          subtitle:
                                                                              Text(
                                                                            list[index].title.toString(),
                                                                            style:
                                                                                FontStyleUtility.h12(fontColor: ColorUtils.black.withOpacity(0.6), fontWeight: FWT.semiBold),
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
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/png/player.png',
                                                                      height:
                                                                          150,
                                                                      width:
                                                                          150,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ))))),
                                  )

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
                          child: isEnd
                              ? Text('End')
                              : CircularProgressIndicator(
                                  color: ColorUtils.primary),
                        )),
                      ],
                    )),
              ),
            ),
            (forceUpdateController.isAndroidForceUpdate.value == true)
                ? Positioned(
                    top: 0.0,
                    bottom: 0.0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        color: Colors.white24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              height: screenSize.height * 0.35,
                              width: screenSize.width,
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 15.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: screenSize.height * 0.04,
                                  ),
                                  Text(
                                    forceUpdateController.forceUpdateTitle.value
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sf_normal",
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.04,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(
                                      forceUpdateController
                                          .forceUpdateMessage.value
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "sf_normal",
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    child: ButtonTheme(
                                      height: 45,
                                      minWidth: double.infinity,
                                      child: RaisedButton(
                                        color: HexColor('#F76E11'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        onPressed: () {},
                                        child: const Text(
                                          'Update',
                                          style: TextStyle(
                                            fontFamily: "sf_normal",
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    child: Container(),
                  ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController!.dispose();

    audioPlayer.dispose();
  }
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
