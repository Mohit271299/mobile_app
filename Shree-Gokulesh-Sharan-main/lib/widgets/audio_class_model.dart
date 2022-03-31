import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/asset_utils.dart';
import '../utils/color_utils.dart';
import '../utils/txt_style.dart';

class AudioListingscreen extends StatefulWidget {
  final String audio_url;
  final String title;
  final String subtitle;

  const AudioListingscreen(
      {Key? key,
      required this.audio_url,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  _AudioListingscreenState createState() => _AudioListingscreenState();
}

class _AudioListingscreenState extends State<AudioListingscreen> {
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  var dbRef;

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.reference().child("Posts");
    init();
    super.initState();
  }

  init() async {
    // await getData();
    setupPlaylist();
  }

  Future setupPlaylist() async {
    await audioPlayer.open(Audio.network(widget.audio_url),
        autoStart: false,
        playInBackground: PlayInBackground.disabledRestoreOnForeground);
  }

  DatabaseReference? _databaseReference;
  Future<DataSnapshot>? event;
  Query? query;
  List workshopList = [];
  List final_list = [];
  List<Audio> audio_file = [];

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

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController!.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: ColorUtils.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        // visualDensity: const VisualDensity(vertical: 0.0, horizontal: -4.0),
        contentPadding: EdgeInsets.zero,
        // contentPadding: EdgeInsets.zero,
        // tileColor: ColorUtils.orangeBack,
        leading: SizedBox(
          height: 50,
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              // iconSize: 50,
              icon: Image.asset(
                AssetUtils.reddit_png,
              ),
              onPressed: () {},
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.black, fontWeight: FWT.semiBold),
        ),
        subtitle: Text(
          widget.subtitle,
          style: FontStyleUtility.h12(
              fontColor: ColorUtils.black.withOpacity(0.6),
              fontWeight: FWT.semiBold),
        ),
        trailing: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: audioPlayer.builderRealtimePlayingInfos(
                builder: (context, realtimePlayingInfos) {
              if (realtimePlayingInfos != null) {
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorUtils.primary,
                    ),
                    child: circularAudioPlayer(
                        realtimePlayingInfos, screenSize.width));
              } else {
                return Container();
              }
            })),
      ),
    );
  }
}
