import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_widget.dart';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  var indiaFormat = NumberFormat.compactCurrency(locale: 'en_IN',decimalDigits: 3);
  // print(indiaFormat.format(1000000));//10L
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget().CommonCustomerAppBar(
        labelText: "Inquiry",
        bodyWidget: Container(
          color: HexColor(CommonColor.appBackColor),
          child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 0.0,
                        top: 0.0),
                    child: Text(
                      'Inquiry',

                    ),
                  ),
                  Container(
                    child: Text('asdjhasbd'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
