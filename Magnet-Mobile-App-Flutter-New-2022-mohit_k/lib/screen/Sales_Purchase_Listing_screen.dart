import 'dart:convert';

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
import 'package:magnet_update/custom_widgets/floating_action_button.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/purchase_order_model.dart';
import 'package:magnet_update/model_class/sales_order_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Purchase_Order_Edit_screen.dart';
import 'Purchase_Setup_screen.dart';
import 'Sales_Order_Edit_screen.dart';
import 'Sales_tax_invoice_Setup_screen.dart';

class sales_purchaseScreen extends StatefulWidget {
  const sales_purchaseScreen({Key? key}) : super(key: key);

  @override
  _sales_purchaseScreenState createState() => _sales_purchaseScreenState();
}

class _sales_purchaseScreenState extends State<sales_purchaseScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Sales_Purchase_Listing_controller _sales_purchase_controller =
      Get.find(tag: Sales_Purchase_Listing_controller().toString());
  PageController? _pageController;

  List _viewData = [
    "Sales Order",
    "Purchase Order",
  ];
  int _indexData = 0;

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
    sales_order_list_API();
    purchase_order_list_API();

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
        labelText: "Sales/Purchase",
        burger: AssetUtils.burger,
        data:GetBuilder<Sales_Purchase_Listing_controller>(
            init: _sales_purchase_controller,
            builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 0.0,
                        top: 0.0),
                    child: Text(
                      'Sales/Purchase',
                      style: FontStyleUtility.h20(
                        fontColor: ColorUtils.blackColor,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.065,
                    margin: EdgeInsets.only(top: 20,left: 20),
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
                                margin: EdgeInsets.only(left: 0,top: 0,bottom: 0),
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
                            SizedBox(width: 15,)
                          ],
                        );

                      },
                    ),
                  ),
                  Expanded(
                    child: (_indexData == 0
                        ? sales_order_list()
                        : (_indexData == 1
                        ? purchase_order_list()
                        : purchase_order_list())),
                  )
                ],
              );
            }),

      ),
      floatingActionButton: GetBuilder<Sales_Purchase_Listing_controller>(
          init: _sales_purchase_controller,
          builder: (_) {
            return floating_button(
              Open: () {
                _sales_purchase_controller.isFloatingActionUpdate(true);
              },
              Close: () {
                _sales_purchase_controller.isFloatingActionUpdate(false);
              },
              labelText_1: 'Sales Order',
              labelText_2: 'Purchase Order',
              onTap_1: () {
                Get.toNamed(BindingUtils.sales_order_Screen_SetupRoute);
              },
              onTap_2: () {
                Get.toNamed(BindingUtils.purchase_order_Screen_SetupRoute);
              },
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String query_sales_order = '';
  List<Data_sales_order> SalesOrderData = [];
  int? selected_sales;
  String? selected_sales_customer;

  String query_purchase_order = '';
  List<Data_purchase_order> PurchaseOrderData = [];
  int? selected_purchase;
  String? selected_purchase_vendor;

//==Tax Invoice.........................................
  Future sales_order_list_API() async {
    final books = await call_api.getSales_order_List(query_sales_order);

    setState(() => this.SalesOrderData = books);
    // print(VendorsData);
  }

  Future sales_list_search_API(String query) async {
    final books_vendors = await call_api.getSales_order_List(query);

    if (!mounted) return;

    setState(() {
      this.query_sales_order = query;
      this.SalesOrderData = books_vendors;
    });
  }

  Widget build_sales_order_Search() {
    return SearchWidget(
      text: query_sales_order,
      hintText: 'Search Here',
      onChanged: sales_list_search_API,
    );
  }

  Future sales_data_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/sales-order/$selected_sales';
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
      sales_order_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget sales_order_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: build_sales_order_Search(),
              ),
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
          itemCount: SalesOrderData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
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
                      // "${SalesOrderData[index].salesOrderNumber}",
                      "${SalesOrderData[index].customer!.billingName}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
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
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding:
                                        MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      color: Color(0xff737373),
                                      child: Container(
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
                                                topLeft: Radius.circular(30),
                                                topRight:
                                                    Radius.circular(30)),
                                          ),
                                          child: SingleChildScrollView(
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
                                                      selected_sales =
                                                          SalesOrderData[
                                                                  index]
                                                              .id;
                                                    });
                                                    Get.to(salesEditScreen(
                                                      sales_id:
                                                          selected_sales,
                                                    ));
                                                    print(selected_sales);
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
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selected_sales =
                                                          SalesOrderData[
                                                                  index]
                                                              .customer!
                                                              .id;
                                                      selected_sales_customer =
                                                          SalesOrderData[
                                                                  index]
                                                              .customer!
                                                              .billingName;
                                                    });
                                                    Get.to(taxInvoiceScreen(
                                                      customer_id:
                                                          selected_sales,
                                                      customer_name:
                                                          selected_sales_customer,
                                                    ));
                                                    print(
                                                        selected_sales_customer);
                                                    print(selected_sales);
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
                                                            'Create into Invoice',
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
                                                      selected_sales =
                                                          SalesOrderData[
                                                                  index]
                                                              .id;
                                                    });
                                                    sales_data_delete();
                                                    print(selected_sales);
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
                                    ),
                                  );
                                },
                              );
                            });
                        setState(() {});
                      },
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "${SalesOrderData[index].customer!.accountName}",
                        style: TextStyle(
                            fontFamily: "GR",
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: HexColor("#BBBBC5")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '₹ ${SalesOrderData[index].totalAmt!.toDouble()}',
                            style: TextStyle(
                              overflow: TextOverflow
                                  .ellipsis,
                              fontSize: 13.0,
                              color:
                              HexColor("#000000"),
                              fontFamily:
                              "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '₹ ${oCcy.format(double.parse(SalesOrderData[index].totalAmt!.toDouble().toString()))}',
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
                        right: 0, top: 4.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Flexible(
                        //   child: Text(
                        //     '${SalesOrderData[index].salesOrderDate}',
                        //     style: TextStyle(
                        //       fontSize: 11.0,
                        //       fontWeight: FontWeight.w600,
                        //       color: HexColor("#BBBBC5"),
                        //       fontFamily: "GR",
                        //     ),
                        //   ),
                        // ),
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ));
  }

