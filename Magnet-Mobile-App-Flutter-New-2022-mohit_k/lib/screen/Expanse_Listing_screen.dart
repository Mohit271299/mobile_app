import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/expense_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Expense_Edit_screen.dart';

class expanseScreen extends StatefulWidget {
  const expanseScreen({Key? key}) : super(key: key);

  @override
  _expanseScreenState createState() => _expanseScreenState();
}

class _expanseScreenState extends State<expanseScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Expanse_Listing_controller _expanse_screen_controller =
      Get.find(tag: Expanse_Listing_controller().toString());
  PageController? _pageController;

  List task_cust_name = [
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia'
  ];
  List list_two = [
    'T&C',
    'Bank Details',
    'Note',
  ];
  List price_tab = [
    '₹12,68,452.34',
    '₹12,68,452.34',
    '₹12,68,452.34',
    '₹12,68,452.34',
  ];
  final List<String> data = <String>[
    'Exclusive of Tax',
    'Inclusive of Tax',
    'Out of Scope of Tax'
  ];
  String selectedValue = 'Exclusive of Tax';
  int? id;

  String? Vendor_name;
  int? Vendor_id;
  String? Vendor_company_name;
  String? Product_name_selected;
  int? Product_id;
  String? product_Hsn_Sac_name;

  bool vendor_selected = false;
  bool isLoading = false;

  // bool selected_customer= false;
  // String? customer_name;
  late String dateSelected_invoice;
  TextEditingController invoicedateController = new TextEditingController();
  final List<String> invoice_date_list = <String>[];
  TextEditingController duedateController = new TextEditingController();
  TextEditingController podateController = new TextEditingController();
  TextEditingController ponumberController = new TextEditingController();
  final List<String> due_date_list = <String>[];
  TextEditingController invoiceNumberController = new TextEditingController();
  final List<String> invoice_number_list = <String>[];
  TextEditingController termsController = new TextEditingController();
  TextEditingController Addressontroller = new TextEditingController();
  TextEditingController Gst_no_Controller = new TextEditingController();
  TextEditingController place_of_supply_Controller =
      new TextEditingController();

  TextEditingController product_name_controller = new TextEditingController();
  TextEditingController product_HSN_controller = new TextEditingController();
  TextEditingController product_unit_controller = new TextEditingController();
  TextEditingController product_quantity_controller =
      new TextEditingController();
  TextEditingController product_rate_controller = new TextEditingController();
  TextEditingController product_tax_controller = new TextEditingController();
  TextEditingController product_discount_controller =
      new TextEditingController();

  final List<String> product_name_list = <String>[];
  final List<String> product_quantity_list = <String>[];
  final List<String> product_rate_list = <String>[];
  final List<double> product_total_exl_price_list = <double>[];

  final List<double> product_texable_inl_price_list = <double>[];
  final List<double> product_texable_exl_price_list = <double>[];

  final List<String> product_total_out_of_scope_price_list = <String>[];
  final List<double> product_total_tax_list_excl = <double>[];
  final List<double> product_total_tax_list_incl = <double>[];
  final List<double> product_total_ammount_list = <double>[];
  final List<double> product_total_dis_list = <double>[];
  final List<double> product_total_inc_ammount_list = <double>[];
  num? product_final_tax_excl;
  num? product_final_tax_incl;
  num? product_final_dis;
  num? product_final_amt;

  num? product_final_taxable_amt_exl;
  num? product_final_taxable_amt_incl;

  num? product__final_exclusive_price;
  num? product_final_inclusive_price;
  String? word_exl;
  String? word_incl;
  final List<String> product_tax_list = <String>[];
  final List<String> product_discount_list = <String>[];

  String resulttext_total_exl = "0";
  String resulttext_total_dis = "0";
  String resulttext_total_inl = "0";
  String resulttext_total_out_of_scope = "0";
  String resulttext_amount = "0";

  String resulttotal_tax_excl = '0';

  String resulttotal_tax_incl = '0';

  String resulttext_discount = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);

    Expense_list_API();

    // setState(() {
    //   (selectedValue ==
    //       'Exclusive of Tax'
    //       ? product_final_taxable_amt = product_final_amt
    //       : (selectedValue ==
    //       'Inclusive of Tax'
    //       ? product_final_taxable_amt =
    //       : (selectedValue ==
    //       'Out of Scope of Tax'
    //       ? (product_final_inclusive_price !=
    //       null
    //       ? '${product_final_inclusive_price}'
    //       : "-")
    //       : (product_final_exclusive_price !=
    //       null
    //       ? '${product_final_exclusive_price}'
    //       : "-")))),
    // });
    // setState(() {
    //   int total_ammount = int.parse(product_quantity_controller.text) * int.parse(product_rate_controller.text);
    //   print(total_ammount.toString());
    //   resulttext = total_ammount.toString();
    //   product_total_list.add(resulttext);
    // });
  }

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: 'Expanse',
        burger: AssetUtils.burger,
        data: GetBuilder<Expanse_Listing_controller>(
          init: _expanse_screen_controller,
          builder: (_) {
            return Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                            child: Text(
                              'Expanse',
                              style: FontStyleUtility.h20(
                                fontColor: ColorUtils.blackColor,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 15, top: 20, left: 20, bottom: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: build_Expense_Search(),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 12.0, left: 12.0),
                                  child: Container(
                                      margin: EdgeInsets.all(6),
                                      child: SvgPicture.asset(
                                        AssetUtils.sort_Icons,
                                        height: 17.0,
                                        width: 19.83,
                                        // fit: BoxFit.fill,
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
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(bottom: 80.0),
                            itemCount: isLoading ? 15 : ExpenseData.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (isLoading) {
                                return shimmer_list();
                              } else {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 3.0),
                                  margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 0.0,
                                      bottom: 10.0),
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
                                        visualDensity: VisualDensity(
                                            vertical: -4.0, horizontal: -4.0),
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "${ExpenseData[index].srNumber}",
                                          style: TextStyle(
                                            overflow:
                                            TextOverflow.ellipsis,
                                            fontFamily: "Gilroy-Bold",
                                            fontSize: 15.0,
                                            color: HexColor("#0B0D16"),
                                          ),
                                        ),
                                        trailing: InkWell(
                                          child: Container(
                                            width: 20,
                                            child: Icon(
                                              Icons.more_vert,
                                              size: 30.0,
                                              color: HexColor("#0B0D16"),
                                            ),
                                          ),
                                          onTap: () async {
                                            await showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            StateSetter
                                                                setState) {
                                                      return Padding(
                                                        padding:
                                                            MediaQuery.of(
                                                                    context)
                                                                .viewInsets,
                                                        child: Container(
                                                          color: Color(
                                                              0xff737373),
                                                          child: Container(
                                                            height: 300,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            30),
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
                                                                    height:
                                                                        20,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () {
                                                                          setState(
                                                                                  () {
                                                                                selected_expense =
                                                                                    ExpenseData[index].id;
                                                                              });
                                                                          Get.to(expenseEditScreen(expense_id: selected_expense,));
                                                                          print(
                                                                              selected_expense);
                                                                        },
                                                                    child: Container(
                                                                        margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                        decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
                                                                        child: Container(
                                                                            alignment: Alignment.center,
                                                                            margin: EdgeInsets.only(
                                                                              top: 13,
                                                                              bottom: 13,
                                                                            ),
                                                                            child: Text(
                                                                              'Edit',
                                                                              style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xff000000), fontFamily: 'GR'),
                                                                            ))),
                                                                  ),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              38,
                                                                          left:
                                                                              38,
                                                                          bottom:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              Color(0xfff3f3f3),
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          margin: EdgeInsets.only(
                                                                            top: 13,
                                                                            bottom: 13,
                                                                          ),
                                                                          child: Text(
                                                                            'Change Priority',
                                                                            style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xff000000), fontFamily: 'GR'),
                                                                          ))),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              38,
                                                                          left:
                                                                              38,
                                                                          bottom:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              Color(0xfff3f3f3),
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          margin: EdgeInsets.only(
                                                                            top: 13,
                                                                            bottom: 13,
                                                                          ),
                                                                          child: Text(
                                                                            'Mark as complete',
                                                                            style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xff000000), fontFamily: 'GR'),
                                                                          ))),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              38,
                                                                          left:
                                                                              38,
                                                                          bottom:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              Color(0xfff3f3f3),
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          margin: const EdgeInsets.only(
                                                                            top: 13,
                                                                            bottom: 13,
                                                                          ),
                                                                          child: const Text(
                                                                            'Change due date',
                                                                            style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xff000000), fontFamily: 'GR'),
                                                                          ))),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        selected_expense =
                                                                            ExpenseData[index].id;
                                                                      });
                                                                      expense_data_delete();
                                                                      print(
                                                                          selected_expense);
                                                                    },
                                                                    child: Container(
                                                                        margin: const EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                        decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
                                                                        child: Container(
                                                                            alignment: Alignment.center,
                                                                            margin: EdgeInsets.only(
                                                                              top: 13,
                                                                              bottom: 13,
                                                                            ),
                                                                            child: const Text(
                                                                              'Delete',
                                                                              style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xffE74B3B), fontFamily: 'GR'),
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
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            "${ExpenseData[index].invoiceDate}",
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
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '₹ ${oCcy.format(double.parse(ExpenseData[index].totalAmt!.toDouble().toString()))}',
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 13.0,
                                                  color: HexColor("#000000"),
                                                  fontFamily: "Gilroy-SemiBold",
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '₹ ${oCcy.format(double.parse(ExpenseData[index].balanceDue!.toDouble().toString()))}',
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                            right: 5.0, top: 4.0, bottom: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                'Due Ammount',
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
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,
        onPressed: () {
          Get.toNamed(BindingUtils.expanses_Screen_SetupRoute);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String Token = "";

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

  String query_expense = '';
  List<Data_expense> ExpenseData = [];
  int? selected_expense;

  Widget build_Expense_Search() {
    return SearchWidget(
      text: query_expense,
      hintText: 'Search Here',
      onChanged: Expense_list_search_API,
    );
  }

  Future Expense_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    final books = await call_api.getExpense_List(query_expense);

    setState(() => this.ExpenseData = books);
    setState(() {
      isLoading = false;
    });
    // print("PurchaseData");
    // print(PurchaseData);
  }

  Future Expense_list_search_API(String query) async {
    final books = await call_api.getExpense_List(query);

    if (!mounted) return;

    setState(() {
      this.query_expense = query;
      this.ExpenseData = books;
    });
  }

  Future expense_data_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/expense/$selected_expense/null/null';
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
      Expense_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }
}
