import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class serviceEditScreen extends StatefulWidget {
  final int? service_id;
  const serviceEditScreen({Key? key, this.service_id}) : super(key: key);

  @override
  _serviceEditScreenState createState() => _serviceEditScreenState();
}

class _serviceEditScreenState extends State<serviceEditScreen>  {
  PageController? _pageController;

  final Service_Edit_controller _serviceEditController = Get.put(
      Service_Edit_controller(),
  tag: Service_Edit_controller().toString());  var reg_pan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  var reg_gst = RegExp("^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");
  var reg_email = RegExp("r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';");
  var reg_ifsc = RegExp("^[A-Z]{4}0[A-Z0-9]{6}");

  @override
  void initState() {
    // display_name_list.add(Customer_account_name_controller.text);
    // Customer_birthdate_controller.text = ""; //set the initial value of text field
    _pageController = PageController(initialPage: 0, keepPage: false);
    account_head_controller.text = 'Sundry Creditors';
    pan_number_controller.text = 'BNZAA2318J';
    gisin_number_controller.text = '06BZAHM6385P6Z2';

    super.initState();
    group_name_API();
    account_head();
    product_Edit_get();
  }

  // final List<String> data = <String>[
  //   'Follow Ups',
  //   'Phone Call',
  //   'Site Visit',
  //   'Meeting'
  // ];

  List<String> _viewData = [
    "Product",
    "Services",
  ];

  List g_data = [
    "G1",
    "G2",
    "G3",
  ];
  List sg_data = [
    "SG1",
    "SG2",
    "SG3",
  ];
  List c_d = [
    "SG1",
    "SG2",
    "SG3",
  ];
  List gst_purchase = [
    "00",
    "05",
    "10",
    "15",
    "20",

  ]; List gst_sales = [
    "00",
    "05",
    "10",
    "15",
    "20",

  ];
  List g_r_type = [
    "Registered Under Regular Scheme",
    "Registered Under Composition Scheme",
    "Consumer",
    "Overseas",
    "Sez",
    "Deemed Export",
  ];
  int _indexData = 0;

// Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 2;


  String result = "";

  String? dateSelected;
  bool isChecked = false;



  var data;
  void refresh() {
    setState(() {});
  }

  int? sales_price;

  Future product_Edit_get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://magnetbackend.fsp.media/api/service-master/${widget.service_id}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print("taxinvoice.statusCode");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      // Customer_list_API();
      Map<String, dynamic> Books =
      json.decode(response.body.replaceAll('}[]', '}'));
      print(Books);
      data = Books["data"];
      setState(() {
        service_name_controller.text= data["service_name"];
        sac_code_controller.text= data["sac_code"];
        service_type_controller.text= data["service_type"];
        sales_price = data["sales_price"];
        service_sales_price_controller.text = sales_price.toString();
        service_income_controller.text = data["income_account"];
        print(data);

      });
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Found!');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //customers
  final hsn_code_controller = TextEditingController();
  final product_name_controller = TextEditingController();
  final quentity_hand_controller = TextEditingController();
  final account_head_controller = TextEditingController();
  final group_name_controller = TextEditingController();
  final sub_group_name_controller = TextEditingController();
  final opening_balance_controller = TextEditingController();
  final debit_credit_controller = TextEditingController();
  final date_controller = TextEditingController();
  final gst_regi_type_controller = TextEditingController();
  final pan_number_controller = TextEditingController();
  final gst_purchase_controller = TextEditingController();
  final gst_sales_controller = TextEditingController();
  final income_amount_controller = TextEditingController();
  final expanse_controller = TextEditingController();
  final purchase_price_controller = TextEditingController();
  final sales_price_controller = TextEditingController();
  final low_stock_controller = TextEditingController();
  late final gisin_number_controller = TextEditingController();



  final address_controller = TextEditingController();
  final city_controller = TextEditingController();
  final pincode_controller = TextEditingController();
  final state_controller = TextEditingController();
  final country_controller = TextEditingController();
  final stdcode_controller = TextEditingController();
  final ofc_number_controller = TextEditingController();
  final mobile_number_controller = TextEditingController();
  final email_controller = TextEditingController();

  final bank_name_controller = TextEditingController();
  final account_number_controller = TextEditingController();
  final ifsc_code_controller = TextEditingController();
  final ac_holder_name_controller = TextEditingController();

  final service_name_controller = TextEditingController();
  final sac_code_controller = TextEditingController();
  final service_type_controller = TextEditingController();
  final service_sales_price_controller = TextEditingController();
  final service_income_controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

