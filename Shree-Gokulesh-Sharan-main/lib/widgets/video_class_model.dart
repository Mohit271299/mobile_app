import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class videoPlayer extends StatefulWidget {
  final String? video_file_path;
  final String? video_url;

  const videoPlayer({Key? key, this.video_file_path, this.video_url})
      : super(key: key);

  @override
  _videoPlayerState createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {
  @override
  void initState() {
    // video_code();
    // better_player_file();
    init();
    super.initState();
  }

  bool playing = false;

  init() {
    (widget.video_url != null ? better_player_url() : better_player_file());
  }

  // video_code() {
  //   _videoPlayerController = VideoPlayerController.asset(AssetUtils.vid_test)
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _videoPlayerController!.play();
  //       playing = true;
  //     });
  // }

  BetterPlayerController? _betterPlayerController;

  better_player_file() async {
    print("widget.video_url");
    print(widget.video_file_path);

    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file, widget.video_file_path!,
        useAsmsSubtitles: true, useAsmsTracks: true);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController!.setupDataSource(dataSource);
  }

  better_player_url() async {
    print("widget.video_url");
    print(widget.video_file_path);

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(controller: _betterPlayerController!),
      ),
    );
  }
}
