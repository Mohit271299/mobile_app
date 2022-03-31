import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/purchase_model.dart';
import 'package:magnet_update/custom_widgets/header_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Purchase_Edit_screen.dart';

class purchaseScreen extends StatefulWidget {
  const purchaseScreen({Key? key}) : super(key: key);

  @override
  _purchaseScreenState createState() => _purchaseScreenState();
}

class _purchaseScreenState extends State<purchaseScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Purchase_Listing_controller _purchasescreencontroller = Get.put(
      Purchase_Listing_controller(),
      tag: Purchase_Listing_controller().toString());
  PageController? _pageController;

  final List<String> data = <String>[
    'Exclusive of Tax',
    'Inclusive of Tax',
    'Out of Scope of Tax'
  ];
  String selectedValue = 'Exclusive of Tax';
  int? id;


  bool vendor_selected = false;


  TabController? _tabController;

  @override
  void initState() {
    init();
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 1,
      vsync: this,
    );
    _pageController = PageController(initialPage: 0, keepPage: false);
    // purchase_API();
  }
  init()async{
    Purchase_list_API();
  }


  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: DrawerScreen(),
      // appBar: AppBar(
      //   backgroundColor: ColorUtils.blueColor,
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   leading: InkWell(
      //     onTap: ()=> _globalKey!.currentState!.openDrawer(),
      //     child: SizedBox(
      //       width: 20.0,
      //       height: 17.0,
      //       child: Padding(
      //         padding: const EdgeInsets.only(
      //             top: 19.0, bottom: 19.0, left: 19.0, right: 15.0),
      //         child: Image.asset(
      //           AssetUtils.drawerIcons,
      //           width: 20.0,
      //           height: 17.0,
      //           fit: BoxFit.fill,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: 'Purchase',
        burger: AssetUtils.burger,
        data: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: GetBuilder<Purchase_Listing_controller>(
            init: _purchasescreencontroller,
            builder: (_) {
              return PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
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
                            'Purchase',
                            style: FontStyleUtility.h20B(
                              fontColor: ColorUtils.blackColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 15,
                              top: 20,
                              left: 20,
                              bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: build_Purchase_Search()),
                              Container(
                                margin: EdgeInsets.only(
                                    right: 12.0, left: 12.0),
                                child: Container(
                                    margin: EdgeInsets.all(6),
                                    child: SvgPicture.asset(
                                      AssetUtils.sort_Icons,
                                      height: 17.0,
                                      width: 19.83,
                                      // fit: BoxFit.fill,
                                    )
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
                                  borderRadius:
                                  BorderRadius.circular(8),
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
                          itemCount: isLoading ? 10 : PurchaseData.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            if(isLoading) {
                              return shimmer_list();
                            }else{
                              return Container(
                                padding: const EdgeInsets.only(
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
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      visualDensity: VisualDensity(vertical: -4.0, horizontal: -4.0),
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        "${PurchaseData[index].invoiceNumber}",
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
                                              isScrollControlled:
                                              true,
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext
                                                  context,
                                                      StateSetter
                                                      setState) {
                                                    return Padding(
                                                      padding: MediaQuery.of(
                                                          context)
                                                          .viewInsets,
                                                      child:
                                                      Container(
                                                        color: Color(
                                                            0xff737373),
                                                        child:
                                                        Container(
                                                          height: 300,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors
                                                                .white,
                                                            borderRadius:
                                                            BorderRadius
                                                                .only(
                                                              topRight:
                                                              Radius.circular(15),
                                                              topLeft:
                                                              Radius.circular(15),
                                                            ),
                                                          ),
                                                          child:
                                                          Container(
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft:
                                                                  Radius.circular(30),
                                                                  topRight: Radius.circular(30)),
                                                            ),
                                                            child:
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                  20,
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () {
                                                                    setState(() {
                                                                      selected_purchase = PurchaseData[index].id;
                                                                    });
                                                                    Get.to(PurchaseEditScreen(purchase_id:selected_purchase ,));
                                                                    print(selected_purchase);
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
                                                                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                    decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
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
                                                                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                    decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
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
                                                                    margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                    decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
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
                                                                    setState(() {
                                                                      selected_purchase = PurchaseData[index].id;
                                                                    });
                                                                    purchase_data_delete();
                                                                    print(selected_purchase);
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
                                        padding: const EdgeInsets.only(
                                            top: 4.0),
                                        child: Text(
                                          "${PurchaseData[index].invoiceDate}",
                                          style: TextStyle(
                                              overflow:
                                              TextOverflow.ellipsis,
                                              fontFamily:
                                              "Gilroy-SemiBold",
                                              fontWeight:
                                              FontWeight.w400,
                                              color:
                                              HexColor("#BBBBC5"),
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '₹ ${oCcy.format(double.parse(PurchaseData[index].totalAmt!.toDouble().toString()))}',
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
                                              '₹ ${oCcy.format(double.parse(PurchaseData[index].balanceDue!.toDouble().toString()))}',
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
                                          right: 5.0, top: 4.0, bottom: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Total Amount',
                                              style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight:
                                                FontWeight.w600,
                                                color:
                                                HexColor("#BBBBC5"),
                                                fontFamily: "GR",
                                              ),
                                            ),
                                          ),
                                          // Flexible(
                                          //   child: Text(
                                          //     'Due Ammount',
                                          //     style: TextStyle(
                                          //       fontSize: 11.0,
                                          //       fontWeight: FontWeight.w600,
                                          //       color: HexColor("#BBBBC5"),
                                          //       fontFamily: "GR",
                                          //     ),
                                          //   ),
                                          // ),
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
              );
            },
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,
        onPressed: () {
          Get.offAllNamed(BindingUtils.purchase_setup_Route);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  String Token = "";

  String query_purchase = '';
  List<Data_purchase> PurchaseData = [];
  int? selected_purchase;
  bool isLoading = false;

  Widget build_Purchase_Search() {
    return SearchWidget(
      text: query_purchase,
      hintText: 'Search Here',
      onChanged: Purchase_list_search_API,
    );
  }

  Future Purchase_list_API() async {
    setState(() {
      isLoading = true;
    });
    final books = await call_api.getPurchaseList(query_purchase);

    setState(() => this.PurchaseData = books);
    setState(() {
      isLoading = false;
    });
    // print("PurchaseData");
    // print(PurchaseData);
  }

  Future Purchase_list_search_API(String query) async {
    final books = await call_api.getPurchaseList(query);

    if (!mounted) return;

    setState(() {
      this.query_purchase = query;
      this.PurchaseData = books;
    });
  }

  Future purchase_data_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/purchase/$selected_purchase/null/null';
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
      Purchase_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }
}


