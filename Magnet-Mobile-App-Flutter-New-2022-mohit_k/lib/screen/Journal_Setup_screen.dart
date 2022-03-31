import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/product_model.dart';
import 'package:magnet_update/model_class/vendor_ledger_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class journalSetupScreen extends StatefulWidget {
  const journalSetupScreen({Key? key}) : super(key: key);

  @override
  _journalSetupScreenState createState() => _journalSetupScreenState();
}

class _journalSetupScreenState extends State<journalSetupScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Journal_Setup_controller _journal_setup_screenConrtoller =
      Get.find(tag: Journal_Setup_controller().toString());
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
  List c_d = [
    "Credit",
    "Debit",
  ];
  String? _selectedd_b;

  String selectedValue = 'Exclusive of Tax';
  int? id;

  String? Vendor_name;
  int? Vendor_id;
  String? Vendor_billing_name;
  List<String> vendor_name_list = [];
  List<String> vendor_id_list = [];

  String? customer_name;
  int? customer_id;
  String? customer_billing_name;
  List<String> customer_name_list = [];
  List<String> customer_id_list = [];

  String? other_name;
  int? other_id;
  String? other_billing_name;
  List<String> other_name_list = [];
  List<String> other_id_list = [];

  List<String> ledger_name_list = [];
  List<String> ledger_id_list = [];
  List<String> entity_type_list = [];

  String? Product_name_selected;
  int? Product_id;
  String? product_Hsn_Sac_name;

  bool customer_selected = false;
  bool vendor_selected = false;
  bool other_selected = false;

  // bool selected_customer= false;
  // String? customer_name;
  late String dateSelected_invoice;
  TextEditingController dateController = new TextEditingController();
  TextEditingController voucher_number_controller = new TextEditingController();
  TextEditingController global_narration_controller =
      new TextEditingController();
  List credit_debit = [];
  List<TextEditingController> credit_ammount = [];
  List<TextEditingController> debit_ammount = [];
  List<TextEditingController> note_controller = [];

  void select_vendor() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Vendors',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                        Text('Add new Vendor',
                            style: FontStyleUtility.h14(
                              fontColor: ColorUtils.blueColor,
                              fontWeight: FWT.semiBold,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, left: 30, right: 30, bottom: 20),
                    child: build_vendors_Search(),
                  ),
                  Expanded(child: list())
                ],
              ),
            ),
          );
        });
  }

  Widget list() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Final_customer.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  //  selected_customer= true;
                  //  setState(
                  //    customer_name = task_cust_name[index]
                  //  );
                  // print(task_cust_name[index]);
                  setState(() {
                    customer_selected = true;
                  });
                  setState(() {
                    customer_name = Final_customer[index]["account_name"];
                    customer_id = Final_customer[index]["id"];
                    customer_billing_name =
                        Final_customer[index]["billing_name"];

                    customer_name_list.add(customer_billing_name!);
                    customer_id_list.add(customer_id.toString());

                    ledger_name_list.add(customer_billing_name!);
                    ledger_id_list.add(customer_id.toString());
                    entity_type_list.add(Final_customer[index]["ledger_type"]);
                    print(ledger_id_list);
                    print(entity_type_list);
                  });
                  print("customer_name");
                  print(customer_name);
                  print("Customer_nid");
                  print(customer_id);
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorUtils.scffoldBgColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 12, right: 19),
                                    child: Text(
                                        "${Final_customer[index]["billing_name"]}",
                                        style: FontStyleUtility.h15(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 4, right: 19),
                                    child: Text(
                                        "${Final_customer[index]["account_name"]} / ${Final_customer[index]["company_name"]}",
                                        style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.medium,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 0, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Balance: ',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "${Final_customer[index]["opening_balance"]}/-",
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blueColor,
                                            fontWeight: FWT.semiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Final_vendor.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  //  selected_customer= true;
                  //  setState(
                  //    customer_name = task_cust_name[index]
                  //  );
                  // print(task_cust_name[index]);
                  setState(() {
                    vendor_selected = true;
                  });
                  setState(() {
                    Vendor_name = Final_vendor[index]["account_name"];
                    Vendor_id = Final_vendor[index]["id"];
                    Vendor_billing_name = Final_vendor[index]["billing_name"];

                    vendor_name_list.add(Vendor_billing_name!);
                    vendor_id_list.add(Vendor_id.toString());

                    ledger_name_list.add(Vendor_billing_name!);
                    ledger_id_list.add(Vendor_id.toString());
                    entity_type_list.add(Final_vendor[index]["ledger_type"]);

                    print(ledger_id_list);
                    print(entity_type_list);
                  });
                  print("Vendor_name");
                  print(Vendor_name);
                  print("Vendor_nid");
                  print(Vendor_id);

                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorUtils.scffoldBgColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 12, right: 19),
                                    child: Text(
                                        "${Final_vendor[index]["billing_name"]}",
                                        style: FontStyleUtility.h15(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 4, right: 19),
                                    child: Text(
                                        "${Final_vendor[index]["account_name"]} / ${Final_vendor[index]["company_name"]}",
                                        style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.medium,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 0, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Balance: ',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "${Final_vendor[index]["opening_balance"]}/-",
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blueColor,
                                            fontWeight: FWT.semiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Final_others.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  //  selected_customer= true;
                  //  setState(
                  //    customer_name = task_cust_name[index]
                  //  );
                  // print(task_cust_name[index]);
                  setState(() {
                    other_selected = true;
                  });
                  setState(() {
                    other_name = Final_others[index]["account_name"];
                    other_id = Final_others[index]["id"];
                    other_billing_name = Final_others[index]["billing_name"];

                    other_name_list.add(other_billing_name!);
                    other_id_list.add(other_id.toString());

                    ledger_name_list.add(other_billing_name!);
                    ledger_id_list.add(other_id.toString());
                    entity_type_list.add(Final_others[index]["ledger_type"]);

                    print(ledger_id_list);
                    print(entity_type_list);
                  });
                  print("other_name");
                  print(other_name);
                  print("other_id");
                  print(other_id);

                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorUtils.scffoldBgColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 12, right: 19),
                                    child: Text(
                                        "${Final_others[index]["billing_name"]}",
                                        style: FontStyleUtility.h15(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 12, top: 4, right: 19),
                                    child: Text(
                                        "${Final_others[index]["account_name"]} / ${Final_others[index]["company_name"]}",
                                        style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.ogfont,
                                          fontWeight: FWT.medium,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 0, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Balance: ',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "${Final_others[index]["opening_balance"]}/-",
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blueColor,
                                            fontWeight: FWT.semiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  int _counter = 1;

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
        dateController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);

    print('all Ledger');
    fetchAdd();
  }

  var debit;
  var credit;
  bool tap = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      body: custom_header(
        labelText: 'Add Information',
        back: AssetUtils.back_svg,
        backRoute: BindingUtils.journal_Screen_Route,
        data: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 0.0,
                    top: 0.0),
                child: Text(
                  'Add Information',
                  style: FontStyleUtility.h20B(
                    fontColor: ColorUtils.blackColor,
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x17000000),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                      color: ColorUtils.whiteColor,
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorUtils.whiteColor,
                            borderRadius:  BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              alignLabelWithHint: false,
                              isDense: true,
                              labelText: 'Voucher number',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15,left: 15,bottom: 15),
                              floatingLabelBehavior:FloatingLabelBehavior.auto,
                              labelStyle: FontStyleUtility.h12(
                                  fontColor: ColorUtils.ogfont,
                                  fontWeight: FWT.semiBold),
                            ),
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.blackColor, fontWeight: FWT.semiBold),
                            controller: voucher_number_controller,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorUtils.whiteColor,
                            borderRadius:  BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            onTap: (){
                              _showIOS_DatePicker(context);
                            },
                            showCursor: true,
                            readOnly: true,
                            decoration: InputDecoration(
                              alignLabelWithHint: false,
                              isDense: true,

                              labelText: 'Date',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15,left: 15,bottom: 15),
                              floatingLabelBehavior:FloatingLabelBehavior.auto,
                              labelStyle: FontStyleUtility.h12(
                                  fontColor: ColorUtils.ogfont,
                                  fontWeight: FWT.semiBold),
                            ),
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.blackColor, fontWeight: FWT.semiBold),
                            controller: dateController,
                          ),
                        ),
                      ),
                    ],
                  )),
              StatefulBuilder(builder: (context, setState) {
                return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 20.0),

                  itemCount: _counter,
                  itemBuilder: (context, index) {

                    credit_ammount.add(new TextEditingController());
                    debit_ammount.add(new TextEditingController());
                    note_controller.add(new TextEditingController());
                    credit_debit.add(_selectedd_b);

                    return Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75),
                            ),
                          ],
                          color: ColorUtils.whiteColor,
                          borderRadius: BorderRadius.circular(15)),
                      margin:
                      EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 18,right: 18,top: 20),
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
                                                fontColor:
                                                ColorUtils.ogfont,
                                                fontWeight:
                                                FWT.semiBold),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: c_d
                                        .map((item) =>
                                        DropdownMenuItem<String>(
                                          onTap: () {
                                            tap = false;
                                          },
                                          value: item,
                                          child: Text(
                                            item,
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils
                                                    .blackColor,
                                                fontWeight:
                                                FWT.semiBold),
                                            overflow: TextOverflow
                                                .ellipsis,
                                          ),
                                        ))
                                        .toList(),
                                    value: (credit_debit.isNotEmpty
                                        ? credit_debit[index]
                                        : _selectedd_b),
                                    onChanged: (value) {
                                      tap == true
                                          ? setState(() {
                                        _selectedd_b = "Hello";
                                        credit_debit[index].text =
                                        _selectedd_b!;
                                      })
                                          : setState(() {
                                        _selectedd_b =
                                        value as String;
                                        credit_debit[index] =
                                            _selectedd_b
                                                .toString();
                                        print(credit_debit);
                                      });
                                    },
                                    iconSize: 25,
                                    icon: SvgPicture.asset(
                                        AssetUtils.drop_svg),
                                    iconEnabledColor: Color(0xff007DEF),
                                    iconDisabledColor:
                                    Color(0xff007DEF),
                                    buttonHeight: 50,
                                    buttonWidth: 160,
                                    buttonPadding:
                                    const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: ColorUtils.ogback,
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
                                    offset: const Offset(0, 0),
                                  ),
                                );
                              },
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              select_vendor();
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: ColorUtils.ogback,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              margin: EdgeInsets.only(left: 18,right: 18,top: 15),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Text(
                                  (customer_selected
                                      ? '${customer_billing_name}'
                                      : (vendor_selected
                                      ? '${Vendor_billing_name}'
                                      : (other_selected
                                      ? '${other_billing_name}'
                                      : 'Select Vendor'))),
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 18,right: 18,top: 15),

                            child: CustomTextFieldWidget_two(
                              enabled: (_selectedd_b == "Credit"
                                  ? false
                                  : true),
                              controller: debit_ammount[index],
                              keyboardType: TextInputType.number,
                              labelText: 'Debit Ammount',
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 18,right: 18,top: 15),

                            child: CustomTextFieldWidget_two(
                              enabled: (_selectedd_b == "Debit"
                                  ? false
                                  : true),
                              controller: credit_ammount[index],
                              keyboardType: TextInputType.number,
                              labelText: 'Credit Ammount',
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 18,right: 18,top: 15),

                            child: CustomTextFieldWidget_two(
                              controller: note_controller[index],
                              maxLines: 2,
                              labelText: 'Note',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // customer_selected == false;
                                _counter--;
                                // print(Counter);
                                // print(transaction_type_controller);
                              });
                              // setState(() {}); // select_product();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 18,bottom: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            50),
                                        color: ColorUtils
                                            .delete_Color),
                                    child: Icon(
                                      Icons.close,
                                      color: ColorUtils
                                          .whiteColor,
                                      size: 10.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Delete Entry',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.redColor,
                                      fontWeight: FWT.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // customer_selected == false;
                    _counter++;
                    // print(Counter);
                    // print(transaction_type_controller);
                  });
                  // setState(() {}); // select_product();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ColorUtils.blueColor),
                        child: Icon(
                          Icons.add,
                          color: ColorUtils.whiteColor,
                          size: 15.0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add Product/Service',
                        style: FontStyleUtility.h12(
                          fontColor: ColorUtils.blueColor,
                          fontWeight: FWT.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x17000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    color: ColorUtils.whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 18),
                  child: CustomTextFieldWidget_two(
                    controller: global_narration_controller,
                    maxLines: 4,
                    labelText: 'Narration',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x17000000),
                blurRadius: 10.0,
                offset: Offset(0.0, 0.75),
              ),
            ],
            color: ColorUtils.whiteColor,
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '₹ ${debit_ammount.fold<int>(0, (previousValue, element) {
                              return (previousValue) +
                                  int.parse(element.value.text != ""
                                      ? element.value.text
                                      : "0");
                            })}',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.bold,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            '₹ ${credit_ammount.fold<int>(0, (previousValue, element) {
                              return (previousValue) +
                                  int.parse(element.value.text != ""
                                      ? element.value.text
                                      : "0");
                            })}',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.bold,
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  child: MyLeadingItemCustomButtonWidget(
                    title: 'Save',
                    alignment: Alignment.center,
                    onTap: () {
                      debit = debit_ammount.fold<int>(0,
                          (previousValue, element) {
                        return (previousValue) +
                            int.parse(element.value.text != ""
                                ? element.value.text
                                : "0");
                      });
                      credit = credit_ammount.fold<int>(0,
                          (previousValue, element) {
                        return (previousValue) +
                            int.parse(element.value.text != ""
                                ? element.value.text
                                : "0");
                      });
                      print(debit);
                      print(credit);

                      if (credit == debit) {
                        print("success");
                        journal_API();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Credit Debit ammount doesn't match",
                            backgroundColor: Colors.black87,
                            textColor: Colors.white,
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG);
                        print("error");
                      }

                      // Get.offAllNamed(BindingUtils.companyDetailsScreenRoute);
                    }, // Navigator.push(
                  ),
                )
              ],
            )),
      ),
    );
  }

  String Token = "";

  Future journal_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    print(ledger_id_list);

    List journalItems = [];
    for (int i = 0; i < _counter; i++) {
      {
        Map entity = {
          "id": i,
          "entity_id": ledger_id_list[i],
          "particular_name": ledger_name_list[i],
          "voucher_number": "string",
          "entity_type": entity_type_list[i],
          "payment_type": credit_debit[i],
          "credit_amount": credit_ammount[i].text,
          "debit_amount": debit_ammount[i].text,
          "narration": note_controller[i].text,
          // "created_at": "2022-02-01T10:09:26.781Z",
          // "created_by": 0
        };
        journalItems.add(entity);
      }
    }

    Map data = {
      // "id": 0,
      "voucher_number": voucher_number_controller.text,
      "date": dateController.text,
      "voucher_id": 0,
      "total_credit_amount": credit,
      "total_debit_amount": debit,
      "global_narration": global_narration_controller.text,
      "journal_items": journalItems,
      "company_profile_id": 0,
      "created_at": "2022-02-01T10:09:26.781Z",
      "update_at": "2022-02-01T10:09:26.781Z",
      "created_by": 0,
      "update_by": 0,
      "fin_start_date": "string",
      "fin_end_date": "string"
    };

    print("data");
    print(data);

    String body = json.encode(data);
    var url = Api_url.journal_add_api;
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
      Get.offAllNamed(BindingUtils.journal_Screen_Route);
      print('Seccess');
    } else {
      print("error");
    }
  }

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

  String query_vendors = '';
  List<Data_vendors> VendorsData = [];

  List<dynamic> Final = [];
  List<dynamic> Final_customer = [];
  List<dynamic> Final_vendor = [];
  List<dynamic> Final_others = [];
  var newList = [];

  // var newList = [...this.CustomersData, ...list2, ...list3];

  String query_products = '';
  List<Data_product> ProductData = [];

  Future Vendors_list_API() async {
    final books = await call_api.getVendorsList(query_vendors);

    setState(() {
      this.VendorsData = books;
    });
    // print(VendorsData);
  }

  Future Vendors_list_search_API(String query) async {
    final books_vendors = await call_api.getVendorsList(query);

    if (!mounted) return;

    setState(() {
      this.query_vendors = query;
      this.VendorsData = books_vendors;
    });
  }

  Widget build_vendors_Search() {
    return SearchWidget(
      text: query_vendors,
      hintText: 'Search Here',
      onChanged: Vendors_list_search_API,
    );
  }

  Future fetchAdd() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://magnetbackend.fsp.media/api/customers/all-ledgers/modal?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody =
          json.decode(response.body.replaceAll('}[]', '}'));
      setState(() {
        Final_customer = responseBody["data"]["customers"];
        Final_vendor = responseBody["data"]["vendors"];
        Final_others = responseBody["data"]["others"];
        newList = [Final_customer, Final_vendor, Final_others]
            .expand((x) => x)
            .toList();
        print(newList);
        print(newList.length);
      });
    } else {
      throw Exception('Failed to load');
    }
  }

// Future all_ledger() async {
//   Token = await PreferenceManager().getPref(Api_url.token);
//   var url =
//       'https://magnetbackend.fsp.media/api/customers/all-ledgers/modal?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';
//
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       // "Accept": "application/json",
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ' + Token
//     },
//   );
//   print(json.decode(response.body.replaceAll('}[]', '}')));
//   // Map<String, dynamic> Books = json.decode(response.body);
//   // List books = Books['data'];
//   // print(Books);
//   // print(books);
//
//   if (response.statusCode == 200) {
//     Map<String, dynamic> responseBody = json.decode(response.body);
//
//     print("response");
//     Final = responseBody['data'];
//     print(Final);
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
}
