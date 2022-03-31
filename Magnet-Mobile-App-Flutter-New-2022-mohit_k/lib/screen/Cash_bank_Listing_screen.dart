import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_appbar.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/contra_model.dart';
import 'package:magnet_update/model_class/payment_model.dart';
import 'package:magnet_update/model_class/receipt_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';
import 'package:http/http.dart' as http;

import 'Cash_bank_Edit_screen.dart';

class cash_bank_entry_Screen extends StatefulWidget {
  const cash_bank_entry_Screen({Key? key}) : super(key: key);

  @override
  _cash_bank_entry_ScreenState createState() => _cash_bank_entry_ScreenState();
}

class _cash_bank_entry_ScreenState extends State<cash_bank_entry_Screen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Cash_bank_Listing_Controller _cash_bank_screen_controller =
  Get.find(tag: Cash_bank_Listing_Controller().toString());
  PageController? _pageController;

  List _viewData = [
    "Receipt",
    "Payment",
    "Contra",
  ];

  List bank_name = [
    "ICICI Current Bank Account",
    "ICICI Current Bank Account",
    "ICICI Current Bank Account",
    "ICICI Current Bank Account",
  ];

  int _indexData = 0;

  List task_cust_name = [
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia'
  ];
  List price_tab = [
    '₹12,68,452.34',
    '₹12,68,452.34',
    '₹12,68,452.34',
    '₹12,68,452.34',
  ];

  List task_priority_status = [
    'High Priority',
    'Medium Priority',
    'Low Priority',
    'High Priority'
  ];

  List task_DnT = [
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM'
  ];
  String Token = '';
  String? selectedValue_cash_bank;
  String? selectedValue_transaction;

  int? selected_receipt;
  int? selected_payment;
  int? selected_contra;

  final List<String> data_cash_bank = <String>[
    'CASH',
    'SBI Current Account',
    'ICICI Current Bank Account',
    'AXIS',
    'HDFC Bank',
    'Kotak Mahindra Bank',
  ];
  final List<String> data_transaction = <String>[
    'CASH',
    'Cheque',
    'neft/rtgs',
    'Phone pay',
    'GPay',
  ];

  List myProducts = ['A-101', 'A-102', 'A-103', 'A-104'];

  TextEditingController dateController = new TextEditingController();
  TextEditingController voucher_no_controller = new TextEditingController();
  TextEditingController ref_no_controller = new TextEditingController();
  TextEditingController payment_ammount_controller = new TextEditingController();

  final List<String> date_list = <String>[];
  final List<String> voucher_no_list = <String>[];
  final List<String> cash_bank_type_list = <String>[];
  final List<String> transaction_type_list = <String>[];
  final List<String> ref_no_list = <String>[];
  final List<String> pay_ammount_list = <String>[];

  Future<void> _show_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate);
      setState(() {
        dateController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receipt_list_API();
    payment_list_API();
    contra_list_API();
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
        labelText: "Cash & Bank",
        burger: AssetUtils.burger,
        data: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: GetBuilder<Cash_bank_Listing_Controller>(
              init: _cash_bank_screen_controller,
              builder: (_) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 0.0,
                          top: 0.0),
                      child: Text(
                        'Cash & Bank',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height *0.065,
                      margin: EdgeInsets.only(top: 20,left: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _viewData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _indexData = index;
                                  });
                                  print(_indexData);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 0,top: 0,bottom: 10),
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
                                      style: FontStyleUtility.h12(
                                        fontColor: _indexData == index
                                            ? ColorUtils.blueColor
                                            : ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,)

                            ],
                          );
                        },
                      ),
                    ),
                    Expanded(child:(_indexData == 0
                        ? receipt_tab()
                        : (_indexData == 1
                        ? payment_tab()
                        : (_indexData == 2
                        ? contra_tab()
                        : receipt_tab()))) ),
                    
                  ],
                );
              }),
        ),

      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,

        onPressed: () {
          Get.toNamed(BindingUtils.cash_bank_setupScreenRoute);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  bool isLoading = false;

  String query_receipt = '';
  List<Data_receipt> receipt_Data = [];

  String query_payment = '';
  List<Data_payment> payment_Data = [];

  String query_contra = '';
  List<Data_contra> contra_Data = [];

  Widget build_receipt_Search() {
    return SearchWidget(
      text: query_receipt,
      hintText: 'Search Here',
      onChanged: receipt_list_search_API,
    );
  }

  Future receipt_list_API() async {
    setState(() {
      isLoading = true;
    });
    final books = await call_api.getreceipt_paymentList(query_receipt);

    setState(() => this.receipt_Data = books);
    setState(() {
      isLoading = false;
    });
  }

  Future receipt_list_search_API(String query) async {
    final books = await call_api.getreceipt_paymentList(query);

    if (!mounted) return;

    setState(() {
      this.query_receipt = query;
      this.receipt_Data = books;
    });
  }

  Widget build_payment_Search() {
    return SearchWidget(
      text: query_payment,
      hintText: 'Search Here',
      onChanged: payment_list_search_API,
    );
  }

  Future payment_list_API() async {
    setState(() {
      isLoading = true;
    });
    final books = await call_api.getpaymentList(query_payment);

    setState(() => this.payment_Data = books);
    setState(() {
      isLoading = false;
    });
  }

  Future payment_list_search_API(String query) async {
    final books = await call_api.getpaymentList(query);

    if (!mounted) return;

    setState(() {
      this.query_payment = query;
      this.payment_Data = books;
    });
  }

  Widget build_contra_Search() {
    return SearchWidget(
      text: query_contra,
      hintText: 'Search Here',
      onChanged: contra_list_search_API,
    );
  }

  Future contra_list_API() async {
    setState(() {
      isLoading = true;
    });
    final books = await call_api.getcontraList(query_contra);

    setState(() => this.contra_Data = books);
    setState(() {
      isLoading = false;
    });
  }

  Future contra_list_search_API(String query) async {
    final books = await call_api.getcontraList(query);

    if (!mounted) return;

    setState(() {
      this.query_contra = query;
      this.contra_Data = books;
    });
  }

  Future receipt_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/receipt/$selected_receipt/null/null';

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
      receipt_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future payment_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/payment/$selected_payment/null/null';

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
      payment_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future contra_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/contra/$selected_contra/null/null';

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
      contra_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }


  // Future receipt_list_API() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final books = await call_api.getreceipt_paymentList(query_receipt);
  //
  //   setState(() => this.receipt_Data = books);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //
  // Future receipt_list_search_API(String query) async {
  //   final books = await call_api.getreceipt_paymentList(query);
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     this.query_receipt = query;
  //     this.receipt_Data = books;
  //   });
  // }
  //
  // Widget build_payment_Search() {
  //   return SearchWidget(
  //     text: query_payment,
  //     hintText: 'Search Here',
  //     onChanged: payment_list_search_API,
  //   );
  // }
  //
  // Future payment_list_API() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final books = await call_api.getpaymentList(query_payment);
  //
  //   setState(() => this.payment_Data = books);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //
  // Future payment_list_search_API(String query) async {
  //   final books = await call_api.getpaymentList(query);
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     this.query_payment = query;
  //     this.payment_Data = books;
  //   });
  // }
  //
  // Widget build_contra_Search() {
  //   return SearchWidget(
  //     text: query_contra,
  //     hintText: 'Search Here',
  //     onChanged: contra_list_search_API,
  //   );
  // }
  //
  // Future contra_list_API() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final books = await call_api.getcontraList(query_contra);
  //
  //   setState(() => this.contra_Data = books);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //
  // Future contra_list_search_API(String query) async {
  //   final books = await call_api.getcontraList(query);
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     this.query_contra = query;
  //     this.contra_Data = books;
  //   });
  // }

  Widget receipt_tab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
            const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_receipt_Search()),
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
            itemCount: isLoading ? 3 : receipt_Data.length,
            itemBuilder: (BuildContext context, int index) {
              if (isLoading) {
                return shimmer_list();
              } else {
                return Container(
                  padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "#${receipt_Data[index].id}",
                              maxLines: 9,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "GR",
                                fontWeight: FontWeight.w400,
                                fontSize: 11.0,
                                color: HexColor("#BBBBC5"),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "${receipt_Data[index].date}",
                              maxLines: 9,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "GR",
                                fontWeight: FontWeight.w400,
                                fontSize: 11.0,
                                color: HexColor("#BBBBC5"),
                              ),
                            ),
                          ],
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
                                          MediaQuery
                                              .of(context)
                                              .viewInsets,
                                          child: Container(
                                            color: Color(0xff737373),
                                            child: Container(
                                              height: 300,
                                              decoration:
                                              BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.only(
                                                  topRight:
                                                  Radius.circular(
                                                      15),
                                                  topLeft:
                                                  Radius.circular(
                                                      15),
                                                ),
                                              ),
                                              child: Container(
                                                decoration:
                                                BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .only(
                                                      topLeft: Radius
                                                          .circular(
                                                          30),
                                                      topRight: Radius
                                                          .circular(
                                                          30)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selected_receipt =
                                                              receipt_Data[index]
                                                                  .id;
                                                        });
                                                        print(
                                                            selected_receipt);
                                                        // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                        Get.to(
                                                            cash_bank_EditScreen(
                                                              receipt_id: selected_receipt,
                                                            ));

                                                        // Navigator.of(context).push(MaterialPageRoute(
                                                        //     builder: (c) => ledgerEditScreen(
                                                        //       customer: selected_customer,
                                                        //     )));
                                                      },
                                                      child:
                                                      Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              right:
                                                              38,
                                                              left:
                                                              38,
                                                              bottom:
                                                              10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                              Color(
                                                                  0xfff3f3f3),
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 13,
                                                                bottom: 13,
                                                              ),
                                                              child: Text(
                                                                'Edit',
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    decoration: TextDecoration
                                                                        .none,
                                                                    fontWeight: FontWeight
                                                                        .w600,
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontFamily: 'GR'),
                                                              ))),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            right:
                                                            38,
                                                            left:
                                                            38,
                                                            bottom:
                                                            10),
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
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom:
                                                              13,
                                                            ),
                                                            child: Text(
                                                              'Change Priority',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .none,
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily: 'GR'),
                                                            ))),
                                                    Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            right:
                                                            38,
                                                            left:
                                                            38,
                                                            bottom:
                                                            10),
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
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom:
                                                              13,
                                                            ),
                                                            child: Text(
                                                              'Mark as complete',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .none,
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily: 'GR'),
                                                            ))),
                                                    Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            right:
                                                            38,
                                                            left:
                                                            38,
                                                            bottom:
                                                            10),
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
                                                            margin: const EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom:
                                                              13,
                                                            ),
                                                            child: const Text(
                                                              'Change due date',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .none,
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily: 'GR'),
                                                            ))),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selected_receipt =
                                                              receipt_Data[index]
                                                                  .id;
                                                        });
                                                        receipt_delete();
                                                        print(
                                                            selected_receipt);
                                                        // setState(() {
                                                        //   selected_customer =
                                                        //       CustomersData[index]
                                                        //           .id;
                                                        // });
                                                        // Customer_delete();
                                                        // print(
                                                        //     selected_customer);
                                                      },
                                                      child:
                                                      Container(
                                                          margin: const EdgeInsets
                                                              .only(
                                                              right:
                                                              38,
                                                              left:
                                                              38,
                                                              bottom:
                                                              10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                              Color(
                                                                  0xfff3f3f3),
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 13,
                                                                bottom: 13,
                                                              ),
                                                              child: const Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    decoration: TextDecoration
                                                                        .none,
                                                                    fontWeight: FontWeight
                                                                        .w600,
                                                                    color: Color(
                                                                        0xffE74B3B),
                                                                    fontFamily: 'GR'),
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${receipt_Data[index].customer!.billingName}",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-Bold",
                              fontSize: 15.0,
                              color: HexColor("#0B0D16"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Invoice-1234',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#BBBBC5"),
                                  fontFamily: "GR",
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '₹ ${oCcy.format(double.parse(receipt_Data[index].paymentAmount!.toDouble().toString()))}',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13.0,
                                  color: HexColor("#000000"),
                                  fontFamily: "Gilroy-SemiBold",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '${receipt_Data[index].cashBank!
                                    .billingName}',
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
                                '${receipt_Data[index].transactionType!
                                    .transactionType.toString()}',
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
      ),
    );
  }

  Widget payment_tab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
            const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_payment_Search()),
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
          FutureBuilder<Object>(
              future: null,
              builder: (context, snapshot) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 80.0),
                  scrollDirection: Axis.vertical,
                  itemCount: isLoading ? 3 : payment_Data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (isLoading) {
                      return shimmer_list();
                    } else {
                      return Container(
                        padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "#${payment_Data[index].id.toString()}",
                                    maxLines: 9,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "GR",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0,
                                      color: HexColor("#BBBBC5"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "${payment_Data[index].date}",
                                    maxLines: 9,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "GR",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0,
                                      color: HexColor("#BBBBC5"),
                                    ),
                                  ),
                                ],
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
                                                padding: MediaQuery
                                                    .of(context)
                                                    .viewInsets,
                                                child: Container(
                                                  color: Color(0xff737373),
                                                  child: Container(
                                                    height: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(15),
                                                        topLeft:
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(30),
                                                            topRight:
                                                            Radius.circular(
                                                                30)),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selected_payment =
                                                                    payment_Data[
                                                                    index]
                                                                        .id;
                                                              });
                                                              print(
                                                                  selected_payment);

                                                              // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                              Get.to(
                                                                  cash_bank_EditScreen(
                                                                    payment_id: selected_payment,
                                                                  ));


                                                              // Navigator.of(context).push(MaterialPageRoute(
                                                              //     builder: (c) => ledgerEditScreen(
                                                              //       customer: selected_customer,
                                                              //     )));
                                                            },
                                                            child: Container(
                                                                margin:
                                                                EdgeInsets.only(
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
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                      top: 13,
                                                                      bottom: 13,
                                                                    ),
                                                                    child: Text(
                                                                      'Edit',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          15,
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
                                                              margin:
                                                              EdgeInsets.only(
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
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                    top: 13,
                                                                    bottom: 13,
                                                                  ),
                                                                  child: Text(
                                                                    'Change Priority',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
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
                                                              margin:
                                                              EdgeInsets.only(
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
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                    top: 13,
                                                                    bottom: 13,
                                                                  ),
                                                                  child: Text(
                                                                    'Mark as complete',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
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
                                                              margin:
                                                              EdgeInsets.only(
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
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                    top: 13,
                                                                    bottom: 13,
                                                                  ),
                                                                  child: const Text(
                                                                    'Change due date',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
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
                                                              // setState(() {
                                                              //   selected_customer =
                                                              //       CustomersData[index]
                                                              //           .id;
                                                              // });
                                                              // Customer_delete();
                                                              // print(
                                                              //     selected_customer);

                                                              setState(() {
                                                                selected_payment =
                                                                    payment_Data[
                                                                    index]
                                                                        .id;
                                                              });
                                                              payment_delete();
                                                              print(
                                                                  selected_payment);
                                                            },
                                                            child: Container(
                                                                margin:
                                                                const EdgeInsets
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
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                      top: 13,
                                                                      bottom: 13,
                                                                    ),
                                                                    child:
                                                                    const Text(
                                                                      'Delete',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          15,
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${payment_Data[index].entity!.billingName}",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: "Gilroy-Bold",
                                    fontSize: 15.0,
                                    color: HexColor("#0B0D16"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Invoice-1234',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#BBBBC5"),
                                        fontFamily: "GR",
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '₹ ${oCcy.format(double.parse(payment_Data[index].paymentAmount!.toDouble().toString()))}',
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13.0,
                                        color: HexColor("#000000"),
                                        fontFamily: "Gilroy-SemiBold",
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, top: 10.0, bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${payment_Data[index].cashBank!
                                          .billingName}',
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
                                      '${payment_Data[index].transactionType!
                                          .transactionType}',
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
                );
              }),
        ],
      ),
    );
  }

  Widget contra_tab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
            const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_contra_Search()),
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
          FutureBuilder<Object>(
              future: null,
              builder: (context, snapshot) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(bottom: 80.0),
                  itemCount: isLoading ? 3 : contra_Data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (isLoading) {
                      return shimmer_list();
                    } else {
                      return Container(
                        padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "#${contra_Data[index].id.toString()}",
                                    maxLines: 9,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "GR",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0,
                                      color: HexColor("#BBBBC5"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "${contra_Data[index].date}",
                                    maxLines: 9,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "GR",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0,
                                      color: HexColor("#BBBBC5"),
                                    ),
                                  ),
                                ],
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
                                                padding: MediaQuery
                                                    .of(context)
                                                    .viewInsets,
                                                child: Container(
                                                  color: Color(0xff737373),
                                                  child: Container(
                                                    height: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(15),
                                                        topLeft:
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(30),
                                                            topRight:
                                                            Radius.circular(
                                                                30)),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selected_contra =
                                                                    contra_Data[
                                                                    index]
                                                                        .id;
                                                              });
                                                              print(
                                                                  selected_contra);

                                                              // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                              Get.to(
                                                                  cash_bank_EditScreen(
                                                                    contra_id: selected_contra,
                                                                  ));

                                                              // Navigator.of(context).push(MaterialPageRoute(
                                                              //     builder: (c) => ledgerEditScreen(
                                                              //       customer: selected_customer,
                                                              //     )));
                                                            },
                                                            child: Container(
                                                                margin:
                                                                EdgeInsets.only(
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
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                      top: 13,
                                                                      bottom: 13,
                                                                    ),
                                                                    child: Text(
                                                                      'Edit',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          15,
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
                                                              margin:
                                                              EdgeInsets.only(
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
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                    top: 13,
                                                                    bottom: 13,
                                                                  ),
                                                                  child: Text(
                                                                    'Change Priority',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
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
                                                              margin:
                                                              EdgeInsets.only(
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
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                    top: 13,
                                                                    bottom: 13,
                                                                  ),
                                                                  child: Text(
                                                                    'Mark as complete',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
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
                                                              margin:
                                                              EdgeInsets.only(
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
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                    top: 13,
                                                                    bottom: 13,
                                                                  ),
                                                                  child: const Text(
                                                                    'Change due date',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
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
                                                              // setState(() {
                                                              //   selected_customer =
                                                              //       CustomersData[index]
                                                              //           .id;
                                                              // });
                                                              // Customer_delete();
                                                              // print(
                                                              //     selected_customer);

                                                              setState(() {
                                                                selected_contra =
                                                                    contra_Data[
                                                                    index]
                                                                        .id;
                                                              });
                                                              contra_delete();
                                                              print(
                                                                  selected_contra);
                                                            },
                                                            child: Container(
                                                                margin:
                                                                const EdgeInsets
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
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                      top: 13,
                                                                      bottom: 13,
                                                                    ),
                                                                    child:
                                                                    const Text(
                                                                      'Delete',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          15,
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${contra_Data[index].other!.billingName}",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: "Gilroy-Bold",
                                    fontSize: 15.0,
                                    color: HexColor("#0B0D16"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Invoice-1234',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#BBBBC5"),
                                        fontFamily: "GR",
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '₹ ${oCcy.format(double.parse(contra_Data[index].paymentAmount!.toDouble().toString()))}',
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13.0,
                                        color: HexColor("#000000"),
                                        fontFamily: "Gilroy-SemiBold",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, top: 10.0, bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${contra_Data[index].cashBank!
                                          .billingName}',
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
                                      '${contra_Data[index].transactionType!
                                          .transactionType.toString()}',
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
                );
              }),
        ],
      ),
    );
  }


}
