import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_appbar.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/inquiry_model.dart';
import 'package:magnet_update/screen/Inquiry_Edit_screen.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class inquiryScreen extends StatefulWidget {
  const inquiryScreen({Key? key}) : super(key: key);

  @override
  _inquiryScreenState createState() => _inquiryScreenState();
}

class _inquiryScreenState extends State<inquiryScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  inquiry_Listing_controller _inquiryScreenController = Get.put(
      inquiry_Listing_controller(),
      tag: inquiry_Listing_controller().toString());

  List _viewData = [
    "Customers",
    "Vendors",
    "Others",
  ];

  int _indexData = 0;

  @override
  void initState() {
    super.initState();
    inquiry_list_API();
  }

  Color _textColor = ColorUtils.black_light_Color;
  Color _textColor2 = ColorUtils.black_light_Color;
  late double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: "Inquiry",
        burger: AssetUtils.burger,
        data: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 0.0,
                      top: 0.0),
                  child: Text(
                    'Inquiry',
                    style: FontStyleUtility.h20B(
                      fontColor: ColorUtils.blackColor,

                    ),
                  ),
                ),
                inquiry_tab()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,
        onPressed: () {
          Get.toNamed(BindingUtils.inquiry_Screen_SetupRoute);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String query_inquiry = '';
  List<Data_inquiry> inquiryData = [];

  bool isLoading = false;
  var data;
  int? selected_customer;
  int? selected_vendor;
  int? selected_inquiry;

  Widget build_others_Search() {
    return SearchWidget(
      text: query_inquiry,
      hintText: 'Search Here',
      onChanged: inquiry_list_search_API,
    );
  }

  Future inquiry_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.getInquiryList(query_inquiry);

    setState(() => this.inquiryData = books);
    setState(() {
      isLoading = false;
    });
    print(inquiryData);
  }

  Future inquiry_list_search_API(String query) async {
    final books = await call_api.getInquiryList(query);

    if (!mounted) return;

    setState(() {
      this.query_inquiry = query;
      this.inquiryData = books;
    });
  }

  Future inquiry_delete() async {
    var url = 'https://magnetbackend.fsp.media/api/inquiry/$selected_inquiry';

    var response = await http_service.delete(url);

    if (response['success']) {
      Navigator.pop(context);
      inquiry_list_API();
    }
  }

  Widget inquiry_tab() {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 15, left: 23, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_others_Search()),
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
          itemCount: isLoading ? 5 :  inquiryData.length,
          itemBuilder: (BuildContext context, int index) {
            if (isLoading) {
              return shimmer_list();
            } else {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 5.0),
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
                        "${inquiryData[index].businessName}",
                        maxLines: 9,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "GR",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      trailing: InkWell(
                        child: Icon(
                          Icons.more_vert,
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
                                                  topLeft: Radius.circular(30),
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
                                                      selected_inquiry =
                                                          inquiryData[index].id;
                                                    });
                                                    print(selected_inquiry);
                                                    Get.to(inquiryEditScreen(
                                                      inquiry_id:
                                                          selected_inquiry,
                                                    ));
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
                                                      selected_inquiry =
                                                          inquiryData[index].id;
                                                    });
                                                    inquiry_delete();
                                                    // inquiry_delete();
                                                    print(selected_inquiry);
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
                          "${inquiryData[index].inquiryFor}",
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
                              '${inquiryData[index].response}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#000000"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '₹ ${inquiryData[index].name}',
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
        ),
      ],
    );
  }
}
