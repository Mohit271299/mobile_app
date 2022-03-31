import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tring/screens/initialization/add_customer.dart';
import 'package:tring/screens/initialization/estimate_screen.dart';
import 'package:tring/screens/initialization/payment_screen.dart';
import 'package:tring/screens/initialization/sales_screen.dart';
import 'package:tring/screens/initialization/task_activity_screen.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  List<String> list_alphabet = ['Block - A', 'Block - B', 'Block - C'];
  String _startalpha = 'Block - A';
  int _selectedIndex = 0;

  List _viewData = [
    "Task & Activity",
    "Property",
    "Payment",
  ];

  int _indexData = 0;

  List myProducts = ['A-101', 'A-102', 'A-103', 'A-104'];
  List myProducts2 = ['A-101', 'A-102', 'A-103', 'A-104', 'A-105', 'A-106'];

  List task_cust_name = [
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia'
  ];
  List task_status = ['Follow Ups', 'Phone Call', 'Site Visit', 'Meeting'];

  List task_priority_status = [
    'High Priority',
    'Medium Priority',
    'Low Priority',
    'High Priority'
  ];
  final List<Color> colors = <Color>[Color(0xffFF0000), Color(0xffFF6600),Color(0xff05B884),Color(0xffFF0000)];

  List task_DnT = [
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM'
  ];

  @override
  Size get preferredSize => Size.fromHeight(34);

  void show_info() {
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
            margin: EdgeInsets.symmetric(vertical: 224, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    'Booking Info',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 17,
                        fontFamily: 'GR',
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 70, right: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffE8E8E8), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xff398E5B)),
                        margin: EdgeInsets.fromLTRB(10, 8, 30, 8),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          'Booked',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              fontFamily: 'GR',
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 70, right: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffE8E8E8), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xffFBBC0A)),
                        margin: const EdgeInsets.fromLTRB(10, 8, 30, 8),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          'Enquiry',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              fontFamily: 'GR',
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 70, right: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffE8E8E8), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xffEF6C00)),
                        margin: EdgeInsets.fromLTRB(10, 8, 30, 8),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          'On Hold',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              fontFamily: 'GR',
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 70, right: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE8E8E8), width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0xff398E5B)),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 8, 30, 8),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          height: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff15740D)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          'Toke Received',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              fontFamily: 'GR',
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 70, right: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffE8E8E8),
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0xffEF6C00)),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 8, 30, 8),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          height: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffEF0000)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          'Rescale',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              fontFamily: 'GR',
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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

  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                'assets1/Vector_drawer.svg',
                height: 15,
                width: 34,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        backgroundColor: Color(0xff007DEF),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: Container(
        margin: EdgeInsets.only(top: 93, left: 15, bottom: 50),
        width: MediaQuery.of(context).size.width / 1.9,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0), bottom: Radius.circular(20)),
          child: Drawer(
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 30, 20, 40),
                    child: Text(
                      'Tring App India',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff485056),
                          fontFamily: 'GB'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 5),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff757C85),
                          fontFamily: 'GB'),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/handshake.png',
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: salesScreen(),
                                  type: PageTransitionType.rightToLeft));
                          // Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Sales',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff485056),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/application-settings.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: estimateScreen(),
                                  type: PageTransitionType.rightToLeft));
                          // Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Estimates',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff485056),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/verify.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 700),
                                  child: task_activity_Screen(),
                                  type: PageTransitionType.rightToLeft));
                          // Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Task',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff485056),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/group.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text('Leads',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff485056),
                              fontFamily: 'GR',
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/analytics.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 700),
                                  child: task_activity_Screen(),
                                  type: PageTransitionType.rightToLeft));
                          // Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Activity',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff485056),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/contact-information.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 700),
                                  child: add_customerScreen(),
                                  type: PageTransitionType.rightToLeft));
                          // Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Contact',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff485056),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/contact-information.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 700),
                                    child: paymentScreen(),
                                    type: PageTransitionType.rightToLeft));
                            // Navigator.of(context).push(_createRoute());
                        },
                        child: Text('Payment',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff485056),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 5, top: 5),
                    child: Text(
                      'Reports',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff757C85),
                          fontFamily: 'GR'),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets1/analytics.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text('Activity',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff485056),
                              fontFamily: 'GR',
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 5),
                          child: IconButton(
                            icon: Image.asset(
                              'assets1/log-in.png',
                              fit: BoxFit.fill,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Text('Register',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff007DEF),
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Color(0xff5D5D5D),
        selectedLabelStyle:
            TextStyle(fontFamily: 'GB', fontSize: 10, color: Colors.black),
        unselectedLabelStyle:
            TextStyle(fontFamily: 'GB', fontSize: 10, color: Color(0xff5D5D5D)),
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        iconSize: 25,
        // onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset('assets1/Vector_home.svg',
                height: 25, width: 25, color: Color(0xff5D5D5D)),
            activeIcon: SvgPicture.asset(
              'assets1/Vector.svg',
              height: 25,
              width: 25,
              color: Colors.blueAccent,
            ),
          ),
          BottomNavigationBarItem(
            label: "Pet Lover",
            icon: SvgPicture.asset('assets1/Vector_search.svg',
                height: 25, width: 25, color: Color(0xff5D5D5D)),
            activeIcon: SvgPicture.asset(
              'assets1/Vector.svg',
              height: 25,
              width: 25,
              color: Colors.blueAccent,
            ),
          ),
          BottomNavigationBarItem(
            label: "home",
            icon: SvgPicture.asset('assets1/Vector_estimate.svg',
                height: 25, width: 25, color: Color(0xff5D5D5D)),
            activeIcon: SvgPicture.asset(
              'assets1/Vector.svg',
              height: 25,
              width: 25,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160.0,
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  left: 20, top: 23, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 15, top: 15),
                                      child: Text(
                                        'Profit',
                                        style: TextStyle(
                                            fontSize: 14, fontFamily: 'GB'),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 15, right: 120),
                                      child: Text("\$1234,455,00.00",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'GB',
                                            color: Color(0xff05B884),
                                          ))),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15, top: 10, bottom: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text('Revenue'),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("\$123,34,33.00")
                                          ],
                                        ),
                                        Container(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 50, right: 23),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text('Revenue'),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text("\$123,34,33.00")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _viewData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _indexData = index;
                                  });
                                  print(_indexData);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 0, top: 15, left: 28),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    color: _indexData != null &&
                                            _indexData == index
                                        ? Color(0xffA6D2F9)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _viewData[index],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff9D9D9D)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        (_indexData == 0
                            ? task_activity_dash()
                            : (_indexData == 1
                                ? property_dash()
                                : (_indexData == 2
                                    ? payment_dash()
                                    : property_dash()))),
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

  Widget property_dash() {
    return Column(
      children: [
        Row(
          children: [
            Container(
                height: 30,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                    right: 0, top: 15, left: 28),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.9), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      top: 7, bottom: 7, left: 10, right: 10),
                  alignment: Alignment.centerLeft,
                  child: DropdownButton(
                    icon: SvgPicture.asset(
                        'assets1/Polygon_1.svg'),
                    iconEnabledColor: Color(0xff007DEF),
                    iconSize: 14,
                    underline: SizedBox(),
                    value: _startalpha,
                    selectedItemBuilder:
                        (BuildContext context) {
                      return list_alphabet
                          .map<Widget>((String item) {
                        return Container(
                            alignment: Alignment.center,
                            child: Text('$item',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GB')));
                      }).toList();
                    },
                    items: list_alphabet.map((item) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          '$item',
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'GB'),
                        ),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _startalpha = value as String;
                      });
                    },
                  ),
                )),
            GestureDetector(
              onTap: () {
                show_info();
              },
              child: Container(
                  margin: EdgeInsets.only(left: 15, top: 12),
                  child: SvgPicture.asset(
                    'assets1/Vector.svg',
                    height: 15,
                    width: 15,
                  )),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 15, left: 28, bottom: 15),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 34,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.9), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
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
                            decoration: InputDecoration(
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
                margin: EdgeInsets.only(right: 51),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      'assets1/Vector_filter.svg',
                      height: 14,
                      width: 14,
                    )),
              ),
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 11),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                ),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff007DEF)),
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 13,
                              spreadRadius: 25)
                        ]),
                        margin:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                        child: Text(
                          myProducts[index],
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'GB',
                              color: Color(0xff007DEF)),
                        )),
                  );
                }),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 11),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: myProducts2.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff007DEF)),
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 13,
                              spreadRadius: 25)
                        ]),
                        margin:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                        child: Text(
                          myProducts2[index],
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'GB',
                              color: Color(0xff007DEF)),
                        )),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget task_activity_dash() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
              right: 15, top: 15, left: 23, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.9), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
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
                            decoration: InputDecoration(
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
                margin: EdgeInsets.only(right: 15,left: 15),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      'assets1/Vector_sort.svg',
                      height: 14,
                      width: 14,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                margin: EdgeInsets.only(right: 51),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      'assets1/Vector_filter.svg',
                      height: 14,
                      width: 14,
                    )),
              ),
            ],
          ),
        ),

        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: task_cust_name.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 12, bottom: 8, left: 12, right: 19),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 0, bottom: 7),
                                  child: Text(
                                    task_status[index],
                                    style: TextStyle(
                                        color: Color(0xff9D9D9D),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'GR'),
                                  )),
                              Text(task_DnT[index],
                                  style: TextStyle(
                                      color: Color(0xff9D9D9D),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'GR')),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, bottom: 12, right: 19),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(task_cust_name[index],
                                  style: TextStyle(
                                      color: Color(0xff0B0D16),
                                      fontSize: 14,
                                      fontFamily: 'GR',
                                      fontWeight: FontWeight.w600)),
                              Text(task_priority_status[index],
                                  style: TextStyle(
                                      color: colors[index],
                                      fontSize: 10,
                                      fontFamily: 'GR',
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: edit_options,
                    child: Container(
                      // color: Colors.redAccent,
                      width: 20,
                      height: 30,
                      margin: EdgeInsets.only(right: 12),
                      child:SvgPicture.asset(
                        'assets1/Vector_three_dot.svg',
                        width: 12,
                        height: 12,
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget payment_dash() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 11),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                ),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff007DEF)),
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 13,
                              spreadRadius: 25)
                        ]),
                        margin:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                        child: Text(
                          myProducts[index],
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'GB',
                              color: Color(0xff007DEF)),
                        )),
                  );
                }),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 11),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: myProducts2.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff007DEF)),
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 13,
                              spreadRadius: 25)
                        ]),
                        margin:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                        child: Text(
                          myProducts2[index],
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'GB',
                              color: Color(0xff007DEF)
                          ),
                        )),
                  );
                }),
          ),
        )
      ],
    );
  }

  void edit_options() {
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
                SizedBox(height: 20,),
                Container(
                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                        ),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontFamily: 'GR'),
                        ))),
                Container(
                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                        ),
                        child: Text(
                          'Change Priority',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontFamily: 'GR'),
                        ))),
                Container(
                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                        ),
                        child: Text(
                          'Mark as complete',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontFamily: 'GR'),
                        ))),
                Container(
                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                        ),
                        child: Text(
                          'Change due date',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontFamily: 'GR'),
                        ))),
                Container(
                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffE74B3B),
                              fontFamily: 'GR'),
                        ))),


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
}
