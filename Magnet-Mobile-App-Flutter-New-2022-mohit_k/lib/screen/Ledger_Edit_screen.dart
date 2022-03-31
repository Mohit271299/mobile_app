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
import 'package:magnet_update/model_class/state_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class ledgerEditScreen extends StatefulWidget {
  final int? customer;
  final int? vendor;
  final int? other;
  final int? customer_as_vendor;
  final int? vendor_as_customer;

  ledgerEditScreen(
      {this.customer,
      this.vendor,
      this.other,
      this.customer_as_vendor,
      this.vendor_as_customer});

  @override
  _ledgerEditScreenState createState() => _ledgerEditScreenState();
}

class _ledgerEditScreenState extends State<ledgerEditScreen> {
  PageController? _pageController_customer;

  final Ledger_Edit_controller _ledgerScreenEditController = Get.put(
      Ledger_Edit_controller(),
      tag: Ledger_Edit_controller().toString());
  var reg_pan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  var reg_gst =
      RegExp("^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");
  var reg_email = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  var reg_ifsc = RegExp("^[A-Z]{4}0[A-Z0-9]{6}");

  @override
  void initState() {
    _init();

    (widget.customer != null || widget.vendor_as_customer != null
        ? id = 1
        : (widget.vendor != null || widget.customer_as_vendor != null
            ? id = 2
            : (widget.other != null ? id = 3 : id = 1)));

    _pageController_customer = PageController(initialPage: 0, keepPage: false);
    // Customer_account_head_controller.text = 'Sundry Creditors';
    // Customer_pan_number_controller.text = 'BNZAA2318J';
    // Customer_gisin_number_controller.text = '06BZAHM6385P6Z2';
    super.initState();
  }

  _init() async {
    await  group_name_API();
    await  accountHead_list_API();
    await  State_list_API();
    (widget.customer != null
        ? Customer_Edit_Get()
        : (widget.vendor != null
            ? Vendor_Edit_Get()
            : (widget.other != null
                ? Other_Edit_Get()
                : (widget.customer_as_vendor != null
                    ? Customer_as_vendor_Get()
                    : (widget.vendor_as_customer != null
                        ? Vendor_as_customer_Get()
                        : Customer_Edit_Get())))));
  }

  // final List<String> data = <String>[
  //   'Follow Ups',
  //   'Phone Call',
  //   'Site Visit',
  //   'Meeting'
  // ];

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
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int? id;

  String _selectedCustomer = 'Customer';
  String? _selectedgroup;
  Data_state? _selectedstate_billing;
  Data_state? _selectedstate_shipping;
  String? _selectedsubgroup;
  String? _selecteddisplayname;
  String? _selectedd_b;
  String? _selectedr_type;
  Data_ac_head? _selectedAccounthead;


  String? dateSelected;
  bool isChecked = false;

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

  var data;
  List address = [];
  var billing;
  var shipping;

