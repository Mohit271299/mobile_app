import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/screens/authentication/login/controller/logincontroller.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';
import 'package:tring/screens/homepage/ui/homepage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double screenHeight, screenWidth;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }


  Widget? get getPage {
    if (_page == 0) {
      return const HomePage();
    } else if (_page == 1) {
      return const HomePage();
    } else if (_page == 2) {
      return const HomePage();
    }
  }

  final loginControllers = Get.put(LoginController());

  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      backgroundColor: HexColor(CommonColor.appBackColor),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor(CommonColor.appBackColor),
        centerTitle: true,
        leading: InkWell(
          onTap: ()=> _globalKey!.currentState!.openDrawer(),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 18.0, bottom: 18.0, right: 10.0),
            child: InkWell(
              child: Image.asset(
                CommonImage.drawer_icon,
                height: 17,
                width: 20.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        title: Text(
          'Dashboard',
          style: titleStyle(),
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0,top: 10.0,bottom: 10.0),
              child: Image.asset(
                CommonImage.user_avatar_icon,
                height: 37.0,
                width: 37.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: (int.parse(_page.toString()) == 0)
                ? Colors.white
                : Colors.black,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: (int.parse(_page.toString()) == 1)
                ? Colors.white
                : Colors.black,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: (int.parse(_page.toString()) == 2)
                ? Colors.white
                : Colors.black,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: HexColor(CommonColor.appActiveColor),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.decelerate,
        animationDuration: const Duration(milliseconds: 100),
        onTap: (index) {
          if (index == 0) {
            setState(() {
              _page = 0;
            });
          } else if (index == 1) {
            setState(() {
              _page = 1;
            });
          } else if (index == 2) {
            setState(() {
              _page = 2;
            });
          }
        },
        letIndexChange: (index) => true,
      ),
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



}
