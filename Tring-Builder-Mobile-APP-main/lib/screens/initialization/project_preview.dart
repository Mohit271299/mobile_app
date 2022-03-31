import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tring/screens/authentication/login/ui/login.dart';
import 'package:tring/screens/initialization/dashboard_screen.dart';

class projectpreview extends StatefulWidget {
  @override
  _projectpreviewState createState() => _projectpreviewState();
}

class _projectpreviewState extends State<projectpreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff007DEF),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15))),
                    margin: EdgeInsets.only(top: 97),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25, top: 40,),
                          child: const Text(
                            'Project preview',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'GB',
                                color: Color(0xff485056)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(
                              top: 30, left: 38, right: 38),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              Text('Total Flats:',style: TextStyle(color: Color(0xff007DEF),fontFamily: 'GB',fontWeight: FontWeight.normal),),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13),
                                  child: Text('150',style: TextStyle(color: Color(0xff007DEF),fontFamily: 'GB',fontWeight: FontWeight.normal)))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 38),
                          child: Text('Tower',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'GSB',
                                  color: Color(0xff485056))),
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 0, right: 0, top: 0),
                                child: Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      for (var index = 0;
                                          index < 7;
                                          index++) ...{
                                        GestureDetector(
                                          onTap: () {
                                            print(index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 38,
                                                top: 15,
                                                right: 38),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                                8),
                                                    color:
                                                        Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  38,
                                                                  9,
                                                                  19,
                                                                  9),
                                                          child: Text(
                                                            'A:',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    13),
                                                          )),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  19,
                                                                  9,
                                                                  33,
                                                                  9),
                                                          child: const Text(
                                                            '25',
                                                            style: TextStyle(fontSize:
                                                            13,color: Color(0xff007DEF),fontFamily: 'GB',fontWeight: FontWeight.normal),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                                8),
                                                    color:
                                                        Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  38,
                                                                  9,
                                                                  19,
                                                                  9),
                                                          child: Text(
                                                            'A:',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    13),
                                                          )),
                                                      Container(
                                                          margin: const EdgeInsets
                                                              .fromLTRB(
                                                                  19,
                                                                  9,
                                                                  33,
                                                                  9),
                                                          child: const Text(
                                                            '25',style: TextStyle(fontSize:
                            13,color: Color(0xff007DEF),fontFamily: 'GB',fontWeight: FontWeight.normal)

                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      }
                                    ]))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 10, top: 30, bottom: 30),
                              height: 32,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff3f3f3),
                                  borderRadius:
                                      BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 1,
                                      color: Color(0xff007DEF))),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff9d9d9d)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            dashboard()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 30, bottom: 30, left: 10),
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xff007DEF),
                                  borderRadius:
                                      BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 9),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