//==Bill of Supply.........................................
  Future purchase_order_list_API() async {
    final books = await call_api.getPurchase_order_List(query_purchase_order);

    setState(() => this.PurchaseOrderData = books);
    // print(VendorsData);
  }

  Future purchase_order_list_search_API(String query) async {
    final books = await call_api.getPurchase_order_List(query);

    if (!mounted) return;

    setState(() {
      this.query_purchase_order = query;
      this.PurchaseOrderData = books;
    });
  }

  Widget build_purchase_order_Search() {
    return SearchWidget(
      text: query_purchase_order,
      hintText: 'Search Here',
      onChanged: purchase_order_list_search_API,
    );
  }

  Future purchase_data_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/purchase-order/$selected_purchase';
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
      purchase_order_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget purchase_order_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: build_purchase_order_Search(),
              ),
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
          itemCount: PurchaseOrderData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
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
                      // "${SalesOrderData[index].salesOrderNumber}",
                      "${PurchaseOrderData[index].vendor!.billingName}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
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
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding:
                                        MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      color: Color(0xff737373),
                                      child: Container(
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
                                                topLeft: Radius.circular(30),
                                                topRight:
                                                    Radius.circular(30)),
                                          ),
                                          child: SingleChildScrollView(
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
                                                      selected_purchase =
                                                          PurchaseOrderData[
                                                          index]
                                                              .id;
                                                    });
                                                    Get.to(purchaseEditScreen(purchase_id:selected_purchase ,));

                                                    print(selected_purchase);
                                                  },
                                                  child: Container(
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
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selected_purchase = PurchaseOrderData[index].id;
                                                      selected_purchase_vendor = PurchaseOrderData[index].vendor!.billingName;
                                                    });
                                                    Get.to(purchaseSetupScreen(vendor_id: selected_purchase, vendor_name: selected_purchase_vendor,));

                                                    print(selected_purchase);
                                                    print(selected_purchase_vendor);
                                                  },
                                                  child: Container(
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
                                                            'Create into Invoice',
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
                                                                .circular(10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets.only(
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
                                                              fontFamily: 'GR'),
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
                                                                .circular(10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets.only(
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
                                                              fontFamily: 'GR'),
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
                                                                .circular(10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: const EdgeInsets
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
                                                              fontFamily: 'GR'),
                                                        ))),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selected_purchase =
                                                          PurchaseOrderData[
                                                                  index]
                                                              .id;
                                                    });
                                                    purchase_data_delete();
                                                    print(selected_purchase);
                                                  },
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
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
                                    ),
                                  );
                                },
                              );
                            });
                        setState(() {});
                      },
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "${PurchaseOrderData[index].purchaseOrderNumber}",
                        style: TextStyle(
                            fontFamily: "GR",
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: HexColor("#BBBBC5")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
            '₹ ${oCcy.format(double.parse(PurchaseOrderData[index].totalAmt!.toDouble().toString()))}',
                            style: TextStyle(
                              overflow: TextOverflow
                                  .ellipsis,
                              fontSize: 13.0,
                              color:
                              HexColor("#000000"),
                              fontFamily:
                              "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '₹ ${oCcy.format(double.parse(PurchaseOrderData[index].totalAmt!.toDouble().toString()))}',
                            style: TextStyle(
                              overflow: TextOverflow
                                  .ellipsis,
                              fontSize: 13.0,
                              color:
                              HexColor("#000000"),
                              fontFamily:
                              "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 0.0, top: 4.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Flexible(
                        //   child: Text(
                        //     '${PurchaseOrderData[index].purchaseOrderDate}',
                        //     style: TextStyle(
                        //       fontSize: 11.0,
                        //       fontWeight: FontWeight.w600,
                        //       color: HexColor("#BBBBC5"),
                        //       fontFamily: "GR",
                        //     ),
                        //   ),
                        // ),
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
                      ],
                    ),
                  ),
                ],
              ),
            );

            //                           '${PurchaseOrderData[index].purchaseOrderNumber}',
            //                           style: FontStyleUtility.h15(
            //                             fontColor: ColorUtils.blackColor,
            //                             fontWeight: FWT.semiBold,
            //                           )),
            //                     ),
            //                     Container(
            //                       margin: EdgeInsets.only(
            //                           left: 12, top: 4, right: 19),
            //                       child: Text(
            //                           "${PurchaseOrderData[index].purchaseOrderDate}",
            //                           style: FontStyleUtility.h12(
            //                             fontColor: ColorUtils.ogfont,
            //                             fontWeight: FWT.medium,
            //                           )),
            //                     ),
            //                   ],
            //                 ),
            //                 GestureDetector(
            //                   onTap: () async {
            //
            //                   },
            //                   child: Container(
            //                     // color: Colors.redAccent,
            //                     width: 20,
            //                     height: 30,
            //                     margin: EdgeInsets.only(right: 12),
            //                     child: SvgPicture.asset(
            //                       'assets/images/png/Vector_dot.svg',
            //                       width: 5,
            //                       height: 5,
            //                       fit: BoxFit.none,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Container(
            //               margin: EdgeInsets.only(
            //                   top: 12, bottom: 8, left: 12, right: 19),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Container(
            //                           margin:
            //                               EdgeInsets.only(left: 0, bottom: 7),
            //                           child: Text(
            //                               "${PurchaseOrderData[index].totalAmt}",
            //                               style: FontStyleUtility.h13(
            //                                 fontColor: ColorUtils.blackColor,
            //                                 fontWeight: FWT.semiBold,
            //                               ))),
            //                       Container(
            //                           margin:
            //                               EdgeInsets.only(left: 0, bottom: 7),
            //                           child: Text("Total Ammount",
            //                               style: FontStyleUtility.h11(
            //                                 fontColor: ColorUtils.darkBlueColor,
            //                                 fontWeight: FWT.semiBold,
            //                               ))),
            //                     ],
            //                   ),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.end,
            //                     children: [
            //                       Container(
            //                           margin:
            //                               EdgeInsets.only(left: 0, bottom: 7),
            //                           child: Text(
            //                               "${PurchaseOrderData[index].vendor!.billingName}",
            //                               style: FontStyleUtility.h13(
            //                                 fontColor: ColorUtils.blackColor,
            //                                 fontWeight: FWT.semiBold,
            //                               ))),
            //                       Container(
            //                           margin:
            //                               EdgeInsets.only(left: 0, bottom: 7),
            //                           child: Text("Billing Name",
            //                               style: FontStyleUtility.h11(
            //                                 fontColor: ColorUtils.ogfont,
            //                                 fontWeight: FWT.semiBold,
            //                               ))),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // );
          },
        ),
      ],
    ));
  }

//==Cash Memo.........................................

}
