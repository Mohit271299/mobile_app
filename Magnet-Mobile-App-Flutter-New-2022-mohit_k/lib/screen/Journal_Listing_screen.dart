import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/expense_model.dart';
import 'package:magnet_update/model_class/journal_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class journalScreen extends StatefulWidget {
  const journalScreen({Key? key}) : super(key: key);

  @override
  _journalScreenState createState() => _journalScreenState();
}

class _journalScreenState extends State<journalScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Journal_Listing_controller _journal_screen_controller =
  Get.find(tag: Journal_Listing_controller().toString());
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

  bool vendor_selected = false;
  bool isLoading = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);

    journal_list_API();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: 'Journal',
        burger: AssetUtils.burger,
        data: GetBuilder<Journal_Listing_controller>(
            init: _journal_screen_controller,
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
                              'Jornal',
                              style: FontStyleUtility.h20B(
                                fontColor: ColorUtils.blackColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 15, top: 15, left: 20, bottom: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: build_Journal_Search(),
                                ),
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
                            itemCount: isLoading ? 9 : JournalData.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (isLoading) {
                                return shimmer_list();
                              } else {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 15.0),
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
                                        offset: Offset(0.0, 0.75),
                                      ),
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
                                          "#${JournalData[index].voucherNumber}",
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
                                          child: Text(
                                            '${JournalData[index].date.toString()}',
                                            style: TextStyle(
                                              fontFamily: "GR",
                                              color: HexColor("#0B0D16"),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: isLoading
                                            ? 2
                                            : JournalData[index]
                                            .journalItems!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: HexColor("#007DEF"),
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: HexColor("#007DEF")
                                                      .withOpacity(0.5),
                                                ),
                                                BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: -1.0,
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.zero,
                                            margin: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  bottom: 0.0,
                                                  top: 0.0),
                                              visualDensity: VisualDensity(
                                                  vertical: -4,
                                                  horizontal: -4),
                                              title: Text(
                                                'By ${JournalData[index].journalItems![i].billingName}',
                                                style: TextStyle(
                                                  color: HexColor("#0B0D16"),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  fontFamily: "GR",
                                                ),
                                              ),
                                              trailing: Text(
                                                '₹ ${JournalData[index].journalItems![i].creditAmount.toString()}',
                                                style: TextStyle(
                                                  fontFamily: "GR",
                                                  fontWeight: FontWeight.w600,
                                                  color: HexColor("#000000"),
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),

                                          );
                                          // return Container(
                                          //   decoration: BoxDecoration(
                                          //     color: Colors.white,
                                          //     borderRadius: BorderRadius.circular(15),
                                          //   ),
                                          //   margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Text(
                                          //           '${JournalData[index].journalItems![i].billingName}'),
                                          //       Text(
                                          //           '${JournalData[index].journalItems![i].creditAmount}'),
                                          //     ],
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                );

                                //                 '${JournalData[index].voucherNumber}',
                                //               ),
                                //               Text(
                                //                 '${JournalData[index].date}',
                                //               ),
                                //             ],
                                //           ),
                                //           SizedBox(
                                //             height: 20,
                                //           ),
                                //           ListView.builder(
                                //             physics: ScrollPhysics(),
                                //             shrinkWrap: true,
                                //             scrollDirection: Axis.vertical,
                                //             itemCount: isLoading
                                //                 ? 3
                                //                 : JournalData[index]
                                //                     .journalItems!
                                //                     .length,
                                //             itemBuilder:
                                //                 (BuildContext context,
                                //                     int i) {
                                //               return Container(
                                //                 decoration: BoxDecoration(
                                //                     color: Colors.white,
                                //                     borderRadius:
                                //                         BorderRadius.circular(
                                //                             15)),
                                //                 margin: EdgeInsets.only(
                                //                     left: 20,
                                //                     right: 20,
                                //                     bottom: 10),
                                //                 child: Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                   children: [
                                //                     Text(
                                //                         '${JournalData[index].journalItems![i].billingName}'),
                                //                     Text(
                                //                         '${JournalData[index].journalItems![i].creditAmount}'),
                                //                   ],
                                //                 ),
                                //               );
                                //             },
                                //           )
                                //         ],
                                //       ),
                                //     ));
                                //
                              }
                            },
                          ),
                        ],
                      )),

                ],
              );
            }),

      ),
      floatingActionButton:  FloatingActionButton(
        backgroundColor: ColorUtils.blueColor,
        onPressed: () {
          Get.toNamed(BindingUtils.journal_Screen_SetupRoute);
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

  String query_journal = '';
  List<Data_journal> JournalData = [];

  Widget build_Journal_Search() {
    return SearchWidget(
      text: query_journal,
      hintText: 'Search Here',
      onChanged: journal_list_search_API,
    );
  }

  Future journal_list_API() async {
    setState(() {
      isLoading= true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    final books = await call_api.getJournal_List(query_journal);

    setState(() => this.JournalData = books);
    setState(() {
      isLoading= false;
    });
    // print("PurchaseData");
    // print(PurchaseData);
  }

  Future journal_list_search_API(String query) async {
    final books = await call_api.getJournal_List(query);

    if (!mounted) return;

    setState(() {
      this.query_journal = query;
      this.JournalData = books;
    });
  }
}