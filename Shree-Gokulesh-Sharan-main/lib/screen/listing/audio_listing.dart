import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pagination/controller_class.dart';
import '../../pagination/route_name.dart';
import '../../utils/asset_utils.dart';
import '../../utils/back_image.dart';
import '../../utils/shimmer_list.dart';
import '../../widgets/audio_class_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/drawer_class.dart';

class Audio_listing extends StatefulWidget {
  const Audio_listing({Key? key}) : super(key: key);

  @override
  _Audio_listingState createState() => _Audio_listingState();
}

class _Audio_listingState extends State<Audio_listing> {
  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  final _audiolisting_controller = Get.put(Audiolisting_controller());

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.reference().child("Posts");
    // setupPlaylist(Url);
    super.initState();
  }

  var dbRef;

  List final_list = [];

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<Audiolisting_controller>(
      init: _audiolisting_controller,
      builder: (ctx) {
        return Scaffold(
          key: globalKey, drawer: DrawerScreen(),
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: custom_appbar(
              title: "Audio",
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
                    FutureBuilder(
                        future:dbRef
                                .orderByChild("fileType")
                                .equalTo("Audio")
                                .once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final_list.clear();
                            Map<dynamic, dynamic> values = snapshot.data!.value;
                            values.forEach((key, values) {
                              final_list.add(values);
                              // print("values[setupPlaylist]");
                              // print(values["path"]);
                            });

                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: final_list.length,
                                padding: EdgeInsets.only(top: 10, bottom: 0),
                                itemBuilder: (BuildContext context, int index) {
                                  return AudioListingscreen(
                                    audio_url: final_list[index]
                                    ["path"],
                                    subtitle: final_list[index]
                                    ["description"],
                                    title: final_list[index]
                                    ["title"],
                                  );
                                });
                          }
                          return shimmer_list();
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
