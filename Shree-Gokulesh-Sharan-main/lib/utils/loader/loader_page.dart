import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderPage extends StatefulWidget {
  @override
  AddPromptPageState createState() => AddPromptPageState();
}

class AddPromptPageState extends State<LoaderPage> {
  TextEditingController nameAlbumController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Color> _kDefaultRainbowColors = [
    HexColor('#F76E11')

  ];
  @override
  Widget build(BuildContext context) {
    return animatedDialogueWithTextFieldAndButton(context);
  }

  animatedDialogueWithTextFieldAndButton(context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: Color(0x66D4D4D4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: 200,
              width: 200,
              child: Material(
                color: Colors.transparent,
                child: LoadingIndicator(
                  backgroundColor: Colors.transparent,
                  indicatorType: Indicator.ballScale,
                  colors: _kDefaultRainbowColors,
                  strokeWidth: 4.0,
                  pathBackgroundColor: Colors.yellow,
                  // showPathBackground ? Colors.black45 : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
