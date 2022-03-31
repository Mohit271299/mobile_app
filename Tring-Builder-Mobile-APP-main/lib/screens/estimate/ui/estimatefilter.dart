import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class EstimateFilter extends StatefulWidget {
  const EstimateFilter({Key? key}) : super(key: key);

  @override
  EstimateFilterState createState() => EstimateFilterState();
}

class EstimateFilterState extends State<EstimateFilter> {
  late double screenHeight,screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.445,
      width: screenWidth,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(
                  vertical: -4.0,
                  horizontal: -4.0,
                ),
                title: Text('asd'),
              ),
          ],
        ),
      ),
    );
  }
}
