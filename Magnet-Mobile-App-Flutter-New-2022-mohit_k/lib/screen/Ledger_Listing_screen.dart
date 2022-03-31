import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/customer_ledger_model.dart';
import 'package:magnet_update/model_class/other_ledger_model.dart';
import 'package:magnet_update/model_class/vendor_ledger_model.dart';
import 'package:magnet_update/screen/Ledger_Edit_screen.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Cash_bank_Edit_screen.dart';

class ledgerScreen extends StatefulWidget {
  const ledgerScreen({Key? key}) : super(key: key);

  @override
  _ledgerScreenState createState() => _ledgerScreenState();
}

class _ledgerScreenState extends State<ledgerScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  Ledger_Listing_controller _ledgerScreenController = Get.put(
      Ledger_Listing_controller(),
      tag: Ledger_Listing_controller().toString());

  List _viewData = [
    "Customers",
    "Vendors",
    "Others",
  ];

  int _indexData = 0;

  @override
  void initState() {
    Customer_list_API();
    super.initState();
  }

  // init() async {
  //   await
  //   // await Vendors_list_API();
  //   // await Others_list_API();
  //   // await hideLoader(context);
  // }

  Color _textColor = ColorUtils.black_light_Color;
  Color _textColor2 = ColorUtils.black_light_Color;
  late double screenHeight, screenWidth;
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: "Ledger",
        burger: AssetUtils.burger,
        data: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                  child: Text(
                    'Ledger',
                    style: FontStyleUtility.h20B(
                      fontColor: ColorUtils.blackColor,
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
                              (_indexData == 0
                                  ? Customer_list_API()
                                  : (_indexData == 1
                                      ? Vendors_list_API()
                                      : (_indexData == 2
                                          ? Others_list_API()
                                          : Customer_list_API())));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 0, bottom: 0),
                              height: 30,
                              width: 88,
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
                                    horizontal: 0, vertical: 8),
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
                        ? customers_tab()
                        : (_indexData == 1
                            ? vendors_tab()
                            : (_indexData == 2
                                ? others_tab()
                                : customers_tab()))))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,
        onPressed: () {
          Get.toNamed(BindingUtils.ledgerSetupScreenRoute);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String Token = "";
  String query_others = '';
  String query_vendors = '';
  String query_customers = '';
  List<Data_customers> CustomersData = [];
  List<Data_customers> CustomersData_edit = [];
  List<Data_vendors> VendorsData = [];
  List<Data_others> OthersData = [];
  List<Data_customers>? book;

  bool isLoading = false;
  var data;
  int? selected_customer;

  int? selected_vendor;

  int? selected_other;

  Widget build_others_Search() {
    return SearchWidget(
      text: query_others,
      hintText: 'Search Here',
      onChanged: Others_list_search_API,
    );
  }

  Future Others_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.getOthersList(query_others);

    setState(() => this.OthersData = books);
    setState(() {
      isLoading = false;
    });
    print(OthersData);
  }

  Future Others_list_search_API(String query) async {
    final books = await call_api.getOthersList(query);

    if (!mounted) return;

    setState(() {
      this.query_others = query;
      this.OthersData = books;
    });
  }

  Widget build_vendors_Search() {
    return SearchWidget(
      text: query_others,
      hintText: 'Search Here',
      onChanged: Vendors_list_search_API,
    );
  }

  Future Vendors_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.getVendorsList(query_vendors);

    setState(() => this.VendorsData = books);
    setState(() {
      isLoading = false;
    });
    print(VendorsData);
  }

  Future Vendors_list_search_API(String query) async {
    final booksVendors = await call_api.getVendorsList(query);

    if (!mounted) return;

    setState(() {
      this.query_vendors = query;
      this.VendorsData = booksVendors;
    });
  }

  Widget build_customers_Search() {
    return SearchWidget(
      text: query_customers,
      hintText: 'Search Here',
      onChanged: Customer_list_search_API,
    );
  }

  Future<void> Customer_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});

    // showLoader(context);
    final books = await call_api.getCustomersList(query_customers);

    setState(() => this.CustomersData = books);
    setState(() {
      isLoading = false;
    });
  }

  Future Customer_list_search_API(String query) async {
    final books = await call_api.getCustomersList(query);

    if (!mounted) return;

    setState(() {
      this.query_customers = query;
      this.CustomersData = books;
    });
  }

  Future Customer_delete() async {
    var url =
        'https://www.magnetbackend.fsp.media/api/customers/$selected_customer';

    var response = await http_service.delete(url);
    // print(json.decode(response.body.replaceAll('}[]', '}')));

    // print(response.statusCode);
    if (response['success']) {
      Navigator.pop(context);
      Customer_list_API();
    }
  }

  Future Vendor_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/vendors/$selected_vendor';

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
      Vendors_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future Other_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = 'https://www.magnetbackend.fsp.media/api/others/$selected_other';

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
      Others_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget customers_tab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_customers_Search()),
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
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 80),
            scrollDirection: Axis.vertical,
            itemCount: isLoading ? 10 : CustomersData.length,
            itemBuilder: (BuildContext context, int index) {
              if (isLoading) {
                return shimmer_list();
              } else {
                return Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        visualDensity:
                            VisualDensity(vertical: -4.0, horizontal: -4.0),
                        contentPadding: EdgeInsets.only(
                            left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                        title: Text(
                          "${CustomersData[index].billingName}",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "Gilroy-Bold",
                            fontSize: 15.0,
                            color: HexColor("#0B0D16"),
                          ),
                          softWrap: true,
                        ),
                        trailing: InkWell(
                          child: Container(
                            // color: Colors.red,
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
                                                    topLeft:
                                                        Radius.circular(30),
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
                                                          selected_customer =
                                                              CustomersData[
                                                                      index]
                                                                  .id;
                                                        });
                                                        print(
                                                            selected_customer);
                                                        // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                        Get.to(ledgerEditScreen(
                                                          customer:
                                                              selected_customer,
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
                                                              margin: EdgeInsets
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selected_customer =
                                                              CustomersData[
                                                                      index]
                                                                  .id;
                                                        });
                                                        print(
                                                            selected_customer);
                                                        Get.to(
                                                            cash_bank_EditScreen(
                                                          customer_id:
                                                              selected_customer,
                                                        ));
                                                        // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                        // Get.to(
                                                        //     ledgerEditScreen(
                                                        //       customer:
                                                        //       selected_customer,
                                                        //     ));

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
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 13,
                                                                bottom: 13,
                                                              ),
                                                              child: Text(
                                                                'Receive Payment',
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
                                                              'Send Payment Reminder',
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
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: const Text(
                                                              'Create sales',
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
                                                          selected_customer =
                                                              CustomersData[
                                                                      index]
                                                                  .id;
                                                        });
                                                        print(
                                                            selected_customer);
                                                        Get.to(ledgerEditScreen(
                                                          customer_as_vendor:
                                                              selected_customer,
                                                        ));
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
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 13,
                                                                bottom: 13,
                                                              ),
                                                              child: const Text(
                                                                'Copy as Vendor',
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selected_customer =
                                                              CustomersData[
                                                                      index]
                                                                  .id;
                                                        });
                                                        Customer_delete();
                                                        print(
                                                            selected_customer);
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
                                                          ),
                                                        ),
                                                      ),
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
                            "${CustomersData[index].accountName}",
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
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 5.0, top: 0.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '₹ ${oCcy.format(double.parse(CustomersData[index].openingBalance!.toDouble().toString()))}',
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
                                '₹ ${oCcy.format(double.parse(CustomersData[index].totalSales!.toDouble().toString()))}',
                                style: TextStyle(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Due In 5 Days',
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

  Widget vendors_tab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_customers_Search()),
                Container(
                  margin: EdgeInsets.only(right: 12.0, left: 12.0),
                  child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AssetUtils.sort_Icons,
                      height: 17.0,
                      width: 19.83,
                    ),
                  ),
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
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: isLoading ? 10 : VendorsData.length,
            padding: EdgeInsets.only(bottom: 80.0),
            itemBuilder: (BuildContext context, int index) {
              if (isLoading) {
                return shimmer_list();
              } else {
                return Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
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
                          "${VendorsData[index].billingName}",
                          overflow: TextOverflow.ellipsis,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30)),
                                                ),
                                                child: SingleChildScrollView(
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
                                                            selected_vendor =
                                                                VendorsData[
                                                                        index]
                                                                    .id;
                                                          });
                                                          print(
                                                              selected_vendor);

                                                          // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                          Get.to(
                                                              ledgerEditScreen(
                                                            vendor:
                                                                selected_vendor,
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selected_vendor =
                                                                VendorsData[
                                                                        index]
                                                                    .id;
                                                          });
                                                          print(
                                                              selected_vendor);

                                                          Get.to(
                                                              cash_bank_EditScreen(
                                                            vendore_id:
                                                                selected_vendor,
                                                          ));
                                                          // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
                                                          // Get.to(ledgerEditScreen(
                                                          //   vendor: selected_vendor,
                                                          // ));

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
                                                                  'Pay Payment',
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
                                                                'Send Payment Reminder',
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
                                                                'Create new Purchase',
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
                                                            selected_vendor =
                                                                VendorsData[
                                                                        index]
                                                                    .id;
                                                          });
                                                          print(
                                                              selected_vendor);

                                                          Get.to(
                                                              ledgerEditScreen(
                                                            vendor_as_customer:
                                                                selected_vendor,
                                                          ));
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
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 13,
                                                                  bottom: 13,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'Copy as Customer',
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selected_vendor =
                                                                VendorsData[
                                                                        index]
                                                                    .id;
                                                          });
                                                          Vendor_delete();
                                                          print(
                                                              selected_vendor);
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
                            "${VendorsData[index].accountName}",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-SemiBold",
                              fontWeight: FontWeight.w400,
                              color: HexColor("#BBBBC5"),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 0.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '₹ ${oCcy.format(double.parse(VendorsData[index].openingBalance!.toDouble().toString()))}',
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
                                '₹ ${oCcy.format(double.parse(VendorsData[index].totalPurchase!.toDouble().toString()))}',
                                style: TextStyle(
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

  Widget others_tab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 15, top: 0, left: 23, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_customers_Search()),
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
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 80.0),
            itemCount: (isLoading) ? 10 : OthersData.length,
            itemBuilder: (BuildContext context, int index) {
              if (isLoading) {
                return shimmer_list();
              } else {
                return Container(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 3.0),
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        visualDensity:
                            VisualDensity(vertical: -4.0, horizontal: -4.0),
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        title: Text(
                          "${OthersData[index].billingName}",
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30)),
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
                                                          selected_other =
                                                              OthersData[index]
                                                                  .id;
                                                        });
                                                        print(selected_other);
                                                        Get.to(ledgerEditScreen(
                                                          other: selected_other,
                                                        ));
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
                                                              margin: EdgeInsets
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
                                                          selected_other =
                                                              OthersData[index]
                                                                  .id;
                                                        });
                                                        Other_delete();
                                                        print(selected_other);
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 13,
                                                                bottom: 13,
                                                              ),
                                                              child: const Text(
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
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "${OthersData[index].accountName}",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-SemiBold",
                              fontWeight: FontWeight.w400,
                              color: HexColor("#BBBBC5"),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 0.0, left: 0.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '${OthersData[index].accountHead!.accountHeadName}',
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
                                '₹ ${oCcy.format(double.parse(OthersData[index].closingBalance!.toDouble().toString()))}',
                                style: TextStyle(
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
                            right: 10.0, top: 4.0, bottom: 0.0),
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
}
