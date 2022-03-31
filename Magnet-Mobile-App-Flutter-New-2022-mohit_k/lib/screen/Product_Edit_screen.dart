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
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class productEditScreen extends StatefulWidget {
  final int? product_id;

  const productEditScreen({Key? key, this.product_id}) : super(key: key);

  @override
  _productEditScreenState createState() => _productEditScreenState();
}

class _productEditScreenState extends State<productEditScreen> {
  PageController? _pageController;

  final Product_Edit_controller _productEditController = Get.put(
      Product_Edit_controller(),
      tag: Product_Edit_controller().toString());
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
    _init();
    super.initState();

    account_head();
    // group_name_API();
    //
    // product_Edit_get();
  }

  _init() async {
    await account_head();
    await group_name_API();
    await product_Edit_get();
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

  List gst = [
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

  String? _selectedgst_purchase;
  String? _selectedgst_sales;
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

  var data;

  void refresh() {
    setState(() {});
  }

  int? quantity_hand;
  int? purchase_price;
  int? low_stock;
  int? sales_price;
  int? sales_gst;
  int? purchase_gst;
  int? grp_id;
  int? subgrp_id;
  String? unit_name;

  Future product_Edit_get() async {
    showLoader(context);
    group_name_API();
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://magnetbackend.fsp.media/api/product/${widget.product_id}';

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
      hideLoader(context);
      // Navigator.pop(context);
      // Customer_list_API();
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));
      print("Books");
      setState(() {
        data = Books["data"];
        print("data");
        print(data);

        product_name_controller.text = data["product_name"];
        hsn_code_controller.text = data["description"];
        // _selectedgroup =data["group_id"];
        quantity_hand = data["product_quantity_on_hand"];
        quentity_hand_controller.text = quantity_hand.toString();

        as_of_date_controller.text = data["product_as_of_date"];

        purchase_price = data["purchase_price"];
        purchase_price_controller.text = purchase_price.toString();

        low_stock = data["product_low_stock_alert"];
        low_stock_controller.text = low_stock.toString();

        sales_price = data["sales_price"];

        sales_price_controller.text = sales_price.toString();

        _selectedgst_purchase = data["gst_purchase"].toString();
        print("_selectedgst_purchase");
        print(_selectedgst_purchase);

        _selectedgst_sales = data["gst_sales"].toString();
        print("_selectedgst_sales");
        print(_selectedgst_sales);



        income_amount_controller.text = data["income_account"];
        expanse_controller.text = data["expense_account"];

        grp_id = data["group_id"];
        // _selectedgroup = grp_id.toString();

        subgrp_id = data["sub_group_id"];
        // _selectedsubgroup = subgrp_id.toString();

        unit_name = data["product_unit"];

        unit_model unit_new =
            unit.firstWhere((element) => element.value == data["product_unit"]);

        print(unit_new.value);
        print("GroupData");
        print(GroupData.length);

        account account_income =
            income_account.firstWhere((element) => element.value ==data["income_account"]);
        select_income_Ammount = account_income;

        account account_expanse =
        expense_account.firstWhere((element) => element.value ==data["expense_account"]);
        select_expense_Ammount = account_expanse;

        var g_data_items = GroupData.firstWhere(
            (element) => element["id"] == data["group_id"]);
        List s_group = g_data_items["sub_groups"];

        // var s_group_items = s_group.firstWhere((element) => element["id"] == data["sub_group_id"]);

        print("blah");
        print(g_data_items);
        // print(s_group_items);
        _selectedgroup = g_data_items["id"].toString();
        // _selectedsubgroup= s_group_items["id"].toString();
        selectedUnit = unit_new;
        print("selectedUnit");
        print(selectedUnit);

        print("unt");
        print(data["product_unit"]);

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

  final ifsc_code_controller = TextEditingController();

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
      data: Container(
        // margin: EdgeInsets.only(top: 36),
        // decoration: BoxDecoration(
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
                          (_productEditController.pageIndex == '01'
                              ? screenSize.width / 2
                              : (_productEditController.pageIndex == '02'
                                  ? screenSize.width / 3
                                  : (_productEditController.pageIndex == '03'
                                      ? screenSize.width / 4
                                      : 0)))),
                ),
              ),
            ),

            product_add(),
            // customer_ledger(),
            // (_indexData == 0
            //     ? customer_ledger()
            //     : (_indexData == 1
            //     ? vendors_ledger()
            //     : (_indexData == 2
            //     ? others_ledger()
            //     : customer_ledger()))),
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
      "product_unit": selectedUnit!.value.toString(),
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

    var url = Api_url.product_add_api + '/${widget.product_id}';
    var response = await http_service.put(url, data);

    if (response["success"]) {
      Get.offAllNamed(BindingUtils.product_service_ScreenRoute);
      print('Seccess');
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
        print(GroupData);
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

  Widget product_add() {
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

    return GetBuilder<Product_Edit_controller>(
      init: _productEditController,
      builder: (_) {
        return Expanded(
          child: Container(
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
                                items: GroupData.map((item) =>
                                    DropdownMenuItem<String>(
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
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedUnit,
                                onChanged: (newvalue) {
                                  setState(() {
                                    selectedUnit = newvalue;
                                    product_unit_controller.text =
                                        selectedUnit!.value;
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
                              : Border.all(
                                  color: Colors.transparent, width: 1)),
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
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold),
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
                                    _productEditController
                                        .pageIndexUpdate('02');
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
                                        'GST in sales',
                                        style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: gst
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: FontStyleUtility.h14(
                                        fontColor:
                                        ColorUtils.blackColor,
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
                                        'GST in Purchase',
                                        style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: gst
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: _selectedgst_sales,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedgst_purchase = value as String;
                                    gst_purchase_controller.text =
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
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: select_income_Ammount,
                                onChanged: (newvalue) {
                                  setState(() {
                                    select_income_Ammount = newvalue;
                                    income_amount_controller.text =
                                        select_income_Ammount!.value;
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
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: select_expense_Ammount,
                                onChanged: (newvalue) {
                                  setState(() {
                                    select_expense_Ammount = newvalue;
                                    expanse_controller.text =
                                        select_expense_Ammount!.value;
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
                                  _productEditController.pageIndexUpdate('01');
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
