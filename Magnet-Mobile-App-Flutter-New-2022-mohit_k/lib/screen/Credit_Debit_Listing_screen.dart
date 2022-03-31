import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/floating_action_button.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/credit_note_model.dart';
import 'package:magnet_update/model_class/debit_note_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Credit_note_Edit_screen.dart';
import 'Debit_not_Edit_screen.dart';

class credit_debitScreen extends StatefulWidget {
  const credit_debitScreen({Key? key}) : super(key: key);

  @override
  _credit_debitScreenState createState() => _credit_debitScreenState();
}

class _credit_debitScreenState extends State<credit_debitScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Credit_Debit_Listing_controller _credit_debit_controller =
      Get.find(tag: Credit_Debit_Listing_controller().toString());
  PageController? _pageController;

  List _viewData = [
    "Credit",
    "Debit",
  ];
  int _indexData = 0;

  final List<String> data = <String>[
    'Tax Invoice',
    'Bill of Supply',
    'Cash Memo',
    'Proforma Invoice',
    'Estimate',
    'Delivery Challan',
  ];
  String selectedValue = 'Tax Invoice';
  String Token = '';

  // bool selected_customer= false;
  // String? customer_name;
  late String dateSelected_invoice;
  TextEditingController invoicedateController = new TextEditingController();
  final List<String> invoice_date_list = <String>[];
  TextEditingController duedateController = new TextEditingController();
  final List<String> due_date_list = <String>[];
  TextEditingController invoiceNumberController = new TextEditingController();
  final List<String> invoice_number_list = <String>[];
  TextEditingController termsController = new TextEditingController();

  TextEditingController product_name_controller = new TextEditingController();
  TextEditingController product_quantity_controller =
      new TextEditingController();
  TextEditingController product_rate_controller = new TextEditingController();
  final List<String> product_name_list = <String>[];
  final List<String> product_quantity_list = <String>[];
  final List<String> product_rate_list = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    credit_list_API();
    debit_note_list_API();

    _pageController = PageController(initialPage: 0, keepPage: false);
  }

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: 'Credit & Debit Note',
        burger: AssetUtils.burger,
        data: GetBuilder<Credit_Debit_Listing_controller>(
            init: _credit_debit_controller,
            builder: (_) {
              return Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                    child: Text(
                      'Credit & Debit Note',
                      style: FontStyleUtility.h20(
                        fontColor: ColorUtils.blackColor,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.065,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _viewData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _indexData = index;
                                });
                                print(_indexData);
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: 0, top: 0, bottom: 0),
                                height: screenSize.height * 0.05,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x17000000),
                                      blurRadius: 10.0,
                                      offset: Offset(
                                        0.0,
                                        0.75,
                                      ),
                                    ),
                                  ],
                                  color: ColorUtils.whiteColor,
                                  border: Border.all(
                                    color: _indexData == index
                                        ? HexColor("#3B7AF1")
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 6),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _viewData[index],
                                    style: TextStyle(
                                        fontFamily: "GR",
                                        color: _indexData == index
                                            ? ColorUtils.blueColor
                                            : ColorUtils.ogfont,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: (_indexData == 0
                        ? credit_note_list()
                        : (_indexData == 1
                            ? debit_note_list()
                            : debit_note_list())),
                  )
                ],
              ));
            }),
      ),
      floatingActionButton: GetBuilder<Credit_Debit_Listing_controller>(
          init: _credit_debit_controller,
          builder: (_) {
            return floating_button(
              Open: () {
                _credit_debit_controller.isFloatingActionUpdate(true);
              },
              Close: () {
                _credit_debit_controller.isFloatingActionUpdate(false);
              },
              labelText_1: 'Credit Note',
              labelText_2: 'Debit Note',
              onTap_1: () {
                Get.toNamed(BindingUtils.credit_note_Screen_SetupRoute);
              },
              onTap_2: () {
                Get.toNamed(BindingUtils.debit_note_Screen_SetupRoute);
              },
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                SizedBox(
                  height: 20,
                ),
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

  String query_credit_note = '';
  List<Data_credit_note> creditNoteData = [];
  int? selected_credit;

  String query_debit_note = '';
  List<Data_debit_note> debitNoteData = [];
  int? selected_dedit;
  bool isLoading = false;

//==Credit Note.........................................
  Future credit_list_API() async {
    setState(() {
      isLoading = true;
    });
    final books = await call_api.getCredit_note_List(query_credit_note);
    setState(() => this.creditNoteData = books);
    setState(() {
      isLoading = false;
    });
    // print(VendorsData);
  }

  Future credit_note_list_search_API(String query) async {
    final books_vendors = await call_api.getCredit_note_List(query);

    if (!mounted) return;

    setState(() {
      this.query_credit_note = query;
      this.creditNoteData = books_vendors;
    });
  }

  Widget build_credit_note_Search() {
    return SearchWidget(
      text: query_credit_note,
      hintText: 'Search Here',
      onChanged: credit_note_list_search_API,
    );
  }

  Future credit_data_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/credit-note/$selected_credit/null/null';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      credit_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget credit_note_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_credit_note_Search()),
              Container(
                margin: EdgeInsets.only(right: 12.0, left: 12.0),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AssetUtils.sort_Icons,
                      height: 17.0,
                      width: 19.83,
                    )),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(right: 51),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AssetUtils.filter_Icons,
                    height: 17,
                    width: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 80.0),
          scrollDirection: Axis.vertical,
          itemCount: isLoading ? 10 : creditNoteData.length,
          itemBuilder: (BuildContext context, int index) {
            if (isLoading) {
              return shimmer_list();
            } else {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity:
                          VisualDensity(vertical: -4.0, horizontal: -4.0),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${creditNoteData[index].creditNoteNumber}",
                        maxLines: 9,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "GR",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      trailing: Container(
                        child: InkWell(
                          child: Icon(
                            Icons.more_vert,
                            size: 30.0,
                            color: HexColor("#0B0D16"),
                          ),
                          onTap: () async {
                            await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Container(
                                          color: Color(0xff737373),
                                          child: Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_credit =
                                                            creditNoteData[
                                                            index]
                                                                .id;
                                                      });
                                                     Get.to(creditEditScreen(credti_edit_id:selected_credit ,));
                                                      print(selected_credit);
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Change Priority',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Mark as complete',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: const Text(
                                                            'Change due date',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_credit =
                                                            creditNoteData[
                                                                    index]
                                                                .id;
                                                      });
                                                      credit_data_delete();
                                                      print(selected_credit);
                                                    },
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xffE74B3B),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                            setState(() {});
                          },
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${creditNoteData[index].creditNoteDate}",
                          style: TextStyle(
                              fontFamily: "GR",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: HexColor("#BBBBC5")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(creditNoteData[index].totalAmt!.toDouble().toString()))}',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '₹ ${creditNoteData[index].entityType}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#000000"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 4.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Ledger',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    ));
  }

