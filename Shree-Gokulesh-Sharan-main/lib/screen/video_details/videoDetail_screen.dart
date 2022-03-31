import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/pagination/controller_class.dart';
import 'package:vaishnav_parivar/pagination/route_name.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/txt_style.dart';
// import 'package:video_player/video_player.dart';

import '../../utils/asset_utils.dart';
import '../../utils/color_utils.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/video_class_model.dart';

class VideoDetails extends StatefulWidget {
  final String? video_url;
  final String? video_title;
  final String? video_subtitle;

  const VideoDetails(
      {Key? key,
      this.video_url,
      this.video_title,
      this.video_subtitle,})
      : super(key: key);

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails>
    with SingleTickerProviderStateMixin {
  final _video_screen_controller = Get.put(video_screen_controller());
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  // VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    // video_code();
    better_player_code();
    super.initState();
  }

  bool playing = false;

  // video_code() {
  //   _videoPlayerController = VideoPlayerController.asset(AssetUtils.vid_test)
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _videoPlayerController!.play();
  //       playing = true;
  //     });
  // }

  BetterPlayerController? _betterPlayerController;

  better_player_code() async {
    print("widget.video_url");
    print(widget.video_url);


    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );

      BetterPlayerDataSource dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, widget.video_url!,
          useAsmsSubtitles: true, useAsmsTracks: true);

      _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
      _betterPlayerController!.setupDataSource(dataSource);



  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<video_screen_controller>(
        init: _video_screen_controller,
        builder: (ctx) {
          return Scaffold(
            key: globalKey,
            extendBodyBehindAppBar: true,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: custom_appbar(
                title: 'Video',
                backRoute: BindingUtils.dashboard_route,
                back: AssetUtils.drawer_back,
              ),
            ),
            body: back_image(
              body_container: Container(
                height: screenSize.height,
                margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: (screenSize.height * 0.118)),
                      SizedBox(
                        height: 20,
                      ),
                      videoPlayer(video_url: widget.video_url),
                      SizedBox(
                          height: (screenSize.height * 0.02)
                              .ceilToDouble()),
                      Container(
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
                              "${widget.video_title}",
                              style: FontStyleUtility.h16(
                                  fontColor: ColorUtils.black,
                                  fontWeight: FWT.semiBold),
                            ),
                            subtitle: Text(
                              "${widget.video_subtitle}",
                              style: FontStyleUtility.h12(
                                  fontColor: ColorUtils.black
                                      .withOpacity(0.6),
                                  fontWeight: FWT.semiBold),
                            ),
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiamturpis molestie dictum est a, mattis tellus. Sed dignissim, metusnec fringilla accumsan, risus sem sollicitudin lacus, ut interdumtellus elit sed risus. Maecenas eget condimentum velit, sit ametfeugiat lectus. Class aptent taciti sociosqu ad litora torquent perconubia nostra, per inceptos himenaeos. Praesent auctor purusluctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhocus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabiturvel bibendum lorem. Morbi convallis convallis diam sit ametlacinia. Aliquam in elementum tellus.",
                                maxLines: 5,
                                textAlign: TextAlign.justify,
                                style: FontStyleUtility.h14(
                                    fontColor: ColorUtils.black,
                                    fontWeight: FWT.lightBold),
                              ),
                            ],
                            trailing: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
          );
        });

  }
  Widget file_path_widget(){
  final  screenSize  = MediaQuery.of(context).size;
    return  Column(
      children: [
        SizedBox(height: (screenSize.height * 0.118)),
        SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
                controller: _betterPlayerController!),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // _videoPlayerController!.dispose();
    _betterPlayerController!.dispose();
    super.dispose();
  }
}
