import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tring/screens/initialization/sales_details.dart';

import 'estimate_details.dart';

class salesScreen extends StatefulWidget {

  @override
  _salesScreenState createState() => _salesScreenState();
}

class _salesScreenState extends State<salesScreen> {

  List customer_name = [
    "Devang vadaliya",
    "Devang Vadaliya",
    "Devang Vadaliya",
    "Devang Vadaliya"
  ];

  List phone_number = [
    "9998979695",
    "9998979695",
    "9998979695",
    "9998979695",
  ];

  void add_sales() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: Container(
              color: Color(0xff737373),
              child: Container(
                height: 640,
                child: Column(
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
                      height: 34,
                      margin: const EdgeInsets.only(
                          right: 55, top: 16, left: 55, bottom: 21),
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
                        itemCount: customer_name.length,
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
                                              child: sales_details(),
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
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:Color(0xff007DEF),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.only(top: 30,left: 63,right: 64,bottom: 40),
                      child: Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 14,bottom: 14,left: 58,right: 58),
                            child: Text('Add New Customer',style: TextStyle(fontSize: 13,fontFamily: "gr",fontWeight: FontWeight.w600,color: Color(0xffffffff)),)),
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
            ),
          );
        });
  }


  List sales_no = ['#112', '#112', '#112', '#112'];
  List flat_no = ['A-1002', 'A-1002', 'A-1002', 'A-1002'];

  List price = [
    '₹12112123',
    '₹12112123',
    '₹12112123',
    '₹12112123'
  ];
  List sales_due = [
    '50% Due',
    '50% Due',
    '50% Due',
    '50% Due'
  ];


  final List<Color> colors = <Color>[Color(0xffFF0000), Color(0xffFF6600),Color(0xff05B884),Color(0xffFF0000)];

  List sales_DnT = [
    '20/02/2022',
    '20/02/2022',
    '20/02/2022',
    '20/02/2022'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xff007DEF),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xff007DEF),
        onPressed: () {
          add_sales();
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
                            'Sales',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'GR',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: customer_name.length,
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
                                              top: 12, bottom: 7, left: 12, right: 19),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    sales_no[index],
                                                    style: TextStyle(
                                                        color: Color(0xff9D9D9D),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: 'GR'),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: Color(0xfff3f3f3)
                                                    ),
                                                      margin: EdgeInsets.only(left: 11),
                                                      child: Container(
                                                        margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                                        child: Text(
                                                          flat_no[index],
                                                          style: TextStyle(
                                                              color: Color(0xff9D9D9D),
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: 'GR'),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              Text(sales_DnT[index],
                                                  style: TextStyle(
                                                      color: Color(0xff9D9D9D),
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'GR')),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12, bottom: 6, right: 19),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(customer_name[index],
                                                  style: TextStyle(
                                                      color: Color(0xff0B0D16),
                                                      fontSize: 14,
                                                      fontFamily: 'GR',
                                                      fontWeight: FontWeight.w600)),
                                              Text(price[index],
                                                  style: TextStyle(
                                                      color: Color(0xff0B0D16),
                                                      fontSize: 15,
                                                      fontFamily: 'GR',
                                                      fontWeight: FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12, bottom: 10, right: 19),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(phone_number[index],
                                                  style: TextStyle(
                                                      color: Color(0xff9D9D9D),
                                                      fontSize: 14,
                                                      fontFamily: 'GR',
                                                      fontWeight: FontWeight.w400)),
                                              Text(sales_due[index],
                                                  style: TextStyle(
                                                      color: Color(0xffE74B3B),
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
