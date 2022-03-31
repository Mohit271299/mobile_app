import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/model_class/account_head_model.dart';
import 'package:magnet_update/model_class/customer_ledger_model.dart';
import 'package:magnet_update/model_class/state_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class ledgerSetupScreen extends StatefulWidget {
  const ledgerSetupScreen({Key? key}) : super(key: key);

  @override
  _ledgerSetupScreenState createState() => _ledgerSetupScreenState();
}

class _ledgerSetupScreenState extends State<ledgerSetupScreen> {
  PageController? _pageController_customer;
  PageController? _pageController_vendors;
  PageController? _pageController_others;
  final Ledger_Setup_controller _ledgerScreenSetup_customer_Controller =
      Get.find(tag: Ledger_Setup_controller().toString());
  var reg_pan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  var reg_gst =
      RegExp("^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  var reg_email = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  var reg_ifsc = RegExp("^[A-Z]{4}0[A-Z0-9]{6}");

  @override
  void initState() {
    // display_name_list.add(Customer_account_name_controller.text);
    // Customer_birthdate_controller.text = ""; //set the initial value of text field
    _pageController_customer = PageController(initialPage: 0, keepPage: false);
    Customer_account_head_controller.text = 'Sundry Creditors';
    Customer_pan_number_controller.text = 'BNZAA2318J';
    // Customer_gisin_number_controller.text = '06BZAHM6385P6Z2';
    super.initState();
    group_name_API();
    accountHead_list_API();
    State_list_API();
 print(_selectedAccounthead);
  }

  // final List<String> data = <String>[
  //   'Follow Ups',
  //   'Phone Call',
  //   'Site Visit',
  //   'Meeting'
  // ];
  ScaffoldMessengerState? scaffoldMessenger;

  List<String> _viewData = [
    "Customers",
    "Vendors",
    "Others",
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
    "credit",
    "debit",
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
  String radioButtonItem = '';

  // Group Value for Radio Button.
  int id = 1;

  String _selectedCustomer = 'Customer';
  String? _selectedgroup;
  Data_state? _selectedstate_billing;
  Data_state? _selectedstate_shipping;
  String? _selectedsubgroup;
  String? _selecteddisplayname;
  String? _selectedd_b;
  String? _selectedr_type;
  Data_ac_head? _selectedAccounthead;

  String result = "";

  String? dateSelected;
  bool isChecked = false;

  bool birth_date = false;
  bool company_name_validate = true;
  bool display_name_validate = true;
  bool gst_type_validate = true;

  Future<void> _showIOS_DatePicker(ctx) async {
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
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        Customer_birthdate_controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void dispose() {
    hideLoader(context);
    // TODO: implement dispose
    super.dispose();
  }

  //customers
  final Customer_company_name_controller = TextEditingController();
  final Customer_name_controller = TextEditingController();
  final Customer_display_name_controller = TextEditingController();
  final Customer_account_head_controller = TextEditingController();
  final Customer_group_name_controller = TextEditingController();
  final Customer_sub_group_name_controller = TextEditingController();
  final Customer_opening_balance_controller = TextEditingController();
  final Customer_debit_credit_controller = TextEditingController();
  final Customer_birthdate_controller = TextEditingController();
  final Customer_gst_regi_type_controller = TextEditingController();
  final Customer_pan_number_controller = TextEditingController();
  late final Customer_gisin_number_controller = TextEditingController();

  //Registerd-address-billing
  final Customer_address_controller = TextEditingController();
  final Customer_city_controller = TextEditingController();
  final Customer_pincode_controller = TextEditingController();
  final Customer_state_controller = TextEditingController();
  final Customer_country_controller = TextEditingController();
  final Customer_stdcode_controller = TextEditingController();
  final Customer_ofc_number_controller = TextEditingController();
  final Customer_mobile_number_controller = TextEditingController();
  final Customer_email_controller = TextEditingController();

  //Registerd-address-shippiing
  final shipping_Customer_address_controller = TextEditingController();
  final shipping_Customer_city_controller = TextEditingController();
  final shipping_Customer_pincode_controller = TextEditingController();
  final shipping_Customer_state_controller = TextEditingController();
  final shipping_Customer_country_controller = TextEditingController();
  final shipping_Customer_stdcode_controller = TextEditingController();
  final shipping_Customer_ofc_number_controller = TextEditingController();
  final shipping_Customer_mobile_number_controller = TextEditingController();
  final shipping_Customer_email_controller = TextEditingController();

  final Customer_bank_name_controller = TextEditingController();
  final Customer_account_number_controller = TextEditingController();
  final Customer_ifsc_code_controller = TextEditingController();
  final Customer_ac_holder_name_controller = TextEditingController();

  gst_type? selectedUnit;
  List<gst_type> gst = <gst_type>[
    const gst_type('Registered Under Regular Scheme', 'registered_under_regular_scheme'),
    const gst_type('Registered Under Composition Scheme', 'registered_under_composition_scheme'),
    const gst_type('Unregistered', 'unregistered'),
    const gst_type('Consumer', 'consumer'),
    const gst_type('Overseas', 'overseas'),
    const gst_type('Sez', 'sez'),
    const gst_type('Deemed Export', 'deemed_export'),

  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: ColorUtils.blueColor,
        // ),
        body: custom_header(
      labelText: 'Add Ledger',
      back: AssetUtils.back_svg,
      backRoute: BindingUtils.ledgerScreenRoute,
      data: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          // margin: EdgeInsets.only(top: 15),
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(15),
          //     topLeft: Radius.circular(15),
          //   ),
          //   color: Color(0xfff3f3f3),
          // ),
          child: Column(
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
                    ]),
                margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                height: 34,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.all(Radius.circular(39.0)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                  height: 0,
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
                            (_ledgerScreenSetup_customer_Controller
                                        .pageIndex_customer ==
                                    '01'
                                ? screenSize.width / 2
                                : (_ledgerScreenSetup_customer_Controller
                                            .pageIndex_customer ==
                                        '02'
                                    ? screenSize.width / 3
                                    : (_ledgerScreenSetup_customer_Controller
                                                .pageIndex_customer ==
                                            '03'
                                        ? screenSize.width / 4
                                        : 0)))),
                  ),
                ),
              ),
              Expanded(
                child: ledger_setup(),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  String Token = "";

  Future customers_API() async {
    showLoader(context);
    print('calling');
    Map data = {
      "id": '',
      "ledger_type": "customer",
      "profile_photo": "string",
      "account_name": Customer_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": _selectedAccounthead!.id,
      "company_profile_id": 1,
      "group_id": int.parse(_selectedgroup!),
      "sub_group_id": int.parse(_selectedsubgroup!),
      "as_of_date": Customer_birthdate_controller.text,
      "gst_type": Customer_gst_regi_type_controller.text,
      "pan_number": Customer_pan_number_controller.text,
      "gst_in": Customer_gisin_number_controller.text,
      "ifsc_code": Customer_ifsc_code_controller.text,
      "bank_name": Customer_bank_name_controller.text,
      "account_no": Customer_account_number_controller.text,
      "account_holder_name": Customer_ac_holder_name_controller.text,
      "status": true,
      // "company_profile_id": ,
      "addresses": [
        {
          // "id": 0,
          "address": Customer_address_controller.text,
          "pincode": Customer_pincode_controller.text,
          "city": Customer_city_controller.text,
          "state": _selectedstate_billing!.id.toString(),
          // "state_code": Customer_stdcode_controller.text,
          "country": Customer_country_controller.text,
          "std_code": Customer_stdcode_controller.text,
          "office_no": Customer_ofc_number_controller.text,
          "mobile_no": Customer_mobile_number_controller.text,
          "email": Customer_email_controller.text,
          "address_type": "billing",
          // "customer_id": 0,
          // "vendor_id": 0,
          // "other_ledger_id": 0
        }
      ],
      "opening_balance": int.parse(Customer_opening_balance_controller.text),
      "opening_type": _selectedd_b,
      "closing_balance": 0,
      "closing_type": "debit",
      "total_sales": 0,
      "created_at": "2021-12-30T10:29:38.745Z",
      "update_at": "2021-12-30T10:29:38.745Z",
      // "created_by": 0,
      // "updated_by": 0
    };

    print(data);

    var url = Api_url.customer_ledger_api;
    var response = await http_service.post(url, data);
    if (response["success"]) {
      hideLoader(context);
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
    }
  }

  Future vendors_API() async {
    showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '',
      "ledger_type": "vendor",
      "profile_photo": "string",
      "account_name": Customer_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": _selectedAccounthead!.id,
      "company_profile_id": 1,
      "group_id": int.parse(_selectedgroup!),
      "sub_group_id": int.parse(_selectedsubgroup!),
      "as_of_date": Customer_birthdate_controller.text,
      "gst_type": Customer_gst_regi_type_controller.text,
      "pan_number": Customer_pan_number_controller.text,
      "gst_in": Customer_gisin_number_controller.text,
      "ifsc_code": Customer_ifsc_code_controller.text,
      "bank_name": Customer_bank_name_controller.text,
      "account_no": Customer_account_number_controller.text,
      "account_holder_name": Customer_ac_holder_name_controller.text,
      "status": true,
      // "company_profile_id": ,
      "addresses": [
        {
          // "id": 0,
          "address": Customer_address_controller.text,
          "pincode": Customer_pincode_controller.text,
          "city": Customer_city_controller.text,
          "state": Customer_state_controller.text,
          // "state_code": Customer_stdcode_controller.text,
          "country": Customer_country_controller.text,
          "std_code": _selectedstate_billing!.id.toString(),
          "office_no": Customer_ofc_number_controller.text,
          "mobile_no": Customer_mobile_number_controller.text,
          "email": Customer_email_controller.text,
          "address_type": "billing",
          // "customer_id": 0,
          // "vendor_id": 0,
          // "other_ledger_id": 0
        }
      ],
      "opening_balance": int.parse(Customer_opening_balance_controller.text),
      "opening_type": _selectedd_b,
      "closing_balance": 0,
      "closing_type": "debit",
      "total_sales": 0,
      "created_at": "2021-12-30T10:29:38.745Z",
      "update_at": "2021-12-30T10:29:38.745Z",
      // "created_by": 0,
      // "updated_by": 0
    };

    print(data);
    var url = Api_url.vendors_ledger_api;
    var response = await http_service.post(url, data);

    if (response["success"]) {
      hideLoader(context);

      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
    }
  }

  Future others_API() async {
    showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "ledger_type": "other",
      "profile_photo": "string",
      "account_name": Customer_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": _selectedAccounthead!.id,
      "company_profile_id": 1,
      "group_id": int.parse(_selectedgroup!),
      "sub_group_id": int.parse(_selectedsubgroup!),
      "as_of_date": Customer_birthdate_controller.text,
      "gst_type": Customer_gst_regi_type_controller.text,
      "pan_number": Customer_pan_number_controller.text,
      "gst_in": Customer_gisin_number_controller.text,
      "ifsc_code": Customer_ifsc_code_controller.text,
      "bank_name": Customer_bank_name_controller.text,
      "account_no": Customer_account_number_controller.text,
      "account_holder_name": Customer_ac_holder_name_controller.text,
      "status": true,
      // "company_profile_id": ,
      "addresses": [
        {
          // "id": 0,
          "address": Customer_address_controller.text,
          "pincode": Customer_pincode_controller.text,
          "city": Customer_city_controller.text,
          "state": _selectedstate_billing!.id.toString(),
          // "state_code": Customer_stdcode_controller.text,
          "country": Customer_country_controller.text,
          "std_code": Customer_stdcode_controller.text,
          "office_no": Customer_ofc_number_controller.text,
          "mobile_no": Customer_mobile_number_controller.text,
          "email": Customer_email_controller.text,
          "address_type": "billing",
          // "customer_id": 0,
          // "vendor_id": 0,
          // "other_ledger_id": 0
        }
      ],
      "opening_balance": int.parse(Customer_opening_balance_controller.text),
      "opening_type": _selectedd_b,
      "closing_balance": 0,
      "closing_type": "debit",
      "total_sales": 0,
      "created_at": "2021-12-30T10:29:38.745Z",
      "update_at": "2021-12-30T10:29:38.745Z",
      // "created_by": 0,
      // "updated_by": 0
    };
    print(data);
    var url = Api_url.others_ledger_api;
    var response = await http_service.post(url, data);
    if (response["success"]) {
      hideLoader(context);
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
    }
  }

