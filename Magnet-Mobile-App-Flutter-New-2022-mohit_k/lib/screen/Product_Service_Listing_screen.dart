import 'dart:async';
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
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/customer_ledger_model.dart';
import 'package:magnet_update/model_class/other_ledger_model.dart';
import 'package:magnet_update/model_class/product_model.dart';
import 'package:magnet_update/model_class/service_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Product_Edit_screen.dart';
import 'Service_Edit_screen.dart';

class product_serviceScreen extends StatefulWidget {
  const product_serviceScreen({Key? key}) : super(key: key);

  @override
  _product_serviceScreenState createState() => _product_serviceScreenState();
}

class _product_serviceScreenState extends State<product_serviceScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  Product_Service_Listing_controller _product_screen_controller =
      Get.find(tag: Product_Service_Listing_controller().toString());

  List _viewData = [
    "Product",
    "Service",
  ];

  bool isLoading = false;
  int _indexData = 0;

  List myProducts = ['A-101', 'A-102', 'A-103', 'A-104'];
  List myProducts2 = ['A-101', 'A-102', 'A-103', 'A-104', 'A-105', 'A-106'];

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
  final List<Color> colors = <Color>[
    Color(0xffFF0000),
    Color(0xffFF6600),
    Color(0xff05B884),
    Color(0xffFF0000)
  ];

  List task_DnT = [
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM'
  ];
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    Service_list_API();
    Product_list_API();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  late double screenHeight, screenWidth;
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),

      body: custom_header(
        labelText: "Product/Service",
        burger: AssetUtils.burger,
        data: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: GetBuilder<Product_Service_Listing_controller>(
              init: _product_screen_controller,
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            bottom: 0.0,
                            top: 0.0),
                        child: Text(
                          'Product/Service',
                          style: FontStyleUtility.h20B(
                            fontColor: ColorUtils.blackColor,
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.06,
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
                                    bottom: 2, top: 10, left: 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x17000000),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 0.75)),
                                  ],
                                  color: ColorUtils.whiteColor,
                                  border: Border.all(
                                      color: _indexData == index
                                          ? HexColor("#3B7AF1")
                                          : Colors.transparent,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _viewData[index],
                                    style: FontStyleUtility.h12(
                                      fontColor: _indexData != null &&
                                          _indexData == index
                                          ? ColorUtils.blueColor
                                          : ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      (_indexData == 0
                          ? Product_tab()
                          : (_indexData == 1
                          ? Service_tab()
                          : Product_tab())),
                    ],
                  ),
                );
              }),
        ),

      ),

      floatingActionButton: new FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,
        onPressed: () {
          Get.toNamed(BindingUtils.product_service_setup_ScreenRoute);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String Token = "";
  String query_service = '';
  String query_products = '';
  List<Data_product> ProductData = [];
  List<Data_service> ServiceData = [];
  List<Data_others> OthersData = [];
  List<Data_customers> data = [];

  int? selected_product;

  int? selected_service;

  // Future Customer_list_API() async {
  //   Token = await PreferenceManager().getPref(Api_url.token);
  //   var url = Api_url.customer_listing_api;
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       // "Accept": "application/json",
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ' + Token
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     setState(() {
  //       CustomersData = responseData['data'];
  //       // SubgroupData = GroupData[1]["sub_groups"];
  //     });
  //   } else {
  //     throw Exception("failed");
  //   }
  //   // print(resposeData);
  // }
  // Future Vendors_list_API() async {
  //   Token = await PreferenceManager().getPref(Api_url.token);
  //   var url = Api_url.vendors_listing_api;
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       // "Accept": "application/json",
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ' + Token
  //     },
  //   );
  //   var resposeData = json.decode(response.body);
  //
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     setState(() {
  //       VendorsData = responseData['data'];
  //       // SubgroupData = GroupData[1]["sub_groups"];
  //     });
  //   } else {
  //     throw Exception("failed");
  //   }
  //   print(resposeData);
  // }

  Widget build_service_Search() {
    return SearchWidget(
      text: query_service,
      hintText: 'Search Here',
      onChanged: Service_list_search_API,
    );
  }

  Future Service_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.getServiceList(query_service);

    setState(() => this.ServiceData = books);
    setState(() {
      isLoading = false;
    });
    print(ServiceData);
  }

  Future Service_list_search_API(String query) async => debounce(() async {
        final books = await call_api.getServiceList(query);

        if (!mounted) return;

        setState(() {
          this.query_service = query;
          this.ServiceData = books;
        });
      });

  Widget build_Product_Search() {
    return SearchWidget(
      text: query_products,
      hintText: 'Search Here',
      onChanged: Product_list_search_API,
    );
  }

  Future Product_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.getProductList(query_products);

    setState(() {
      this.ProductData = books;
    });
    setState(() {
      isLoading = false;
    });
    print(ProductData);
  }

  Future Product_list_search_API(String query) async {
    debounce(() async {
      final books = await call_api.getProductList(query_products);

      if (!mounted) return;

      setState(() {
        this.query_products = query;
        this.ProductData = books;
      });
    });
  }

  Future Product_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/product/$selected_product';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Product_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future Service_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/service-master/$selected_service';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Service_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }


  Widget Product_tab() {
    return Column(
      children: [
        Container(
          margin:
          const EdgeInsets.only(right: 15, top: 15, left: 23, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_Product_Search()),
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
                    )),
              ),
            ],
          ),
        ),
        FutureBuilder<Object>(
            future: null,
            builder: (context, snapshot) {
              return ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 80.0),
                scrollDirection: Axis.vertical,
                itemCount: isLoading ? 10 : ProductData.length,
                itemBuilder: (BuildContext context, int index) {
                  if (isLoading) {
                    return shimmer_list();
                  } else {
                    return Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 5.0),
                      margin: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
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
                              "${ProductData[index].productName}",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "Gilroy-Bold",
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
                                              padding: MediaQuery.of(context)
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
                                                              selected_product =
                                                                  ProductData[
                                                                  index]
                                                                      .id;
                                                            });
                                                            Get.to(productEditScreen(
                                                              product_id:selected_product ,
                                                            ));
                                                            print(
                                                                selected_product);
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
                                                            setState(() {
                                                              selected_product =
                                                                  ProductData[
                                                                  index]
                                                                      .id;
                                                            });
                                                            Product_delete();
                                                            print(
                                                                selected_product);
                                                          },
                                                          child: Container(
                                                              margin:
                                                              const EdgeInsets.only(
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
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                "${ProductData[index].hsnCode}",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: "Gilroy-SemiBold",
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("#BBBBC5"),
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 13.0,
                          ),
                          Table(
                            defaultColumnWidth: FixedColumnWidth(screenWidth / 3.2),
                            border: TableBorder.all(
                                color: Colors.transparent,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Sales',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("#92959E"),
                                          fontFamily: "GR",
                                        ),

                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AVL. Qty.',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("#92959E"),
                                          fontFamily: "GR",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sales Price',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("#92959E"),
                                          fontFamily: "GR",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '₹ ${oCcy.format(double.parse(ProductData[index].totalSales!.toDouble().toString()))}',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13.0,
                                          color: HexColor("#000000"),
                                          fontFamily: "Gilroy-SemiBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '₹ ${ProductData[index].totalQty}',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: HexColor("#000000"),
                                          fontFamily: "Gilroy-SemiBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          '₹ ${oCcy.format(double.parse(ProductData[index].salesPrice!.toDouble().toString()))}',
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
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, top: 4.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Row(
                                    children: [
                                      Text(
                                        'This Month',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#3B7AF1"),
                                          fontFamily: "GR",
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: HexColor("#3B7AF1"),
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Due Today',
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
    );
  }

  Widget Service_tab() {
    return Column(
      children: [
        Container(
          margin:
          const EdgeInsets.only(right: 15, top: 15, left: 23, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: build_service_Search(),
              ),
              Container(
                margin: EdgeInsets.only(right: 15, left: 15),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      'assets/images/png/Vector-sort.svg',
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
                      'assets/images/png/Vector -filter.svg',
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
          padding: EdgeInsets.only(bottom: 80.0),

          itemCount: ServiceData.length,
          itemBuilder: (BuildContext context, int index) {
            if (isLoading) {
              return shimmer_list();
            } else {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 10.0),
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
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
                        "${ServiceData[index].serviceName}",
                        maxLines: 9,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Gilroy-Bold",
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
                                        padding: MediaQuery.of(context)
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
                                                        selected_service =
                                                            ServiceData[
                                                            index]
                                                                .id;
                                                      });
                                                      Get.to(serviceEditScreen(
                                                        service_id: selected_service,
                                                      ));
                                                      print(
                                                          selected_service);
                                                    },
                                                    child: Container(
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
                                                            BorderRadius.circular(
                                                                10)),
                                                        child:
                                                        Container(
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top:
                                                              13,
                                                              bottom:
                                                              13,
                                                            ),
                                                            child:
                                                            Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  decoration: TextDecoration.none,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Color(0xff000000),
                                                                  fontFamily: 'GR'),
                                                            ))),
                                                  ),
                                                  Container(
                                                      margin:
                                                      EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
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
                                                      margin: EdgeInsets
                                                          .only(
                                                          right: 38,
                                                          left: 38,
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
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          margin:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child:
                                                          const Text(
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
                                                      setState(() {
                                                        selected_service =
                                                            ServiceData[
                                                            index]
                                                                .id;
                                                      });
                                                      Service_delete();
                                                      print(
                                                          selected_service);
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
                                                            BorderRadius.circular(
                                                                10)),
                                                        child:
                                                        Container(
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top:
                                                              13,
                                                              bottom:
                                                              13,
                                                            ),
                                                            child:
                                                            const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  decoration: TextDecoration.none,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Color(0xffE74B3B),
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
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${ServiceData[index].serviceType}",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-SemiBold",
                              fontWeight: FontWeight.w400,
                              color: HexColor("#BBBBC5"),
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 4.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Total Sales',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#92959E"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Sales Price',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#92959E"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(ServiceData[index].totalSales!.toDouble().toString()))}',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(ServiceData[index].salesPrice!.toDouble().toString()))}',
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
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'This Month',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: HexColor("#3B7AF1"),
                            fontFamily: "GR",
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: HexColor("#3B7AF1"),
                          size: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                  ],
                ),
              );
              // return Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(15)),
              //   margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 2,
              //         child: Container(
              //           margin:
              //               EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Container(
              //                         child: Text(
              //                             "${ServiceData[index].serviceName}",
              //                             style: FontStyleUtility.h15(
              //                               fontColor: ColorUtils.blackColor,
              //                               fontWeight: FWT.semiBold,
              //                             )),
              //                       ),
              //                       Container(
              //                         margin: EdgeInsets.only(
              //                             left: 0, top: 2, right: 0),
              //                         child: Text(
              //                             "${ServiceData[index].serviceType}",
              //                             style: FontStyleUtility.h12(
              //                               fontColor: ColorUtils.ogfont,
              //                               fontWeight: FWT.medium,
              //                             )),
              //                       ),
              //                     ],
              //                   ),
              //                   GestureDetector(
              //                     onTap: () async {
              //                       await showModalBottomSheet(
              //                           context: context,
              //                           isScrollControlled: true,
              //                           builder: (context) {
              //                             return StatefulBuilder(
              //                               builder: (BuildContext context,
              //                                   StateSetter setState) {
              //                                 return Padding(
              //                                   padding: MediaQuery.of(context)
              //                                       .viewInsets,
              //                                   child: Container(
              //                                     color: Color(0xff737373),
              //                                     child: Container(
              //                                       height: 300,
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.white,
              //                                         borderRadius:
              //                                             BorderRadius.only(
              //                                           topRight:
              //                                               Radius.circular(15),
              //                                           topLeft:
              //                                               Radius.circular(15),
              //                                         ),
              //                                       ),
              //                                       child: Container(
              //                                         decoration: BoxDecoration(
              //                                           color: Colors.white,
              //                                           borderRadius:
              //                                               BorderRadius.only(
              //                                                   topLeft: Radius
              //                                                       .circular(
              //                                                           30),
              //                                                   topRight: Radius
              //                                                       .circular(
              //                                                           30)),
              //                                         ),
              //                                         child: Column(
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .center,
              //                                           children: [
              //                                             SizedBox(
              //                                               height: 20,
              //                                             ),
              //                                             GestureDetector(
              //                                               onTap: () {},
              //                                               child: Container(
              //                                                   margin: EdgeInsets
              //                                                       .only(
              //                                                           right:
              //                                                               38,
              //                                                           left:
              //                                                               38,
              //                                                           bottom:
              //                                                               10),
              //                                                   decoration: BoxDecoration(
              //                                                       color: Color(
              //                                                           0xfff3f3f3),
              //                                                       borderRadius:
              //                                                           BorderRadius.circular(
              //                                                               10)),
              //                                                   child:
              //                                                       Container(
              //                                                           alignment:
              //                                                               Alignment
              //                                                                   .center,
              //                                                           margin: EdgeInsets
              //                                                               .only(
              //                                                             top:
              //                                                                 13,
              //                                                             bottom:
              //                                                                 13,
              //                                                           ),
              //                                                           child:
              //                                                               Text(
              //                                                             'Edit',
              //                                                             style: TextStyle(
              //                                                                 fontSize: 15,
              //                                                                 decoration: TextDecoration.none,
              //                                                                 fontWeight: FontWeight.w600,
              //                                                                 color: Color(0xff000000),
              //                                                                 fontFamily: 'GR'),
              //                                                           ))),
              //                                             ),
              //                                             Container(
              //                                                 margin:
              //                                                     EdgeInsets.only(
              //                                                         right: 38,
              //                                                         left: 38,
              //                                                         bottom:
              //                                                             10),
              //                                                 decoration: BoxDecoration(
              //                                                     color: Color(
              //                                                         0xfff3f3f3),
              //                                                     borderRadius:
              //                                                         BorderRadius
              //                                                             .circular(
              //                                                                 10)),
              //                                                 child: Container(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .center,
              //                                                     margin:
              //                                                         EdgeInsets
              //                                                             .only(
              //                                                       top: 13,
              //                                                       bottom: 13,
              //                                                     ),
              //                                                     child: Text(
              //                                                       'Change Priority',
              //                                                       style: TextStyle(
              //                                                           fontSize:
              //                                                               15,
              //                                                           decoration:
              //                                                               TextDecoration
              //                                                                   .none,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           color: Color(
              //                                                               0xff000000),
              //                                                           fontFamily:
              //                                                               'GR'),
              //                                                     ))),
              //                                             Container(
              //                                                 margin:
              //                                                     EdgeInsets.only(
              //                                                         right: 38,
              //                                                         left: 38,
              //                                                         bottom:
              //                                                             10),
              //                                                 decoration: BoxDecoration(
              //                                                     color: Color(
              //                                                         0xfff3f3f3),
              //                                                     borderRadius:
              //                                                         BorderRadius
              //                                                             .circular(
              //                                                                 10)),
              //                                                 child: Container(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .center,
              //                                                     margin:
              //                                                         EdgeInsets
              //                                                             .only(
              //                                                       top: 13,
              //                                                       bottom: 13,
              //                                                     ),
              //                                                     child: Text(
              //                                                       'Mark as complete',
              //                                                       style: TextStyle(
              //                                                           fontSize:
              //                                                               15,
              //                                                           decoration:
              //                                                               TextDecoration
              //                                                                   .none,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           color: Color(
              //                                                               0xff000000),
              //                                                           fontFamily:
              //                                                               'GR'),
              //                                                     ))),
              //                                             Container(
              //                                                 margin: EdgeInsets
              //                                                     .only(
              //                                                         right: 38,
              //                                                         left: 38,
              //                                                         bottom:
              //                                                             10),
              //                                                 decoration: BoxDecoration(
              //                                                     color: Color(
              //                                                         0xfff3f3f3),
              //                                                     borderRadius:
              //                                                         BorderRadius
              //                                                             .circular(
              //                                                                 10)),
              //                                                 child: Container(
              //                                                     alignment:
              //                                                         Alignment
              //                                                             .center,
              //                                                     margin:
              //                                                         const EdgeInsets
              //                                                             .only(
              //                                                       top: 13,
              //                                                       bottom: 13,
              //                                                     ),
              //                                                     child:
              //                                                         const Text(
              //                                                       'Change due date',
              //                                                       style: TextStyle(
              //                                                           fontSize:
              //                                                               15,
              //                                                           decoration:
              //                                                               TextDecoration
              //                                                                   .none,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           color: Color(
              //                                                               0xff000000),
              //                                                           fontFamily:
              //                                                               'GR'),
              //                                                     ))),
              //                                             GestureDetector(
              //                                               onTap: () {
              //                                                 setState(() {
              //                                                   selected_service =
              //                                                       ServiceData[
              //                                                               index]
              //                                                           .id;
              //                                                 });
              //                                                 Service_delete();
              //                                                 print(
              //                                                     selected_service);
              //                                               },
              //                                               child: Container(
              //                                                   margin: const EdgeInsets
              //                                                           .only(
              //                                                       right: 38,
              //                                                       left: 38,
              //                                                       bottom: 10),
              //                                                   decoration: BoxDecoration(
              //                                                       color: Color(
              //                                                           0xfff3f3f3),
              //                                                       borderRadius:
              //                                                           BorderRadius.circular(
              //                                                               10)),
              //                                                   child:
              //                                                       Container(
              //                                                           alignment:
              //                                                               Alignment
              //                                                                   .center,
              //                                                           margin: EdgeInsets
              //                                                               .only(
              //                                                             top:
              //                                                                 13,
              //                                                             bottom:
              //                                                                 13,
              //                                                           ),
              //                                                           child:
              //                                                               const Text(
              //                                                             'Delete',
              //                                                             style: TextStyle(
              //                                                                 fontSize: 15,
              //                                                                 decoration: TextDecoration.none,
              //                                                                 fontWeight: FontWeight.w600,
              //                                                                 color: Color(0xffE74B3B),
              //                                                                 fontFamily: 'GR'),
              //                                                           ))),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 );
              //                               },
              //                             );
              //                           });
              //                       setState(() {});
              //                     },
              //                     child: Container(
              //                       // color: Colors.redAccent,
              //                       width: 20,
              //                       height: 30,
              //                       child: SvgPicture.asset(
              //                         'assets/images/png/Vector_dot.svg',
              //                         width: 5,
              //                         height: 5,
              //                         fit: BoxFit.none,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Container(
              //                 margin: EdgeInsets.only(top: 13, bottom: 5),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Container(
              //                             margin: EdgeInsets.only(
              //                                 left: 0, bottom: 2),
              //                             child: Text('Total Sales',
              //                                 style: FontStyleUtility.h11(
              //                                   fontColor: ColorUtils.ogfont,
              //                                   fontWeight: FWT.semiBold,
              //                                 ))),
              //                         Container(
              //                             child: Text(
              //                                 "${ServiceData[index].totalSales}",
              //                                 style: FontStyleUtility.h13(
              //                                   fontColor:
              //                                       ColorUtils.blackColor,
              //                                   fontWeight: FWT.semiBold,
              //                                 ))),
              //                       ],
              //                     ),
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Container(
              //                             margin: EdgeInsets.only(
              //                                 left: 0, bottom: 2),
              //                             child: Text('Sales Price',
              //                                 style: FontStyleUtility.h11(
              //                                   fontColor: ColorUtils.ogfont,
              //                                   fontWeight: FWT.semiBold,
              //                                 ))),
              //                         Container(
              //                             child: Text(
              //                                 "${ServiceData[index].salesPrice}",
              //                                 style: FontStyleUtility.h13(
              //                                   fontColor:
              //                                       ColorUtils.blackColor,
              //                                   fontWeight: FWT.semiBold,
              //                                 ))),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               Text("${ServiceData[index].createdBy}",
              //                   style: FontStyleUtility.h11(
              //                     fontColor: ColorUtils.darkBlueColor,
              //                     fontWeight: FWT.semiBold,
              //                   )),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            }
          },
        ),
      ],
    );
  }

}
