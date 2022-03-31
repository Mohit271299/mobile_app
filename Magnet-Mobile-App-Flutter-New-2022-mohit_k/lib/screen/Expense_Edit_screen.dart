import 'dart:convert';
import 'dart:core';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/customer_ledger_model.dart';
import 'package:magnet_update/model_class/other_ledger_model.dart';
import 'package:magnet_update/model_class/product_model.dart';
import 'package:magnet_update/model_class/vendor_ledger_model.dart';
import 'package:magnet_update/model_edit_class/remove_expense.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';
import 'package:number_to_words/number_to_words.dart';

class expenseEditScreen extends StatefulWidget {
  final int? expense_id;

  const expenseEditScreen({Key? key, this.expense_id}) : super(key: key);

  @override
  _expenseEditScreenState createState() => _expenseEditScreenState();
}

class _expenseEditScreenState extends State<expenseEditScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Expense_Edit_controller _expenseEditController =
      Get.put(Expense_Edit_controller(), tag: Expense_Edit_controller().toString());
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
  final List<String> tax_type = <String>[
    'exclusive_tax',
    'inclusive_tax',
    'out_of_tax'
  ];
  List terms = [
    "05",
    "10",
    "20",
    "30",
  ];
  String? _selected_term;
  String selectedValue = 'exclusive_tax';
  int? id;

  String? Vendor_name;
  int? Vendor_id;
  String? Vendor_billing_name;

  String? customer_name;
  int? customer_id;
  String? customer_billing_name;

  String? other_name;
  int? other_id;
  String? other_billing_name;

  String? Product_name_selected;
  int? Product_id;
  String? product_Hsn_Sac_name;

  bool customer_selected = false;
  bool vendor_selected = false;
  bool other_selected = false;

  // bool selected_customer= false;
  // String? customer_name;
  late String dateSelected_invoice;
  TextEditingController invoicedateController = new TextEditingController();
  final List<String> invoice_date_list = <String>[];
  TextEditingController duedateController = new TextEditingController();
  TextEditingController podateController = new TextEditingController();
  TextEditingController ponumberController = new TextEditingController();
  final List<String> due_date_list = <String>[];
  TextEditingController invoiceNumberController = new TextEditingController();
  TextEditingController SrNumberController = new TextEditingController();
  final List<String> invoice_number_list = <String>[];
  TextEditingController termsController = new TextEditingController();
  TextEditingController Addressontroller = new TextEditingController();
  TextEditingController Gst_no_Controller = new TextEditingController();
  TextEditingController place_of_supply_Controller =
      new TextEditingController();

  TextEditingController expanse_account_name_controller =
      new TextEditingController();
  TextEditingController Expanse_comp_controller = new TextEditingController();
  TextEditingController product_unit_controller = new TextEditingController();
  TextEditingController product_quantity_controller =
      new TextEditingController();
  TextEditingController product_rate_controller = new TextEditingController();
  TextEditingController product_tax_controller = new TextEditingController();
  TextEditingController product_discount_controller =
      new TextEditingController();

  final List<String> product_name_list = <String>[];
  final List<String> product_quantity_list = <String>[];
  final List<String> product_rate_list = <String>[];
  final List<double> product_total_exl_price_list = <double>[];

  final List<String> product_id_list = <String>[];

  final List<double> product_texable_inl_price_list = <double>[];
  final List<double> product_texable_exl_price_list = <double>[];

  final List<String> product_total_out_of_scope_price_list = <String>[];
  final List<double> product_total_tax_list_excl = <double>[];
  final List<double> product_total_tax_list_incl = <double>[];
  final List<double> product_total_ammount_list = <double>[];
  final List<double> product_total_dis_list = <double>[];
  final List<double> product_total_inc_ammount_list = <double>[];
  num? product_final_tax_excl;
  num? product_final_tax_incl;
  num? product_final_dis;
  num? product_final_amt;

  num? product_final_taxable_amt_exl;
  num? product_final_taxable_amt_incl;

  num? product_final_exclusive_price;
  num? product_final_inclusive_price;
  String? word_exl;
  String? word_incl;
  String? word_other;
  final List<String> product_tax_list = <String>[];
  final List<String> product_discount_list = <String>[];

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

  Future<void> select_product() async {
    await showModalBottomSheet(
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
                        Text('Select Product',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                        Text('Add new Product',
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
                    child: build_others_Search(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: OthersData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            //  selected_customer= true;
                            //  setState(
                            //    customer_name = task_cust_name[index]
                            //  );
                            // print(task_cust_name[index]);

                            setState(() {
                              Product_id = OthersData[index].id;
                              product_id_list.add("$Product_id");

                              expanse_account_name_controller.text =
                                  OthersData[index].billingName!;
                              Expanse_comp_controller.text =
                                  OthersData[index].accountName!;
                              print(expanse_account_name_controller.text);
                            });
                            Navigator.pop(context);
                            add_product();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.scffoldBgColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 12, top: 12, right: 19),
                                          child: Text(
                                              "${OthersData[index].billingName}",
                                              style: FontStyleUtility.h15(
                                                fontColor:
                                                    ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold,
                                              )),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 12, top: 4, right: 19),
                                          child: Text(
                                              '${OthersData[index].companyName}',
                                              style: FontStyleUtility.h12(
                                                fontColor: ColorUtils.ogfont,
                                                fontWeight: FWT.medium,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0, right: 15),
                                  child: Text(
                                      'Balance: ${OthersData[index].openingBalance}',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      )),
                                ),
                              ],
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

  String resulttext_total_exl = "0";
  String resulttext_total_dis = "0";
  String resulttext_total_inl = "0";
  String resulttext_total_out_of_scope = "0";
  String resulttext_amount = "0";

  String resulttotal_tax_excl = '0';

  String resulttotal_tax_incl = '0';

  String resulttext_discount = "0";

  Future<void> add_product() async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  color: Color(0xff737373),
                  child: Container(
                    height: 470,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, left: 30, right: 30, bottom: 20),
                          child: Text('Add Product',
                              style: FontStyleUtility.h17(
                                fontColor: ColorUtils.blackColor,
                                fontWeight: FWT.semiBold,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, bottom: 15),
                          child: CustomTextFieldWidget_two(
                            controller: expanse_account_name_controller,
                            labelText: 'Product Name/ Description',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, bottom: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldWidget_two(
                                  controller: Expanse_comp_controller,
                                  labelText: 'HSN',
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: CustomTextFieldWidget_two(
                                  controller: product_unit_controller,
                                  labelText: 'Unit',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, bottom: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldWidget_two(
                                  keyboardType: TextInputType.number,
                                  controller: product_quantity_controller,
                                  labelText: 'Qty.',
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: CustomTextFieldWidget_two(
                                  keyboardType: TextInputType.number,
                                  controller: product_rate_controller,
                                  labelText: 'Rate',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, bottom: 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldWidget_two(
                                  controller: product_discount_controller,
                                  labelText: 'Discount.',
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: CustomTextFieldWidget_two(
                                  keyboardType: TextInputType.number,
                                  controller: product_tax_controller,
                                  labelText: 'Tax',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 27),
                            child: Divider(
                              color: ColorUtils.ogback,
                              height: 10,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 38),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('Ammount',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('Discount',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('Tax',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('Total',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.bold,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("{Ammount}",
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('₹ 5,580.00',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('₹ 5,580.00',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('₹ 5,580.00',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              );
            },
          );
        }).then((val) {
      model.add(edit_expense_model(
        productname: expanse_account_name_controller.text,
        product_qnty: product_quantity_controller.text,
        product_rate: product_rate_controller.text,
        product_dis: product_discount_controller.text,
        product_tax: product_tax_controller.text,
      ));

      // tax_invoice_Edit_get();
      product_name_list.add(expanse_account_name_controller.text);
      product_quantity_list.add(product_quantity_controller.text);
      product_rate_list.add(product_rate_controller.text);
      product_tax_list.add(product_tax_controller.text);
      product_discount_list.add(product_discount_controller.text);

      double amount = double.parse(product_quantity_controller.text) *
          double.parse(product_rate_controller.text);

      double disc =
          amount * double.parse(product_discount_controller.text) / 100;
      double ammountInti = amount - disc;

      resulttext_amount = ammountInti.toStringAsFixed(3);
      double taxInti =
          ammountInti * double.parse(product_tax_controller.text) / 100;

      double taxIntiIncl = ammountInti *
          double.parse(product_tax_controller.text) /
          (100 + double.parse(product_tax_controller.text));

      double exlAmmountTotal = ammountInti + taxInti;
      double inlAmmountTotal = ammountInti - taxIntiIncl;

      resulttext_total_exl = exlAmmountTotal.toStringAsFixed(3);
      resulttext_total_inl = inlAmmountTotal.toStringAsFixed(3);
      resulttext_total_dis = disc.toString();

      resulttext_total_out_of_scope = ammountInti.toString();
      resulttotal_tax_excl = taxInti.toStringAsFixed(3);
      resulttotal_tax_incl = taxIntiIncl.toStringAsFixed(3);

      model_texable.add(expense_texable_value(
          product_texable_incl: "${double.parse(resulttext_total_inl)}",
          product_texable_excl: "${double.parse(resulttext_amount)}",
          product_final_tax_incl: "${double.parse(resulttotal_tax_excl)}",
          product_final_tax_excl: "${double.parse(resulttotal_tax_incl)}"));

      product_texable_inl_price_list.add(double.parse(resulttext_total_inl));
      product_texable_exl_price_list.add(double.parse(resulttext_amount));

      product_total_tax_list_excl.add(double.parse(resulttotal_tax_excl));
      product_total_tax_list_incl.add(double.parse(resulttotal_tax_incl));
      print(product_total_tax_list_excl);
      print(product_total_tax_list_incl);
      product_total_dis_list.add(double.parse(resulttext_total_dis));
      product_total_ammount_list.add(double.parse(resulttext_amount));

      print(product_total_ammount_list);

      num amt = 0;
      product_total_ammount_list.forEach((num element) {
        amt += element;
      });
      product_final_amt = amt;
      print("product_final_amt");
      print(product_final_amt);

      num taxExl = 0;
      model_texable.forEach((element) {
        taxExl += num.parse(element.product_final_tax_excl);
      });
      product_final_tax_excl = taxExl;
      print("product_final_tax_excl");
      print(product_final_tax_excl);

      num taxIncl = 0;
      model_texable.forEach((element) {
        taxIncl += num.parse(element.product_final_tax_incl);
      });
      product_final_tax_incl = taxIncl;
      print("product_final_tax_incl");
      print(product_final_tax_incl);

      num dis = 0;
      product_total_dis_list.forEach((num element) {
        dis += element;
      });
      product_final_dis = dis;
      print("product_final_dis");
      print(product_final_dis);

      num exl = 0;
      product_total_exl_price_list.add(double.parse(resulttext_total_exl));
      product_total_exl_price_list.forEach((num element) {
        exl += element;
      });
      product_final_exclusive_price = exl;
      print("product_final_exclusive_price");
      print(product_final_exclusive_price);

      word_exl = NumberToWord()
          .convert('en-in', product_final_exclusive_price!.toInt());

      num icl = 0;
      product_total_inc_ammount_list.add(double.parse(resulttext_amount));
      product_total_inc_ammount_list.forEach((num element) {
        icl += element;
      });
      product_final_inclusive_price = icl;
      print("product_final_inclusive_price");
      print(product_final_inclusive_price);
      word_incl = NumberToWord()
          .convert('en-in', product_final_inclusive_price!.toInt());

      num taxableInl = 0;
      product_texable_inl_price_list.forEach((element) {
        taxableInl += element;
      });
      product_final_taxable_amt_incl = taxableInl;

      num taxableExl = 0;
      product_texable_exl_price_list.forEach((element) {
        taxableExl += element;
      });
      product_final_taxable_amt_exl = taxableExl;
      word_other = NumberToWord()
          .convert('en-in', product_final_taxable_amt_exl!.toInt());

      product_total_out_of_scope_price_list.add(resulttext_total_out_of_scope);
      print(productItems.length);
      print("final data");
      print(product_name_list);
      print(product_quantity_list);
      print(product_rate_list);
      print(product_texable_exl_price_list);
      print(product_texable_inl_price_list);
      print(product_tax_list);
      print("final data");

      print(product_total_exl_price_list);

      expanse_account_name_controller.clear();
      product_quantity_controller.clear();
      product_rate_controller.clear();
      product_tax_controller.clear();
      product_discount_controller.clear();

      // productItems.length++;
      // print(productItems.length);
    });
    setState(() {
      Counter++;
      print(
          "Counter>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(Counter);
    });
    // setState(() {});
  }

  void tax_details() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Color(0xff737373),
                child: Container(
                  height: 470,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 20, left: 30, right: 30, bottom: 20),
                        child: Text('Tax Details',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, bottom: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorUtils.ogback)),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('CGST @6%',
                                      style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.semiBold,
                                      )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('On 5,550.00',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('SGST @6%',
                                      style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.semiBold,
                                      )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('On 5,550.00',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('₹ 330.00',
                                      style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.semiBold,
                                      )),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text('₹ 330.00',
                                      style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.semiBold,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 27),
                          child: Divider(
                            color: ColorUtils.ogback,
                            height: 10,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 38),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blackColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxable Value',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.ogfont,
                                      fontWeight: FWT.semiBold,
                                    )),
                                Text('₹ 5,580.00',
                                    style: FontStyleUtility.h12(
                                      fontColor: ColorUtils.blueColor,
                                      fontWeight: FWT.semiBold,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                ),
              );
            },
          );
        });
  }

  String? initial_date;
  String? second_date;
  DateTime? pickedDate;

  Future<void> _showInvoice_DatePicker(ctx) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
      setState(() {
        invoicedateController.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
  Future<void> terms_date(int _date) async {
    if (pickedDate != null) {
      setState(() {
        initial_date = DateFormat('dd-MM-yyyy').format(pickedDate!);
        final move = pickedDate!.add( Duration(days: _date));
        second_date = DateFormat('dd-MM-yyyy').format(move);
        print(second_date);
      });
      setState(() {
        duedateController.text = second_date!; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> _show_DatePicker_due(ctx) async {
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
        duedateController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
    Customer_list_API();
    Vendors_list_API();
    others_list_API();
    Product_list_API();
    // purchase_API();
    expense_Edit_get();

    print('all Ledger');
    fetchAdd();
  }

  var data;
  List productItems = [];
  var entity;
  var product;
  var customers;
  List ind = [];
  List ammount = [];
  List discc = [];
  List<double> taxx_exl = <double>[];
  List<double> taxx_incl = <double>[];
  List<double> total_price_excl = <double>[];
  List<double> total_price_incl = <double>[];
  List<double> total_texable_excl = <double>[];
  List<double> total_texable_incl = <double>[];

  List final_amt = [];
  List final_amt_exl = [];
  List final_amt_incl = [];
  num? final_txt_excl;
  num? final_txt_incl;
  num? final_excl_price;
  num? final_incl_price;

  num? final_texable_incl_price;
  num? final_texable_excl_price;

  String? last_excl_price_word;
  String? last_incl_price_word;
  String? excl_price_word;
  String? incl_price_word;
  String taxt_excl_string = '0';
  String taxt_incl_string = '0';
  String total_excl_price_string = '0';
  String total_incl_price_string = '0';
  String ammount_string = '0';

  List<edit_expense_model> model = [];

  List<expense_texable_value> model_texable = [];

  final List<double> product_total_taxable_value_excl = <double>[];
  final List<double> product_total_taxable_value_incl = <double>[];
  List<String> exclusive_amt = <String>[];

  void refresh() {
    setState(() {});
  }

  Future expense_Edit_get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://magnetbackend.fsp.media/api/expense/${widget.expense_id}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print("taxinvoice.statusCode");
    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      // Customer_list_API();
      Map<String, dynamic> Books =
          json.decode(response.body.replaceAll('}[]', '}'));
      print(Books);
      setState(() {
        data = Books["data"];
        productItems = data["expense_items"];
        entity = data["entity"];
        print(productItems);
        print("qqqqqqqqqqqqqqqqqqqqqqqqq");
        print(entity);
        Counter = productItems.length;
        print(Counter);
        print(product_final_exclusive_price);
        for (int i = 0; i < productItems.length; i++) {
          model.add(edit_expense_model(
            productname: "${productItems[i]["other"]["billing_name"]}",
            product_qnty: "${productItems[i]["product_qty"]}",
            product_rate: "${productItems[i]["product_rate"]}",
            product_dis: "${productItems[i]["product_discount"]}",
            product_tax: "${productItems[i]["product_tax"]}",
          ));
          // print(productItems[i]["product"]["product_name"]);
          // print(productItems);
          double amount = int.parse(model[i].product_qnty.toString()) *
              double.parse(model[i].product_rate.toString());
          double disc =
              (amount * double.parse(model[i].product_dis.toString())) / 100;
          double ammountInti = amount - disc;
          double taxExl =
              ammountInti * double.parse(model[i].product_tax.toString()) / 100;
          double taxIncl = ammountInti *
              double.parse(model[i].product_tax.toString()) /
              (100 + double.parse(model[i].product_tax.toString()));

          double exlAmmountTotal = ammountInti + taxExl;
          double inlAmmountTotal = ammountInti - taxIncl;

          print(productItems[i]["product_qty"]);

          product_name_list.add("${productItems[i]["other"]["billing_name"]}");
          product_quantity_list.add("${productItems[i]["product_qty"]}");
          product_rate_list.add("${productItems[i]["product_rate"]}");
          product_discount_list.add("${productItems[i]["product_discount"]}");
          product_tax_list.add("${productItems[i]["product_tax"]}");
          product_id_list.add("${productItems[i]["product_id"]}");

          ind.add(i);
          ammount.add(amount);
          discc.add(disc);

          taxt_excl_string = taxExl.toStringAsFixed(3);
          taxt_incl_string = taxIncl.toStringAsFixed(3);
          total_excl_price_string = exlAmmountTotal.toStringAsFixed(3);
          total_incl_price_string = inlAmmountTotal.toStringAsFixed(3);
          ammount_string = ammountInti.toStringAsFixed(3);

          model_texable.add(expense_texable_value(
              product_texable_incl: "${double.parse(total_incl_price_string)}",
              product_texable_excl: "${double.parse(ammount_string)}",
              product_final_tax_excl: "${double.parse(taxt_excl_string)}",
              product_final_tax_incl: "${double.parse(taxt_incl_string)}"));

          product_texable_exl_price_list.add(double.parse(ammount_string));
          product_texable_inl_price_list
              .add(double.parse(total_incl_price_string));

          print("product_texable_exl_price_list");
          print(product_texable_exl_price_list);
          print("product_texable_inl_price_list");
          print(product_texable_inl_price_list);

          print("taxt_tax_string");

          product_total_tax_list_excl.add(double.parse(taxt_excl_string));
          product_total_tax_list_incl.add(double.parse(taxt_incl_string));

          print(product_total_tax_list_excl);
          print(product_total_tax_list_incl);
          print("total_amt_string");
          product_total_exl_price_list
              .add(double.parse(total_excl_price_string));
          product_total_inc_ammount_list.add(double.parse(ammount_string));
          num dis = 0;
          product_total_dis_list.forEach((num element) {
            dis += element;
          });
          product_final_dis = dis;
          print("product_final_dis");
          print(product_final_dis);

          num taxExl1 = 0;
          model_texable.forEach((element) {
            taxExl1 += num.parse(element.product_final_tax_excl);
          });
          product_final_tax_excl = taxExl1;
          print("product_final_tax_excl1111111111111111111");
          print(product_final_tax_excl);

          num taxIncl1 = 0;
          model_texable.forEach((element) {
            taxIncl1 += num.parse(element.product_final_tax_incl);
          });
          product_final_tax_incl = taxIncl1;
          print("product_final_tax_incl");
          print(product_final_tax_incl);

          num taxableInl = 0;
          model_texable.forEach((element) {
            taxableInl += num.parse(element.product_texable_incl);
          });
          product_final_taxable_amt_incl = taxableInl;

          num taxableExl = 0;
          model_texable.forEach((element) {
            taxableExl += num.parse(element.product_texable_excl);
          });
          product_final_taxable_amt_exl = taxableExl;

          num exl = 0;
          product_total_exl_price_list.add(double.parse(resulttext_total_exl));
          product_total_exl_price_list.forEach((num element) {
            exl += element;
          });
          product_final_exclusive_price = exl;
          print("product_final_exclusive_price");
          print(product_final_exclusive_price);

          word_exl = NumberToWord()
              .convert('en-in', product_final_exclusive_price!.toInt());

          num icl = 0;
          product_total_inc_ammount_list.add(double.parse(resulttext_amount));
          product_total_inc_ammount_list.forEach((num element) {
            icl += element;
          });
          product_final_inclusive_price = icl;
          print("product_final_inclusive_price");
          print(product_final_inclusive_price);
          word_incl = NumberToWord()
              .convert('en-in', product_final_inclusive_price!.toInt());

          final_amt.add(ammountInti);
          final_amt_exl.add(exlAmmountTotal.toStringAsFixed(3));
          final_amt_incl.add(inlAmmountTotal.toStringAsFixed(3));

          print("productname");
          print(model[i].product_tax);
          print("productname");
        }

        invoicedateController.text = data["invoice_date"];
        invoiceNumberController.text = data["invoice_number"];
        SrNumberController.text = data["sr_number"];
        duedateController.text = data["due_date"];

        (data["entity_type"] == "customer"
            ? customer_selected = true
            : (data["entity_type"] == "vendor"
                ? vendor_selected = true
                : (data["entity_type"] == "other"
                    ? other_selected = true
                    : customer_name = data["ledger_name"])));

        (customer_selected
            ? customer_id = data["entity_id"]
            : (vendor_selected
                ? Vendor_id = data["entity_id"]
                : (other_selected
                    ? other_id = data["entity_id"]
                    : customer_id = data["ledger_name"])));

        (customer_selected
            ? customer_name = entity["account_name"]
            : (vendor_selected
                ? Vendor_name = entity["account_name"]
                : (other_selected
                    ? other_name = entity["account_name"]
                    : customer_name = entity["account_name"])));

        (customer_selected
            ? customer_billing_name = entity["billing_name"]
            : (vendor_selected
                ? Vendor_billing_name = entity["billing_name"]
                : (other_selected
                    ? other_billing_name = entity["billing_name"]
                    : customer_billing_name = entity["billing_name"])));

        termsController.text = data["terms"];
        Addressontroller.text = data["billing_address"];
        Gst_no_Controller.text = data["gst_number"];
        place_of_supply_Controller.text = data["place_of_supply"];
        selectedValue = data["tax_type"];
      });

      print("tax_edit_details");
      print(data);
      print("----------------------");
      print("tax_edit_prodcut_details");
      print(productItems);
      print(customer_billing_name);
      print(Vendor_billing_name);
      print(customer_billing_name);

      return json.decode(response.body);
    } else {
      throw Exception('Item Not Found!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,

      body: custom_header(
        labelText: 'Add Information',
        back: AssetUtils.back_svg,
        backRoute: BindingUtils.expanses_ScreenRoute,
        data: GetBuilder<Expense_Edit_controller>(
            init: _expenseEditController,
            builder: (_) {
              return Container(
                  // margin: EdgeInsets.only(top: 0),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(10),
                  //       topRight: Radius.circular(10)),
                  //   color: ColorUtils.ogback,
                  // ),
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 0,
                                ),
                                child: Text(
                                  'Add Information',
                                  style: FontStyleUtility.h20B(
                                    fontColor: ColorUtils.blackColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  select_vendor();
                                },
                                child: Container(
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
                                  margin: EdgeInsets.only(top: 15),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Customer and Company Name",
                                              // (selected_customer == true ? Text(customer_name!) : Text(customer_name!)),
                                              style: FontStyleUtility.h11(
                                                fontColor:
                                                ColorUtils.greyTextColor,
                                                fontWeight: FWT.medium,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              (customer_selected
                                                  ? '$customer_billing_name'
                                                  : (vendor_selected
                                                  ? '$Vendor_billing_name'
                                                  : (other_selected
                                                  ? '$other_billing_name'
                                                  : '$customer_billing_name'))),
                                              style: FontStyleUtility.h15(
                                                fontColor:
                                                ColorUtils.blackColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: SvgPicture.asset(
                                              AssetUtils.arrow_right),
                                        ),
                                      ],
                                    ),
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
                                  margin: EdgeInsets.only(top: 15,bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: Text(
                                          'Required Details',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        child: CustomTextFieldWidget_two(
                                          controller: SrNumberController,
                                          keyboardType: TextInputType.number,
                                          labelText: 'Sr Number',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        child: CustomTextFieldWidget_two(
                                          controller: invoiceNumberController,
                                          keyboardType: TextInputType.number,
                                          labelText: 'Invoice Number',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xfff3f3f3),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: TextFormField(
                                                enabled: false,
                                                controller:
                                                invoicedateController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(
                                                      top: 5, left: 12),
                                                  labelText: 'Invoice Date',
                                                  labelStyle:
                                                  FontStyleUtility.h12(
                                                      fontColor: ColorUtils
                                                          .greyTextColor,
                                                      fontWeight:
                                                      FWT.medium),
                                                  border: InputBorder.none,
                                                ),
                                                style: FontStyleUtility.h14(
                                                    fontColor:
                                                    ColorUtils.blackColor,
                                                    fontWeight: FWT.semiBold),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                _showInvoice_DatePicker(context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: SvgPicture.asset(
                                                  AssetUtils.date_picker,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        child: CustomTextFieldWidget_two(
                                          labelText: 'Address',
                                          controller: Addressontroller,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        child: CustomTextFieldWidget_two(
                                          keyboardType: TextInputType.number,
                                          controller: Gst_no_Controller,
                                          labelText: 'Gst Number',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        child: CustomTextFieldWidget_two(
                                          controller:
                                          place_of_supply_Controller,
                                          labelText: 'Place of Supply',
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
                                                        'Terms',
                                                        style: FontStyleUtility.h12(
                                                            fontColor: ColorUtils.ogfont,
                                                            fontWeight: FWT.semiBold),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                items: terms
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
                                                value: _selected_term,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selected_term = value as String;
                                                    termsController.text = _selected_term!;
                                                    print(_selected_term);
                                                    terms_date(int.parse(_selected_term!));
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
                                        margin: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xfff3f3f3),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: TextFormField(
                                                readOnly: true,
                                                controller: duedateController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(
                                                      top: 5, left: 12),
                                                  labelText: 'Due Date',
                                                  labelStyle:
                                                  FontStyleUtility.h12(
                                                      fontColor: ColorUtils
                                                          .greyTextColor,
                                                      fontWeight:
                                                      FWT.medium),
                                                  border: InputBorder.none,
                                                ),
                                                style: FontStyleUtility.h14(
                                                    fontColor:
                                                    ColorUtils.blackColor,
                                                    fontWeight: FWT.semiBold),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                _show_DatePicker_due(context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: SvgPicture.asset(
                                                  AssetUtils.date_picker,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _expenseEditController
                                                  .pageIndexUpdate('02');
                                              _pageController!.jumpToPage(1);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20, bottom: 20, left: 0),
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: const Color(0xff007DEF),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 28,
                                                    vertical: 9),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Next',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                              // Container(
                              //     decoration: BoxDecoration(
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.black,
                              //             blurRadius: 10, // soften the shadow
                              //             spreadRadius: -5, //extend the shadow
                              //             offset: Offset(
                              //               0, // Move to right 10  horizontally
                              //               1.0, // Move to bottom 10 Vertically
                              //             ),
                              //           ),
                              //         ],
                              //         color: ColorUtils.whiteColor,
                              //         borderRadius: BorderRadius.circular(15)),
                              //     margin: EdgeInsets.symmetric(
                              //         vertical: 15, horizontal: 20),
                              //     child: Column(
                              //       children: [
                              //         SizedBox(
                              //           height: 20,
                              //         ),
                              //         Column(
                              //           crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //           children: [
                              //             Container(
                              //               margin: EdgeInsets.only(
                              //                 left: 20,
                              //               ),
                              //               child: Text(
                              //                 'Other Details',
                              //                 style: FontStyleUtility.h12(
                              //                   fontColor:
                              //                   ColorUtils.blackColor,
                              //                   fontWeight: FWT.bold,
                              //                 ),
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             Container(
                              //               margin: const EdgeInsets.only(
                              //                   left: 18,
                              //                   right: 18,
                              //                   bottom: 15),
                              //               child: CustomTextFieldWidget_two(
                              //                 controller:
                              //                 invoiceNumberController,
                              //                 labelText: 'Invoice Number',
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: const EdgeInsets.only(
                              //                   left: 18,
                              //                   right: 18,
                              //                   bottom: 15),
                              //               decoration: BoxDecoration(
                              //                 color: Color(0xfff3f3f3),
                              //                 borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //               ),
                              //               child: Row(
                              //                 mainAxisSize: MainAxisSize.max,
                              //                 mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //                 crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //                 children: <Widget>[
                              //                   Expanded(
                              //                     child: TextFormField(
                              //                       enabled: false,
                              //                       controller:
                              //                       invoicedateController,
                              //                       decoration: InputDecoration(
                              //                         contentPadding:
                              //                         EdgeInsets.only(
                              //                             top: 5, left: 12),
                              //                         labelText: 'Invoice Date',
                              //                         labelStyle:
                              //                         FontStyleUtility.h12(
                              //                             fontColor:
                              //                             ColorUtils
                              //                                 .greyTextColor,
                              //                             fontWeight:
                              //                             FWT.medium),
                              //                         border: InputBorder.none,
                              //                       ),
                              //                       style: FontStyleUtility.h14(
                              //                           fontColor: ColorUtils
                              //                               .blackColor,
                              //                           fontWeight:
                              //                           FWT.semiBold),
                              //                     ),
                              //                   ),
                              //                   GestureDetector(
                              //                     onTap: () async {
                              //                       _showIOS_DatePicker(
                              //                           context);
                              //                     },
                              //                     child: Container(
                              //                       margin:
                              //                       EdgeInsets.symmetric(
                              //                           horizontal: 15),
                              //                       child: SvgPicture.asset(
                              //                         AssetUtils.date_picker,
                              //                         height: 20,
                              //                         width: 20,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: const EdgeInsets.only(
                              //                   left: 18,
                              //                   right: 18,
                              //                   bottom: 15),
                              //               child: CustomTextFieldWidget_two(
                              //                 controller: termsController,
                              //                 labelText: 'Terms',
                              //               ),
                              //             ),
                              //             Container(
                              //               margin: const EdgeInsets.only(
                              //                   left: 18,
                              //                   right: 18,
                              //                   bottom: 15),
                              //               decoration: BoxDecoration(
                              //                 color: Color(0xfff3f3f3),
                              //                 borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //               ),
                              //               child: Row(
                              //                 mainAxisSize: MainAxisSize.max,
                              //                 mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //                 crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //                 children: <Widget>[
                              //                   Expanded(
                              //                     child: TextFormField(
                              //                       readOnly: true,
                              //                       controller:
                              //                       duedateController,
                              //                       decoration: InputDecoration(
                              //                         contentPadding:
                              //                         EdgeInsets.only(
                              //                             top: 5, left: 12),
                              //                         labelText: 'Due Date',
                              //                         labelStyle:
                              //                         FontStyleUtility.h12(
                              //                             fontColor:
                              //                             ColorUtils
                              //                                 .greyTextColor,
                              //                             fontWeight:
                              //                             FWT.medium),
                              //                         border: InputBorder.none,
                              //                       ),
                              //                       style: FontStyleUtility.h14(
                              //                           fontColor: ColorUtils
                              //                               .blackColor,
                              //                           fontWeight:
                              //                           FWT.semiBold),
                              //                     ),
                              //                   ),
                              //                   GestureDetector(
                              //                     onTap: () async {
                              //                       _show_DatePicker_due(
                              //                           context);
                              //                     },
                              //                     child: Container(
                              //                       margin:
                              //                       EdgeInsets.symmetric(
                              //                           horizontal: 15),
                              //                       child: SvgPicture.asset(
                              //                         AssetUtils.date_picker,
                              //                         height: 20,
                              //                         width: 20,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ],
                              //         )
                              //       ],
                              //     )),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 0,
                                left: 20,
                              ),
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
                                  color: ColorUtils.blueColor,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (customer_selected
                                              ? '$customer_name'
                                              : (vendor_selected
                                              ? '$Vendor_name'
                                              : (other_selected
                                              ? '$other_name'
                                              : 'Name'))),
                                          style: FontStyleUtility.h15(
                                            fontColor:
                                            ColorUtils.whiteColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                            (customer_selected
                                                ? '$customer_billing_name'
                                                : (vendor_selected
                                                ? '$Vendor_billing_name'
                                                : (other_selected
                                                ? '$other_billing_name'
                                                : 'Billing NAme'))),
                                            style: FontStyleUtility.h12(
                                              fontColor: ColorUtils
                                                  .mediumblueColor,
                                              fontWeight: FWT.medium,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            child: RichText(
                                              text: TextSpan(
                                                text:
                                                '${termsController.text}/',
                                                style: FontStyleUtility.h15(
                                                  fontColor:
                                                  ColorUtils.whiteColor,
                                                  fontWeight: FWT.bold,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                    invoiceNumberController
                                                        .text,
                                                    style: FontStyleUtility.h15(
                                                      fontColor:
                                                      ColorUtils.whiteColor,
                                                      fontWeight: FWT.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          invoicedateController.text.trim(),
                                          style: FontStyleUtility.h15(
                                            fontColor:
                                            ColorUtils.whiteColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Due date',
                                            style: FontStyleUtility.h12(
                                              fontColor: ColorUtils
                                                  .mediumblueColor,
                                              fontWeight: FWT.medium,
                                            )),
                                        Text(
                                          duedateController.text.trim(),
                                          style: FontStyleUtility.h15(
                                            fontColor:
                                            ColorUtils.whiteColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
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
                              ),
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
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
                                              'Tax Type',
                                              style: FontStyleUtility.h12(
                                                  fontColor: ColorUtils
                                                      .greyTextColor,
                                                  fontWeight: FWT.medium),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: tax_type
                                          .map((item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: FontStyleUtility.h12(
                                                  fontColor: ColorUtils
                                                      .blackColor,
                                                  fontWeight:
                                                  FWT.semiBold),
                                              overflow:
                                              TextOverflow.ellipsis,
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
                                      iconEnabledColor: Color(0xff007DEF),
                                      iconDisabledColor: Color(0xff007DEF),
                                      buttonHeight: 50,
                                      buttonWidth: 160,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: ColorUtils.whiteColor,
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
                                  left: 20, right: 20, top: 20),
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Product/Service',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      StatefulBuilder(
                                          builder: (context, setState) {
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                                physics: ScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                product_name_list.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color:
                                                        HexColor("#007DEF"),
                                                        width: 1,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: HexColor(
                                                              "#007DEF")
                                                              .withOpacity(0.5),
                                                        ),
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          spreadRadius: -1.0,
                                                          blurRadius: 2.0,
                                                        ),
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        bottom: 15),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 9,
                                                          bottom: 9,
                                                          left: 15,
                                                          right: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        product_name_list[
                                                                        index],
                                                                        style: FontStyleUtility
                                                                            .h12(
                                                                          fontColor:
                                                                          ColorUtils.blackColor,
                                                                          fontWeight:
                                                                          FWT.bold,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                        5,
                                                                      ),
                                                                      Text(
                                                                        '${product_quantity_list[index]} * ${product_rate_list[index]}',
                                                                        style: FontStyleUtility
                                                                            .h11(
                                                                          fontColor:
                                                                          ColorUtils.ogfont,
                                                                          fontWeight:
                                                                          FWT.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                    children: [
                                                                      Text(
                                                                          (selectedValue == 'Exclusive of Tax'
                                                                              ? product_texable_exl_price_list[index].toString()
                                                                              : (selectedValue == 'Inclusive of Tax' ? "${product_texable_inl_price_list[index]}" : (selectedValue == 'Out of Scope of Tax' ? "${product_texable_inl_price_list[index]}" : product_total_exl_price_list[index].toString()))),
                                                                          style: FontStyleUtility.h12(
                                                                            fontColor:
                                                                            ColorUtils.blackColor,
                                                                            fontWeight:
                                                                            FWT.bold,
                                                                          )),
                                                                      SizedBox(
                                                                        height:
                                                                        5,
                                                                      ),
                                                                      Text(
                                                                        '${product_tax_list[index]}% GST',
                                                                        style: FontStyleUtility
                                                                            .h11(
                                                                          fontColor:
                                                                          ColorUtils.ogfont,
                                                                          fontWeight:
                                                                          FWT.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
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
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }),
                                      GestureDetector(
                                        onTap: () {
                                          select_product();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 18,
                                              width: 18,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50),
                                                  color:
                                                  ColorUtils.blueColor),
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                ColorUtils.whiteColor,
                                                size: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Add Product/Service',
                                              style: FontStyleUtility.h12(
                                                fontColor:
                                                ColorUtils.blueColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 20,
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
                                  color: ColorUtils.blueColor,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total Tax',
                                              style: FontStyleUtility.h15(
                                                fontColor: ColorUtils
                                                    .mediumblueColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Total Ammount',
                                              style: FontStyleUtility.h15(
                                                fontColor: ColorUtils
                                                    .mediumblueColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'In Words',
                                              style: FontStyleUtility.h15(
                                                fontColor: ColorUtils
                                                    .mediumblueColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (selectedValue ==
                                                'Exclusive of Tax'
                                                ? (product_final_tax_excl !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_tax_excl)}'
                                                : "-")
                                                : (selectedValue ==
                                                'Inclusive of Tax'
                                                ? (product_final_tax_incl !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_tax_incl)}'
                                                : "-")
                                                : (selectedValue ==
                                                'Out of Scope of Tax'
                                                ? "-"
                                                : (product_final_tax_excl !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_tax_excl)}'
                                                : "-")))),
                                            style: FontStyleUtility.h15(
                                              fontColor:
                                              ColorUtils.whiteColor,
                                              fontWeight: FWT.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            (selectedValue ==
                                                'Exclusive of Tax'
                                                ? (product_final_exclusive_price !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_exclusive_price)}'
                                                : "-")
                                                : (selectedValue ==
                                                'Inclusive of Tax'
                                                ? (product_final_inclusive_price !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_inclusive_price)}'
                                                : "-")
                                                : (selectedValue ==
                                                'Out of Scope of Tax'
                                                ? (product_final_inclusive_price !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_inclusive_price)}'
                                                : "-")
                                                : (product_final_exclusive_price !=
                                                null
                                                ? '₹ ${oCcy.format(product_final_exclusive_price)}'
                                                : "-")))),
                                            style: FontStyleUtility.h15(
                                              fontColor:
                                              ColorUtils.whiteColor,
                                              fontWeight: FWT.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            (selectedValue ==
                                                'Exclusive of Tax'
                                                ? (word_exl != null
                                                ? '${word_exl}'
                                                : '-')
                                                : (selectedValue ==
                                                'Inclusive of Tax'
                                                ? (word_incl != null
                                                ? '${word_incl}'
                                                : '-')
                                                : (selectedValue ==
                                                'Out of Scope of Tax'
                                                ? (word_incl != null
                                                ? '${word_incl}'
                                                : '-')
                                                : (word_exl != null
                                                ? '${word_exl}'
                                                : '-')))),
                                            maxLines: 3,
                                            style: FontStyleUtility.h10(
                                              fontColor:
                                              ColorUtils.whiteColor,
                                              fontWeight: FWT.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        tax_details();
                                      },
                                      child: SizedBox(
                                        height: 26,
                                        width: 26,
                                        child: SvgPicture.asset(
                                            AssetUtils.svg_next),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Container(
                                  width: screenSize.width,
                                  height: 45,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 15),
                                  child: ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: list_two.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Container(
                                          margin:
                                          EdgeInsets.only(right: 13),
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
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 11),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Text(
                                                  list_two[index],
                                                  style:
                                                  FontStyleUtility.h12(
                                                    fontColor: ColorUtils
                                                        .blackColor,
                                                    fontWeight: FWT.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SvgPicture.asset(
                                                  AssetUtils.checkmark,
                                                  height: 15,
                                                  width: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                            ),
                            SizedBox(
                              height: 20,
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: ExpansionTile(
                                title: Text(
                                  'Bank Details',
                                  style: FontStyleUtility.h12(
                                    fontColor: ColorUtils.blackColor,
                                    fontWeight: FWT.bold,
                                  ),
                                ),
                                trailing: SizedBox(),
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child:
                                          CustomTextFieldWidget_two(
                                            // controller: invoiceNumberController,
                                            keyboardType:
                                            TextInputType.number,
                                            labelText: 'IFSC code',
                                          ),
                                        ),
                                        Container(
                                          margin:
                                          EdgeInsets.only(top: 15),
                                          child:
                                          CustomTextFieldWidget_two(
                                            labelText: 'Bank Name',
                                            // controller: Addressontroller,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                          EdgeInsets.only(top: 15),
                                          child:
                                          CustomTextFieldWidget_two(
                                            keyboardType:
                                            TextInputType.number,
                                            // controller: Gst_no_Controller,
                                            labelText: 'Account Number',
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 15, bottom: 20),
                                          child:
                                          CustomTextFieldWidget_two(
                                            // controller: place_of_supply_Controller,
                                            labelText:
                                            'Account Holder name',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Text("Add Bill/Invoice",
                                          style: FontStyleUtility.h12(
                                            fontColor:
                                            ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          )),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 20,
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, top: 10, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              (selectedValue ==
                                                  'Exclusive of Tax'
                                                  ? (product_final_exclusive_price !=
                                                  null
                                                  ? '₹ ${product_final_exclusive_price}'
                                                  : "-")
                                                  : (selectedValue ==
                                                  'Inclusive of Tax'
                                                  ? (product_final_inclusive_price !=
                                                  null
                                                  ? '₹ ${product_final_inclusive_price}'
                                                  : "-")
                                                  : (selectedValue ==
                                                  'Out of Scope of Tax'
                                                  ? (product_final_inclusive_price !=
                                                  null
                                                  ? '₹ ${product_final_inclusive_price}'
                                                  : "-")
                                                  : (product_final_exclusive_price !=
                                                  null
                                                  ? '${product_final_exclusive_price}'
                                                  : "-")))),
                                              style: FontStyleUtility.h17(
                                                fontColor:
                                                ColorUtils.blackColor,
                                                fontWeight: FWT.bold,
                                              )),
                                          SizedBox(
                                            height: 9,
                                          ),
                                          Row(
                                            children: [
                                              Text('Total Amount',
                                                  style:
                                                  FontStyleUtility.h14(
                                                    fontColor:
                                                    ColorUtils.ogfont,
                                                    fontWeight: FWT.bold,
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                child: SvgPicture.asset(
                                                    AssetUtils.info_svg),
                                                height: 14,
                                                width: 14,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 13, top: 13, bottom: 13),
                                    child: MyLeadingItemCustomButtonWidget(
                                      title: 'Save',
                                      alignment: Alignment.center,
                                      onTap: () {
                                        // invoice_date_list.add(
                                        //     invoicedateController.text);
                                        // due_date_list.add(
                                        //     duedateController.text);
                                        // invoice_number_list.add(
                                        //     invoiceNumberController
                                        //         .text);
                                        //
                                        // invoicedateController.clear();
                                        // duedateController.clear();
                                        // invoiceNumberController.clear();
                                        //
                                        Expanse_API();

                                        // Get.offAllNamed(BindingUtils.companyDetailsScreenRoute);
                                      }, // Navigator.push(
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }),

      )
    );
  }

  String Token = "";
  int Counter = 0;

  Future Expanse_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');

    List ExpenseItems = [];
    for (int i = 0; i < Counter; i++) {
      {
        Map expense = {
          "id": i,
          "hsn_code": Expanse_comp_controller.text,
          "product_unit": product_unit_controller.text,
          "product_id": product_id_list[i],
          "product_qty": product_quantity_list[i],
          "product_rate": product_rate_list[i],
          "other_ledger_id": 0,
          "expense_id": 0,
          "voucher_id": 0,
          "product_discount": product_discount_list[i],
          "product_taxable_val": (selectedValue == 'exclusive_tax'
              ? product_texable_exl_price_list[i]
              : (selectedValue == 'inclusive_tax'
                  ? product_texable_inl_price_list[i]
                  : (selectedValue == 'out_of_tax'
                      ? null
                      : product_texable_exl_price_list[i]))),
          "product_tax": product_tax_list[i],
          // "product_name"
          // "company_profile_id": 0,
          // "tax_invoice_id": 0,
          // "purchase_id": 0,
          // "cash_memo_id": 0,
          // "estimate_invoice_id": 0,
          // "proforma_invoice_id": 0,
          // "delivery_challan_id": 0,
          // "bill_of_supply_id": {},
          // "credit_note_id": 0,
          // "debit_note_id": 0,
          // "customer_id": 0,
          // "vendor_id": 0,
          // "other_id": 0,
          // "entity_type": "string",
          // "created_at": "2022-01-05T11:30:05.170Z"
        };
        ExpenseItems.add(expense);
      }
    }

    Map data = {
      // "id": 0,
      "invoice_number": invoiceNumberController.text,
      "sr_number": SrNumberController.text,
      "entity_id": (customer_selected
          ? customer_id
          : (vendor_selected
              ? Vendor_id
              : (other_selected ? other_id : customer_id))),
      "entity_type": (customer_selected
          ? "customer"
          : (vendor_selected
              ? "vendor"
              : (other_selected ? "other" : "customer"))),
      "invoice_date": invoicedateController.text,
      "billing_address": Addressontroller.text,
      "gst_number": Gst_no_Controller.text,
      "place_of_supply": place_of_supply_Controller.text,
      "terms": termsController.text,
      "terms_condition_invoice": "",
      "invoice_status": true,
      "due_date": duedateController.text,
      // "po_number": "string",
      // "po_date": "string",
      "tax_type": selectedValue,
      "payment_type": "debit",
      "ledger_name": (customer_selected
          ? customer_name
          : (vendor_selected
              ? Vendor_name
              : (other_selected ? other_name : customer_name))),
      "expense_items": ExpenseItems,
      "taxable_value": (selectedValue == 'exclusive_tax'
          ? product_final_taxable_amt_exl
          : (selectedValue == 'inclusive_tax'
              ? product_final_taxable_amt_incl
              : (selectedValue == 'out_of_tax'
                  ? null
                  : product_final_taxable_amt_exl))),
      "total_discount": product_final_dis,
      "other_expenses": 0,
      "total_cgst": 0,
      "total_sgst": 0,
      "total_igst": 0,
      "total_tax": (selectedValue == 'exclusive_tax'
          ? product_final_tax_excl
          : (selectedValue == 'inclusive_tax'
              ? product_final_tax_incl
              : (selectedValue == 'out_of_tax'
                  ? "-"
                  : product_final_tax_excl))),
      "total_amt": (selectedValue == 'exclusive_tax'
          ? product_final_exclusive_price
          : (selectedValue == 'inclusive_tax'
              ? product_final_inclusive_price
              : (selectedValue == 'out_of_tax'
                  ? product_final_inclusive_price
                  : product_final_exclusive_price))),
      "total_amt_word": (selectedValue == 'exclusive_tax'
          ? "$word_exl"
          : (selectedValue == 'inclusive_tax'
              ? "$word_incl"
              : (selectedValue == 'out_of_tax' ? "$word_exl" : "$word_exl"))),
      "balance_due": 0,
      // "terms_condition_invoice": "string",
      "note": "string",
      "ifsc_code": "string",
      "bank_name": "string",
      "account_number": "string",
      "account_holder_name": "string",
      "attachments": [
        {
          "id": 0,
          "url": "string",
          "type": "string",
          "entity_id": 0,
          "entity_type": "string",
          "cloud_type": "string",
          "file_name": "string"
        }
      ],
      // "invoice_status": {},
      // "company_profile_id": null,
      // "created_at": "2022-01-05T11:30:05.170Z",
      // "update_at": "2022-01-05T11:30:05.170Z",
      // "created_by": 0,
      // "update_by": 0,
      // "fin_start_date": "string",
      // "fin_end_date": "string"
    };

    print("data");
    print(data);

    String body = json.encode(data);
    var url = Api_url.expanse_add_api + '/${widget.expense_id}';
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
      Get.offAllNamed(BindingUtils.expanses_ScreenRoute);
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
  String query_customers = '';
  List<Data_customers> CustomersData = [];
  String query_others = '';
  List<Data_others> OthersData = [];
  List<dynamic> Final = [];

  List<dynamic> Final_customer = [];
  List<dynamic> Final_vendor = [];
  List<dynamic> Final_others = [];
  var newList = [];

  // var newList = [...this.CustomersData, ...list2, ...list3];

  String query_products = '';
  List<Data_product> ProductData = [];

  Future others_list_API() async {
    final books = await call_api.getOthers_modal_List(query_others);

    setState(() {
      this.OthersData = books;
    });
    // print(VendorsData);
  }

  Future others_list_search_API(String query) async {
    final books_vendors = await call_api.getOthers_modal_List(query);

    if (!mounted) return;

    setState(() {
      this.query_others = query;
      this.OthersData = books_vendors;
    });
  }

  Widget build_others_Search() {
    return SearchWidget(
      text: query_others,
      hintText: 'Search Here',
      onChanged: others_list_search_API,
    );
  }

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

  Future Customer_list_API() async {
    final books = await call_api.getCustomersList(query_customers);

    setState(() {
      this.CustomersData = books;
    });
    // print(VendorsData);
  }

  Future Customer_list_search_API(String query) async {
    final books_vendors = await call_api.getCustomersList(query);

    if (!mounted) return;

    setState(() {
      this.query_customers = query;
      this.CustomersData = books_vendors;
    });
  }

  Widget build_Customer_Search() {
    return SearchWidget(
      text: query_customers,
      hintText: 'Search Here',
      onChanged: Customer_list_search_API,
    );
  }

  Widget build_Product_Search() {
    return SearchWidget(
      text: query_products,
      hintText: 'Search Here',
      onChanged: Product_list_search_API,
    );
  }

  Future Product_list_API() async {
    // setState(() {
    //   isLoading= true;
    // });
    // await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.getProductList(query_products);

    setState(() {
      this.ProductData = books;
    });
    // setState(() {
    //   isLoading= false;
    // });
    // print(ProductData);
  }

  Future Product_list_search_API(String query) async {
    final books = await call_api.getProductList(query_products);

    if (!mounted) return;

    setState(() {
      this.query_products = query;
      this.ProductData = books;
    });
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