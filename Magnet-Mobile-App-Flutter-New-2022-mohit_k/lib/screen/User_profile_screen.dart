import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_appbar.dart';
import 'package:magnet_update/custom_widgets/drawer_feild_custom_wid.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';
class user_profileScreen extends StatefulWidget {
  const user_profileScreen({Key? key}) : super(key: key);

  @override
  _user_profileScreenState createState() => _user_profileScreenState();
}

class _user_profileScreenState extends State<user_profileScreen> {
  userprofileScreenController _userprofileScreenController =
      Get.find(tag: userprofileScreenController().toString());
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  String name= "";
  String email="";
  String mobile_no="";
  String token="";
  String Profile_image="";

  Future data(BuildContext context) async{

     name = await PreferenceManager().getPref('First_name');
     email = await PreferenceManager().getPref('Email');
     mobile_no = await PreferenceManager().getPref('Contact_no');
     
     Profile_image = await PreferenceManager().getPref('Profile_image');
     setState(() {
     });
    print(name);
    print(Profile_image);
  }

  Future logout(BuildContext context) async{
    await PreferenceManager().setPref(Api_url.token, "");
    token  = await PreferenceManager().getPref(Api_url.token);
    Get.offAllNamed(BindingUtils.loginScreenRoute);
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data(context);
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: GetBuilder<userprofileScreenController>(
            init: _userprofileScreenController,
            builder: (_) {
              return Stack(
                children: [
                  Container(
                    height: 30,
                    color: ColorUtils.blueColor,
                  ),
                  Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: ColorUtils.ogback,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 30,
                            left: 20,
                          ),
                          child: Text(
                            'Add Information',
                            style: FontStyleUtility.h20(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 8,
                                offset: Offset(0, 5),
                                spreadRadius: -8,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: ColorUtils.whiteColor,
                          ),
                          child: Container(
                            margin: EdgeInsets.all(11),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: (Profile_image.isNotEmpty ? Image.network(Profile_image,fit: BoxFit.fill,) : Image.asset(AssetUtils.userjpg, fit:  BoxFit.fill,))
                                          
                                           
                                      ),
                                    ),
                                    Text(
                                      'Edit',
                                      style: FontStyleUtility.h10(
                                        fontColor: ColorUtils.blueColor,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 28,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      email,
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      mobile_no ,
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 8,
                                  offset: Offset(0, 5),
                                  spreadRadius: -8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: ColorUtils.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 15, left: 18,),
                                  child: Text(
                                    'Billing Details',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: ColorUtils.blueColor)
                                  ),
                                  margin: EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Billing Name',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          name,
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: ColorUtils.blueColor)
                                  ),
                                  margin: EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Email ID',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          email,
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: ColorUtils.blueColor)
                                  ),
                                  margin: EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Mobile Number',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          mobile_no,
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: ColorUtils.blueColor)
                                  ),
                                  margin: EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'GST number',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          'Comapny Name',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,)
                              ],
                            )),
                        Container(
                          width: screenSize.width,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 8,
                                  offset: Offset(0, 5),
                                  spreadRadius: -8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: ColorUtils.whiteColor,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1,color: ColorUtils.blueColor)
                              ),
                              margin: EdgeInsets.only(
                                  top: 20, left: 18, right: 18,bottom: 20),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                child: Text(
                                  'Change Password',
                                  style: FontStyleUtility.h12(
                                    fontColor: ColorUtils.blackColor,
                                    fontWeight: FWT.bold,
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 8,
                                  offset: Offset(0, 5),
                                  spreadRadius: -8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: ColorUtils.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 15, left: 18,),
                                  child: Text(
                                    'Add Information',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 1,color: ColorUtils.blueColor)
                                  ),
                                  margin: EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Billing Name',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          'Comapny Name',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          // onTap: edit_options,
                                          child: Container(
                                            // color: Colors.redAccent,
                                            width: 20,
                                            height: 20,
                                            margin: EdgeInsets.only(right: 0),
                                            child: SvgPicture.asset(
                                              AssetUtils.svg_dot,
                                              width: 12,
                                              height: 20,
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20,)
                              ],
                            )),
                        GestureDetector(
                          onTap: (){
                            logout(context);
                          },
                          child: Container(
                              width: screenSize.width,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8,
                                    offset: Offset(0, 5),
                                    spreadRadius: -8,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.whiteColor,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: ColorUtils.redColor)
                                ),
                                margin: EdgeInsets.only(
                                    top: 20, left: 18, right: 18,bottom: 20),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                                  child: Text(
                                    'Log Out',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.redColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ),
                              )),
                        ),

                      ],
                    ),
                  ),
                ],
              );
            }),
      ),

    );
  }
}
