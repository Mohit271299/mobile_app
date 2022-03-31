import 'package:country_code_picker/country_code_picker.dart';
import 'package:encrypted_app/common/common_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../appdetails.dart';
import '../common/common_color.dart';
import '../common/image_utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfeild.dart';
import '../widgets/gradient_txt.dart';
import 'dashboard.dart';
import 'otp_verification.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Size screenSize;

  String dialCodedigits = "+00";


  Widget build(BuildContext context) {
  screenSize = MediaQuery.of(context).size;
  return Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
            margin: EdgeInsets.only(left: 30, top: 30, bottom: 10),
            child: Text('ENCRYPTO',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: AppDetails.fontGilroySemiBold,
                    color: Colors.white,
                    fontSize: 24))),
        actions: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              child: Image.asset(
                AssetUtils.add_Icon_png,
                height: 24.0,
                width: 24.0,
                // width: 37.0,
                // fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 90 margin on top
                SizedBox(
                  height: (screenSize.height * 0.05).ceilToDouble(),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: HexColor(CommonColor.appBackColor),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor("#FFFFFF").withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: -8,
                              offset: const Offset(-6, -6),
                            ),
                            BoxShadow(
                              color: HexColor("#000000").withOpacity(0.25),
                              blurRadius: 12,
                              spreadRadius: 0,
                              offset: const Offset(6, 6),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                'Title here',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: AppDetails.fontGilroySemiBold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: (screenSize.height * 0.023).ceilToDouble(),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Description here',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: AppDetails.fontGilroySemiBold,
                                      fontSize: 14.0,
                                      color: HexColor(CommonColor.fontColor),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 0, right: 20),
                                    child: SvgPicture.asset(
                                      AssetUtils.attach_Icon,
                                      height: 16.0,
                                      width: 16.0,
                                      // width: 37.0,
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }),

                customButton(
                  text: 'Lets do this',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen(0)));
                  },
                )
                //
                // Text(
                //   '${(screenSize.height * 0.02).ceilToDouble()}.',
                //   style: const TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
