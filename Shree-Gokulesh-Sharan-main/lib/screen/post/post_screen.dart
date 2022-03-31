import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

//
// import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vaishnav_parivar/services/service.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/loader/page_loader.dart';
import 'package:vaishnav_parivar/utils/txt_file.dart';

import '../../Common/toast_util.dart';
import '../../pagination/controller_class.dart';
import '../../pagination/route_name.dart';
import '../../utils/asset_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/txt_style.dart';
import '../../widgets/custom_feild_box.dart';
import '../../widgets/video_class_model.dart';
import '../dashboard/dashboard_screen.dart';
import '../video_details/videoDetail_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  PageController? _pageController;

  final _post_screen_controller = Get.put(post_screen_controller());
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  bool initialized = false;

  TextEditingController Image_title_controller = new TextEditingController();
  TextEditingController Image_description_controller =
      new TextEditingController();

  TextEditingController Video_description_controller =
      new TextEditingController();
  TextEditingController Video_title_controller = new TextEditingController();

  TextEditingController Audio_description_controller =
      new TextEditingController();
  TextEditingController Audio_title_controller = new TextEditingController();

  TextEditingController Blog_description_controller =
      new TextEditingController();
  TextEditingController Blog_title_controller = new TextEditingController();
  TextEditingController Blog_content_controller = new TextEditingController();

  // TextEditingController Video_description_controller = new TextEditingController();

  @override
  void initState() {
    _fetchAssets();
    _pageController = PageController(initialPage: 0, keepPage: false);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {});
  }

  // void _showDialog() {
  //   // flutter defined function
  //   ElevatedButton(
  //     onPressed: () async {
  //       final permitted = await PhotoManager.requestPermission();
  //       if (!permitted) return;
  //      ;
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(builder: (_) => Gallery()),
  //       // );
  //     },
  //     child: Text('Open Gallery'),
  //   );
  // }

  List<AssetEntity> assets = [];

  var data_type = PhotoManager.getImageAsset();
  PermissionStatus? _permissionStatus;

  _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    // final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final albums = await data_type;
    final recentAlbum = albums.first;
    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );
    // Update the state and notify UI
    setState(() => assets = recentAssets);
  }

  _permission() async {
    _permissionStatus = await Permission.storage.status;

    if (_permissionStatus != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      setState(() {
        _permissionStatus = permissionStatus;
      });
    }
    setState(() {});
  }

  List data_list = ["Images", "Videos"];
  String selected_data_type = "Images";
  BoxFit fitting = BoxFit.scaleDown;
  var ImgB64Decoder;

  // VideoPlayerController? _controller;

  // Future<VideoPlayerController> video() async {
  //   print("object");
  //   final File file = File(_post_screen_controller.file_selected_video!.path);
  //   _controller = VideoPlayerController.file(file);
  //   await _controller!.initialize();
  //   await _controller!.setLooping(true);
  //   print("_controller");
  //   print("controller");
  //   print(_controller);
  //   return _controller!;
  // }

  @override
  dispose() {
    hideLoader(context);
    // _controller!.dispose();
    super.dispose();
  }

  bool audio = false;
  bool video = false;
  bool image = true;
  bool blog = false;

  static File? select_image_file;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leadingWidth: 400,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: Center(
            // margin: EdgeInsets.only(left: 20,top: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));

              },
              child: GestureDetector(
                onTap: (){
                  clear();
                },
                child: Text(
                  'Cancel',
                  style: FontStyleUtility.h16(
                      fontColor: ColorUtils.black, fontWeight: FWT.medium),
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            txt_utils.drawer_post,
            style: FontStyleUtility.h16(
                fontColor: ColorUtils.black, fontWeight: FWT.medium),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _post_screen_controller.pageIndexUpdate('02');
                  _pageController!.jumpToPage(1);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Next',
                    style: FontStyleUtility.h16(
                        fontColor: ColorUtils.primary, fontWeight: FWT.medium),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: back_image(
        body_container: Container(
          margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
          child: GetBuilder<post_screen_controller>(
            init: _post_screen_controller,
            builder: (_) {
              return PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      SizedBox(height: (screenSize.height * 0.118)),
                      Obx(
                        () => Container(
                            height: screenSize.height / 3,
                            width: screenSize.width,
                            child: (_post_screen_controller.selected_item.value
                                        .toString() ==
                                    'Image'
                                ?
                                // Image.memory(
                                //         Uint8List.fromList(_post_screen_controller
                                //             .file_selected_image.codeUnits),
                                //         fit: fitting,
                                //       )
                                Image.file(
                                    File(_post_screen_controller
                                        .image_original_path.value
                                        .toString()),
                                    fit: fitting,
                                  )
                                // Text(
                                //     File(_post_screen_controller
                                //             .file_orignal_path.value)
                                //         .toString(),
                                //   )
                                : (_post_screen_controller.selected_item.value
                                            .toString() ==
                                        'Video'
                                    ? const Center(
                                        child: Text('Video selected'),
                                      )
                                    // ClipRRect(
                                    //             borderRadius: BorderRadius.circular(10),
                                    //             child: AspectRatio(
                                    //               aspectRatio: 16 / 9,
                                    //               child: BetterPlayer(
                                    //                   controller:
                                    //                       _post_screen_controller
                                    //                           .playerController!),
                                    //             ),
                                    //           )
                                    : Container(
                                        child: Center(
                                            child: Image.asset(
                                                AssetUtils.gallery_png,height: 60,)))))),
                      ),
                      // Container(
                      //   alignment: Alignment.bottomRight,
                      //   child: IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         (fitting == BoxFit.scaleDown
                      //             ? fitting = BoxFit.fitWidth
                      //             : (fitting == BoxFit.fitWidth
                      //                 ? fitting = BoxFit.scaleDown
                      //                 : fitting = BoxFit.scaleDown));
                      //         // fitting = BoxFit.fitWidth;
                      //       });
                      //     },
                      //     icon: const Icon(Icons.check_box_outline_blank),
                      //   ),
                      // ),
                      Expanded(
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            // A grid view with 3 items per row
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 4,
                          ),
                          itemCount: assets.length,
                          itemBuilder: (_, index) {
                            return AssetThumbnail(asset: assets[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                  (_post_screen_controller.selected_item.value.toString() ==
                          'Image'
                      ? image_post()
                      : (_post_screen_controller.selected_item.value
                                  .toString() ==
                              'Video'
                          ? video_post()
                          : (_post_screen_controller.selected_item.value
                                      .toString() ==
                                  'Audio'
                              ? audio_post()
                              : (_post_screen_controller.selected_item.value
                                          .toString() ==
                                      'Blog'
                                  ? blog_post()
                                  : image_post()))))
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorUtils.white,
        height: 50,
        // margin: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // if (blog == true) {
                  //   _post_screen_controller.pageIndexUpdate('01');
                  //   _pageController!.jumpToPage(0);
                  // }
                  setState(() {
                    audio = true;
                    video = false;
                    image = false;
                    blog = false;
                  });
                  _post_screen_controller.pageIndexUpdate('01');
                  _pageController!.jumpToPage(0);
                  _openFileExplorer_audio();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Audio",
                      style: FontStyleUtility.h14(
                          fontColor: (audio == true
                              ? ColorUtils.primary
                              : ColorUtils.black),
                          fontWeight: FWT.lightBold)),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // if (blog == true) {
                  //   _post_screen_controller.pageIndexUpdate('01');
                  //   _pageController!.jumpToPage(0);
                  // }
                  setState(() {
                    image = true;
                    video = false;
                    audio = false;
                    blog = false;
                  });
                  data_type = PhotoManager.getImageAsset();

                  _fetchAssets();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Photo",
                      style: FontStyleUtility.h14(
                          fontColor: (image == true
                              ? ColorUtils.primary
                              : ColorUtils.black),
                          fontWeight: FWT.lightBold)),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // if (blog == true) {
                  //   _post_screen_controller.pageIndexUpdate('01');
                  //   _pageController!.jumpToPage(0);
                  // }
                  setState(() {
                    video = true;
                    image = false;
                    audio = false;
                    blog = false;
                  });

                  data_type = PhotoManager.getVideoAsset();
                  // _fetchAssets();
                  _openFileExplorer_video();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Video",
                      style: FontStyleUtility.h14(
                          fontColor: (video == true
                              ? ColorUtils.primary
                              : ColorUtils.black),
                          fontWeight: FWT.lightBold)),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _post_screen_controller.selected_item.value = 'Blog';
                    blog = true;
                    audio = false;
                    image = false;
                    video = false;
                    _post_screen_controller.pageIndexUpdate('02');
                    _pageController!.jumpToPage(1);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Blog",
                      style: FontStyleUtility.h14(
                          fontColor: (blog == true
                              ? ColorUtils.primary
                              : ColorUtils.black),
                          fontWeight: FWT.lightBold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _audio = false;
  bool _video = false;
  bool _thumb = false;
  PlatformFile? audio_file;
  PlatformFile? video_file;
  PlatformFile? thumb_file;
  var thumb_image;
  File? date;

  void _openFileExplorer_audio() async {
    setState(() => _audio = true);
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.audio);
      audio_file = result?.files.first;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    print('size: ${audio_file!.size}');
    print('path: ${audio_file!.path}');
    print('extention: ${audio_file!.extension}');
    if (_audio) {
      _post_screen_controller.selected_item.value = "Audio";
      _post_screen_controller.Aud_postType.value = 'Audio';
      _post_screen_controller.Aud_fileType.value = 'Audio';
      _post_screen_controller.Aud_size.value = audio_file!.size.toString();
      _post_screen_controller.Aud_path.value = audio_file!.path.toString();

      _post_screen_controller.Aud_datetime.value = DateFormat.yMMMMd().format(now);
      _post_screen_controller.Aud_tPath.value = audio_file!.path.toString();

      _post_screen_controller.pageIndexUpdate('02');
      _pageController!.jumpToPage(1);
    }
    // if (!mounted) return;
    // setState(() {
    //   isLoadingPath = false;
    //   fileName =  path!.split('/').last ;
    // });
  }

  DateTime now = DateTime.now();

  void _openFileExplorer_video() async {
    setState(() => _video = true);
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video);
      video_file = result?.files.first;
      date = File(video_file!.path!);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    print('size: ${video_file!.size}');
    print('path: ${video_file!.path}');
    print('extention: ${video_file!.extension}');
    if (_video) {
      _post_screen_controller.selected_item.value = "Video";
      _post_screen_controller.vid_postType.value = 'Video';
      _post_screen_controller.vid_fileType.value = 'Video';
      _post_screen_controller.vid_size.value = video_file!.size.toString();
      _post_screen_controller.vid_path.value = video_file!.path.toString();
      _post_screen_controller.vid_datetime.value = DateFormat.yMMMMd().format(now);
      _post_screen_controller.vid_tPath.value = video_file!.path.toString();

      _post_screen_controller.pageIndexUpdate('02');
      _pageController!.jumpToPage(1);
    }
    // if (!mounted) return;
    // setState(() {
    //   isLoadingPath = false;
    //   fileName =  path!.split('/').last ;
    // });
  }

  void _openFileExplorer_video_thumbnail() async {
    setState(() => _thumb = true);
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      thumb_file = result?.files.first;
      thumb_image = File(thumb_file!.path!);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    print('size: ${thumb_file!.size}');
    print('path: ${thumb_file!.path}');
    print('extention: ${thumb_file!.extension}');
    if (_thumb) {
      _post_screen_controller.pageIndexUpdate('02');
      _pageController!.jumpToPage(1);
    }
    // if (!mounted) return;
    // setState(() {
    //   isLoadingPath = false;
    //   fileName =  path!.split('/').last ;
    // });
  }

  Widget image_post() {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [

            Obx(
              () => Container(
                  margin: EdgeInsets.only(top: 100),
                  height: screenSize.height / 3,
                  width: screenSize.width,
                  child: (_post_screen_controller.file_selected_image.value
                              .toString() !=
                          '_')
                      ? Image.file(
                          File(_post_screen_controller.image_original_path.value
                              .toString()),
                          fit: BoxFit.contain,
                        )
                      : const Text('no image found')),
            ),
            // SizedBox(
            //   height: screenSize.height * 0.059,
            // ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: custom_login_feild(
                controller: Image_title_controller,
                backgroundColor: ColorUtils.white,
                labelText: 'Enter Your title',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 100,
              child: custom_login_feild(
                controller: Image_description_controller,
                maxLines: 4,
                backgroundColor: ColorUtils.white,
                labelText: 'Say something about this photo',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: custom_button(
                title: 'Post',
                onTap: () async {
                  setState(() {
                    _post_screen_controller.Img_title.value =
                        Image_title_controller.text.toString();
                    _post_screen_controller.Img_description.value =
                        Image_description_controller.text.toString();
                  });

                  // await Post_firebase_storage();
                  await upload_image_file();
                  await Post_firebase();
                  await clear();
                  // Get.offAllNamed(BindingUtils.dashboard_route);
                  _post_screen_controller.pageIndexUpdate('01');
                  _pageController!.jumpToPage(0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  clear() {
    _post_screen_controller.selected_item.value = '_';
  }

  Widget video_post() {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: videoPlayer(video_file_path: video_file!.path!),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 15),
            //   child: Center(
            //       child: Text('File Name: ${video_file!.name}'
            //           '${video_file!.extension}')),
            // ),
            // SizedBox(
            //   height: screenSize.height * 0.059,
            // ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: custom_login_feild(
                controller: Video_title_controller,
                backgroundColor: ColorUtils.white,
                labelText: 'Enter Your title',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 100,
              child: custom_login_feild(
                controller: Video_description_controller,
                maxLines: 4,
                backgroundColor: ColorUtils.white,
                labelText: 'Say something about this photo',
              ),
            ),

            (thumb_file == null
                ? Row(
              mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 15, right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.primary,
                            ),
                            onPressed: () {
                              _openFileExplorer_video_thumbnail();
                            },
                            child: Text('Add Thumbnail'),
                          )),

                    ],
                  )
                : Container(
              margin: EdgeInsets.only(top: 15),
                    child: Image.file(thumb_image,height: 100,width: 100,),
                  )),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: custom_button(
                title: 'Post',
                onTap: () async {
                  setState(() {
                    _post_screen_controller.vid_description.value =
                        Video_description_controller.text.toString();
                    _post_screen_controller.vid_title.value =
                        Video_title_controller.text.toString();
                  });
                  await upload_video_file();
                  await upload_thumbnail_file();
                  await Post_firebase();
                  await clear();
                  _post_screen_controller.pageIndexUpdate('01');
                  _pageController!.jumpToPage(0);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget audio_post() {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 100),
                height: screenSize.height / 5,
                width: screenSize.width,
                child: Center(
                    child: Text('File Name: ${audio_file!.name}'
                        '${audio_file!.extension}'))),

            // SizedBox(
            //   height: screenSize.height * 0.059,
            // ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: custom_login_feild(
                controller: Audio_title_controller,
                backgroundColor: ColorUtils.white,
                labelText: 'Enter Your title',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 100,
              child: custom_login_feild(
                controller: Audio_description_controller,
                maxLines: 4,
                backgroundColor: ColorUtils.white,
                labelText: 'Say something about this photo',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: custom_button(
                title: 'Post',
                onTap: () async {
                  setState(() {
                    _post_screen_controller.Aud_title.value =
                        Audio_title_controller.text.toString();
                    _post_screen_controller.Aud_description.value =
                        Audio_description_controller.text.toString();
                  });
                  await upload_audio_file();
                  await Post_firebase();
                  await clear();
                  _post_screen_controller.pageIndexUpdate('01');
                  _pageController!.jumpToPage(0);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget blog_post() {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: (screenSize.height * 0.1).ceilToDouble()),
          // SizedBox(
          //   height: screenSize.height * 0.059,
          // ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: custom_login_feild(
              controller: Blog_title_controller,
              backgroundColor: ColorUtils.white,
              labelText: 'Enter Your title',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: custom_login_feild(
              controller: Blog_description_controller,
              backgroundColor: ColorUtils.white,
              labelText: 'Enter Your Sub-title',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            height: 100,
            child: custom_login_feild(
              controller: Blog_content_controller,
              maxLines: 4,
              backgroundColor: ColorUtils.white,
              labelText: 'Content',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: custom_button(
              title: 'Post',
              onTap: () async {
                await Post_firebase();
                await clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));
                _post_screen_controller.pageIndexUpdate('01');
                _pageController!.jumpToPage(0);
              },
            ),
          ),
        ],
      ),
    );
  }

  // FirebaseStorage storage =
  //      FirebaseStorage.instance;

  // Post_firebase_storage() async {
  //   debugPrint('insde storage');
  //   File final_file = File(_post_screen_controller.file_selected_image.value);
  //
  //   // final ref =firebase_storage.FirebaseStorage.instance.ref('files/');
  //
  //   // ref.putFile(final_file);
  //
  //   // File? finalFile = _post_screen_controller.image_file;
  //   // debugPrint(finalFile.toString());
  //   // File image = File(AssetUtils.back_png);
  //   // _storageReference = firebase_storage.Reference.FirebaseStorage.instance;
  //
  //   // firebase_storage.FirebaseStorage.instance
  //   //     .ref()
  //   //     .child("final_file")
  //   //     .child(image.path)
  //   //     .putFile(image);
  //
  //
  //
  //   // await firebase_storage.FirebaseStorage.instance
  //   //     .ref()
  //   //     .child('img---')
  //   //     .putFile(finalFile!);
  //
  //   // var stored_file = await _storageReference.ref().child('png').child('File-1').putFile(final_file);
  //   //  var url =  done.;
  //   print("url -------`");
  //   // print(url);
  //   debugPrint('outside storage');
  // }

  FirebaseStorage storage = FirebaseStorage.instance;
  var Image_url;
  var Video_url;
  var Audio_url;
  var thumbnail_url;

  Future upload_image_file() async {
    showLoader(context);
    String pickedImage =
        _post_screen_controller.Img_base64String.value.toString();

    String picked_image_title =
        _post_screen_controller.Img_basetitle.value.toString();
    print(_post_screen_controller.file_selected_image.value.toString());
    final String fileName = path.basename(pickedImage.substring(0, 10));
    debugPrint("pickedImage");
    debugPrint(pickedImage.toString());
    debugPrint(pickedImage.split('/').last.toString());
    File imageFile =
        File(_post_screen_controller.image_original_path.value.toString());

    try {
      print("Iside!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // Uploading the selected image with some custom meta data
      Reference ref = await storage.ref("images/").child(
          picked_image_title.split('/').last.toString() +
              DateTime.now().toString());
      await ref.putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));

      Image_url = await ref.getDownloadURL();
      print("url.toString()");
      print(Image_url);
      // Refresh the UI
      Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));

      hideLoader(context);
    } on FirebaseException catch (error) {
      hideLoader(context);
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future upload_video_file() async {
    showLoader(context);
    File pickedvideo = File(video_file!.path!);

    // String picked_image_title = _post_screen_controller.Vid_basetitle.value.toString();
    // print(_post_screen_controller.file_selected_image.value.toString());
    //   final String fileName = path.basename(pickedvideo.substring(0,10));

    debugPrint("pickedImage new_one");
    debugPrint(video_file!.path!);
    // debugPrint(pickedvideo.split('/').last.toString());
    // final videoFile = pickedvideo;
    try {
      print("Iside!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // Uploading the selected image with some custom meta data
      Reference ref =
          await storage.ref("videos/").child(DateTime.now().toString());
      await ref.putFile(
          pickedvideo,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));

      Video_url = await ref.getDownloadURL();
      print("url.toString()");
      print(Video_url);
      // Refresh the UI
      Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));

      hideLoader(context);
    } on FirebaseException catch (error) {
      hideLoader(context);
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future upload_audio_file() async {
    showLoader(context);
    File pickedaudio = File(audio_file!.path!);
    //
    // String picked_image_title = _post_screen_controller.Vid_basetitle.value.toString();
    // print(_post_screen_controller.file_selected_image.value.toString());
    //   final String fileName = path.basename(pickedvideo.substring(0,10));
    debugPrint("pickedImage");
    debugPrint(audio_file!.path!);
    debugPrint(audio_file.toString().split('/').last.toString());

    // final videoFile = pickedvideo;
    try {
      print("Iside!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      // Uploading the selected image with some custom meta data
      Reference ref =
          await storage.ref("audios/").child(DateTime.now().toString());
      await ref.putFile(
          pickedaudio,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));

      Audio_url = await ref.getDownloadURL();
      print("url.toString()");
      print(Audio_url);
      // Refresh the UI
      Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));

      hideLoader(context);
    } on FirebaseException catch (error) {
      hideLoader(context);
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future upload_thumbnail_file() async {
    showLoader(context);
    File pickedthumb = File(thumb_file!.path!);
    debugPrint("pickedImage new_one");
    debugPrint(thumb_file!.path!);
    try {
      debugPrint("Iside!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      Reference ref =
          await storage.ref("thumbnail/").child(DateTime.now().toString());
      await ref.putFile(
          pickedthumb,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));

      thumbnail_url = await ref.getDownloadURL();
      print("thumbnail_url.toString()");
      print(thumbnail_url);
      // Refresh the UI
      setState(() {
        _post_screen_controller.pageIndexUpdate('02');
        _pageController!.jumpToPage(1);
      });
      hideLoader(context);
    } on FirebaseException catch (error) {
      hideLoader(context);
      if (kDebugMode) {
        print(error);
      }
    }
  }

  DatabaseReference? _databaseReference;

  Post_firebase() async {
    showLoader(context);
    _databaseReference = await FirebaseDatabase.instance.reference();
    String key = _databaseReference!.child('Posts').push().key.trim();

    if (_post_screen_controller.selected_item.value == 'Image') {
      _databaseReference!.child('Posts').child(key).set({
        "id": key,
        "postType": _post_screen_controller.Img_postType.toString(),
        "fileType": _post_screen_controller.Img_fileType.toString(),
        "size": _post_screen_controller.Img_size.toString(),
        "path": Image_url.toString(),
        "title": _post_screen_controller.Img_title.toString(),
        "description": _post_screen_controller.Img_description.toString(),
        "datetime": _post_screen_controller.Img_datetime.toString(),
        "tPath": _post_screen_controller.Img_path.toString(),
      });
      if (_post_screen_controller.Img_postType.toString().isNotEmpty &&
          _post_screen_controller.Img_fileType.toString().isNotEmpty &&
          _post_screen_controller.Img_size.toString().isNotEmpty &&
          _post_screen_controller.Img_path.toString().isNotEmpty &&
          _post_screen_controller.Img_title.toString().isNotEmpty &&
          _post_screen_controller.Img_description.toString().isNotEmpty &&
          _post_screen_controller.Img_datetime.toString().isNotEmpty) {
        hideLoader(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));

        SendFCMNotification.sendFcmMessage(
            _post_screen_controller.Img_title.toString(),
            _post_screen_controller.Img_description.toString());
      } else {
        hideLoader(context);
        ToastUtils.showSuccess(message: 'Insufficeient details');
      }
    } else if (_post_screen_controller.selected_item.value == 'Video') {
      _databaseReference!.child('Posts').child(key).set({
        "id": key,
        "postType": _post_screen_controller.vid_postType.toString(),
        "fileType": _post_screen_controller.vid_fileType.toString(),
        "size": _post_screen_controller.vid_size.toString(),
        "path": Video_url.toString(),
        "title": _post_screen_controller.vid_title.toString(),
        "description": _post_screen_controller.vid_description.toString(),
        "datetime": _post_screen_controller.vid_datetime.toString(),
        "tPath": thumbnail_url.toString().toString(),
      });
      if (_post_screen_controller.vid_postType.toString().isNotEmpty &&
          _post_screen_controller.vid_fileType.toString().isNotEmpty &&
          _post_screen_controller.vid_size.toString().isNotEmpty &&
          _post_screen_controller.vid_path.toString().isNotEmpty &&
          _post_screen_controller.vid_title.toString().isNotEmpty &&
          _post_screen_controller.vid_description.toString().isNotEmpty &&
          _post_screen_controller.vid_datetime.toString().isNotEmpty) {
        hideLoader(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));

        SendFCMNotification.sendFcmMessage(
            _post_screen_controller.vid_title.toString(),
            _post_screen_controller.vid_description.toString());
      } else {
        hideLoader(context);
        ToastUtils.showSuccess(message: 'Insufficeient details');
      }
    } else if (_post_screen_controller.selected_item.value == 'Audio') {
      _databaseReference!.child('Posts').child(key).set({
        "id": key,
        "postType": _post_screen_controller.Aud_postType.toString(),
        "fileType": _post_screen_controller.Aud_fileType.toString(),
        "size": _post_screen_controller.Aud_size.toString(),
        "path": Audio_url.toString(),
        "title": _post_screen_controller.Aud_title.toString(),
        "description": _post_screen_controller.Aud_description.toString(),
        "datetime": _post_screen_controller.Aud_datetime.toString(),
        "tPath": _post_screen_controller.Aud_path.toString(),
      });
      if (_post_screen_controller.Aud_postType.toString().isNotEmpty &&
          _post_screen_controller.Aud_fileType.toString().isNotEmpty &&
          _post_screen_controller.Aud_size.toString().isNotEmpty &&
          _post_screen_controller.Aud_path.toString().isNotEmpty &&
          _post_screen_controller.Aud_title.toString().isNotEmpty &&
          _post_screen_controller.Aud_description.toString().isNotEmpty &&
          _post_screen_controller.Aud_datetime.toString().isNotEmpty) {
        hideLoader(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen()));
        SendFCMNotification.sendFcmMessage(
            _post_screen_controller.Aud_title.toString(),
            _post_screen_controller.Aud_description.toString());
      } else {
        hideLoader(context);
        ToastUtils.showSuccess(message: 'Insufficeient details');
      }
    } else if (_post_screen_controller.selected_item.value == 'Blog') {
      _databaseReference!.child('Posts').child(key).set({
        "id": key,
        "postType": 'Blogs',
        "fileType": 'Blog',
        "size": '',
        "path": '',
        "title": Blog_title_controller.text.toString(),
        "description": Blog_description_controller.text.toString(),
        "content": Blog_content_controller.text.toString(),
        "datetime": DateFormat.yMMMMd().format(now),
        "tPath": '',
      }).then((value) {
        // hideLoader(context);
        SendFCMNotification.sendFcmMessage(
            Blog_title_controller.text.toString(),
            Blog_description_controller.text.toString());
      });

      if (Blog_title_controller.text.toString().isNotEmpty &&
          Blog_description_controller.text.toString().isNotEmpty &&
          Blog_content_controller.text.toString().isNotEmpty) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => dashBoard_screen()));

        // SendFCMNotification.sendFcmMessage(
        //     Blog_title_controller.text.toString(),
        //     Blog_description_controller.text.toString());
      } else {
        hideLoader(context);
        ToastUtils.showSuccess(message: 'Insufficeient details');
      }
    }
  }
}

