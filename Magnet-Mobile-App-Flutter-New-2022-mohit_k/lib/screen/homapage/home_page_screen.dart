// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/model_class/company_list.dart';
import 'package:magnet_update/screen/homapage/column_chart.dart';
import 'package:magnet_update/screen/homapage/pie_chart.dart';
import 'package:magnet_update/screen/homapage/spline_chart.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoard_screen_controller _dashBoardScreenController = Get.put(
      DashBoard_screen_controller(),
      tag: DashBoard_screen_controller().toString());
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  String Token = '';
  var Final_sales;
  var Final_payable;
  var Final_receivable;

  final List<String> data = <String>[
    '(2000-2010)',
    '(2010-2020)',
    '(2020-2030)'
  ];
  String selectedValue = '(2020-2030)';
  String? period;

  unit_model? selectedsales;
  unit_model? selectedgst_pay;
  unit_model? selectedgst_receive;

  unit_model? selectedsales_chart;
  unit_model? selectedpurchase_chart;
  unit_model? selectedgst_chart;

  List<unit_model> unit = <unit_model>[
    const unit_model('Today', 'Interval.Today'),
    const unit_model('Yesterday', 'Interval.Yesterday'),
    const unit_model('This-week', 'Interval.THIS_MONTH'),
    const unit_model('This-month', 'Interval.THIS_WEEK'),
    const unit_model('Last-month', 'Interval.LAST_MONTH'),
    const unit_model('Qurter-1', 'Interval.QURTER_1'),
    const unit_model('Qurter-2', 'Interval.QURTER_2'),
    const unit_model('Qurter-3', 'Interval.QURTER_3'),
    const unit_model('Qurter-4', 'Interval.QURTER_4'),
    const unit_model('This-year', 'Interval.THIS_YEAR'),
    const unit_model('last-year', 'Interval.LAST_YEAR'),
  ];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await setting();
    await companyListAPI();
    await sales_Api();
    await payable_Api();
    await receivable_Api();
    await sales_Chart_Api();
    await purchase_Chart_Api();
    await GST_Chart_Api();
  }
  setting(){
    unit_model _stdBilling =
    unit.firstWhere((element) => element.name == "This-year");
    setState(() {
      selectedsales_chart = _stdBilling;
      selectedpurchase_chart = _stdBilling;
      selectedgst_chart = _stdBilling;

      selectedsales = _stdBilling;
      selectedgst_pay = _stdBilling;
      selectedgst_receive = _stdBilling;
    });
  }

  String? Company_id;

  void select_company() {
    final screenSize = MediaQuery.of(context).size;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: screenSize.height / 1.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Company',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(BindingUtils.add_company);
                          },
                          child: Text('Add new Company',
                              style: FontStyleUtility.h14(
                                fontColor: ColorUtils.blueColor,
                                fontWeight: FWT.semiBold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 16, left: 20, right: 20, bottom: 21),
                    // child: build_Customer_Search(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: CompanyListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            //  selected_customer= true;
                            //  setState(
                            //    customer_name = task_cust_name[index]
                            //  );
                            // print(task_cust_name[index]);
                            // setState(() {
                            //   customer_selected = true;
                            // });
                            setState(() {
                              Company_id = CompanyListData[index].id.toString();
                            });
                            company_switch_API();
                            print("Customer_nid");
                            print(Company_id);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: HexColor("E8E8E8"), width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 0),
                              child: Row(
                                children: [
                                  // Container(
                                  //   height: 40,
                                  //   child: ClipRRect(
                                  //       borderRadius:
                                  //           BorderRadius.circular(100),
                                  //       child:
                                  //           CompanyListData[index].logo!.isEmpty
                                  //               ? Container()
                                  //               : Image.network(
                                  //                   "${CompanyListData[index].logo}",
                                  //                   fit: BoxFit.fill,
                                  //                 )),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      visualDensity: VisualDensity(
                                          vertical: -4.0, horizontal: -4.0),
                                      contentPadding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 0.0,
                                          bottom: 0.0,
                                          top: 0.0),
                                      title: Text(
                                        "${CompanyListData[index].companyName}",
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
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: Container(
                                                          color:
                                                              Color(0xff737373),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
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
                                                                    topRight: Radius
                                                                        .circular(
                                                                            30)),
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
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
                                                                        // setState(() {
                                                                        //   selected_customer =
                                                                        //       CustomersData[
                                                                        //       index]
                                                                        //           .id;
                                                                        // });
                                                                        // print(
                                                                        //     selected_customer);
                                                                        // // Get.toNamed(BindingUtils.ledgerScreenEditRoute);
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
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() {
                                                                        //   selected_customer =
                                                                        //       CustomersData[
                                                                        //       index]
                                                                        //           .id;
                                                                        // });
                                                                        // print(
                                                                        //     selected_customer);
                                                                        // Get.to(
                                                                        //     cash_bank_EditScreen(
                                                                        //       customer_id: selected_customer,
                                                                        //     ));
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
                                                                          margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                          decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
                                                                          child: Container(
                                                                              alignment: Alignment.center,
                                                                              margin: EdgeInsets.only(
                                                                                top: 13,
                                                                                bottom: 13,
                                                                              ),
                                                                              child: Text(
                                                                                'Receive Payment',
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
                                                                              'Send Payment Reminder',
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
                                                                              'Create sales',
                                                                              style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xff000000), fontFamily: 'GR'),
                                                                            ))),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() {
                                                                        //   selected_customer =
                                                                        //       CustomersData[
                                                                        //       index]
                                                                        //           .id;
                                                                        // });
                                                                        // print(
                                                                        //     selected_customer);
                                                                        // Get.to(
                                                                        //     ledgerEditScreen(
                                                                        //       customer_as_vendor:selected_customer ,
                                                                        //     ));
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(right: 38, left: 38, bottom: 10),
                                                                          decoration: BoxDecoration(color: Color(0xfff3f3f3), borderRadius: BorderRadius.circular(10)),
                                                                          child: Container(
                                                                              alignment: Alignment.center,
                                                                              margin: const EdgeInsets.only(
                                                                                top: 13,
                                                                                bottom: 13,
                                                                              ),
                                                                              child: const Text(
                                                                                'Copy as Vendor',
                                                                                style: TextStyle(fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.w600, color: Color(0xff000000), fontFamily: 'GR'),
                                                                              ))),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() {
                                                                        //   selected_customer =
                                                                        //       CustomersData[
                                                                        //       index]
                                                                        //           .id;
                                                                        // });
                                                                        // Customer_delete();
                                                                        // print(
                                                                        //     selected_customer);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: const EdgeInsets.only(
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
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          margin:
                                                                              EdgeInsets.only(
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
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          "${CompanyListData[index].companyName}",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: "Gilroy-SemiBold",
                                              fontWeight: FontWeight.w400,
                                              color: HexColor("#BBBBC5"),
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: ColorUtils.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0x17000000),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(
                  AssetUtils.burger,
                  color: Colors.black,
                ))),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Dashboard",
                  style: FontStyleUtility.h15B(
                    fontColor: ColorUtils.blackColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 125,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Tax Type',
                                  style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.greyTextColor,
                                      fontWeight: FWT.medium),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: data
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.greyTextColor,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                            print(selectedValue);
                          },
                          iconSize: 25,
                          // icon: SvgPicture.asset(AssetUtils.drop_svg),
                          iconEnabledColor: Color(0xff007DEF),
                          iconDisabledColor: Color(0xff007DEF),
                          buttonHeight: 30,
                          buttonWidth: 100,
                          buttonPadding:
                              const EdgeInsets.only(left: 15, right: 15),
                          // buttonDecoration: BoxDecoration(
                          //   borderRadius:
                          //   BorderRadius.circular(10),
                          //   color: ColorUtils.whiteColor,
                          // ),
                          buttonElevation: 0,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                select_company();
              },
              child: Text(
                "Magnet Accounting Private Limited",
                style: FontStyleUtility.h12(
                    fontColor: ColorUtils.blueColor, fontWeight: FWT.bold),
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: ColorUtils.whiteColor_2,
        actions: [
          // action button
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.more_vert,
              size: 30.0,
              color: HexColor("#0B0D16"),
            ),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: GetBuilder<DashBoard_screen_controller>(
            init: _dashBoardScreenController,
            builder: (_) {
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.20,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16.0, top: 20.0, bottom: 20.0),
                                height: screenSize.height * 0.15,
                                width: screenSize.width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorUtils.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorUtils.black_light_Color,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 10.0,
                                        spreadRadius: -5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Sales',
                                              style: FontStyleUtility.h16(
                                                fontColor: ColorUtils.blackColor
                                                    .withOpacity(0.7),
                                                fontWeight: FWT.lightBold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 30,
                                              child: FormField<String>(
                                                builder: (FormFieldState<String>
                                                    state) {
                                                  return DropdownButtonHideUnderline(
                                                    child: DropdownButton2<
                                                        unit_model>(
                                                      isExpanded: true,
                                                      hint: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Unit',
                                                              style: FontStyleUtility.h12(
                                                                  fontColor:
                                                                      ColorUtils
                                                                          .ogfont,
                                                                  fontWeight: FWT
                                                                      .semiBold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      items: unit
                                                          .map((unit_model
                                                                  user) =>
                                                              DropdownMenuItem<
                                                                  unit_model>(
                                                                value: user,
                                                                child: Text(
                                                                  user.name,
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          ColorUtils
                                                                              .blackColor,
                                                                      fontWeight:
                                                                          FWT.semiBold),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value: selectedsales,
                                                      onChanged: (newvalue) {
                                                        setState(() {
                                                          selectedsales =
                                                              newvalue;
                                                          print(selectedsales);
                                                          period =
                                                              selectedsales!
                                                                  .name;
                                                          print(selectedsales!
                                                              .name
                                                              .toLowerCase());
                                                          print(period);
                                                          print("period");
                                                          sales_Api();
                                                          // payable_Api();
                                                          // receivable_Api();
                                                        });
                                                      },
                                                      iconSize: 25,
                                                      icon: SvgPicture.asset(
                                                          AssetUtils.drop_svg),
                                                      iconEnabledColor:
                                                          Color(0xff007DEF),
                                                      iconDisabledColor:
                                                          Color(0xff007DEF),
                                                      buttonHeight: 50,
                                                      buttonWidth: 160,
                                                      buttonPadding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorUtils
                                                            .lightblueColor_back,
                                                      ),
                                                      buttonElevation: 0,
                                                      itemHeight: 40,
                                                      itemPadding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      dropdownMaxHeight: 200,
                                                      dropdownPadding: null,
                                                      dropdownDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                      dropdownElevation: 8,
                                                      scrollbarRadius:
                                                          const Radius.circular(
                                                              40),
                                                      scrollbarThickness: 6,
                                                      scrollbarAlwaysShow: true,
                                                      offset:
                                                          const Offset(0, -10),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            (Final_sales != null
                                                ? '₹ ${Final_sales}'
                                                : '0'),
                                            style: FontStyleUtility.h20B(
                                              fontColor: ColorUtils.blueColor,
                                            ),
                                          ),
                                          // const Spacer(),
                                          // Text(
                                          //     (period != null
                                          //         ? '${period}'
                                          //         : 'Time'),
                                          //     style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w400,
                                          //         fontStyle: FontStyle.italic,
                                          //         color: ColorUtils.blackColor
                                          //             .withOpacity(0.7))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16.0, top: 20.0, bottom: 20.0),
                                height: screenSize.height * 0.15,
                                width: screenSize.width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorUtils.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorUtils.black_light_Color,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 10.0,
                                        spreadRadius: -5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'GST Payable',
                                              style: FontStyleUtility.h16(
                                                fontColor: ColorUtils.blackColor
                                                    .withOpacity(0.7),
                                                fontWeight: FWT.lightBold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 30,
                                              child: FormField<String>(
                                                builder: (FormFieldState<String>
                                                    state) {
                                                  return DropdownButtonHideUnderline(
                                                    child: DropdownButton2<
                                                        unit_model>(
                                                      isExpanded: true,
                                                      hint: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Unit',
                                                              style: FontStyleUtility.h12(
                                                                  fontColor:
                                                                      ColorUtils
                                                                          .ogfont,
                                                                  fontWeight: FWT
                                                                      .semiBold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      items: unit
                                                          .map((unit_model
                                                                  user) =>
                                                              DropdownMenuItem<
                                                                  unit_model>(
                                                                value: user,
                                                                child: Text(
                                                                  user.name,
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          ColorUtils
                                                                              .blackColor,
                                                                      fontWeight:
                                                                          FWT.semiBold),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value: selectedgst_pay,
                                                      onChanged: (newvalue) {
                                                        setState(() {
                                                          selectedgst_pay =
                                                              newvalue;
                                                          print(
                                                              selectedgst_pay);
                                                          period =
                                                              selectedgst_pay!
                                                                  .name;
                                                          print(selectedgst_pay!
                                                              .name
                                                              .toLowerCase());
                                                          print(period);
                                                          print("period");
                                                          // sales_Api();
                                                          payable_Api();
                                                          //
                                                          // receivable_Api();
                                                        });
                                                      },
                                                      iconSize: 25,
                                                      icon: SvgPicture.asset(
                                                          AssetUtils.drop_svg),
                                                      iconEnabledColor:
                                                          Color(0xff007DEF),
                                                      iconDisabledColor:
                                                          Color(0xff007DEF),
                                                      buttonHeight: 50,
                                                      buttonWidth: 160,
                                                      buttonPadding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorUtils
                                                            .lightblueColor_back,
                                                      ),
                                                      buttonElevation: 0,
                                                      itemHeight: 40,
                                                      itemPadding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      dropdownMaxHeight: 200,
                                                      dropdownPadding: null,
                                                      dropdownDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                      dropdownElevation: 8,
                                                      scrollbarRadius:
                                                          const Radius.circular(
                                                              40),
                                                      scrollbarThickness: 6,
                                                      scrollbarAlwaysShow: true,
                                                      offset:
                                                          const Offset(0, -10),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            (Final_payable != null
                                                ? '₹ ${Final_payable}'
                                                : '0'),
                                            style: FontStyleUtility.h20B(
                                              fontColor: ColorUtils.blueColor,
                                            ),
                                          ),
                                          // const Spacer(),
                                          // Text(
                                          //     (period != null
                                          //         ? '${period}'
                                          //         : 'Time'),
                                          //     style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w400,
                                          //         fontStyle: FontStyle.italic,
                                          //         color: ColorUtils.whiteColor
                                          //             .withOpacity(0.7))),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16.0,
                                    top: 20.0,
                                    bottom: 20.0,
                                    right: 16),
                                height: screenSize.height * 0.15,
                                width: screenSize.width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorUtils.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorUtils.black_light_Color,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 10.0,
                                        spreadRadius: -5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Gst Receivable',
                                              style: FontStyleUtility.h16(
                                                fontColor: ColorUtils.blackColor
                                                    .withOpacity(0.7),
                                                fontWeight: FWT.lightBold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 30,
                                              child: FormField<String>(
                                                builder: (FormFieldState<String>
                                                    state) {
                                                  return DropdownButtonHideUnderline(
                                                    child: DropdownButton2<
                                                        unit_model>(
                                                      isExpanded: true,
                                                      hint: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Unit',
                                                              style: FontStyleUtility.h12(
                                                                  fontColor:
                                                                      ColorUtils
                                                                          .ogfont,
                                                                  fontWeight: FWT
                                                                      .semiBold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      items: unit
                                                          .map((unit_model
                                                                  user) =>
                                                              DropdownMenuItem<
                                                                  unit_model>(
                                                                value: user,
                                                                child: Text(
                                                                  user.name,
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          ColorUtils
                                                                              .blackColor,
                                                                      fontWeight:
                                                                          FWT.semiBold),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value:
                                                          selectedgst_receive,
                                                      onChanged: (newvalue) {
                                                        setState(() {
                                                          selectedgst_receive =
                                                              newvalue;
                                                          print(
                                                              selectedgst_receive);
                                                          period =
                                                              selectedgst_receive!
                                                                  .name;
                                                          print(selectedgst_receive!
                                                              .name
                                                              .toLowerCase());
                                                          print(period);
                                                          print("period");
                                                          // sales_Api();
                                                          // payable_Api();
                                                          //
                                                          receivable_Api();
                                                        });
                                                      },
                                                      iconSize: 25,
                                                      icon: SvgPicture.asset(
                                                          AssetUtils.drop_svg),
                                                      iconEnabledColor:
                                                          Color(0xff007DEF),
                                                      iconDisabledColor:
                                                          Color(0xff007DEF),
                                                      buttonHeight: 50,
                                                      buttonWidth: 160,
                                                      buttonPadding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorUtils
                                                            .lightblueColor_back,
                                                      ),
                                                      buttonElevation: 0,
                                                      itemHeight: 40,
                                                      itemPadding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      dropdownMaxHeight: 200,
                                                      dropdownPadding: null,
                                                      dropdownDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                      dropdownElevation: 8,
                                                      scrollbarRadius:
                                                          const Radius.circular(
                                                              40),
                                                      scrollbarThickness: 6,
                                                      scrollbarAlwaysShow: true,
                                                      offset:
                                                          const Offset(0, -10),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            (Final_receivable != null
                                                ? '₹ ${Final_receivable}'
                                                : '0'),
                                            style: FontStyleUtility.h20B(
                                              fontColor: ColorUtils.blueColor,
                                            ),
                                          ),
                                          // const Spacer(),
                                          // Text(
                                          //     (period != null
                                          //         ? '${period}'
                                          //         : 'Time'),
                                          //     style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w400,
                                          //         fontStyle: FontStyle.italic,
                                          //         color: ColorUtils.blackColor
                                          //             .withOpacity(0.7))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 31),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Sales',
                                  style: FontStyleUtility.h18(
                                    fontColor: ColorUtils.dark_blue,
                                    fontWeight: FWT.lightBold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton2<unit_model>(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Unit',
                                                  style: FontStyleUtility.h12(
                                                      fontColor:
                                                          ColorUtils.ogfont,
                                                      fontWeight: FWT.semiBold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: unit
                                              .map((unit_model user) =>
                                                  DropdownMenuItem<unit_model>(
                                                    value: user,
                                                    child: Text(
                                                      user.name,
                                                      style: FontStyleUtility.h14(
                                                          fontColor: ColorUtils
                                                              .blackColor,
                                                          fontWeight:
                                                              FWT.semiBold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedsales_chart,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              selectedsales_chart = newvalue;
                                              print(selectedsales_chart);
                                              period =
                                                  selectedsales_chart!.name;
                                              print(selectedsales_chart!.name
                                                  .toLowerCase());
                                              print(period);
                                              print("period");
                                              // sales_Api();
                                              sales_list.clear();
                                              sales_Chart_Api();
                                              // payable_Api();
                                              // receivable_Api();
                                            });
                                          },
                                          iconSize: 25,
                                          icon: SvgPicture.asset(
                                              AssetUtils.drop_svg),
                                          iconEnabledColor: Color(0xff007DEF),
                                          iconDisabledColor: Color(0xff007DEF),
                                          buttonHeight: 50,
                                          buttonWidth: 160,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorUtils.containerBgColor,
                                          ),
                                          buttonElevation: 0,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(0, -10),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: spline_chart_graph(data: sales_list,),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 31),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Purchase',
                                  style: FontStyleUtility.h18(
                                    fontColor: ColorUtils.dark_blue,
                                    fontWeight: FWT.lightBold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton2<unit_model>(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Unit',
                                                  style: FontStyleUtility.h12(
                                                      fontColor:
                                                          ColorUtils.ogfont,
                                                      fontWeight: FWT.semiBold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: unit
                                              .map((unit_model user) =>
                                                  DropdownMenuItem<unit_model>(
                                                    value: user,
                                                    child: Text(
                                                      user.name,
                                                      style: FontStyleUtility.h14(
                                                          fontColor: ColorUtils
                                                              .blackColor,
                                                          fontWeight:
                                                              FWT.semiBold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedpurchase_chart,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              selectedpurchase_chart = newvalue;
                                              print(selectedpurchase_chart);
                                              period = selectedpurchase_chart!.name;
                                              print(selectedpurchase_chart!.name
                                                  .toLowerCase());
                                              print(period);
                                              print("period");
                                              purchase_list.clear();
                                              purchase_Chart_Api();
                                              // payable_Api();
                                              // receivable_Api();
                                            });
                                          },
                                          iconSize: 25,
                                          icon: SvgPicture.asset(
                                              AssetUtils.drop_svg),
                                          iconEnabledColor: Color(0xff007DEF),
                                          iconDisabledColor: Color(0xff007DEF),
                                          buttonHeight: 50,
                                          buttonWidth: 160,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorUtils.containerBgColor,
                                          ),
                                          buttonElevation: 0,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(0, -10),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: spline_chart_graph(
                            data: purchase_list ,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 31),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'GST',
                                  style: FontStyleUtility.h18(
                                    fontColor: ColorUtils.dark_blue,
                                    fontWeight: FWT.lightBold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton2<unit_model>(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Unit',
                                                  style: FontStyleUtility.h12(
                                                      fontColor:
                                                      ColorUtils.ogfont,
                                                      fontWeight: FWT.semiBold),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: unit
                                              .map((unit_model user) =>
                                              DropdownMenuItem<unit_model>(
                                                value: user,
                                                child: Text(
                                                  user.name,
                                                  style: FontStyleUtility.h14(
                                                      fontColor: ColorUtils
                                                          .blackColor,
                                                      fontWeight:
                                                      FWT.semiBold),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ))
                                              .toList(),
                                          value: selectedgst_chart,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              selectedgst_chart = newvalue;
                                              print(selectedgst_chart);
                                              period = selectedgst_chart!.name;
                                              print(selectedgst_chart!.name
                                                  .toLowerCase());
                                              print(period);
                                              print("period");
                                              gst_payable_list.clear();
                                              GST_Chart_Api();
                                              // purchase_list.clear();
                                              // purchase_Chart_Api();
                                              // payable_Api();
                                              // receivable_Api();
                                            });
                                          },
                                          iconSize: 25,
                                          icon: SvgPicture.asset(
                                              AssetUtils.drop_svg),
                                          iconEnabledColor: Color(0xff007DEF),
                                          iconDisabledColor: Color(0xff007DEF),
                                          buttonHeight: 50,
                                          buttonWidth: 160,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: ColorUtils.containerBgColor,
                                          ),
                                          buttonElevation: 0,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                          const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(0, -10),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: column_chart_graph(
                            data: gst_payable_list ,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 31),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Purchase',
                                  style: FontStyleUtility.h18(
                                    fontColor: ColorUtils.dark_blue,
                                    fontWeight: FWT.lightBold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton2<unit_model>(
                                          isExpanded: true,
                                          hint: Row(
                                            children: [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Unit',
                                                  style: FontStyleUtility.h12(
                                                      fontColor:
                                                          ColorUtils.ogfont,
                                                      fontWeight: FWT.semiBold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: unit
                                              .map((unit_model user) =>
                                                  DropdownMenuItem<unit_model>(
                                                    value: user,
                                                    child: Text(
                                                      user.name,
                                                      style: FontStyleUtility.h14(
                                                          fontColor: ColorUtils
                                                              .blackColor,
                                                          fontWeight:
                                                              FWT.semiBold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedsales,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              selectedsales = newvalue;
                                              print(selectedsales);
                                              period = selectedsales!.name;
                                              print(selectedsales!.name
                                                  .toLowerCase());
                                              print(period);
                                              print("period");
                                              sales_Api();
                                              // payable_Api();
                                              // receivable_Api();
                                            });
                                          },
                                          iconSize: 25,
                                          icon: SvgPicture.asset(
                                              AssetUtils.drop_svg),
                                          iconEnabledColor: Color(0xff007DEF),
                                          iconDisabledColor: Color(0xff007DEF),
                                          buttonHeight: 50,
                                          buttonWidth: 160,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorUtils.containerBgColor,
                                          ),
                                          buttonElevation: 0,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(0, -10),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: pie_chart(
                            data: [
                              PieData(2010, 10.5, '90%'),
                              PieData(2011, 9.5, '80%'),
                              PieData(2012, 10.6, '90%'),
                              PieData(2013, 9.4, '65%'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _dashBoardScreenController.isFloatingAction,
                    child: Positioned(
                      bottom: 50,
                      left: 12,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorUtils.blueColor,
                            radius: 25,
                            child: Icon(
                              Icons.filter_alt_sharp,
                              color: ColorUtils.whiteColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Manage Shortcuts',
                            style: FontStyleUtility.h16(
                              fontColor: ColorUtils.blueColor,
                              fontWeight: FWT.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
      floatingActionButton: GetBuilder<DashBoard_screen_controller>(
          init: _dashBoardScreenController,
          builder: (_) {
            return SpeedDial(
              animatedIcon: AnimatedIcons.add_event,
              animatedIconTheme:
                  IconThemeData(size: 22.0, color: ColorUtils.whiteColor),
              activeIcon: IconData(0xf04b6),
              visible: true,
              curve: Curves.bounceIn,
              overlayColor: HexColor("#FFFFFF"),
              overlayOpacity: 0.95,
              backgroundColor: ColorUtils.blueColor,
              onOpen: () {
                _dashBoardScreenController.isFloatingActionUpdate(true);
              },
              onClose: () {
                _dashBoardScreenController.isFloatingActionUpdate(false);
              },
              activeBackgroundColor: HexColor('#3B7AF1'),
              foregroundColor: Colors.black,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.editPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Create Tax Invoice',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.tax_invoice_setup_ScreenRoute);
                  },
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.editPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Create Cash Memo',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.cash_memo_setup_ScreenRoute);
                  },
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.editPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Create Bill of Supply',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.bill_supply_setup_ScreenRoute);
                  },
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.addPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Add Purchase',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.purchase_setup_Route);
                  },
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.addPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  labelBackgroundColor: Colors.white,
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Add Customer',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.ledgerSetupScreenRoute);
                  },
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.addPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Add Vendor',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.ledgerSetupScreenRoute);
                  },
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.printPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Record Received Payment',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {},
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.printPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Record Paid Payment',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {},
                ),
                SpeedDialChild(
                  child: Image(
                    image: AssetImage(AssetUtils.addPng),
                    height: screenSize.height * 0.02,
                    width: screenSize.height * 0.02,
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: ColorUtils.oxffCFDFFD,
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Add Expense',
                      style: TextStyle(
                          fontFamily: "GR",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#0B0D16")),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(BindingUtils.expanses_Screen_SetupRoute);
                  },
                ),
              ],
            );
          }),
    );
  }

  List<ChartData> sales_list = [];
  List data_sales = [];

  List<ChartData> purchase_list = [];
  List data_purchase = [];

  List<ColumnData> gst_payable_list = [];
  List data_gst_payable = [];

  List<ColumnData> gst_receivable_list = [];
  List data_gst_receivable = [];

  var x_axis;

  Future sales_Api() async {
   var url =
         Api_url.main_magnet_url + 'dashboard/total-sales/${selectedsales!.name.toLowerCase()}';
    var response = await http_service.get_Data(url);
    if (response["success"]) {
      print("response_sales : $response");
      var books = response["data"];
      setState(() {
        double value = books["total_sales"];
        Final_sales = value.toStringAsFixed(3);
      });
      return Final_sales;
    }
  }

  Future payable_Api() async {
     var url =
        'https://www.magnetbackend.fsp.media/api/dashboard/total-gst-payable/${selectedgst_pay!.name.toLowerCase()}';
    var response = await http_service.get_Data(url);
    if (response["success"]) {
     print("response_payable : $response");
      var books = response["data"];
      setState(() {
        double value=  books["total_gst_payable"];
        Final_payable = value.toStringAsFixed(3);
      });
      return Final_payable;
    }
  }

  Future receivable_Api() async {
    var url =
        'https://www.magnetbackend.fsp.media/api/dashboard/total-gst-receivable/${selectedgst_receive!.name.toLowerCase()}';
    var response = await http_service.get_Data(url);
    if (response["success"]) {
      var books = response["data"];
      print("response_receivable : $response");
      setState(() {
        double value = books["total_gst_receivable"];
        Final_receivable = value.toStringAsFixed(3);
       });
      return Final_receivable;
    }
  }

  Future sales_Chart_Api() async {
    var url =
        Api_url.main_magnet_url +'dashboard/sales-chart-data/${selectedsales_chart!.name.toLowerCase()}';
    var response = await http_service.get_Data(url);
    if (response["success"]) {
      print("data_sales: $response");
      List books = response["data"];
      setState(() {
        data_sales = books;
      });
      for (var i = 0; i < data_sales.length; i++) {
        (selectedsales_chart!.value == 'Interval.QURTER_1' ||
            selectedsales_chart!.value == 'Interval.QURTER_2' ||
            selectedsales_chart!.value == 'Interval.QURTER_3' ||
            selectedsales_chart!.value == 'Interval.QURTER_4' ||
            selectedsales_chart!.value == 'Interval.THIS_YEAR' ||
            selectedsales_chart!.value == 'Interval.LAST_YEAR'
            ? x_axis = data_sales[i]["month"]
            : (selectedsales_chart!.value == 'Interval.THIS_MONTH' ||
            selectedsales_chart!.value == 'Interval.THIS_WEEK' ||
            selectedsales_chart!.value == 'Interval.LAST_MONTH'
            ? x_axis = data_sales[i]["day"]
            : (selectedsales_chart!.value == 'Interval.Today' ||
            selectedsales_chart!.value == 'Interval.Yesterday'
            ? x_axis = data_sales[i]["day"]
            : x_axis = data_sales[i]["month"])));

        // x_axis = data_sales[i]["month"];
        var y = data_sales[i]['value'];
        sales_list.add(ChartData(
          y,
          x_axis,
        ));
      }
      print("sales_list");
      print(sales_list);
      return data_sales;
    }
  }
  Future purchase_Chart_Api() async {
    var url =
        Api_url.main_magnet_url +'dashboard/purchase-chart-data/${selectedpurchase_chart!.name.toLowerCase()}';
    var response = await http_service.get_Data(url);
    if (response["success"]) {
      List books = response["data"];
      print("response_purchase : $response");
      setState(() {
        data_purchase = books;
      });
      for (var i = 0; i < data_purchase.length; i++) {
        (selectedsales_chart!.value == 'Interval.QURTER_1' ||
            selectedsales_chart!.value == 'Interval.QURTER_2' ||
            selectedsales_chart!.value == 'Interval.QURTER_3' ||
            selectedsales_chart!.value == 'Interval.QURTER_4' ||
            selectedsales_chart!.value == 'Interval.THIS_YEAR' ||
            selectedsales_chart!.value == 'Interval.LAST_YEAR'
            ? x_axis = data_purchase[i]["month"]
            : (selectedsales_chart!.value == 'Interval.THIS_MONTH' ||
            selectedsales_chart!.value == 'Interval.THIS_WEEK' ||
            selectedsales_chart!.value == 'Interval.LAST_MONTH'
            ? x_axis = data_purchase[i]["day"]
            : (selectedsales_chart!.value == 'Interval.Today' ||
            selectedsales_chart!.value == 'Interval.Yesterday'
            ? x_axis = data_purchase[i]["day"]
            : x_axis = data_purchase[i]["month"])));

        // x_axis = data_sales[i]["month"];
        var y = data_purchase[i]['value'];
        purchase_list.add(ChartData(
          y,
          x_axis,
        ));
      }

      return data_sales;
    } else {
      throw Exception('Failed to load');
    }
  }
  Future GST_Chart_Api() async {
    var url =
        Api_url.main_magnet_url +'dashboard/gst-chart-data/${selectedgst_chart!.name.toLowerCase()}';
    var response = await http_service.get_Data(url);
    if (response["success"]) {
      var books = response["data"];
      print("respnse_gst: $response");
      setState(() {
        data_gst_payable = books["gstPayableChartData"];
        data_gst_receivable = books["gstReceivableChartData"];
        });
      print("data_gst_payable : $data_gst_payable");
      print("data_gst_receivable : $data_gst_receivable");

      for (var i = 0; i < data_gst_payable.length; i++) {
        (selectedsales_chart!.value == 'Interval.QURTER_1' ||
            selectedsales_chart!.value == 'Interval.QURTER_2' ||
            selectedsales_chart!.value == 'Interval.QURTER_3' ||
            selectedsales_chart!.value == 'Interval.QURTER_4' ||
            selectedsales_chart!.value == 'Interval.THIS_YEAR' ||
            selectedsales_chart!.value == 'Interval.LAST_YEAR'
            ? x_axis = data_gst_payable[i]["month"]
            : (selectedsales_chart!.value == 'Interval.THIS_MONTH' ||
            selectedsales_chart!.value == 'Interval.THIS_WEEK' ||
            selectedsales_chart!.value == 'Interval.LAST_MONTH'
            ? x_axis = data_gst_payable[i]["day"]
            : (selectedsales_chart!.value == 'Interval.Today' ||
            selectedsales_chart!.value == 'Interval.Yesterday'
            ? x_axis = data_gst_payable[i]["day"]
            : x_axis = data_gst_payable[i]["month"])));

        // x_axis = data_sales[i]["month"];
        var y1 = data_gst_payable[i]['value'];
        var y2 = data_gst_receivable[i]['value'];
        gst_payable_list.add(ColumnData(  x_axis,y1,y2,));
      }

      return data_gst_receivable;
    } else {
      throw Exception('Failed to load');
    }
  }

  String userID = "";
  List<Data_company> CompanyListData = [];
  var switch_companyToken;

  Future<List<Data_company>> companyListAPI() async {
    userID = await PreferenceManager().getPref(Api_url.user_id);
    var url = Api_url.company_list_api + '${userID}';
    final response = await http_service.get_Data(url);
    print(response);
    if (response["success"]) {
      print("response_companyList : $response");
      List books = response["data"];
      var data = books.map((json) => Data_company.fromJson(json)).toList();
      setState(() {
        CompanyListData = data;
      });
    }
    return CompanyListData;
  }

  Future company_switch_API() async {
    userID = await PreferenceManager().getPref(Api_url.user_id);
    print(Token);
    var url = Api_url.company_switch_api + '${Company_id}';
    final response = await http_service.get_Data(url);
    print(response);
    print("switch");
    setState(() {
      Token = response["token"];
    });
    await PreferenceManager().setPref(Api_url.token, Token);

    print(switch_companyToken);
  }
}

class unit_model {
  const unit_model(this.name, this.value);

  final String name;
  final String value;
}

class circularData {
  circularData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
