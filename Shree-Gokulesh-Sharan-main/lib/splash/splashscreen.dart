import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaishnav_parivar/AppDetails.dart';
import 'package:vaishnav_parivar/language/chooselanguage.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double screenHeight, screenWidth;

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mockCheckForSession().then((status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectLanguage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: back_image(
        body_container: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                elevation: 26.0,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/png/applogo.png'),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                AppDetails.appName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sf_normal',
                    color: Colors.black,
                    fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