  List GroupData = [];
  List<Data_state> stateData = [];
  List<Data_ac_head> acHeadData = [];
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

  Future State_list_API() async {

    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.state_API();

    setState(() => this.stateData = books);

    print(stateData);
  }
  Future accountHead_list_API() async {

    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.accountHead_API();

    setState(() => this.acHeadData = books);
    setState(() {
      _selectedAccounthead = acHeadData[29];
    });
    print(acHeadData);
  }

  // Future account_head() async {
  //   Token = await PreferenceManager().getPref(Api_url.token);
  //   var url = Api_url.account_head_api;
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
  //       AccountHeadsData = responseData['data'];
  //       // SubgroupData = GroupData[1]["sub_groups"];
  //     });
  //   } else {
  //     throw Exception("failed");
  //   }
  //   print("AccountHead");
  //   print(resposeData);
  // }

  List display_name_list = [];

  Widget ledger_setup() {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<Ledger_Setup_controller>(
      init: _ledgerScreenSetup_customer_Controller,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorUtils.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0x17000000),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.75),
                ),
              ]),
          margin: EdgeInsets.only(
            top: 15,
            left: 20,
            bottom: 20,
            right: 20,
          ),
          child: PageView(
            controller: _pageController_customer,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Add Ledger',
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
                        style: FontStyleUtility.h12(
                          fontColor: ColorUtils.grey_font,
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
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      ColorUtils.lightBlueradio,
                                  disabledColor: Colors.blue),
                              child: Radio(
                                // fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: 1,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Customer';

                                    id = 1;
                                    _selectedAccounthead = acHeadData[29];
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Customer',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Customer'
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
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      ColorUtils.lightBlueradio,
                                  disabledColor: Colors.blue),
                              child: Radio(
                                // fillColor: MaterialStateProperty.resolveWith(getColor),

                                value: 2,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Vendor';
                                    id = 2;
                                    _selectedAccounthead = acHeadData[28];
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Vendor',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Vendor'
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
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      ColorUtils.lightBlueradio,
                                  disabledColor: Colors.blue),
                              child: Radio(
                                value: 3,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'Others';
                                    id = 3;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Others',
                            style: FontStyleUtility.h12(
                              fontColor: radioButtonItem == 'Others'
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
                        'Basic Information',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (company_name_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (company_name_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        onChanged: (val) {
                          _update();
                        },
                        tap: () {
                          setState(() {
                            company_name_validate = true;
                          });
                        },
                        controller: Customer_company_name_controller,
                        labelText: 'Company Name',
                      ),
                    ),
                    Container(

                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        onChanged: (val) {
                          _update();
                        },

                        controller: Customer_name_controller,
                        labelText: 'Customer Name',
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                          border: (display_name_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (display_name_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
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
                                      'Display Name As',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: display_name_list
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: FontStyleUtility.h14(
                                              fontColor: ColorUtils.blackColor,
                                              fontWeight: FWT.semiBold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _selecteddisplayname,
                              onChanged: (value) {
                                setState(() {
                                  setState(() {
                                    display_name_validate = true;
                                  });
                                  _selecteddisplayname = value as String;
                                  Customer_display_name_controller.text =
                                      _selecteddisplayname!;
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
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
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<Data_ac_head>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Account Head',
                                  style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: acHeadData.map(
                              (Data_ac_head item) => DropdownMenuItem<Data_ac_head>(
                                    onTap: () {
                                      setState(() {
                                        tap = false;
                                      });
                                    },
                                    value: item,
                                    child: Text(
                                      "${item.accountHeadName}",
                                      style: FontStyleUtility.h14(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )).toList(),
                          value: _selectedAccounthead,
                          onChanged: (value) {
                            tap == true
                                ? setState(() {
                                    // _selectedAccounthead = "hello";
                                    Customer_account_head_controller.text =
                                        _selectedAccounthead!.accountHeadName!;
                                  })
                                : setState(() {
                                    _selectedAccounthead = value;
                                    Customer_account_head_controller.text =
                                        _selectedAccounthead!.accountHeadName!;
                                  });
                            print(_selectedAccounthead!.id);
                          },
                          iconSize: 25,
                          icon: SvgPicture.asset(AssetUtils.drop_svg),
                          iconEnabledColor: Color(0xff007DEF),
                          iconDisabledColor: Color(0xff007DEF),
                          buttonHeight: 50,
                          buttonWidth: 160,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorUtils.ogback,
                          ),
                          buttonElevation: 0,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 15, right: 14),
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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
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
                                      'Group Name',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: GroupData.map(
                                  (item) => DropdownMenuItem<String>(
                                        value: item["id"].toString(),
                                        child: Text(
                                          item["name"],
                                          style: FontStyleUtility.h14(
                                              fontColor: ColorUtils.blackColor,
                                              fontWeight: FWT.semiBold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )).toList(),
                              value: _selectedgroup,
                              onChanged: (value) {
                                print(_selectedgroup);
                                for (var i = 0; i < GroupData.length; ++i) {
                                  var g = GroupData[i];
                                  if (g["id"].toString() == value) {
                                    SubgroupData = g["sub_groups"];
                                  }
                                }
                                setState(() {
                                  _selectedgroup = value as String?;
                                  // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                  // print(_selectedgroup);
                                  Customer_group_name_controller.text =
                                      _selectedgroup! as String;
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
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
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Sub Group Name',
                                  style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: SubgroupData.map(
                              (item) => DropdownMenuItem<String>(
                                    value: item["id"].toString(),
                                    child: Text(
                                      item["name"],
                                      style: FontStyleUtility.h14(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )).toList(),
                          value: _selectedsubgroup,
                          onChanged: (value) {
                            setState(() {
                              _selectedsubgroup = value as String?;
                              Customer_sub_group_name_controller.text =
                                  _selectedsubgroup!;
                            });
                          },
                          iconSize: 25,
                          icon: SvgPicture.asset(AssetUtils.drop_svg),
                          iconEnabledColor: Color(0xff007DEF),
                          iconDisabledColor: Color(0xff007DEF),
                          buttonHeight: 50,
                          buttonWidth: 160,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorUtils.ogback,
                          ),
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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_opening_balance_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Opening Balance',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
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
                                      'Debit/Credit',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: c_d
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: FontStyleUtility.h14(
                                              fontColor: ColorUtils.blackColor,
                                              fontWeight: FWT.semiBold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: _selectedd_b,
                              onChanged: (value) {
                                setState(() {
                                  _selectedd_b = value as String;
                                  Customer_debit_credit_controller.text =
                                      _selectedd_b!;
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
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
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                        border: (birth_date == true
                            ? Border.all(
                                color: ColorUtils.blueColor, width: 1.5)
                            : Border.all(color: Colors.transparent, width: 1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                setState(() {
                                  birth_date = true;
                                });
                                _showIOS_DatePicker(context);
                              },
                              showCursor: true,
                              readOnly: true,
                              controller: Customer_birthdate_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 5),
                                labelText: 'Birth Date',
                                labelStyle: FontStyleUtility.h12(
                                    fontColor: ColorUtils.ogfont,
                                    fontWeight: FWT.semiBold),
                                border: InputBorder.none,
                              ),
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.25),
                            child: SvgPicture.asset(
                              AssetUtils.date_picker,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (gst_type_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (gst_type_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<gst_type>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'GST registration type',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: gst
                                  .map((gst_type user) =>
                                  DropdownMenuItem<gst_type>(
                                    value: user,
                                    child: Text(
                                      user.name,
                                      style: FontStyleUtility.h14(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                              value: selectedUnit,
                              onChanged: (newvalue) {
                                setState(() {
                                  gst_type_validate = true;
                                });
                                setState(() {
                                  selectedUnit = newvalue;
                                  Customer_gst_regi_type_controller.text = selectedUnit!.value;
                                  print("name");
                                  print(Customer_gst_regi_type_controller.text);
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
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
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        enabled:(selectedUnit == gst[2] ? false : (selectedUnit == null ? false : true)),
                        controller: Customer_gisin_number_controller,
                        labelText: 'GSTIN',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_pan_number_controller,
                        labelText: 'PAN number',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!reg_pan.hasMatch(
                                  Customer_pan_number_controller.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Enter Valid PAN Number")));
                                return;
                              }

                              // if (!reg_gst.hasMatch(
                              //     Customer_gisin_number_controller.text)) {
                              //   Fluttertoast.showToast(
                              //       msg: 'Enter Valid GSTIN',
                              //       backgroundColor: Colors.black54,
                              //       textColor: Colors.white,
                              //       gravity: ToastGravity.BOTTOM,
                              //       toastLength: Toast.LENGTH_LONG);
                              //   return;
                              // }

                              if (
                                  Customer_company_name_controller.text.isEmpty ||
                                  _selecteddisplayname == null || selectedUnit == null) {
                                Fluttertoast.showToast(
                                    msg: 'Enter Details',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_LONG);

                                if( Customer_company_name_controller.text.isEmpty){
                                  setState(() {
                                    company_name_validate = false;
                                  });
                                }
                                if( _selecteddisplayname == null){
                                  setState(() {
                                    display_name_validate = false;
                                  });
                                }
                                if( selectedUnit == null){
                                  setState(() {
                                    gst_type_validate = false;
                                  });
                                }
                               return;
                              }

                              // if (Customer_company_name_controller
                              //     .text.isEmpty) {
                              //   Fluttertoast.showToast(
                              //       msg: 'Enter Details',
                              //       backgroundColor: Colors.red,
                              //       textColor: Colors.white,
                              //       gravity: ToastGravity.BOTTOM,
                              //       toastLength: Toast.LENGTH_LONG);
                              //   setState(() {
                              //     company_name_validate = false;
                              //   });
                              // }
                              // if (_selecteddisplayname == null) {
                              //   Fluttertoast.showToast(
                              //       msg: 'Enter Details',
                              //       backgroundColor: Colors.red,
                              //       textColor: Colors.white,
                              //       gravity: ToastGravity.BOTTOM,
                              //       toastLength: Toast.LENGTH_LONG);
                              //   setState(() {
                              //     display_name_validate = false;
                              //   });
                              //   return;
                              // }
                              // if (Customer_company_name_controller.text.isEmpty) {
                              //   Fluttertoast.showToast(
                              //       msg: 'Enter Company name',
                              //       backgroundColor: Colors.red,
                              //       textColor: Colors.white,
                              //       gravity: ToastGravity.BOTTOM,
                              //       toastLength: Toast.LENGTH_LONG);
                              //   setState(() {
                              //     company_name_validate = false;
                              //   });
                              //   return;
                              // }
                              // if ( _selecteddisplayname!.isEmpty) {
                              //   Fluttertoast.showToast(
                              //       msg: 'Enter Display name',
                              //       backgroundColor: Colors.red,
                              //       textColor: Colors.white,
                              //       gravity: ToastGravity.BOTTOM,
                              //       toastLength: Toast.LENGTH_LONG);
                              //   setState(() {
                              //     display_name_validate = false;
                              //   });
                              //   return;
                              // }

                              setState(() {
                                _ledgerScreenSetup_customer_Controller
                                    .pageIndexUpdate_customer('02');
                                _pageController_customer!.jumpToPage(1);
                              });
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
                        'Add Ledger',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 19, bottom: 0, left: 20),
                      child: Text(
                        'Registered Address',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_address_controller,
                        labelText: 'Address',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_city_controller,
                        labelText: 'City',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_pincode_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Pincode',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<Data_state>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'State',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: stateData.map(
                                      (Data_state item) => DropdownMenuItem<Data_state>(
                                    value: item,
                                    child: Text(
                                      "${item.name}",
                                      style: FontStyleUtility.h14(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )).toList(),
                              value: _selectedstate_billing,
                              onChanged: (value) {
                                setState(() {
                                  _selectedstate_billing = value;
                                  // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                  print(_selectedstate_billing!.id);
                                  Customer_state_controller.text = _selectedstate_billing!.name!;
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
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

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_country_controller,
                        labelText: 'Country',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        keyboardType: TextInputType.number,
                        controller: Customer_stdcode_controller,
                        labelText: 'STD Code',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_ofc_number_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Office Number',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_mobile_number_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Mobile Number',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_email_controller,
                        labelText: 'Email Id',
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _ledgerScreenSetup_customer_Controller
                                    .pageIndexUpdate_customer('01');
                                _pageController_customer!.jumpToPage(0);
                              });
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
                              setState(() {
                                if (Customer_mobile_number_controller
                                        .text.isNotEmpty &&
                                    Customer_mobile_number_controller
                                            .text.length <
                                        10) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter valid mobile number',
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  return;
                                }
                                if (Customer_email_controller.text.isEmpty &&
                                    !reg_email.hasMatch(
                                        Customer_email_controller.text)) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter valid EmailId',
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  return;
                                }

                                _ledgerScreenSetup_customer_Controller
                                    .pageIndexUpdate_customer('03');
                                _pageController_customer!.jumpToPage(2);
                              });
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
                        'Add Ledger',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 19, bottom: 0, left: 20),
                      child: Text(
                        'Shipping Address',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all(
                                  ColorUtils.blueColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  if (value) {
                                    shipping_Customer_address_controller.text =
                                        Customer_address_controller.text;
                                    shipping_Customer_city_controller.text =
                                        Customer_city_controller.text;
                                    shipping_Customer_pincode_controller.text =
                                        Customer_pincode_controller.text;
                                    shipping_Customer_state_controller.text =
                                        Customer_state_controller.text;
                                    shipping_Customer_country_controller.text =
                                        Customer_country_controller.text;
                                    shipping_Customer_stdcode_controller.text =
                                        Customer_stdcode_controller.text;
                                    shipping_Customer_ofc_number_controller
                                            .text =
                                        Customer_ofc_number_controller.text;
                                    shipping_Customer_mobile_number_controller
                                            .text =
                                        Customer_mobile_number_controller.text;
                                    shipping_Customer_email_controller.text =
                                        Customer_email_controller.text;
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Same as Billing Address',
                            style: FontStyleUtility.h14(
                              fontColor: ColorUtils.blueColor,
                              fontWeight: FWT.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_address_controller,
                        labelText: 'Address',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_city_controller,
                        labelText: 'City',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_pincode_controller,
                        labelText: 'Pincode',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<Data_state>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'State',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: stateData.map(
                                      (Data_state item) => DropdownMenuItem<Data_state>(
                                    value: item,
                                    child: Text(
                                      "${item.name}",
                                      style: FontStyleUtility.h14(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )).toList(),
                              value: _selectedstate_shipping,
                              onChanged: (value) {
                                setState(() {
                                  _selectedstate_shipping = value;
                                  // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                  print(_selectedstate_shipping!.id);
                                  shipping_Customer_state_controller.text = _selectedstate_shipping!.name!;
                                });
                              },
                              iconSize: 25,
                              icon: SvgPicture.asset(AssetUtils.drop_svg),
                              iconEnabledColor: Color(0xff007DEF),
                              iconDisabledColor: Color(0xff007DEF),
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtils.ogback,
                              ),
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

                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_country_controller,
                        labelText: 'Country',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        keyboardType: TextInputType.number,
                        controller: shipping_Customer_stdcode_controller,
                        labelText: 'STD Code',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_ofc_number_controller,
                        labelText: 'Office Number',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_mobile_number_controller,
                        keyboardType: TextInputType.number,
                        labelText: 'Mobile Number',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_email_controller,
                        labelText: 'Email Id',
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _ledgerScreenSetup_customer_Controller
                                    .pageIndexUpdate_customer('02');
                                _pageController_customer!.jumpToPage(1);
                              });
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
                              setState(() {
                                if (shipping_Customer_mobile_number_controller
                                        .text.isNotEmpty &&
                                    shipping_Customer_mobile_number_controller
                                            .text.length <
                                        10) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter valid mobile number',
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  return;
                                }
                                if (shipping_Customer_email_controller
                                        .text.isNotEmpty && reg_email.hasMatch(
                                        shipping_Customer_email_controller
                                            .text)) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter valid EmailId',
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  return;
                                }
                                _ledgerScreenSetup_customer_Controller
                                    .pageIndexUpdate_customer('04');
                                _pageController_customer!.jumpToPage(3);
                              });
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
                        'Add Ledger',
                        style: FontStyleUtility.h20(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 19, bottom: 0, left: 20),
                      child: Text(
                        'Bank Details',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_bank_name_controller,
                        labelText: 'Bank Name',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_account_number_controller,
                        labelText: 'Account Number',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_ifsc_code_controller,
                        labelText: 'IFSC code',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: Customer_ac_holder_name_controller,
                        labelText: 'Account Holder Name',
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!reg_ifsc.hasMatch(
                                    Customer_ifsc_code_controller.text)) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter valid IFSC code',
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  return;
                                }
                                _ledgerScreenSetup_customer_Controller
                                    .pageIndexUpdate_customer('03');
                                _pageController_customer!.jumpToPage(2);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 0, bottom: 20, left: 0),
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
                              // customers_API();

                              (id == 1
                                  ? customers_API()
                                  : (id == 2
                                      ? vendors_API()
                                      : (id == 3
                                          ? others_API()
                                          : customers_API())));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 0, bottom: 20, left: 0),
                              decoration: BoxDecoration(
                                color: const Color(0xff007DEF),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 29, vertical: 9),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Done',
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

  _update() {
    setState(() {
      display_name_list = [
        Customer_name_controller.text,
        Customer_company_name_controller.text
      ];
      print(display_name_list);
    });
  }
}
class gst_type {
  const gst_type(this.name, this.value);

  final String name;
  final String value;
}