  Future Customer_Edit_Get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/customers/${widget.customer}}';

    var response = await http_service.get_Data(url);

    if (response["success"]) {
      // Navigator.pop(context);
      // Customer_list_API();
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));
      print(Books);
      setState(() {
        data = Books["data"];
        address = data["addresses"];
        print("data");
        print(data);
        print("address");
        print(address);

        Customer_account_name_controller.text = data["account_name"];
        Customer_company_name_controller.text = data["company_name"];

        display_name_list = [
          Customer_account_name_controller.text,
          Customer_company_name_controller.text
        ];

        _selecteddisplayname = data["billing_name"];
        // _selecteddisplayname = data["billing_name"];

        Data_ac_head _get = acHeadData.firstWhere(
                (element) => element.id == data["account_head_id"]);
        _selectedAccounthead = _get;

        print(address.length);
        for(var i=0 ; i< address.length; i++){
          if(address[i]["address_type"] == "Shipping"){
            shipping = address[i];
            print("address[i]");
            print(address[i]);
          }
          else if(address[i]["address_type"] == "billing"){
            billing = address[i];
          }
        }
        print("billing");
        print(billing);
        print(shipping);

        if(billing != null){
          Data_state _stdBilling = stateData.firstWhere(
                  (element) => element.id.toString() == billing["state"]);
          print(_stdBilling.name);
          setState(() {
            _selectedstate_billing = _stdBilling;
          });

        }else if(shipping != null){
          Data_state _stdShipping = stateData.firstWhere(
                  (element) => element.id.toString() == shipping["state"]);
          print(_stdShipping.name);
          setState(() {
            _selectedstate_shipping= _stdShipping;
          });
        }

        print("_std");
        print("_selectedstate_billing");
        print(_selectedstate_billing);
        print("_selectedstate_shipping");
        print(_selectedstate_shipping);

        String name = data["gst_type"] ;
        print("name");
        print(name);

        gst_type type_get = gst.firstWhere(
                (element) => element.value == data["gst_type"]);
        print("type_get");
        print(type_get.value);
        //////////////////////////////////////
        selectedUnit = type_get;
        /////////////////////////////////////
        Customer_gisin_number_controller.text = data["gst_in"];
        Customer_opening_balance_controller.text =
            data["opening_balance"].toString();
        Customer_birthdate_controller.text = data["as_of_date"];
        Customer_bank_name_controller.text = data["bank_name"];
        Customer_account_number_controller.text = data["account_no"];
        Customer_ifsc_code_controller.text = data["ifsc_code"];
        Customer_ac_holder_name_controller.text = data["account_holder_name"];
        _selectedd_b = data["opening_type"];

        var g_data_items = GroupData.firstWhere(
            (element) => element["id"] == data["group_id"]);

        List s_group = g_data_items["sub_groups"];
        print("blah");
        print(g_data_items);
        _selectedgroup = g_data_items["id"].toString();
        // _selectedsubgroup= s_group_items["id"].toString();


        Customer_address_controller.text = address[0]["address"];
        Customer_city_controller.text = address[0]["city"];
        Customer_pincode_controller.text = address[0]["pincode"];
        Customer_state_controller.text = address[0]["state"];
        Customer_country_controller.text = address[0]["country"];
        Customer_stdcode_controller.text = address[0]["std_code"];
        Customer_ofc_number_controller.text = address[0]["office_no"];
        Customer_mobile_number_controller.text = address[0]["mobile_no"];
        Customer_email_controller.text = address[0]["email"];
      });

      print("Custome_edit_details");
      print(data);
      print(address);

      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }
  List display_name_list = [];

  _update() {
    setState(() {
      display_name_list = [
        Customer_account_name_controller.text,
        Customer_company_name_controller.text
      ];
      print(display_name_list);
    });
  }
  Future Customer_as_vendor_Get() async {
    showLoader(context);

    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/customers/${widget.customer_as_vendor}}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print("vendor.statusCode");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      // Customer_list_API();
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));
      print(Books);

      setState(() {
        data = Books["data"];
        address = data["addresses"];

        Customer_account_name_controller.text = data["account_name"];
        Customer_company_name_controller.text = data["company_name"];

        _selecteddisplayname = data["billing_name"];
        // _selecteddisplayname = data["billing_name"];
        _selectedAccounthead = acHeadData[data["account_head_id"]];

        Customer_opening_balance_controller.text =
            data["opening_balance"].toString();
        Customer_birthdate_controller.text = data["as_of_date"];
        Customer_bank_name_controller.text = data["bank_name"];
        Customer_account_number_controller.text = data["account_no"];
        Customer_ifsc_code_controller.text = data["ifsc_code"];
        Customer_ac_holder_name_controller.text = data["account_holder_name"];
        _selectedd_b = data["opening_type"];

        var g_data_items = GroupData.firstWhere(
            (element) => element["id"] == data["group_id"]);
        List s_group = g_data_items["sub_groups"];
        // var s_group_items = s_group.firstWhere((element) => element["id"] == data["sub_group_id"]);

        print("blah");
        print(g_data_items);
        // print(s_group_items);
        _selectedgroup = g_data_items["id"].toString();
        // _selectedsubgroup= s_group_items["id"].toString();

        Customer_address_controller.text = address[0]["address"];
        Customer_city_controller.text = address[0]["city"];
        Customer_pincode_controller.text = address[0]["pincode"];
        Customer_state_controller.text = address[0]["state"];
        Customer_country_controller.text = address[0]["country"];
        Customer_stdcode_controller.text = address[0]["std_code"];
        Customer_ofc_number_controller.text = address[0]["office_no"];
        Customer_mobile_number_controller.text = address[0]["mobile_no"];
        Customer_email_controller.text = address[0]["email"];
      });

      print("Custome_edit_details");
      print(data);
      print(address);
      hideLoader(context);

      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future Vendor_Edit_Get() async {
    print("calling");
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/vendors/${widget.vendor}}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));

      setState(() {
        data = Books["data"];
        address = data["addresses"];

        Customer_account_name_controller.text = data["account_name"];
        Customer_company_name_controller.text = data["company_name"];

        _selecteddisplayname = data["billing_name"];
        // _selecteddisplayname = data["billing_name"];
        _selectedAccounthead = acHeadData[data["account_head_id"]];

        Customer_opening_balance_controller.text =
            data["opening_balance"].toString();
        Customer_birthdate_controller.text = data["as_of_date"];
        Customer_bank_name_controller.text = data["bank_name"];
        Customer_account_number_controller.text = data["account_no"];
        Customer_ifsc_code_controller.text = data["ifsc_code"];
        Customer_ac_holder_name_controller.text = data["account_holder_name"];
        _selectedd_b = data["opening_type"];

        var g_data_items = GroupData.firstWhere(
            (element) => element["id"] == data["group_id"]);
        List s_group = g_data_items["sub_groups"];
        // var s_group_items = s_group.firstWhere((element) => element["id"] == data["sub_group_id"]);

        print("blah");
        print(g_data_items);
        // print(s_group_items);
        _selectedgroup = g_data_items["id"].toString();
        // _selectedsubgroup= s_group_items["id"].toString();

        Customer_address_controller.text = address[0]["address"];
        Customer_city_controller.text = address[0]["city"];
        Customer_pincode_controller.text = address[0]["pincode"];
        Customer_state_controller.text = address[0]["state"];
        Customer_country_controller.text = address[0]["country"];
        Customer_stdcode_controller.text = address[0]["std_code"];
        Customer_ofc_number_controller.text = address[0]["office_no"];
        Customer_mobile_number_controller.text = address[0]["mobile_no"];
        Customer_email_controller.text = address[0]["email"];
      });

      print("Custome_edit_details");
      print(data);
      print(address);

      return json.decode(response.body);
    } else {
      throw Exception('vendor Not found!');
    }
  }

  Future Vendor_as_customer_Get() async {
    showLoader(context);
    print("calling------------");
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/vendors/${widget.vendor_as_customer}}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      hideLoader(context);
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));

      setState(() {
        data = Books["data"];
        address = data["addresses"];

        Customer_account_name_controller.text = data["account_name"];
        Customer_company_name_controller.text = data["company_name"];

        _selecteddisplayname = data["billing_name"];
        // _selecteddisplayname = data["billing_name"];
        _selectedAccounthead = acHeadData[data["account_head_id"]];

        Customer_opening_balance_controller.text =
            data["opening_balance"].toString();
        Customer_birthdate_controller.text = data["as_of_date"];
        Customer_bank_name_controller.text = data["bank_name"];
        Customer_account_number_controller.text = data["account_no"];
        Customer_ifsc_code_controller.text = data["ifsc_code"];
        Customer_ac_holder_name_controller.text = data["account_holder_name"];
        _selectedd_b = data["opening_type"];

        var g_data_items = GroupData.firstWhere(
            (element) => element["id"] == data["group_id"]);
        List s_group = g_data_items["sub_groups"];
        // var s_group_items = s_group.firstWhere((element) => element["id"] == data["sub_group_id"]);

        print("blah");
        print(g_data_items);
        // print(s_group_items);
        _selectedgroup = g_data_items["id"].toString();
        // _selectedsubgroup= s_group_items["id"].toString();

        Customer_address_controller.text = address[0]["address"];
        Customer_city_controller.text = address[0]["city"];
        Customer_pincode_controller.text = address[0]["pincode"];
        Customer_state_controller.text = address[0]["state"];
        Customer_country_controller.text = address[0]["country"];
        Customer_stdcode_controller.text = address[0]["std_code"];
        Customer_ofc_number_controller.text = address[0]["office_no"];
        Customer_mobile_number_controller.text = address[0]["mobile_no"];
        Customer_email_controller.text = address[0]["email"];
      });

      print("Custome_edit_details");
      print(data);
      print(address);

      return json.decode(response.body);
    } else {
      throw Exception('vendor Not found!');
    }
  }

  Future Other_Edit_Get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = 'https://www.magnetbackend.fsp.media/api/others/${widget.other}}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      // Customer_list_API();
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));

      setState(() {
        data = Books["data"];
        address = data["addresses"];

        Customer_account_name_controller.text = data["account_name"];
        Customer_company_name_controller.text = data["company_name"];

        _selecteddisplayname = data["billing_name"];
        // _selecteddisplayname = data["billing_name"];
        _selectedAccounthead = acHeadData[data["account_head_id"]];

        Customer_opening_balance_controller.text =
            data["opening_balance"].toString();
        Customer_birthdate_controller.text = data["as_of_date"];
        Customer_bank_name_controller.text = data["bank_name"];
        Customer_account_number_controller.text = data["account_no"];
        Customer_ifsc_code_controller.text = data["ifsc_code"];
        Customer_ac_holder_name_controller.text = data["account_holder_name"];
        _selectedd_b = data["opening_type"];

        var g_data_items = GroupData.firstWhere(
            (element) => element["id"] == data["group_id"]);
        List s_group = g_data_items["sub_groups"];
        // var s_group_items = s_group.firstWhere((element) => element["id"] == data["sub_group_id"]);

        print("blah");
        print(g_data_items);
        // print(s_group_items);
        _selectedgroup = g_data_items["id"].toString();
        // _selectedsubgroup= s_group_items["id"].toString();

        Customer_address_controller.text = address[0]["address"];
        Customer_city_controller.text = address[0]["city"];
        Customer_pincode_controller.text = address[0]["pincode"];
        Customer_state_controller.text = address[0]["state"];
        Customer_country_controller.text = address[0]["country"];
        Customer_stdcode_controller.text = address[0]["std_code"];
        Customer_ofc_number_controller.text = address[0]["office_no"];
        Customer_mobile_number_controller.text = address[0]["mobile_no"];
        Customer_email_controller.text = address[0]["email"];
      });

      print("Custome_edit_details");
      print(data);
      print(address);

      return json.decode(response.body);
    } else {
      throw Exception('vendor  Not found!');
    }
  }

  //customers
  TextEditingController Customer_company_name_controller =
      TextEditingController();
  TextEditingController Customer_account_name_controller =
      TextEditingController();
  TextEditingController Customer_display_name_controller =
      TextEditingController();
  TextEditingController Customer_account_head_controller =
      TextEditingController();
  TextEditingController Customer_group_name_controller =
      TextEditingController();
  TextEditingController Customer_sub_group_name_controller =
      TextEditingController();
  TextEditingController Customer_opening_balance_controller =
      TextEditingController();
  TextEditingController Customer_debit_credit_controller =
      TextEditingController();
  TextEditingController Customer_birthdate_controller = TextEditingController();
  TextEditingController Customer_gst_regi_type_controller =
      TextEditingController();
  TextEditingController Customer_pan_number_controller =
      TextEditingController();
  TextEditingController Customer_gisin_number_controller =
      TextEditingController();

  TextEditingController Customer_address_controller = TextEditingController();
  TextEditingController Customer_city_controller = TextEditingController();
  TextEditingController Customer_pincode_controller = TextEditingController();
  TextEditingController Customer_state_controller = TextEditingController();
  TextEditingController Customer_country_controller = TextEditingController();
  TextEditingController Customer_stdcode_controller = TextEditingController();
  TextEditingController Customer_ofc_number_controller =
      TextEditingController();
  TextEditingController Customer_mobile_number_controller =
      TextEditingController();
  TextEditingController Customer_email_controller = TextEditingController();

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

  TextEditingController Customer_bank_name_controller = TextEditingController();
  TextEditingController Customer_account_number_controller =
      TextEditingController();
  TextEditingController Customer_ifsc_code_controller = TextEditingController();
  TextEditingController Customer_ac_holder_name_controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

        body: custom_header(
          labelText: 'Edit Ledger',
          back: AssetUtils.back_svg,
          backRoute: BindingUtils.ledgerScreenRoute,
          data:Container(
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
                      ]
                  ),
                  margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                  height: 34,
                  child: Container(
                    decoration: const BoxDecoration(
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
                          (_ledgerScreenEditController.pageIndex_customer ==
                              '01'
                              ? screenSize.width / 2
                              : (_ledgerScreenEditController
                              .pageIndex_customer ==
                              '02'
                              ? screenSize.width / 3
                              : (_ledgerScreenEditController
                              .pageIndex_customer ==
                              '03'
                              ? screenSize.width / 4
                              : 0)))),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ledger_setup(),
                  ),
                ),
              ],
            ),
          ),

        )
    );
  }

  String Token = "";

  Future customers_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '${widget.customer}',
      "ledger_type": "vendor",
      "profile_photo": "string",
      "account_name": Customer_account_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": 1,
      "company_profile_id": 1,
      // "group_id": 0,
      // "sub_group_id": 0,
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
          // "state_code": Customer_stdcode_controller!.text,
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
      "opening_type": "debit",
      "closing_balance": 0,
      "closing_type": "debit",
      "total_sales": 0,
      "created_at": "2021-12-30T10:29:38.745Z",
      "update_at": "2021-12-30T10:29:38.745Z",
      // "created_by": 0,
      // "updated_by": 0
    };

    print(data);

    var url = Api_url.customer_ledger_api + '/${widget.customer}}';
    var response = await http_service.put(url, data);
    // print(response.body);
    // print(response.statusCode);
    if (response['success']) {
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
      print('Seccessfully updated');
    }
  }

  Future vendors_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '${widget.vendor}',
      "ledger_type": "vendor",
      "profile_photo": "string",
      "account_name": Customer_account_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": 1,
      "company_profile_id": 1,
      // "group_id": 0,
      // "sub_group_id": 0,
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
          // "state_code": Customer_stdcode_controller!.text,
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
      "opening_balance": 0,
      "opening_type": "debit",
      "closing_balance": 0,
      "closing_type": "debit",
      "total_sales": 0,
      "created_at": "2021-12-30T10:29:38.745Z",
      "update_at": "2021-12-30T10:29:38.745Z",
      // "created_by": 0,
      // "updated_by": 0
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.vendors_ledger_api + '/${widget.vendor}';
    var response = await http_service.put(url, data);
    print(response.statusCode);
    if (response["success"]) {
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
      print('Seccess');
    } else {
      print("error");
    }
  }

  Future Customer_as_vendors_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '',
      "ledger_type": "vendor",
      "profile_photo": "string",
      "account_name": Customer_account_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": 1,
      "company_profile_id": 1,
      // "group_id": 0,
      // "sub_group_id": 0,
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
          // "state_code": Customer_stdcode_controller!.text,
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
      "opening_balance": 0,
      "opening_type": "debit",
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
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
    }
  }

  Future Vendor_as_customers_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '',
      "ledger_type": "customer",
      "profile_photo": "string",
      "account_name": Customer_account_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": 1,
      "company_profile_id": 1,
      // "group_id": 0,
      // "sub_group_id": 0,
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
          // "state_code": Customer_stdcode_controller!.text,
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
      "opening_balance": 0,
      "opening_type": "debit",
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
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
    }
  }

  Future others_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '${widget.other}',
      "ledger_type": "vendor",
      "profile_photo": "string",
      "account_name": Customer_account_name_controller.text,
      "company_name": Customer_company_name_controller.text,
      "billing_name": Customer_display_name_controller.text,
      "account_head_id": 1,
      "company_profile_id": 1,
      // "group_id": 0,
      // "sub_group_id": 0,
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
          // "state_code": Customer_stdcode_controller!.text,
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
      "opening_balance": 0,
      "opening_type": "debit",
      "closing_balance": 0,
      "closing_type": "debit",
      "total_sales": 0,
      "created_at": "2021-12-30T10:29:38.745Z",
      "update_at": "2021-12-30T10:29:38.745Z",
      // "created_by": 0,
      // "updated_by": 0
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.others_ledger_api + '/${widget.other}';
    var response = await http_service.put(url, data);
    print(response.statusCode);
    if (response["success"]) {
      Get.offAllNamed(BindingUtils.ledgerScreenRoute);
      print('Seccess');
    } else {
      print("error");
    }
  }

  List GroupData = [];
  List<Data_state> stateData = [];
  List<Data_ac_head> acHeadData = [];
  List SubgroupData = [];
  List AccountHeadsData = [];
  bool tap = true;
  bool isLoading = false;
  Future group_name_API() async {
    setState(() {
      isLoading = true;
    });
    // showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);
    showLoader(cntx);
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
    hideLoader(cntx!);
    // print(responseData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // hideLoader(context);

      var responseData = json.decode(response.body);
      setState(() {
        isLoading = false;
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
    print(acHeadData);
  }


  bool birth_date = false;
  bool custmer_name_validate = true;
  bool company_name_validate = true;
  bool display_name_validate = true;
  bool gst_type_validate = true;
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

  Widget ledger_setup() {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<Ledger_Edit_controller>(
      init: _ledgerScreenEditController,
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
                      decoration: BoxDecoration(
                          border: (custmer_name_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (custmer_name_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        onChanged: (val) {
                          _update();
                        },
                        tap: () {
                          setState(() {
                            custmer_name_validate = true;
                          });
                        },
                        controller: Customer_account_name_controller,
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
                              _selectedAccounthead = value;
                              Customer_account_head_controller.text =
                              _selectedAccounthead!.accountHeadName!;
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
                                  Customer_gst_regi_type_controller.text = selectedUnit!.value!;
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
                              // if (!reg_pan.hasMatch(
                              //     Customer_pan_number_controller.text)) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content:
                              //           Text("Enter Valid PAN Number")));
                              //   return;
                              // }

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

                              if (Customer_account_name_controller.text.isEmpty ||
                                  Customer_company_name_controller.text.isEmpty ||
                                  _selecteddisplayname == null || selectedUnit == null) {
                                Fluttertoast.showToast(
                                    msg: 'Enter Details',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_LONG);
                                if(Customer_account_name_controller.text.isEmpty){
                                  setState(() {
                                    custmer_name_validate = false;
                                  });
                                }
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
                                _ledgerScreenEditController
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
                                _ledgerScreenEditController
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

                                _ledgerScreenEditController
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
                                    // shipping_Customer_state_controller.text =
                                    //     Customer_state_controller.text;
                                    _selectedstate_shipping = _selectedstate_billing;
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
                      child: CustomTextFieldWidget_two(
                        controller: shipping_Customer_state_controller,
                        labelText: 'State',
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
                                _ledgerScreenEditController
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
                                _ledgerScreenEditController
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
                                _ledgerScreenEditController
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
}

class gst_type {
  final String name;
  final String? value;

  const gst_type(this.name, this.value);


}