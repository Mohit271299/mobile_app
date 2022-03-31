import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tring/screens/initialization/sales_screen.dart';
import 'package:tring/screens/initialization/task_activity_screen.dart';

import 'add_customer.dart';
import 'estimate_screen.dart';

class paymentScreen extends StatefulWidget {
  @override
  _paymentScreenState createState() => _paymentScreenState();
}

class _paymentScreenState extends State<paymentScreen> {
  List menus = [
    "Due Payment",
    "Received Payment",
  ];
  int _indexMenu = 0;

  List task_cust_name = [
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia',
  ];
  List due_time = ['Due Today', 'Due In 5 Days', '10 Days Overdue'];

  List price = [
    '₹1230000',
    '₹1230000',
    '₹1230000',
  ];
  final List<Color> colors = <Color>[
    Color(0xffFF0000),
    Color(0xffFF6600),
    Color(0xffFF0000)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onTap: () {},
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
                            itemCount: menus.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _indexMenu = index;
                                  });
                                  print(_indexMenu);
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
                                    color: _indexMenu != null &&
                                            _indexMenu == index
                                        ? Color(0xffA6D2F9)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      menus[index],
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
                        SizedBox(
                          height: 23,
                        ),
                        (_indexMenu == 0
                            ? due_payment()
                            : (_indexMenu == 1
                                ? received_payment()
                                : due_payment()))
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

  Widget due_payment() {
    return ListView.builder(
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
                      margin: EdgeInsets.only(left: 15, top: 13, right: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(task_cust_name[index],
                              style: TextStyle(
                                  color: Color(0xff0B0D16),
                                  fontSize: 15,
                                  fontFamily: 'GR',
                                  fontWeight: FontWeight.w600)),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFAD7D4),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 3),
                              child: Text(price[index],
                                  style: TextStyle(
                                      color: Color(0xffE74B3B),
                                      fontSize: 15,
                                      fontFamily: 'GR',
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 9, bottom: 8, left: 15, right: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 0, bottom: 7),
                              child: Text(
                                due_time[index],
                                style: TextStyle(
                                    color: colors[index],
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'GR'),
                              )),
                          Text(price[index],
                              style: TextStyle(
                                  color: Color(0xff9D9D9D),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'GR')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: edit_options,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 50,
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      'assets1/Vector_three_dot.svg',
                      width: 12,
                      height: 12,
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget received_payment() {
    return ListView.builder(
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
                      margin: EdgeInsets.only(left: 15, top: 13, right: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(task_cust_name[index],
                              style: TextStyle(
                                  color: Color(0xff0B0D16),
                                  fontSize: 15,
                                  fontFamily: 'GR',
                                  fontWeight: FontWeight.w600)),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffECFFF0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 3),
                              child: Text(price[index],
                                  style: TextStyle(
                                      color: Color(0xff5EA965),
                                      fontSize: 15,
                                      fontFamily: 'GR',
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 9, bottom: 8, left: 15, right: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 0, bottom: 7),
                              child: Text(
                                due_time[index],
                                style: TextStyle(
                                    color: colors[index],
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'GR'),
                              )),
                          Text(price[index],
                              style: TextStyle(
                                  color: Color(0xff9D9D9D),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'GR')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: edit_options,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 50,
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      'assets1/Vector_three_dot.svg',
                      width: 12,
                      height: 12,
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void edit_options() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin:
                            EdgeInsets.only(right: 38, left: 38, bottom: 10),
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
                        margin:
                            EdgeInsets.only(right: 38, left: 38, bottom: 10),
                        decoration: BoxDecoration(
                            color: Color(0xfff3f3f3),
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            receive_payment_dialog();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                top: 13,
                                bottom: 13,
                              ),
                              child: Text(
                                'Recieve Payment',
                                style: TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                    fontFamily: 'GR'),
                              )),
                        )),
                    Container(
                        margin:
                            EdgeInsets.only(right: 38, left: 38, bottom: 10),
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
                        margin:
                            EdgeInsets.only(right: 38, left: 38, bottom: 10),
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
                        margin:
                            EdgeInsets.only(right: 38, left: 38, bottom: 10),
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
                        margin:
                            EdgeInsets.only(right: 38, left: 38, bottom: 10),
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
            ),
          );
        });
  }

  void receive_payment_dialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Color(0xff737373),
                child: Container(
                  height: 493,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 0,bottom: 15),
                              child: Text(
                                'Receive Payment',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'GR',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0B0D16),
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 10),
                              decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      // controller: passwordController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 5, left: 12),
                                        labelText: 'Contact name',
                                        labelStyle: TextStyle(
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff0B0D16),
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: SvgPicture.asset(
                                      'assets1/Vector_person.svg',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: TextFormField(
                                        // controller: passwordController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 5, left: 12),
                                          labelText: 'Property Name',
                                          labelStyle: TextStyle(
                                            color: Color(0xff9d9d9d),
                                            fontSize: 12.0,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff0B0D16),
                                            fontFamily: 'GR',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: TextFormField(
                                        // controller: passwordController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 5, left: 12),
                                          labelText: 'Basic Ammount',
                                          labelStyle: TextStyle(
                                            color: Color(0xff9d9d9d),
                                            fontSize: 12.0,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff0B0D16),
                                            fontFamily: 'GR',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: TextFormField(
                                        // controller: passwordController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 5, left: 12),
                                          labelText: 'Property Name',
                                          labelStyle: TextStyle(
                                            color: Color(0xff9d9d9d),
                                            fontSize: 12.0,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff0B0D16),
                                            fontFamily: 'GR',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: TextFormField(
                                        // controller: passwordController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 5, left: 12),
                                          labelText: 'Basic Ammount',
                                          labelStyle: TextStyle(
                                            color: Color(0xff9d9d9d),
                                            fontSize: 12.0,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff0B0D16),
                                            fontFamily: 'GR',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10.0),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextFormField(
                                              // controller: passwordController,
                                              decoration:
                                              const InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(
                                                    top: 5,
                                                    left: 12),
                                                labelText:
                                                'Date',
                                                labelStyle: TextStyle(
                                                  color: Color(
                                                      0xff9d9d9d),
                                                  fontSize: 12.0,
                                                ),
                                                border:
                                                InputBorder.none,
                                              ),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff0B0D16),
                                                  fontFamily: 'GR',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                            EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: SvgPicture.asset(
                                              'assets1/Vector_calendar.svg',
                                              height: 16,
                                              width: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10.0),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextFormField(
                                              // controller: passwordController,
                                              decoration:
                                              const InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(
                                                    top: 5,
                                                    left: 12),
                                                labelText: 'Next Due Date',
                                                labelStyle: TextStyle(
                                                  color: Color(
                                                      0xff9d9d9d),
                                                  fontSize: 12.0,
                                                ),
                                                border:
                                                InputBorder.none,
                                              ),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff0B0D16),
                                                  fontFamily: 'GR',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                            EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: SvgPicture.asset(
                                              'assets1/Vector_calendar.svg',
                                              height: 16,
                                              width: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 10),
                              decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextField(// controller: passwordController,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 12),
                                  labelText: 'Payment Mode',
                                  labelStyle: TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontSize: 12.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0B0D16),
                                    fontFamily: 'GR',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 0),
                              decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextField(// controller: passwordController,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 12),
                                  labelText: 'Paid Ammount',
                                  labelStyle: TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontSize: 12.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0B0D16),
                                    fontFamily: 'GR',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff007DEF),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              margin: EdgeInsets.only(top: 40, left: 0,bottom: 15),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 9,horizontal: 26),

                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'GR',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffffffff),
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
