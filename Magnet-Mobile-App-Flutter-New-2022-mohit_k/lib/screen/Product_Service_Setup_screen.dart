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
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class product_setup extends StatefulWidget {
  const product_setup({Key? key}) : super(key: key);

  @override
  _product_setupState createState() => _product_setupState();
}

class _product_setupState extends State<product_setup> {
  PageController? _pageController;

  final Product_Service_Setup_controller _productSetupController =
      Get.find(tag: Product_Service_Setup_controller().toString());
  final Product_Service_Setup_controller _serviceSetupController =
      Get.find(tag: Product_Service_Setup_controller().toString());
  var reg_pan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  var reg_gst =
      RegExp("^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");
  var reg_email = RegExp(
      "r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';");
  var reg_ifsc = RegExp("^[A-Z]{4}0[A-Z0-9]{6}");

  @override
  void initState() {
    // display_name_list.add(Customer_account_name_controller.text);
    // Customer_birthdate_controller.text = ""; //set the initial value of text field
    _pageController = PageController(initialPage: 0, keepPage: false);
    account_head_controller.text = 'Sundry Creditors';
    pan_number_controller.text = 'BNZAA2318J';
    gisin_number_controller.text = '06BZAHM6385P6Z2';
    // selectedUnit = unit[0];
    super.initState();
    group_name_API();
    account_head();
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

  List gst_purchase = [
    "00",
    "05",
    "10",
    "15",
    "20",
  ];
  List gst_sales = [
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
  int id = 1;

  String _selectedCustomer = 'Customer';
  String? _selectedgroup;
  String? _selectedsubgroup;
  String? _selecteddisplayname;
  String? _selectedd_b;
  String? _selectedgst_purchase;
  String? _selectedgst_sales;
  String? _selectedr_type;
  String? _selectedAccounthead;
  String result = "";

  String? dateSelected;
  bool isChecked = false;
  bool as_of_date = false;

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
        as_of_date_controller.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
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
  final product_unit_controller = TextEditingController();
  final account_head_controller = TextEditingController();
  final group_name_controller = TextEditingController();
  final sub_group_name_controller = TextEditingController();
  final opening_balance_controller = TextEditingController();
  final debit_credit_controller = TextEditingController();
  final as_of_date_controller = TextEditingController();
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


  final service_name_controller = TextEditingController();
  final sac_code_controller = TextEditingController();
  final service_type_controller = TextEditingController();
  final service_sales_price_controller = TextEditingController();
  final service_income_controller = TextEditingController();

  bool product_name_validate = true;
  bool service_name_validate = true;
  bool sac_validate = true;
  bool service_type_validate = true;
  bool sales_price_validate = true;

  unit_model? selectedUnit;
  account? select_income_Ammount;
  account? select_expense_Ammount;

  List<account> income_account = <account>[
    const account('Sales of Goods', 'sales_of_goods'),
    const account('Sales of Services', 'sales_of_services'),
  ];
  List<account> expense_account = <account>[
    const account('Sales of Goods', 'sales_of_goods'),
    const account('Sales of Services', 'sales_of_services'),
  ];

  List<unit_model> unit = <unit_model>[
    const unit_model('BAG-BAGS', 'bag'),
    const unit_model('BAL-BALE', 'bal'),
    const unit_model('BDL-BUNDLES', 'bdl'),
    const unit_model('BKL-BUCKLES', 'bkl'),
    const unit_model('BOU-BILLION OF UNITS', 'bou'),
    const unit_model('BOX-BOX', 'box'),
    const unit_model('BTL-BOTTLES', 'btl'),
    const unit_model('BUN-BUNCHES', 'bun'),
    const unit_model('CAN-CANS', 'can'),
    const unit_model('CBM-CUBIC METERS', 'cbm'),
    const unit_model('CCM-CUBIC CENTIMETERS', 'ccm'),
    const unit_model('CMS-CENTIMETERS', 'cms'),
    const unit_model('CTN-CARTONS', 'ctn'),
    const unit_model('DOZ-DOZENS', 'doz'),
    const unit_model('DRM-DRUMS', 'drm'),
    const unit_model('GGK-GREAT GROSS', 'ggk'),
    const unit_model('GMS-GRAMMES', 'gms'),
    const unit_model('GRS-GROSS', 'grs'),
    const unit_model('GYD-GROSS YARDS', 'gyd'),
    const unit_model('KGS-KILOGRAMS', 'kgs'),
    const unit_model('KLR-KILOLITRE', 'klr'),
    const unit_model('KME-KILOMETRE', 'kme'),
    const unit_model('MLT-MILILITRE', 'mlt'),
    const unit_model('MTR-METERS', 'mtr'),
    const unit_model('LTR-LITER', 'ltr'),
    const unit_model('MTS-METRIC TON', 'mts'),
    const unit_model('NOS-NUMBERS', 'nos'),
    const unit_model('PAC-PACKS', 'pac'),
    const unit_model('PCS-PIECES', 'pcs'),
    const unit_model('PRS-PAIRS', 'prs'),
    const unit_model('QTL-QUINTAL', 'qtl'),
    const unit_model('ROL-ROLLS', 'rol'),
    const unit_model('SET-SETS', 'set'),
    const unit_model('SQF-SQUARE FEET', 'sqf'),
    const unit_model('SQM-SQUARE METER', 'sqm'),
    const unit_model('SQY-SQURE YARDS', 'sqy'),
    const unit_model('TBS-TABLETS', 'tbs'),
    const unit_model('TGM-TEN', 'tgm'),
    const unit_model('THD-THOUNDS', 'thd'),
    const unit_model('TON-TONNES', 'ton'),
    const unit_model('TUB-TUBES', 'tub'),
    const unit_model('UGS-US GALLONS', 'ugs'),
    const unit_model('UNT-UNITS', 'unt'),
    const unit_model('YDS-YARDS', 'yds'),
    const unit_model('OTH-OTHRES', 'oth')
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: custom_header(
      labelText: 'Add Information',
      back: AssetUtils.back_svg,
      backRoute: BindingUtils.product_service_ScreenRoute,
      data: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                      right: (_productSetupController.pageIndex == '01' ||
                              _serviceSetupController.pageIndex == '01'
                          ? screenSize.width / 3
                          : (_productSetupController.pageIndex == '02' ||
                                  _serviceSetupController.pageIndex == '02'
                              ? 0
                              : 0))),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: (id == 1
                    ? product_add()
                    : (id == 2 ? service_add() : product_add())),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  String Token = "";

  Future product_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    Map data = {
      "id": '',
      "product_name": product_name_controller.text,
      "description": hsn_code_controller.text,
      "sku": "string",
      "group_id": int.parse(_selectedgroup!),
      "sub_group_id": int.parse(_selectedsubgroup!),
      "total_sales": 0,
      "sales_qty": 0,
      "total_qty": 0,
      "hsn_code": hsn_code_controller.text,
      "product_quantity_on_hand": int.parse(quentity_hand_controller.text),
      "product_unit": selectedUnit!.value,
      "product_low_stock_alert": int.parse(low_stock_controller.text),
      "product_as_of_date": as_of_date_controller.text,
      "purchase_price": int.parse(purchase_price_controller.text),
      "sales_price": int.parse(sales_price_controller.text),
      "gst_sales": int.parse(_selectedgst_sales!),
      "gst_purchase": int.parse(_selectedgst_purchase!),
      "income_account": income_amount_controller.text,
      "expense_account": expanse_controller.text,
      "product_created_date": "2022-01-04T11:17:47.071Z",
      // "batch_no": 0,
      "expiry_date": "2022-01-04T11:17:47.071Z",
      "company_profile_id": 0,
      // "created_by": 0
    };

    print(data);

    var url = Api_url.product_add_api;
    var response = await http_service.post(url, data);
    if (response["success"]) {
      Get.offAllNamed(BindingUtils.product_service_ScreenRoute);
      print('Seccess');
    }
  }

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
    var url = Api_url.service_add_api;
    var response = await http.post(
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
    if (response.statusCode == 201) {
      Get.offAllNamed(BindingUtils.product_service_ScreenRoute);
      print('Seccess');
    } else {
      print("error");
    }
  }

  List GroupData = [];
  var g_id;

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
      print("GroupData");
      print(GroupData);
      print("g_id");
      print(g_id);
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

  Widget product_add() {
    return GetBuilder<Product_Service_Setup_controller>(
      init: _productSetupController,
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
                        'Add Product',
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
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      ColorUtils.lightBlueradio,
                                  disabledColor: Colors.blue),
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
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      ColorUtils.lightBlueradio,
                                  disabledColor: Colors.blue),
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
                        'Product Information',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (product_name_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (product_name_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        tap: () {
                          setState(() {
                            product_name_validate = true;
                          });
                        },
                        controller: product_name_controller,
                        labelText: 'Product Name',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: hsn_code_controller,
                        labelText: 'HSN Code',
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
                                // print('${GroupData["id"]}');
                                for (var i = 0; i < GroupData.length; ++i) {
                                  var g = GroupData[i];

                                  if (g["id"].toString() == value) {
                                    SubgroupData = g["sub_groups"];
                                  }
                                }
                                setState(() {
                                  _selectedgroup = value as String?;
                                  print(_selectedgroup);
                                  // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                  // print(_selectedgroup);
                                  group_name_controller.text =
                                      _selectedgroup! as String;
                                  print(_selectedgroup);
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
                              sub_group_name_controller.text =
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
                      height: 50,
                      width: MediaQuery.of(context).size.width,
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
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
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
                                              fontColor: ColorUtils.blackColor,
                                              fontWeight: FWT.semiBold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedUnit,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectedUnit = newvalue;
                                  product_unit_controller.text = selectedUnit!.value;
                                  print(selectedUnit!.name);
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
                        keyboardType: TextInputType.number,
                        controller: quentity_hand_controller,
                        labelText: 'Initial quantity in hand',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(10.0),
                        border: (as_of_date == true
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
                                  as_of_date = true;
                                });
                                _showIOS_DatePicker(context);
                              },
                              showCursor: true,
                              readOnly: true,
                              controller: as_of_date_controller,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 5),
                                labelText: 'As of Date',
                                labelStyle: FontStyleUtility.h12(
                                    fontColor: ColorUtils.ogfont, fontWeight: FWT.semiBold),
                                border: InputBorder.none,
                              ),
                              style: FontStyleUtility.h16(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.semiBold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
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
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: low_stock_controller,
                        labelText: 'Low Stock alert',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (product_name_controller.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter Details',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  setState(() {
                                    product_name_validate = false;
                                  });
                                  return;
                                }
                                setState(() {
                                  _productSetupController.pageIndexUpdate('02');
                                  _pageController!.jumpToPage(1);
                                });
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
                        'Add Product',
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
                        'Product Information',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: purchase_price_controller,
                        labelText: 'Purchase Price',
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
                                      'GST in Purchase',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: gst_purchase
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
                              value: _selectedgst_purchase,
                              onChanged: (value) {
                                setState(() {
                                  _selectedgst_purchase = value as String;
                                  gst_purchase_controller.text =
                                      _selectedgst_purchase!;
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
                        controller: sales_price_controller,
                        labelText: 'Sales Price',
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
                                      'GST in sales',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: gst_sales
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
                              value: _selectedgst_sales,
                              onChanged: (value) {
                                setState(() {
                                  _selectedgst_sales = value as String;
                                  gst_sales_controller.text =
                                      _selectedgst_sales!;
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
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<account>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Income Account',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: income_account
                                  .map((account user) =>
                                  DropdownMenuItem<account>(
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
                              value: select_income_Ammount,
                              onChanged: (newvalue) {
                                setState(() {
                                  select_income_Ammount = newvalue;
                                  income_amount_controller.text = select_income_Ammount!.value;
                                  print(select_income_Ammount!.value);
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
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<account>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Expanse Account',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.semiBold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: expense_account
                                  .map((account user) =>
                                  DropdownMenuItem<account>(
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
                              value: select_expense_Ammount,
                              onChanged: (newvalue) {
                                setState(() {
                                  select_expense_Ammount = newvalue;
                                  expanse_controller.text = select_expense_Ammount!.value;
                                  print(select_expense_Ammount!.value);
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
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _productSetupController.pageIndexUpdate('01');
                                _pageController!.jumpToPage(0);
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
                              product_API();
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

  Widget service_add() {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<Product_Service_Setup_controller>(
      init: _serviceSetupController,
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
                        'Add Service',
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
                        'Service Information',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (service_name_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (service_name_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        tap: () {
                          setState(() {
                            service_name_validate = true;
                          });
                        },
                        controller: service_name_controller,
                        labelText: 'Service Name',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (sac_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (sac_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        tap: () {
                          setState(() {
                            sac_validate = true;
                          });
                        },
                        controller: sac_code_controller,
                        labelText: 'SAC code',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (service_type_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (service_type_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        tap: () {
                          setState(() {
                            service_type_validate = true;
                          });
                        },
                        controller: service_type_controller,
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
                              setState(() {
                                if (service_name_controller.text.isEmpty ||
                                    sac_code_controller.text.isEmpty ||
                                    service_type_controller.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter Details',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_LONG);
                                  if(service_name_controller.text.isEmpty){
                                    setState(() {
                                      service_name_validate = false;
                                    });
                                  }
                                  if(sac_code_controller.text.isEmpty){
                                    setState(() {
                                      sac_validate = false;
                                    });
                                  }
                                  if(service_type_controller.text.isEmpty){
                                    setState(() {
                                      service_type_validate = false;
                                    });
                                  }
                                  setState(() {
                                    product_name_validate = false;
                                  });
                                  return;
                                }
                                setState(() {
                                  _productSetupController.pageIndexUpdate('02');
                                  _pageController!.jumpToPage(1);
                                });

                                _serviceSetupController.pageIndexUpdate('02');
                                _pageController!.jumpToPage(1);
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
                        'Add Service',
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
                        'Service Details',
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.blackColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: (sales_price_validate == false
                              ? Border.all(color: Colors.red, width: 1)
                              : Border.all(color: Colors.transparent)),
                          borderRadius: (sales_price_validate == false
                              ? BorderRadius.all(Radius.circular(10))
                              : BorderRadius.all(Radius.circular(10)))),
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        tap: () {
                          setState(() {
                            sales_price_validate = true;
                          });
                        },
                        controller: service_sales_price_controller,
                        labelText: 'Sales Price',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: CustomTextFieldWidget_two(
                        controller: service_income_controller,
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
                              setState(() {
                                _serviceSetupController.pageIndexUpdate('01');
                                _pageController!.jumpToPage(0);
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
                              if (service_sales_price_controller.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'Enter Details',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_LONG);
                                setState(() {
                                  sales_price_validate = false;
                                });
                                return;
                              }
                              service_API();
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
                                  'Save',
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

class unit_model {
  const unit_model(this.name, this.value);

  final String name;
  final String value;
}
class account {
  const account(this.name, this.value);

  final String name;
  final String value;
}