        body: custom_header(
          labelText: 'Edit Service',
          back: AssetUtils.back_svg,
          backRoute: BindingUtils.product_service_ScreenRoute,
          data:Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 35,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.all(Radius.circular(39.0)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                  height: 7,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(39))),
                    margin: EdgeInsets.only(
                        right:
                        // ((_ledgerScreenSetupController.pageIndex ==
                        //             '02') ||
                        //         (_ledgerScreenSetupController.pageIndex ==
                        //             '03') ||
                        //         (_ledgerScreenSetupController.pageIndex ==
                        //             '04')
                        //     ? screenSize.width/2
                        //     : ((_ledgerScreenSetupController.pageIndex ==
                        //                 '03') ||
                        //             (_ledgerScreenSetupController
                        //                     .pageIndex ==
                        //                 '04')
                        //         ? screenSize.width/3
                        //         : ((_ledgerScreenSetupController
                        //                     .pageIndex ==
                        //                 '04')
                        //             ? screenSize.width
                        //             : screenSize.width)))
                        (_serviceEditController
                            .pageIndex ==
                            '01'
                            ? screenSize.width / 2
                            : (_serviceEditController
                            .pageIndex ==
                            '02'
                            ? screenSize.width / 3
                            : (_serviceEditController
                            .pageIndex ==
                            '03'
                            ? screenSize.width / 4
                            : 0)))),
                  ),
                ),
              ),

              Expanded(child: service_add()),
            ],
          ),

        )
    );
  }

  String Token = "";

  Future service_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": 0,
      "service_name": service_name_controller.text,
      "sac_code": sac_code_controller.text,
      "service_type": service_type_controller.text,
      "sales_price": int.parse(service_sales_price_controller.text),
      "income_account": service_income_controller.text,
      "total_sales": 0,
      "company_profile_id": 0,
      "created_by": 0,
      "update_by": 0
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.service_add_api +'/${widget.service_id}';
    var response = await http.put(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
      body: body,
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.offAllNamed(BindingUtils.product_service_ScreenRoute);
      print('Seccess');
    } else {
      print("error");
    }
  }

  List GroupData = [];
  List SubgroupData = [];
  List AccountHeadsData = [];
  bool tap = true;

  Future group_name_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);

    var url = Api_url.customer_group_api;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(Token);
    // print(responseData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        GroupData = responseData['data'];
        // SubgroupData = GroupData[1]["sub_groups"];
      });
    } else {
      throw Exception("failed");
    }
    // print(GroupData);
  }

  Future account_head() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.account_head_api;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    var resposeData = json.decode(response.body);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        AccountHeadsData = responseData['data'];
        // SubgroupData = GroupData[1]["sub_groups"];
      });
    } else {
      throw Exception("failed");
    }
    print(resposeData);
  }

  Widget service_add() {
    final screenSize = MediaQuery.of(context).size;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return GetBuilder<Service_Edit_controller>(
      init: _serviceEditController,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x17000000),
                blurRadius: 10.0,
                offset: Offset(0.0, 0.75),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: ColorUtils.whiteColor,
          ),
          margin: EdgeInsets.only(
            top: 15,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Edit Service',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                          // fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 19, bottom: 0, left: 20),
                      child: Text(
                        'Account Type',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.ogfont,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: Radio(
                              value: 1,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Product';
                                  id = 1;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Product',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Product'
                                  ? ColorUtils.blueColor
                                  : ColorUtils.ogfont,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: Radio(
                              value: 2,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Service';
                                  id = 2;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Service',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Service'
                                  ? ColorUtils.blueColor
                                  : ColorUtils.ogfont,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0, left: 20),
                      child: Text(
                        'Service Info',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller:
                        service_name_controller,
                        labelText: 'Service Name',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller:
                        sac_code_controller,
                        labelText: 'SAC code',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller:
                        service_type_controller,
                        labelText: 'Service type',
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {


                              _serviceEditController
                                  .pageIndexUpdate('02');
                              _pageController!.jumpToPage(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff007DEF),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 29, vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      fontFamily: 'GR',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Edit Service',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                          // fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 19, bottom: 0, left: 20),
                      child: Text(
                        'Account Type',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.ogfont,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: Radio(
                              value: 1,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Product';
                                  id = 1;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Product',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Product'
                                  ? ColorUtils.blueColor
                                  : ColorUtils.ogfont,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: Radio(
                              value: 2,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Service';
                                  id = 2;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Service',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Service'
                                  ? ColorUtils.blueColor
                                  : ColorUtils.ogfont,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0, left: 20),
                      child: Text(
                        'Sales Details',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: service_sales_price_controller,
                        labelText: 'Sales Price',
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller:
                        service_income_controller,
                        labelText: 'Income Ammount',
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _serviceEditController
                                  .pageIndexUpdate('03');
                              _pageController!.jumpToPage(2);

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.blueColor, width: 1),
                                color: ColorUtils.ogback,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 9),
                                alignment: Alignment.center,
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      fontFamily: 'GR',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorUtils.blueColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              service_API();
                            },
                            child:  Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff007DEF),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 29, vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      fontFamily: 'GR',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
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
      },
    );
  }
}