import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tring/screens/initialization/estimate_details.dart';

class estimateScreen extends StatefulWidget {
  const estimateScreen({Key? key}) : super(key: key);

  @override
  _estimateScreenState createState() => _estimateScreenState();
}

class _estimateScreenState extends State<estimateScreen> {
  List item_index = ['#101', '#102', '#103', '#104'];
  List date_index = [
    '20/02/2022',
    '20/02/2022',
    '20/02/2022',
    '20/02/2022',
  ];
  List customer_name = [
    "Devang vadaliya",
    "Devang Vadaliya",
    "Devang Vadaliya",
    "Devang Vadaliya"
  ];
  List price_tag = [
    "12.3Lakh",
    "12.3Lakh",
    "12.3Lakh",
    "12.3Lakh",
  ];
  List phone_number = [
    "9998979695",
    "9998979695",
    "9998979695",
    "9998979695",
  ];
  List flat_number = [
    "1002",
    "1003",
    "1003",
  ];

  void show_filter() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(top: 425),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    'Filter',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 17,
                        fontFamily: 'GR',
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 27, left: 28, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  left: 12,
                                ),
                                child: Text(
                                  'From Account',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9d9d9d),
                                      fontFamily: 'GR'),
                                ))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Container(
                            margin: EdgeInsets.all(7),
                            child: SvgPicture.asset(
                              'assets1/Vector_exchange.svg',
                              height: 14,
                              width: 12,
                            )),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  left: 12,
                                ),
                                child: Text(
                                  'From Account',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9d9d9d),
                                      fontFamily: 'GR'),
                                ))),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 27, left: 28, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  left: 12,
                                ),
                                child: Text(
                                  'From Account',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9d9d9d),
                                      fontFamily: 'GR'),
                                ))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Container(
                            margin: EdgeInsets.all(7),
                            child: SvgPicture.asset(
                              'assets1/Vector_exchange.svg',
                              height: 14,
                              width: 12,
                            )),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  left: 12,
                                ),
                                child: Text(
                                  'From Account',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9d9d9d),
                                      fontFamily: 'GR'),
                                ))),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 27, left: 28, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  left: 12,
                                ),
                                child: Text(
                                  'From Account',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9d9d9d),
                                      fontFamily: 'GR'),
                                ))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Container(
                            margin: EdgeInsets.all(7),
                            child: SvgPicture.asset(
                              'assets1/Vector_exchange.svg',
                              height: 14,
                              width: 12,
                            )),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                  left: 12,
                                ),
                                child: Text(
                                  'From Account',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9d9d9d),
                                      fontFamily: 'GR'),
                                ))),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff007DEF),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  width: 94,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 29),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          fontFamily: 'GR',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void add_estimate() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 640,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'Select Customer',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'GR',
                              fontWeight: FontWeight.w600,
                              color: Color(0xff0B0D16),
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 23, right: 25),
                        child: Text(
                          'Add New Customer',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'GR',
                              fontWeight: FontWeight.w600,
                              color: Color(0xff007DEF),
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 34,
                    margin: const EdgeInsets.only(
                        right: 25, top: 16, left: 25, bottom: 21),
                    decoration: BoxDecoration(
                      color: Color(0xfff3f3f3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 10, 10, 10),
                          child: SvgPicture.asset(
                            'assets1/Vector_search.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              // controller: emailController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: 14, top: 14),
                                hintText: 'Search Here',
                                hintStyle: TextStyle(
                                  color: Color(0xff9d9d9d),
                                  fontFamily: 'GR',
                                  fontSize: 12.0,
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: item_index.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffe8e8e8), width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin:
                              EdgeInsets.only(left: 25, right: 25, bottom: 15),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: estimate_details(),
                                            type:
                                                PageTransitionType.bottomToTop,
                                            duration:
                                                Duration(milliseconds: 500))
                                    );
                                  },
                                  child: Text(customer_name[index],
                                      style: TextStyle(
                                          color: Color(0xff0B0D16),
                                          fontSize: 15,
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(phone_number[index],
                                    style: TextStyle(
                                      color: Color(0xff9d9d9d),
                                      fontSize: 15,
                                      fontFamily: 'GR',
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xff007DEF),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.blueAccent,
      //   unselectedItemColor: Color(0xff5D5D5D),
      //   selectedLabelStyle:
      //   TextStyle(fontFamily: 'GB', fontSize: 10, color: Colors.black),
      //   unselectedLabelStyle:
      //   TextStyle(fontFamily: 'GB', fontSize: 10, color: Color(0xff5D5D5D)),
      //   elevation: 10,
      //   type: BottomNavigationBarType.fixed,
      //   showUnselectedLabels: true,
      //   showSelectedLabels: true,
      //   iconSize: 25,
      //   // onTap: _onItemTapped,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       label: "Home",
      //       icon: SvgPicture.asset('assets1/Vector_home.svg',
      //           height: 25, width: 25, color: Color(0xff5D5D5D)),
      //       activeIcon: SvgPicture.asset(
      //         'assets1/Vector.svg',
      //         height: 25,
      //         width: 25,
      //         color: Colors.blueAccent,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Pet Lover",
      //       icon: SvgPicture.asset('assets1/Vector_search.svg',
      //           height: 25, width: 25, color: Color(0xff5D5D5D)),
      //       activeIcon: SvgPicture.asset(
      //         'assets1/Vector.svg',
      //         height: 25,
      //         width: 25,
      //         color: Colors.blueAccent,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "home",
      //       icon: SvgPicture.asset('assets1/Vector_estimate.svg',
      //           height: 25, width: 25, color: Color(0xff5D5D5D)),
      //       activeIcon: SvgPicture.asset(
      //         'assets1/Vector.svg',
      //         height: 25,
      //         width: 25,
      //         color: Colors.blueAccent,
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xff007DEF),
        onPressed: () {
          add_estimate();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

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
                    margin: EdgeInsets.only(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 20),
                          child: Text(
                            'Estimate',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 34,
                                margin: const EdgeInsets.only(
                                    right: 20, top: 15, left: 26, bottom: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(12, 10, 10, 10),
                                      child: SvgPicture.asset(
                                        'assets1/Vector_search.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          // controller: emailController,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 14, top: 14),
                                            hintText: 'Search Here',
                                            hintStyle: TextStyle(
                                              color: Color(0xff9d9d9d),
                                              fontFamily: 'GR',
                                              fontSize: 12.0,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.only(right: 20),
                              child: Container(
                                  margin: EdgeInsets.all(9),
                                  child: SvgPicture.asset(
                                    'assets1/Vector_sort.svg',
                                    height: 12,
                                    width: 14,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                show_filter();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                margin: EdgeInsets.only(right: 26),
                                child: Container(
                                    margin: EdgeInsets.all(7),
                                    child: SvgPicture.asset(
                                      'assets1/Vector_filter.svg',
                                      height: 16,
                                      width: 16,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: item_index.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 7, left: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 0, bottom: 7),
                                                  child: Text(
                                                    item_index[index],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff9D9D9D),
                                                        fontSize: 11,
                                                        fontFamily: 'GR'),
                                                  )),
                                              Text(date_index[index],
                                                  style: TextStyle(
                                                      color: Color(0xff9D9D9D),
                                                      fontSize: 11,
                                                      fontFamily: 'GR')),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 0, bottom: 6),
                                                  child: Text(
                                                      customer_name[index],
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff0B0D16),
                                                          fontSize: 15,
                                                          fontFamily: 'GR',
                                                          fontWeight: FontWeight
                                                              .w600))),
                                              Text(price_tag[index],
                                                  style: TextStyle(
                                                      color: Color(0xff0B0D16),
                                                      fontSize: 15,
                                                      fontFamily: 'GR',
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 12, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(phone_number[index],
                                                    style: TextStyle(
                                                      color: Color(0xff9d9d9d),
                                                      fontSize: 15,
                                                      fontFamily: 'GR',
                                                    )),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: SvgPicture.asset(
                                      'assets1/Vector_three_dot.svg',
                                      width: 2,
                                      height: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