//==Debit Note.........................................
  Future debit_note_list_API() async {
    final books = await call_api.getdebit_note_List(query_debit_note);

    setState(() => this.debitNoteData = books);
    // print(VendorsData);
  }

  Future debit_note_list_search_API(String query) async {
    final books = await call_api.getdebit_note_List(query);

    if (!mounted) return;

    setState(() {
      this.query_debit_note = query;
      this.debitNoteData = books;
    });
  }

  Widget build_debit_note_Search() {
    return SearchWidget(
      text: query_debit_note,
      hintText: 'Search Here',
      onChanged: debit_note_list_search_API,
    );
  }

  Future debit_data_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/debit-note/$selected_dedit/null/null';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      debit_note_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget debit_note_list() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_credit_note_Search()),
                Container(
                  margin: EdgeInsets.only(right: 12.0, left: 12.0),
                  child: Container(
                      margin: EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        AssetUtils.sort_Icons,
                        height: 17.0,
                        width: 19.83,
                      )),
                ),
                Container(
                  height: 34.0,
                  width: 34.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x17000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(right: 51),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AssetUtils.filter_Icons,
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 80.0),
            scrollDirection: Axis.vertical,
            itemCount: debitNoteData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity:
                          VisualDensity(vertical: -4.0, horizontal: -4.0),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${debitNoteData[index].debitNoteNumber}",
                        maxLines: 9,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "GR",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      trailing: Container(
                        child: InkWell(
                          child: Icon(
                            Icons.more_vert,
                            size: 30.0,
                            color: HexColor("#0B0D16"),
                          ),
                          onTap: () async {
                            await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Container(
                                          color: Color(0xff737373),
                                          child: Container(
                                            height: 300,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              ),
                                            ),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_dedit =
                                                            debitNoteData[index]
                                                                .id;
                                                      });
                                                      Get.to(debitEditScreen(debit_edit_id: selected_dedit,));
                                                      print(selected_dedit);
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Change Priority',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Mark as complete',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: const Text(
                                                            'Change due date',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_dedit =
                                                            debitNoteData[index]
                                                                .id;
                                                      });
                                                      debit_data_delete();
                                                      print(selected_dedit);
                                                    },
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xffE74B3B),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                            setState(() {});
                          },
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${debitNoteData[index].debitNoteDate}",
                          style: TextStyle(
                              fontFamily: "GR",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: HexColor("#BBBBC5")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(debitNoteData[index].totalAmt!.toDouble().toString()))}',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '₹ ${debitNoteData[index].entityType}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#000000"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 4.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Ledger',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
