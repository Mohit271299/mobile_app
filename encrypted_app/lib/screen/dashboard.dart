import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../common/common_color.dart';

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:encrypted_app/common/common_color.dart';
import 'package:encrypted_app/common/common_style.dart';
import 'package:encrypted_app/common/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../appdetails.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfeild.dart';
import '../common/image_utils.dart';
import '../widgets/gradient_txt.dart';
import 'homepage.dart';
import 'otp_verification.dart';

class DashboardScreen extends StatefulWidget {
  @override
  int index;
  DashboardScreen(this.index);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  DashBoardPageViewModel? model;

  String selectDrawerItem = 'Dashnoard';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    model ?? (model = DashBoardPageViewModel(this));
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.yellow,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(color: Colors.yellow),
            ),
            backgroundColor: Colors.yellow,
            shadowColor: Colors.yellow,
            dialogBackgroundColor: Colors.yellow,
          ),
          child: bottomNavigationBar(changeIndex)),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: getPage!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  Widget? get getPage {
    if (model!.menuIndex == 0) {
      return HomePage();
    } else if (model!.menuIndex == 1) {
      return HomePage();
      // return StoreDetailPage(changeIndex);
    }
  }

  changeIndex(int index) {
    setState(() {
      model!.menuIndex = index;
    });
  }

  Widget bottomNavigationBar(changeIndex) {
    return Container(
      color: HexColor(CommonColor.appBackColor),
      child: Container(
        height: 70,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:  HexColor("#1E1F20"),
          boxShadow: [
            BoxShadow(
              color: HexColor("#FFFFFF").withOpacity(0.04),
              blurRadius: 10,
              spreadRadius: -5,
              offset: const Offset(-18, -18),
            ),
            BoxShadow(
              color: HexColor("#000000").withOpacity(0.2),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                changeIndex.call(0);
                setState(() {
                  model!.menuIndex = 0;
                });
              },
              child: Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 0)
                            ? AssetUtils.home_svg
                            : AssetUtils.home_svg,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 0)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeIndex.call(1);
                setState(() {
                  model!.menuIndex = 1;
                });
              },
              child: Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 1)
                            ? AssetUtils.settings_svg
                            : AssetUtils.settings_svg,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 1)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
        //
      ),
    );
  }
}

class DashBoardPageViewModel {
  DashboardScreenState? state;
  int menuIndex = 0;
  DashBoardPageViewModel(DashboardScreenState? state)
  {
    menuIndex = state!.widget.index;
  }
}
