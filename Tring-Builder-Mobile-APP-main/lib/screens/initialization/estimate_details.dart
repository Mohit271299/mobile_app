import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tring/utils/styling.dart';

class estimate_details extends StatefulWidget {
  const estimate_details({Key? key}) : super(key: key);

  @override
  _estimate_detailsState createState() => _estimate_detailsState();
}

class _estimate_detailsState extends State<estimate_details> {
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
    "1003",
    "1003",
    "1003",
    "1003",
    "1003",
    "1003",
  ];

  List<String> list_tower = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
  ];
  List list_floor = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 13, bottom: 4),
                                      child: Text("Devang Vadaliya",
                                          style: TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontSize: 15,
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600))),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 15, top: 18, bottom: 4),
                                    child: Text("Estimate No.  12",
                                        style: TextStyle(
                                          color: Color(0xff9d9d9d),
                                          fontSize: 11,
                                          fontFamily: 'GR',
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 15, bottom: 13),
                                    child: Text("9998979695",
                                        style: TextStyle(
                                          color: Color(0xff9d9d9d),
                                          fontSize: 15,
                                          fontFamily: 'GR',
                                        )),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 15, bottom: 18),
                                    child: Text("20/02/2022",
                                        style: TextStyle(
                                          color: Color(0xff9d9d9d),
                                          fontSize: 11,
                                          fontFamily: 'GR',
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 15),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 15, bottom: 20, left: 15),
                                        child: Text('Estimate-1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                fontFamily: 'GR'))),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 0, left: 0, right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Colors.red),
                                      child: Container(
                                        margin: EdgeInsets.all(4.33),
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xffFFFFFF),
                                          size: 11.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, bottom: 10, right: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              tower_select();
                                            },
                                            // controller: lnameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              focusedBorder:
                                                  textfeild.box_focus_style,
                                              labelText: 'Flat No.',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              focusedBorder:
                                                  textfeild.box_focus_style,
                                              labelText: 'Sq.ft.',
                                              labelStyle: textfeild.lable_style,
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, bottom: 10, right: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              focusedBorder:
                                                  textfeild.box_focus_style,
                                              labelText: 'Price per Sq.ft.',
                                              labelStyle: textfeild.lable_style,
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                              // controller: lnameController,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 0, left: 15),
                                                focusedBorder:
                                                    textfeild.box_focus_style,
                                                labelText: 'Basic Ammount',
                                                labelStyle:
                                                    textfeild.lable_style,
                                                border: InputBorder.none,
                                              ),
                                              style: textfeild.text_style),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, bottom: 10, right: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              focusedBorder:
                                                  textfeild.box_focus_style,
                                              labelText: 'GST',
                                              labelStyle: textfeild.lable_style,
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child:
                                                        other_charges(context),
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                  ));
                                            },
                                            // controller: lnameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              focusedBorder:
                                                  textfeild.box_focus_style,
                                              labelText: 'Other Charges',
                                              labelStyle: textfeild.lable_style,
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, bottom: 15, right: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: home_loan_charges(
                                                        context),
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                  ));
                                            },
                                            // controller: lnameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              labelText: 'Home Loan Charges',
                                              labelStyle: textfeild.lable_style,
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, left: 15),
                                              labelText: 'Total Amount',
                                              labelStyle: textfeild.lable_style,
                                              border: InputBorder.none,
                                            ),
                                            style: textfeild.text_style,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 0, left: 0, right: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Color(0xff007DEF)),
                                child: Container(
                                  margin: EdgeInsets.all(4.33),
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xffFFFFFF),
                                    size: 11.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                  'Add Estimate',
                                  style: TextStyle(
                                      color: Color(0xff007DEF),
                                      fontFamily: 'GR',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
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

  Color boxcolor = Colors.white;
  String selected_tower = "";

  void tower_select() {
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
            margin: EdgeInsets.only(top: 344),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 50),
                  child: Text(
                    'Select Tower',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'GR',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0B0D16),
                        decoration: TextDecoration.none),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 54, right: 54),
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 4,
                          childAspectRatio: 2,
                        ),
                        itemCount: list_tower.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              select_floor();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.lightBlueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text(
                                  list_tower[index],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'GR'),
                                ),
                              ),
                            ),
                          );
                        }),
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

  void select_floor() {
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
            margin: EdgeInsets.only(top: 344),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 50),
                  child: Text(
                    'Select-Floor',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'GR',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0B0D16),
                        decoration: TextDecoration.none),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 54, right: 54),
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 4,
                          childAspectRatio: 2,
                        ),
                        itemCount: list_floor.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              select_flat_number();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.lightBlueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text(
                                  list_floor[index],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'GR'),
                                ),
                              ),
                            ),
                          );
                        }),
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

  void select_flat_number() {
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
            margin: EdgeInsets.only(top: 344),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 50),
                  child: Text(
                    'Select-flat-number',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'GR',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0B0D16),
                        decoration: TextDecoration.none),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 54, right: 54),
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 4,
                          childAspectRatio: 2,
                        ),
                        itemCount: flat_number.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.lightBlueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    flat_number[index],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'GR'),
                                  )),
                            ),
                          );
                        }),
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

  Widget other_charges(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xff007DEF),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 20),
                          child: Text(
                            'Other Charges',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 15, bottom: 15, left: 15),
                                    child: Text('Frequently Used',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: 'GR'))),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: textfeild.box_focus_style,
                                          contentPadding: EdgeInsets.only(
                                              top: 0, left: 15),
                                          labelText: 'Parking',
                                          labelStyle: textfeild.lable_style,
                                        ),

                                        style: textfeild.text_style,
                                        textAlign: TextAlign.start,
                                        // controller: flat_tower_controller[index],
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                      ),
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Maintenance Deposite',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText:
                                            'Preferential Location Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Registration Fee',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder:textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Slamp Duty',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Brokerage Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText:
                                            'Title/Sales Deed (MODT) Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Notary & Franking Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Morgage Charges',
                                        labelStyle: textfeild.lable_style
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Other Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 15, bottom: 15, left: 15),
                                    child: Text('Others',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: 'GR'))),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Club Membership',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder:textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Civic Amenities Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText:
                                            'External Development Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText:
                                            'Infrastructure Development Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Overhead Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style:textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                          contentPadding: EdgeInsets.only(
                                              top: 0, left: 15),
                                        labelText: 'Insurance Charges',
                                        labelStyle: textfeild.lable_style
                                      ),

                                      style:textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Utility Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Home Inspection Cost',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Interiors',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Plumbing',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Furniture',
                                        labelStyle: textfeild.lable_style,
                                      ),
                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder:textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Electric work',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder:textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Miscellaneous Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: textfeild.text_style,
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder:textfeild.box_focus_style,
                                        contentPadding: EdgeInsets.only(
                                            top: 0, left: 15),
                                        labelText: 'Brokerage Charges',
                                        labelStyle: textfeild.lable_style,
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.symmetric(
                              vertical: 26, horizontal: 20),
                          child: Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff007def),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  top: 13, bottom: 13, left: 115, right: 112),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 27, right: 30, top: 11, bottom: 11),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 15,
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        ),
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

  Widget home_loan_charges(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xff007DEF),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 20),
                          child: Text(
                            'Home Loan Charges',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                        bottom: 10,
                                        top: 10),
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          labelText: 'Laon Amount',
                                          labelStyle: TextStyle(
                                            fontFamily: 'GR',
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff9d9d9d),
                                            fontSize: 12.0,
                                          ),
                                        ),

                                        style: const TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0B0D16),
                                          fontSize: 14.0,
                                        ),
                                        textAlign: TextAlign.start,
                                        // controller: flat_tower_controller[index],
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                      ),
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Interest Charges Deposite',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Laon Processing Fee',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Prepayment Charges',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Loan Payment Charges',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Application Processing',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Brokerage Charges',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Insurance Fee',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Morgage Charges',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        labelText: 'Other Charges',
                                        labelStyle: TextStyle(
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9d9d9d),
                                          fontSize: 12.0,
                                        ),
                                      ),

                                      style: const TextStyle(
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0B0D16),
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      // controller: flat_tower_controller[index],
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.symmetric(
                              vertical: 26, horizontal: 20),
                          child: Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff007def),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  top: 13, bottom: 13, left: 115, right: 112),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 27, right: 30, top: 11, bottom: 11),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 15,
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        ),
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