class AssetThumbnail extends StatelessWidget {
  AssetThumbnail({
    Key? key,
    required this.asset,
  }) : super(key: key);

  post_screen_controller poster = Get.find<post_screen_controller>();
  final AssetEntity asset;

  // BetterPlayerController? _betterPlayerController;

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // debugPrint("asset.title.toString()");
    // debugPrint("11111111 asset.title.toString()${asset.title.toString()}");
    // debugPrint("22222222 asset.title.toString() ${asset.relativePath.toString()}");
    // debugPrint('filepath ${asset.file.then((value) => print(value)).toString()}');
    // debugPrint(
    //     'origin path ${asset.originFile.then((value) =>
    //         print('Hellos ${value.toString()}')).toString()}');
    // debugPrint('URL ${asset.getMediaUrl().then((value) => print(value)).toString()}');
    // debugPrint(asset..toString());
    //
    // debugPrint(asset.type.toString());
    asset.originFile.then((value) {
      PostScreenState.select_image_file = value;
      poster.file_orignal_path.value =
          value.toString().split(' ').last.toString();
    });
    return FutureBuilder<Uint8List?>(
      future: asset.thumbData,
      builder: (widget, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          );
        } else {
          return InkWell(
            onTap: () {
              if (asset.type == AssetType.image) {
                // print("asset.file");
                // print(bytes);
                // debugPrint(snapshot.data.toString());
                // print(":Image pathhhhhhhhhhhhhhhhhh");
                // print(asset.relativePath);
                // print(asset.type.toString());
                // print(asset.createDateTime.toIso8601String());
                // print(asset.orientatedSize);
                poster.selected_item.value = 'Image';
                asset.originFile.then((value) {
                  PostScreenState.select_image_file = value;
                  poster.image_original_path.value = value!.path.toString();
                  debugPrint(
                      '00-00-00-00-00- Image Select Path ${poster.image_original_path.value.toString()}');
                  poster.file_orignal_path.value =
                      value.toString().split(' ').last.toString();
                  debugPrint('OnTapppp ${poster.file_orignal_path.value}');
                  debugPrint('OnTapppp ${PostScreenState.select_image_file}');
                });
                // poster.file_orignal_path.value = asset.originFile.then((value) { print(value.toString());).toString();
                debugPrint(
                    '1-1-1-1-1- Checked ${poster.file_orignal_path.value.toString()}');
                poster.file_selected_image.value = String.fromCharCodes(bytes);
                poster.Img_base64String.value = base64Encode(bytes);
                poster.Img_basetitle.value = asset.title.toString();
                print(poster.Img_base64String.value);
                print("poster.Img_basetitle.value");
                print(poster.Img_basetitle.value);
                // print("asset.relativePath");
                // final imageEncoded = base64.encode(bytes); // poster.image_file = asset.file.;
                // print(imageEncoded);
                // poster.image_file = imageEncoded;

                poster.Img_postType.value = 'Image';
                poster.Img_fileType.value = 'images';
                poster.Img_path.value = asset.relativePath.toString();
                poster.Img_datetime.value =  DateFormat.yMMMMd().format(now);
              } else {
                print("video.file");
                print(bytes);
                print(asset.file);
                poster.selected_item.value = 'Video';

                poster.file_selected_video.value = asset.file.toString();
                poster.Vid_ = File(asset.file.toString());
                // poster.videoFile = asset.file;

                poster.Vid_base64String.value = base64Encode(bytes);
                poster.Vid_basetitle.value = asset.title.toString();
                print(poster.Vid_base64String.value);
                print("poster.Img_basetitle.value");
                print(poster.Vid_basetitle.value);

                print("PostScreenState().video()");
                print(asset.file.toString());
                final video = asset.file.toString();
                final video1 = bytes;

                poster.vid_postType.value = 'Video';
                poster.vid_fileType.value = "videos";
                poster.vid_path.value = asset.relativePath.toString();
                poster.vid_datetime.value =
                    asset.createDateTime.toIso8601String();

                // _videoPlayerController = VideoPlayerController.file(video!)
                // // Play the video again when it ends
                //   ..setLooping(true);
                // // initialize the controller and notify UI when done

                // BetterPlayerConfiguration betterPlayerConfiguration =
                //     const BetterPlayerConfiguration(
                //   aspectRatio: 16 / 9,
                //   fit: BoxFit.contain,
                // );
                // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
                //     BetterPlayerDataSourceType.memory, "",
                //     bytes: video1, useAsmsSubtitles: true, useAsmsTracks: true);
                // _betterPlayerController =
                //     BetterPlayerController(betterPlayerConfiguration);
                // _betterPlayerController!.setupDataSource(dataSource);
                //
                // poster.playerController = _betterPlayerController;

                // print(poster.file_selected_video.value.toString());
                // PostScreenState().video();
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) {
              //       if (asset.type == AssetType.image) {
              //         poster.file_selected.value = asset.file.toString();
              //         // return ImageScreen(imageFile: asset.file);
              //       } else {
              //         return VideoScreen(videoFile: asset.file);
              //       }
              //     },
              //   ),
              // );
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.memory(bytes, fit: BoxFit.cover),
                ),
                if (asset.type == AssetType.video)
                  Center(
                    child: Container(
                      color: Colors.blue,
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}

// class ImageScreen extends StatelessWidget {
//   const ImageScreen({
//     Key? key,
//     required this.imageFile,
//   }) : super(key: key);
//
//   final Future<File?> imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       alignment: Alignment.center,
//       child: FutureBuilder<File?>(
//         future: imageFile,
//         builder: (_, snapshot) {
//           final file = snapshot.data;
//           if (file == null) return Container();
//           return Image.file(file);
//         },
//       ),
//     );
//   }
// }
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({
//     Key? key,
//     required this.videoFile,
//   }) : super(key: key);
//
//   final Future<File?> videoFile;
//
//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   VideoPlayerController? _controller;
//   bool initialized = false;
//
//   @override
//   void initState() {
//     _initVideo();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }
//
//   _initVideo() async {
//     final video = await widget.videoFile;
//     _controller = VideoPlayerController.file(video!)
//       // Play the video again when it ends
//       ..setLooping(true)
//       // initialize the controller and notify UI when done
//       ..initialize().then((_) => setState(() => initialized = true));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: initialized
//           // If the video is initialized, display it
//           ? Scaffold(
//               body: Center(
//                 child: AspectRatio(
//                   aspectRatio: _controller!.value.aspectRatio,
//                   // Use the VideoPlayer widget to display the video.
//                   child: VideoPlayer(_controller!),
//                 ),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   // Wrap the play or pause in a call to `setState`. This ensures the
//                   // correct icon is shown.
//                   setState(() {
//                     // If the video is playing, pause it.
//                     if (_controller!.value.isPlaying) {
//                       _controller!.pause();
//                     } else {
//                       // If the video is paused, play it.
//                       _controller!.play();
//                     }
//                   });
//                 },
//                 // Display the correct icon depending on the state of the player.
//                 child: Icon(
//                   _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 ),
//               ),
//             )
//           // If the video is not yet initialized, display a spinner
//           : const SizedBox(
//               height: 20,
//               width: 20,
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }
