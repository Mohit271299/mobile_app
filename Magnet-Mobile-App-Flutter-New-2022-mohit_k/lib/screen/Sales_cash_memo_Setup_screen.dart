import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
import 'package:magnet_update/custom_widgets/custom_dialog.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/custom_widgets/search_widget_two.dart';
import 'package:magnet_update/model_class/other_ledger_model.dart';
import 'package:magnet_update/model_class/product_model.dart';
import 'package:magnet_update/model_class/purchase_model.dart';
import 'package:magnet_update/model_class/state_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';
import 'package:number_to_words/number_to_words.dart';

class cash_memoScreen extends StatefulWidget {
  const cash_memoScreen({Key? key}) : super(key: key);

  @override
  _cash_memoScreenState createState() => _cash_memoScreenState();
}

class _cash_memoScreenState extends State<cash_memoScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Cash_memo_Setup_controller _cash_memo_controller =
  Get.find(tag: Cash_memo_Setup_controller().toString());
  PageController? _pageController;

  List list_two = [
    'T&C',
    'Bank Details',
    'Note',
  ];

  final List<String> data = <String>[
    'Exclusive of Tax',
    'Inclusive of Tax',
    'Out of Scope of Tax'
  ];
  String selectedValue = 'Exclusive of Tax';
  int? id;

  String? others_name;
  int? others_id;
  String? others_company_name;
  String? Product_name_selected;
  int? Product_id;
  String? product_Hsn_Sac_name;

  Data_state? _selectedstate;
  Addresse_other? billing;

  bool vendor_selected = false;

  // bool selected_customer= false;
  // String? customer_name;
  late String dateSelected_invoice;
  TextEditingController invoicedateController = new TextEditingController();
  final List<String> invoice_date_list = <String>[];
  TextEditingController duedateController = new TextEditingController();
  TextEditingController so_dateController = new TextEditingController();
  TextEditingController dc_numberController = new TextEditingController();
  TextEditingController so_numberController = new TextEditingController();
  final List<String> due_date_list = <String>[];
  TextEditingController Sr_NumberController = new TextEditingController();
  final List<String> invoice_number_list = <String>[];
  TextEditingController termsController = new TextEditingController();
  TextEditingController shipping_Address_Controller = new TextEditingController();
  TextEditingController billing_Address_Controller = new TextEditingController();
  TextEditingController Gst_no_Controller = new TextEditingController();
  TextEditingController place_of_supply_Controller =
  new TextEditingController();

  TextEditingController product_name_controller = new TextEditingController();
  TextEditingController product_HSN_controller = new TextEditingController();
  TextEditingController product_unit_controller = new TextEditingController();
  TextEditingController product_quantity_controller =
  new TextEditingController();
  TextEditingController product_rate_controller = new TextEditingController();
  TextEditingController product_tax_controller = new TextEditingController();
  TextEditingController product_discount_controller =
  new TextEditingController();

TextEditingController bank_name_controller = new TextEditingController();
  TextEditingController account_number_controller = new TextEditingController();
  TextEditingController ac_holder_controller = new TextEditingController();
  TextEditingController ifsc_controller = new TextEditingController();

  TextEditingController terms_condition_controller = new TextEditingController();
  TextEditingController notes_controller = new TextEditingController();


  final List<String> product_name_list = <String>[];
  final List<String> product_quantity_list = <String>[];
  final List<String> product_rate_list = <String>[];
  final List<double> product_total_exl_price_list = <double>[];

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
  final List<String> product_tax_list = <String>[];
  final List<String> product_discount_list = <String>[];



  String resulttext_total_exl = "0";
  String resulttext_amt_int= "0";
  String resulttext_total_dis = "0";
  String resulttext_total_inl = "0";
  String resulttext_total_out_of_scope = "0";
  String resulttext_amount = "0";

  String resulttotal_tax_excl = '0';

  String resulttotal_tax_incl = '0';

  String resulttext_discount = "0";

  bool invoice_date = true;
  bool invoice_no_validate = true;
  bool customer_validate = true;
  bool place_supply_validate = true;

  void select_Cash_ledger() {
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
                  color: Colors.white, borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Ledger',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(BindingUtils.ledgerSetupScreenRoute);
                          },
                          child: Text('Add new Ledger',
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
                    child: build_others_Search(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
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
                              vendor_selected = true;
                            });
                            setState(() {
                              customer_validate = true;
                              others_name = OthersData[index].billingName;
                              others_id = OthersData[index].id;
                              others_company_name = OthersData[index].billingName;
                            });
                            print("OthersData[index]");
                            print(others_name);
                            print("Customer_nid");
                            print(others_id);

                            List address = OthersData[index].addresses!.toList();
                            print(address);

                            for(var i=0 ; i< address.length; i++){
                              if(address[i].addressType == "billing"){
                                billing = address[i];
                                print("addres[i]");
                                // print(address[i]["state"]);
                              }
                            }
                            // print("billing");
                            // print(billing_other!.state);
                            if(billing != null){
                              Data_state _stdBilling = stateData.firstWhere(
                                      (element) => element.id.toString() == billing!.state);
                              print(_stdBilling.name);
                              setState(() {
                                _selectedstate = _stdBilling;
                              });
                            } else {
                              Navigator.pop(context);
                            }

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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 15,
                                        right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                              "${OthersData[index].billingName}",
                                              style: FontStyleUtility.h15(
                                                fontColor:
                                                ColorUtils.blackColor,
                                                fontWeight: FWT.semiBold,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(

                                          child: Text(
                                              "${OthersData[index].companyName}",
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
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 15),
                                    child: Text(
                                      'Balance: ${OthersData[index].openingBalance} CR',
                                      style: FontStyleUtility.h12(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold,
                                      ),
                                    ),
                                  ),
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

  Future<void> select_product() async {
    final screenSize = MediaQuery.of(context).size;

    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: screenSize.height / 1.4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30))),
              child: SingleChildScrollView(
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
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(BindingUtils.product_service_setup_ScreenRoute);
                              },
                              child: Text('Add new Product',
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
                        child: build_Product_Search(),
                      ),
                      ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: ProductData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              //  selected_customer= true;
                              //  setState(
                              //    customer_name = task_cust_name[index]
                              //  );
                              // print(task_cust_name[index]);

                              setState(() {
                                Product_id = ProductData[index].id;
                                product_name_controller.text =
                                ProductData[index].productName!;
                                product_HSN_controller.text =
                                ProductData[index].description!;
                                print(product_name_controller.text);
                              });
                              Navigator.pop(context);
                              add_product();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: HexColor("E8E8E8"), width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:1 ,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 10, left: 15,right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                                "${ProductData[index].productName}",
                                                style: FontStyleUtility.h15(
                                                  fontColor: ColorUtils.blackColor,
                                                  fontWeight: FWT.semiBold,
                                                )),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Container(

                                            child: Text(
                                                '${ProductData[index].hsnCode}',
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
                                    flex:1,
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(left: 0, top: 0, right: 15),
                                      child: Text(
                                          'Balance: ${ProductData[index].salesPrice} CR',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
            ),
          );
        });
  }
  Future<void> add_product() async {
    final screenSize = MediaQuery.of(context).size;

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
                    height: screenSize.height/1.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))
                    ),
                    child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15),
                                child: CustomTextFieldWidget_two(
                                  controller: product_name_controller,
                                  labelText: 'Product Name/ Description',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFieldWidget_two(
                                        controller: product_HSN_controller,
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
                                    top: 15),
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
                                    top: 15),
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
                          ),
                        )),
                  ),
                ),
              );
            },
          );
        }).then((val) {

      product_name_list.add(product_name_controller.text);
      product_quantity_list.add(product_quantity_controller.text);
      product_rate_list.add(product_rate_controller.text);
      product_tax_list.add(product_tax_controller.text);
      product_discount_list.add(product_discount_controller.text);
      print(product_quantity_list);
      print(product_rate_list);
      print(product_tax_list);
      print(product_discount_list);
      print("product_discount_controller.text");
      double amount = double.parse(product_quantity_controller.text) *
          double.parse(product_rate_controller.text);
      double disc =
          amount * double.parse(product_discount_controller.text) / 100;
      double ammount_inti = amount - disc;
      resulttext_amount = ammount_inti.toStringAsFixed(3);


      double tax_inti =
          ammount_inti * double.parse(product_tax_controller.text) / 100;

      double tax_inti_incl = ammount_inti *
          double.parse(product_tax_controller.text) /
          (100 + double.parse(product_tax_controller.text));

      double exl_ammount_total = ammount_inti + tax_inti;
      double inl_ammount_total = ammount_inti - tax_inti_incl;

      resulttext_amt_int = ammount_inti.toStringAsFixed(3);
      resulttext_total_exl = exl_ammount_total.toStringAsFixed(3);
      resulttext_total_inl = inl_ammount_total.toStringAsFixed(3);
      resulttext_total_dis = disc.toString();

      resulttext_total_out_of_scope = ammount_inti.toString();
      resulttotal_tax_excl = tax_inti.toStringAsFixed(3);
      resulttotal_tax_incl = tax_inti_incl.toStringAsFixed(3);

      product_total_tax_list_excl.add(double.parse(resulttotal_tax_excl));
      product_total_tax_list_incl.add(double.parse(resulttotal_tax_incl));

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

      num tax_exl = 0;
      product_total_tax_list_excl.forEach((num element) {
        tax_exl += element;
      });
      product_final_tax_excl = tax_exl;
      print("product_final_tax_excl");
      print(product_final_tax_excl);

      num tax_incl = 0;
      product_total_tax_list_incl.forEach((num element) {
        tax_incl += element;
      });
      product_final_tax_incl = tax_incl;
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

      num taxable_inl = 0;
      product_texable_inl_price_list.add(double.parse(resulttext_total_inl));
      product_texable_inl_price_list.forEach((element) {
        taxable_inl += element;
      });
      product_final_taxable_amt_incl = taxable_inl;
      print(product_texable_inl_price_list);
      print("product_final_taxable_amt_incl");
      print(product_final_taxable_amt_incl);

      num taxable_exl = 0;
      product_texable_exl_price_list.add(double.parse(resulttext_amt_int));
      product_texable_exl_price_list.forEach((element) {
        taxable_exl += element;
      });
      product_final_taxable_amt_exl = taxable_exl;
      print(product_texable_exl_price_list);
      print("product_final_taxable_amt_incl");
      print(product_final_taxable_amt_exl);

      product_total_out_of_scope_price_list.add(resulttext_total_out_of_scope);

      // print(product_total_exl_price_list);
      product_name_controller.clear();
      product_quantity_controller.clear();
      product_rate_controller.clear();
      product_tax_controller.clear();
      product_discount_controller.clear();
    });
    setState(() {
      Counter++;
      print(Counter);
    });
  }

  void tax_details() {
    final screenSize = MediaQuery.of(context).size;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Color(0xff737373),
                child: Container(
                  height: screenSize.height / 1.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 30),
                            child: Text('Tax Details',
                                style: FontStyleUtility.h17(
                                  fontColor: ColorUtils.blackColor,
                                  fontWeight: FWT.semiBold,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.dark_grey, width: 2),
                                borderRadius: BorderRadius.circular(10)),
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
                                thickness: 2,
                                color: ColorUtils.devider,
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
                                    Expanded(
                                      flex: 2,
                                      child: Text('Taxable Value',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text(
                                        (selectedValue == 'Exclusive of Tax'
                                            ? "₹ ${product_final_taxable_amt_exl}"
                                            : (selectedValue == 'Inclusive of Tax'
                                            ? "₹ ${product_final_taxable_amt_incl}"
                                            : (selectedValue ==
                                            'Out of Scope of Tax'
                                            ? "₹ ${product_final_taxable_amt_exl}"
                                            : "₹ ${product_final_taxable_amt_exl}"))),
                                        style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.blackColor,
                                          fontWeight: FWT.semiBold,
                                        ),
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Discount',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text('₹ ${product_final_dis}',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Other Expenses',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text('₹ 5,580.00',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Total CGST',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text('₹ 5,580.00',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Total SGST',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text('₹ 5,580.00',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Total Tax',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text(
                                          (selectedValue == 'Exclusive of Tax'
                                              ? "₹ ${product_final_tax_excl}"
                                              : (selectedValue == 'Inclusive of Tax'
                                              ? "₹ ${product_final_tax_incl}"
                                              : (selectedValue ==
                                              'Out of Scope of Tax'
                                              ? '-'
                                              : "₹ ${product_final_taxable_amt_exl}"))),
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Total Ammount',
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.ogfont,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    ),
                                    Expanded(
                                      child: Text(
                                          (selectedValue == 'Exclusive of Tax'
                                              ? (product_final_exclusive_price !=
                                              null
                                              ? '₹ ${product_final_exclusive_price}'
                                              : "-")
                                              : (selectedValue == 'Inclusive of Tax'
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
                                              ? '₹ ${product_final_exclusive_price}'
                                              : "-")))),
                                          style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.blueColor,
                                            fontWeight: FWT.semiBold,
                                          )),
                                    )
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

  Future<void> _showInvoice_DatePicker(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      initial_date = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          initial_date); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        invoicedateController.text =
            DateFormat('dd-MM-yyyy').format(pickedDate);; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  final oCcy = new NumberFormat("#,##0.00", "en_US");


  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);

  }
  init() async {
    await State_list_API();
    await others_list_API();
    await Product_list_API();
    await Purchase_list_API();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,

      body:custom_header(
        labelText: 'Add Information',
        back: AssetUtils.back_svg,
        backRoute: BindingUtils.sales_ScreenRoute,
        data:  GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: GetBuilder<Cash_memo_Setup_controller>(
              init: _cash_memo_controller,
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
                                    // select_Cash_ledger();
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
                                        border: (customer_validate == false
                                        ? Border.all(
                                        color: Colors.red, width: 1)
                                        : Border.all(
                                        color: Colors.transparent)),
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
                                                height: 9,
                                              ),
                                              Text('${others_name}',
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
                                              AssetUtils.arrow_right,
                                              height: 10,
                                              width: 4,),
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

                                        Container(
                                          decoration: BoxDecoration(
                                              border: (invoice_no_validate == false
                                                  ? Border.all(
                                                  color: Colors.red, width: 1)
                                                  : Border.all(
                                                  color: Colors.transparent)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          margin: EdgeInsets.only(
                                              top: 20, right: 18, left: 18),
                                          child: CustomTextFieldWidget_two(
                                            tap: () {
                                              setState(() {
                                                invoice_no_validate = true;
                                              });
                                            },
                                            controller: Sr_NumberController,
                                            keyboardType: TextInputType.number,
                                            labelText: 'Sr Number',
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 15, right: 18, left: 18),
                                          decoration: BoxDecoration(
                                              color: Color(0xfff3f3f3),
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            border: (invoice_date == false
                                                ? Border.all(
                                                color: Colors.red, width: 1)
                                                : Border.all(
                                                color: Colors.transparent)),

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
                                                  onTap: () async {
                                                    setState(() {
                                                      invoice_date = true;
                                                    });
                                                    _showInvoice_DatePicker(context);

                                                  },
                                                  showCursor: true,
                                                  readOnly: true,                                                controller:
                                                invoicedateController,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        top: 5, left: 12),
                                                    labelText: 'Invoice Date',
                                                    labelStyle:
                                                    FontStyleUtility.h12(
                                                        fontColor:
                                                        ColorUtils
                                                            .ogfont,
                                                        fontWeight:
                                                        FWT.semiBold),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:FontStyleUtility.h16(
                                                      fontColor: ColorUtils
                                                          .blackColor,
                                                      fontWeight:
                                                      FWT.semiBold),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15.25),
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
                                          margin: EdgeInsets.only(
                                              top: 15, right: 18, left: 18),
                                          child: CustomTextFieldWidget_two(
                                            labelText: 'Billing Address',
                                            controller: billing_Address_Controller,
                                          ),
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                              border: (place_supply_validate ==
                                                  false
                                                  ? Border.all(
                                                  color: Colors.red, width: 1)
                                                  : Border.all(
                                                  color: Colors.transparent)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          margin: EdgeInsets.only(
                                              top: 15, right: 18, left: 18),
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
                                                  value: _selectedstate,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedstate = value;
                                                      // SubgroupData = GroupData[int.parse(_selectedgroup!)];
                                                      print(_selectedstate!.id);
                                                      place_of_supply_Controller.text = _selectedstate!.name!;
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

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (others_name == null ||
                                                    Sr_NumberController
                                                        .text.isEmpty ||
                                                    invoicedateController
                                                        .text.isEmpty ||
                                                    _selectedstate!
                                                        .name!.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: 'Enter Details',
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      gravity: ToastGravity.BOTTOM,
                                                      toastLength:
                                                      Toast.LENGTH_LONG);
                                                  if (others_name == null) {
                                                    setState(() {
                                                      customer_validate = false;
                                                    });
                                                  }
                                                  if (Sr_NumberController
                                                      .text.isEmpty) {
                                                    setState(() {
                                                      invoice_no_validate = false;
                                                    });
                                                  }
                                                  if (invoicedateController
                                                      .text.isEmpty) {
                                                    setState(() {
                                                      invoice_date = false;
                                                    });
                                                  }
                                                  if (_selectedstate!
                                                      .name!.isEmpty) {
                                                    setState(() {
                                                      place_supply_validate = false;
                                                    });
                                                  }
                                                  return;
                                                }
                                                _cash_memo_controller
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
                                    )
                                ),
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
                                //                 Sr_NumberController,
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
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$others_name',
                                              style: FontStyleUtility.h15(
                                                fontColor:
                                                ColorUtils.whiteColor,
                                                fontWeight: FWT.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('$others_company_name',
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
                                                        Sr_NumberController
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
                                          Text('Invoice date',
                                              style: FontStyleUtility.h12(
                                                fontColor: ColorUtils
                                                    .mediumblueColor,
                                                fontWeight: FWT.medium,
                                              )),
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
                                        items: data
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
                                            left: 15, right: 15),
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
                                                  physics: ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
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
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 18),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => tcDialog(
                                              terms_controller:
                                                  terms_condition_controller,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 13),
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
                                                horizontal: 11,vertical: 15),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "T&C",
                                                  style: FontStyleUtility.h12(
                                                    fontColor:
                                                        ColorUtils.blackColor,
                                                    fontWeight: FWT.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                SvgPicture.asset(
                                                  (terms_condition_controller
                                                          .text.isEmpty
                                                      ? AssetUtils.check_before
                                                      : AssetUtils.check_after),
                                                  height: 12,
                                                  width: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => BankDialog(
                                                ifsc_controller:
                                                    ifsc_controller,
                                                ac_holder_controller:
                                                    ac_holder_controller,
                                                ac_number_controller:
                                                    account_number_controller,
                                                bankname_controller:
                                                    bank_name_controller),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 13),
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
                                                horizontal: 11,vertical: 15),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Bank Details",
                                                  style: FontStyleUtility.h12(
                                                    fontColor:
                                                        ColorUtils.blackColor,
                                                    fontWeight: FWT.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                SvgPicture.asset(
                                                  (ifsc_controller.text.isEmpty &&
                                                      ac_holder_controller.text.isEmpty &&
                                                      account_number_controller.text.isEmpty &&
                                                      bank_name_controller.text.isEmpty
                                                      ? AssetUtils.check_before
                                                      : AssetUtils.check_after),
                                                  height: 12,
                                                  width: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => noteDialog(
                                              note_controller: notes_controller,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 0),
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
                                                horizontal: 15,vertical: 15),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Notes",
                                                  style: FontStyleUtility.h12(
                                                    fontColor:
                                                        ColorUtils.blackColor,
                                                    fontWeight: FWT.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                SvgPicture.asset(
                                                  (notes_controller
                                                      .text.isEmpty
                                                      ? AssetUtils.check_before
                                                      : AssetUtils.check_after),
                                                  height: 12,
                                                  width: 12,
                                                )
                                              ],
                                            ),
                                          ),
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
                                          cash_memo_API();

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
        ),

      ),

    );
  }

  String Token = "";
  int Counter = 0 ;

  Future cash_memo_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    print('calling');
    List ProductItems = [];
    for(int i =0 ; i < Counter; i++){
      {
        Map products = {
          "id": i,
          "hsn_code": product_HSN_controller.text,
          "product_unit": product_unit_controller.text,
          "product_id": Product_id,
          "product_qty": product_quantity_list[i],
          "product_rate": product_rate_list[i],
          "product_discount": product_discount_list[i],
          "product_taxable_val": (selectedValue == 'exclusive_tax'
              ? product_texable_exl_price_list[i]
              : (selectedValue == 'inclusive_tax'
              ? product_texable_inl_price_list[i]
              : (selectedValue == 'out_of_tax'
              ? null
              : product_texable_exl_price_list[i]))),
          "product_tax": product_tax_list[i],
          "entity_type": null
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
        ProductItems.add(products);
      }
    }
    Map data = {
      // "id": 0,
      "sr_number": Sr_NumberController.text,
      "cash_ledger_id": others_id,
      "invoice_date": initial_date,
      "billing_address": shipping_Address_Controller.text,
      "place_of_supply": _selectedstate!.id.toString(),

      "tax_type": selectedValue,
      "payment_type": "debit",
      // "voucher_id": 0,
      "mobile_no": "string",
      // "send_invoice_to_email": true,
      "email": "string",
      "product_items": ProductItems,
      "taxable_value": (selectedValue == 'Exclusive of Tax'
          ? product_final_taxable_amt_exl
          : (selectedValue == 'Inclusive of Tax'
          ? product_final_taxable_amt_incl
          : (selectedValue == 'Out of Scope of Tax'
          ? product_final_taxable_amt_exl
          : product_final_taxable_amt_exl))),
      "total_discount": product_final_dis,
      "other_expenses": 0,
      "total_cgst": 0,
      "total_sgst": 0,
      "total_igst": 0,
      "total_tax": (selectedValue == 'Exclusive of Tax'
          ? product_final_tax_excl
          : (selectedValue == 'Inclusive of Tax'
          ? product_final_tax_incl
          : (selectedValue == 'Out of Scope of Tax'
          ? product_final_tax_excl
          : product_final_tax_excl))),
      "total_amt": (selectedValue == 'Exclusive of Tax'
          ? product_final_exclusive_price
          : (selectedValue == 'Inclusive of Tax'
          ? product_final_inclusive_price
          : (selectedValue == 'Out of Scope of Tax'
          ? product_final_inclusive_price
          : product_final_exclusive_price))),
      "total_amt_word": (selectedValue == 'Exclusive of Tax'
          ? word_exl
          : (selectedValue == 'Inclusive of Tax'
          ? word_incl
          : (selectedValue == 'Out of Scope of Tax'
          ? word_incl
          : word_exl))),
      "balance_due": 0,
      // "terms_condition_invoice": "string",
      "note": "string",
      "ifsc_code": "string",
      "bank_name": "string",
      "account_number": "string",
      "account_holder_name": "string",
      // "invoice_status": {},
      "company_profile_id": null,
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
    var url = Api_url.cash_memo_add_api;
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
      Get.offAllNamed(BindingUtils.sales_ScreenRoute);
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

  String query_purchase = '';
  List<Data_purchase> PurchaseData = [];
  String query_others = '';
  List<Data_others> OthersData = [];
  String query_products = '';
  List<Data_product> ProductData = [];

  List<Data_state> stateData = [];

  Future State_list_API() async {

    await Future.delayed(Duration(seconds: 2), () {});

    final books = await call_api.state_API();

    setState(() => this.stateData = books);

    print(stateData);
  }

  Future others_list_API() async {
    final books = await call_api.getOthers_modal_List(query_others);

    setState(() => this.OthersData = books);

    Data_others _stdBilling = OthersData.firstWhere(
            (element) => element.id.toString() == '134');
    print("_stdBilling.name");
    print(_stdBilling.billingName);
    // _selectedstate = _stdBilling;

    List address = _stdBilling.addresses!.toList();
    print(address);

    for(var i=0 ; i< address.length; i++){
      if(address[i].addressType == "billing"){
        billing = address[i];
        print("addres[i]");
        // print(address[i]["state"]);
      }
    }
    // print("billing");
    // print(billing_other!.state);
    if(billing != null){
      Data_state _stdBilling = stateData.firstWhere(
              (element) => element.id.toString() == billing!.state);
      print(_stdBilling.name);
      setState(() {
        _selectedstate = _stdBilling;
      });
    } else {
      Navigator.pop(context);
    }

    setState(() {
      others_name = _stdBilling.billingName;
      print("others_name");
      print(others_name);
      others_id = _stdBilling.id;
      others_company_name = _stdBilling.companyName;
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
    return SearchWidget_two(
      text: query_others,
      hintText: 'Search Here',
      onChanged: others_list_search_API,
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
  Widget build_Purchase_Search() {
    return SearchWidget(
      text: query_purchase,
      hintText: 'Search Here',
      onChanged: Purchase_list_search_API,
    );
  }

  Future Purchase_list_API() async {
    final books = await call_api.getPurchaseList(query_purchase);

    setState(() => this.PurchaseData = books);

    // print("PurchaseData");
    // print(PurchaseData);
  }

  Future Purchase_list_search_API(String query) async {
    final books = await call_api.getPurchaseList(query);

    if (!mounted) return;

    setState(() {
      this.query_purchase = query;
      this.PurchaseData = books;
    });
  }
}
