import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class sales_details extends StatefulWidget {

  @override
  _sales_detailsState createState() => _sales_detailsState();
}

class _sales_detailsState extends State<sales_details> {

  final invoice_no_controller = new TextEditingController();
  final invoice_date_controller = new TextEditingController();
  Future<void> invoice_box(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: Container(
                alignment: Alignment.center,
                child: Text('Sales Details')),
            titleTextStyle: TextStyle(
              fontFamily: 'GR',
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
              fontSize: 17.0,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF3F3F3),
                        borderRadius:
                        BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                        left: 0, right: 0, bottom: 10),
                    child: TextField(
                      controller: invoice_no_controller,
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
                        labelText: 'Invoice no',
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
                        left: 0, right: 0, bottom: 0),
                    child: TextField(
                      controller: invoice_date_controller,
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
                        labelText: 'Invoice date',
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
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf3f3f3),
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
                            'Sales',
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
                                  GestureDetector(
                                    onTap: (){
                                      invoice_box(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 15, top: 18, bottom: 4),
                                      child: Text("Invoice No",
                                          style: TextStyle(
                                            color: Color(0xff9d9d9d),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'GR',
                                          )),
                                    ),
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
                                        child: Text('Bill',
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              // tower_select();
                                            },
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Flat No.',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Sq.ft.',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Price per Sq.ft.',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Basic Ammount',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'GST',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     PageTransition(
                                              //       child:
                                              //       other_charges(context),
                                              //       type: PageTransitionType
                                              //           .bottomToTop,
                                              //     ));
                                            },
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Other Charges',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          border: Border.all(
                                              color: Colors.lightBlue),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: (){
                                              // Navigator.push(
                                              //     context,
                                              //     PageTransition(
                                              //       child:
                                              //       home_loan_charges(context),
                                              //       type: PageTransitionType
                                              //           .bottomToTop,
                                              //     ));
                                            },
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Home Loan Charges',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xff0B0D16),
                                              fontFamily: 'GR',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
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
                                          color: Color(0xffF3F3F3),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            // controller: lnameController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, left: 0),
                                              labelText: 'Total Amount',
                                              labelStyle: TextStyle(
                                                color: Color(0xff828282),
                                                fontSize: 12.0,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11.0,
                                            ),
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
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Container(
                              margin: EdgeInsets.only(top: 13,bottom: 13,right: 13,left: 13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('₹12,23,330',style: TextStyle(
                                        color: Color(0xff0B0D16),
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.0,
                                      ),),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text('Total Estimate',style: TextStyle(
                                        color: Color(0xff9d9d9d),
                                        fontFamily: 'GR',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      ),),
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff007DEF),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 36),
                                        child: Text('Save',style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontFamily: 'GR',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                        ),),
                                      ))
                                ],
                              ),
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
