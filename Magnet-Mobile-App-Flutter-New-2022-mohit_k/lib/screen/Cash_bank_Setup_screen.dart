  import 'dart:convert';
import 'dart:core';

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
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/customer_ledger_model.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class cash_bankSetupScreen extends StatefulWidget {
  const cash_bankSetupScreen({Key? key}) : super(key: key);

  @override
  _cash_bankSetupScreenState createState() => _cash_bankSetupScreenState();
}

class _cash_bankSetupScreenState extends State<cash_bankSetupScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final cash_bank_Setup_Controller _cash_bank_setup_controller =
      Get.find(tag: cash_bank_Setup_Controller().toString());
  PageController? _pageController;

  List _viewData = [
    "Receipt",
    "Payment",
    "Contra",
  ];

  List bank_name = [
    "ICICI Current Bank Account",
    "ICICI Current Bank Account",
    "ICICI Current Bank Account",
    "ICICI Current Bank Account",
  ];

  int _indexData = 0;

  List task_cust_name = [
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia',
    'Devang Vadalia'
  ];
  List price_tab = [
    '₹12,68,452.34',
    '₹12,68,452.34',
    '₹12,68,452.34',
    '₹12,68,452.34',
  ];

  List task_priority_status = [
    'High Priority',
    'Medium Priority',
    'Low Priority',
    'High Priority'
  ];

  List task_DnT = [
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM',
    '3 Apr 12:30PM'
  ];
  String _selectedfunc = '0';

  String Token = '';
  String? selectedValue_cash_bank;
  String? selectedValue_cash_bank_id;
  String? selectedValue_transaction;
  String? selectedValue_transaction_id;

  final List<String> data_cash_bank = <String>[
    'CASH',
    'SBI Current Account',
    'ICICI Current Bank Account',
    'AXIS',
    'HDFC Bank',
    'Kotak Mahindra Bank',
  ];

  List myProducts = ['A-101', 'A-102', 'A-103', 'A-104'];
  int Counter = 1;

  TextEditingController dateController = new TextEditingController();

  // TextEditingController voucher_no_controller = new TextEditingController();
  // TextEditingController cash_bank_controller = new TextEditingController();
  // TextEditingController transaction_type_controller = new TextEditingController();
  // TextEditingController opening_bal_controller = new TextEditingController();
  // TextEditingController ref_no_controller = new TextEditingController();
  // TextEditingController payment_ammount_controller = new TextEditingController();
  // TextEditingController note_controller = new TextEditingController();

  List<TextEditingController> voucher_list = [];
  List datelist = [];
  List cash_bank_controller = [];
  List cash_bank_controller_id = [];
  List transaction_type_controller = [];
  List transaction_type_controller_id = [];

  List<TextEditingController> opening_bal_controller = [];
  List<TextEditingController> ref_no_controller = [];
  List<TextEditingController> payment_ammount_controller = [];
  List<TextEditingController> note_controller = [];
  String? notes;

  List<String> cust_name = [];
  List<String> cust_id = [];
  List<String> cust_balance = [];
  List<String> vendor_name_list = [];
  List<String> vendor_id_list = [];
  List<String> vendor_balance_list = [];
  List<String> other_name_list = [];
  List<String> other_id_list = [];
  List<String> other_balance_list = [];

  List<String> ledger_id = [];
  List<String> ledger_name = [];
  List<String> ledger_balance = [];
  List<String> ledger_entity = [];

  Future<void> _show_DatePicker(ctx) async {
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
        datelist.add(dateController.text);
        print(datelist);
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Customer_list_API();
    fetchAdd();
    Trans_type_api();
    others_list_API();
    _pageController = PageController(initialPage: 0, keepPage: false);
  }

  String query_customer = '';
  List<Data_customers> CustomersData = [];

  List<dynamic> Final_vendor = [];
  List<dynamic> Final_others = [];
  var newList = [];

  Future Customer_list_API() async {
    final books = await call_api.getCustomers_modal_List(query_customer);

    setState(() => this.CustomersData = books);
    // print(VendorsData);
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
        Final_vendor = responseBody["data"]["vendors"];
        Final_others = responseBody["data"]["others"];
        newList = [Final_vendor, Final_others].expand((x) => x).toList();
        print(newList);
        print(newList.length);
        print("Final_vendor");
        print(Final_vendor);
        print("Final_others");
        print(Final_others);
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  String? customer_name;
  int? customer_balance;
  int? Customer_id;
  String? customer_billing_name;


  String? Vendor_name;
  int? Vendor_id;
  int? Vendor_balance;
  String? Vendor_billing_name;
  String? vendor_entity;

  String? other_name;
  int? other_id;
  int? other_balance;
  String? other_billing_name;
  String? other_entity;

  bool vendor_selected = false;
  bool other_selected = false;
  bool customer_selected = false;

  Future Customer_list_search_API(String query) async {
    final books_vendors = await call_api.getCustomers_modal_List(query);

    if (!mounted) return;

    setState(() {
      this.query_customer = query;
      this.CustomersData = books_vendors;
    });
  }

  Widget build_Customer_Search() {
    return SearchWidget(
      text: query_customer,
      hintText: 'Search Here',
      onChanged: Customer_list_search_API,
    );
  }
  bool birth_date = true;
  bool voucher_no_validate = true;
  bool ammount_validate = true;
  bool vendor_validate = true;
  bool other_validate = true;
  bool customer_validate = true;

  void select_Customer() {
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Customer',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                        Text('Add new Customer',
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
                    child: build_Customer_Search(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: CustomersData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            //  selected_customer= true;
                            //  setState(
                            //    customer_name = task_cust_name[index]
                            //  );
                            // print(task_cust_name[index]);
                            setState(() {
                              customer_name = CustomersData[index].billingName;
                              customer_validate = true;
                              Customer_id = CustomersData[index].id;
                              customer_billing_name =
                                  CustomersData[index].billingName;
                              customer_balance =
                                  CustomersData[index].openingBalance;

                              cust_name.add(customer_billing_name!);
                              cust_id.add(Customer_id.toString());
                              cust_balance.add(customer_balance.toString());
                              print(cust_balance);

                              print("cust_name.length");

                              setState(() {
                                customer_selected = true;
                              });
                              print(cust_name);
                            });
                            print(customer_name);
                            print("Customer_nid");
                            print(Customer_id);
                            Navigator.pop(context);
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
                                  flex: 1,
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
                                              "${CustomersData[index].billingName}",
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
                                              "${CustomersData[index].accountName} / ${CustomersData[index].companyName}",
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    "${CustomersData[index].openingBalance}/-",
                                                style: FontStyleUtility.h12(
                                                  fontColor:
                                                      ColorUtils.blueColor,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }).then((value) {
      setState(() {
        // customer_selected = false;
      });
      print('hello');
    });
  }

  void select_others() {
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Customer',
                            style: FontStyleUtility.h17(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.semiBold,
                            )),
                        Text('Add new Customer',
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
                    child: build_Customer_Search(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
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
                              customer_selected = true;
                            });
                            setState(() {
                              other_name = Final_others[index]["billing_name"];
                              other_validate = true;
                              other_id = Final_others[index]["id"];
                              other_billing_name =
                                  Final_others[index]["billing_name"];
                              other_balance =
                                  Final_others[index]["opening_balance"];

                              other_name_list.add(other_billing_name!);
                              other_id_list.add(other_id.toString());
                              other_balance_list.add(other_balance.toString());
                            });
                            print("other_name");
                            print(other_name);
                            print("other_id");
                            print(other_id);

                            Navigator.pop(context);
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
                                  flex: 1,
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
                                              "${Final_others[index]["billing_name"]}",
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
                                    margin: EdgeInsets.only(
                                        left: 0, top: 0, right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  fontColor:
                                                      ColorUtils.blueColor,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }).then((value) {
      setState(() {
        // customer_selected = false;
      });
      print('hello');
    });
  }

  void select_vendor() {
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
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
                    child: build_Customer_Search(),
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
                    vendor_validate = true;
                    Vendor_id = Final_vendor[index]["id"];
                    Vendor_billing_name = Final_vendor[index]["billing_name"];
                    Vendor_balance = Final_vendor[index]["opening_balance"];
                    vendor_entity = Final_vendor[index]["ledger_type"];

                    ledger_id.add(Vendor_id.toString());
                    ledger_name.add(Vendor_billing_name.toString());
                    ledger_balance.add(Vendor_balance.toString());
                    ledger_entity.add(vendor_entity!);

                    vendor_name_list.add(Vendor_billing_name!);
                    vendor_id_list.add(Vendor_id.toString());
                    vendor_balance_list.add(Vendor_balance.toString());
                  });
                  print("Vendor_name");
                  print(Vendor_name);
                  print("Vendor_nid");
                  print(Vendor_id);
                  print(ledger_id);

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
                    vendor_validate = true;
                    other_id = Final_others[index]["id"];
                    other_billing_name = Final_others[index]["billing_name"];
                    other_balance = Final_others[index]["opening_balance"];
                    other_entity = Final_others[index]["ledger_type"];

                    ledger_id.add(other_id.toString());
                    ledger_name.add(other_billing_name.toString());
                    ledger_balance.add(other_balance.toString());
                    ledger_entity.add(other_entity!);

                    other_name_list.add(other_billing_name!);
                    other_id_list.add(other_id.toString());
                    other_balance_list.add(other_balance.toString());
                  });
                  print("other_name");
                  print(other_name);
                  print("other_id");
                  print(other_id);
                  print(ledger_id);

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

  List transTypeData = [];
  String query_others = '';
  List OthersData = [];
  bool tap = true;
  bool tap1 = true;

  Future Trans_type_api() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.trans_type_api;
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
        transTypeData = responseData['data'];
        // SubgroupData = GroupData[1]["sub_groups"];
      });
    } else {
      throw Exception("failed");
    }
    print("transTypeData");
    print(transTypeData[2]["transaction_type"]);
  }

  Future others_list_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.others_listing_modal_api;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        OthersData = responseData['data'];
        // SubgroupData = GroupData[1]["sub_groups"];
      });
    } else {
      throw Exception("failed");
    }
    print("transTypeData");
    print(OthersData);
  }

  var pay;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      body: custom_header(
        labelText: 'Add Information',
        back: AssetUtils.back_svg,
        backRoute: BindingUtils.cash_bankScreenRoute,
        data: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
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
                  margin: EdgeInsets.only(top: 15, left: 20,bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 18,
                              width: 18,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: ColorUtils.lightBlueradio,
                                    disabledColor: Colors.blue
                                ),
                                child: Radio(
                                  activeColor: ColorUtils.blueColor,
                                  // contentPadding: EdgeInsets.all(0),
                                  groupValue: _selectedfunc,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedfunc = value as String;
                                      print(_selectedfunc);
                                    });
                                  },
                                  value: '0',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Receipt',
                                style: FontStyleUtility.h14(
                                    fontColor: _selectedfunc == '0'
                                        ? ColorUtils.blueColor
                                        : ColorUtils.ogfont,
                                    fontWeight: FWT.semiBold)),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 18,
                              width: 18,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: ColorUtils.lightBlueradio,
                                    disabledColor: Colors.blue
                                ),
                                child: Radio(
                                  activeColor: ColorUtils.blueColor,
                                  // contentPadding: EdgeInsets.all(0),
                                  groupValue: _selectedfunc,
                                  // title: Text('Vendors',
                                  //     style: FontStyleUtility.h11(
                                  //         fontColor:
                                  //             ColorUtils.greyTextColor,
                                  //         fontWeight: FWT.semiBold)),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedfunc = value as String;
                                      print(_selectedfunc);
                                    });
                                    // _cash_bank_screen_controller
                                    //     .pageIndexUpdate('03');
                                    // _pageController!.jumpToPage(3);
                                  },
                                  value: '1',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Payment',
                                style: FontStyleUtility.h14(
                                    fontColor: _selectedfunc == '1'
                                        ? ColorUtils.blueColor
                                        : ColorUtils.ogfont,
                                    fontWeight: FWT.semiBold)),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 18,
                              width: 18,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: ColorUtils.lightBlueradio,
                                    disabledColor: Colors.blue
                                ),
                                child: Radio(
                                  // contentPadding: EdgeInsets.all(0),
                                  groupValue: _selectedfunc,
                                  activeColor: ColorUtils.blueColor,
                                  // title: Text(
                                  //   'Others',
                                  //   style: FontStyleUtility.h11(
                                  //       fontColor:
                                  //           ColorUtils.greyTextColor,
                                  //       fontWeight: FWT.semiBold),
                                  // ),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedfunc = value as String;
                                      print(_selectedfunc);
                                    });
                                  },
                                  value: '2',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Contra',
                              style: FontStyleUtility.h14(
                                  fontColor:_selectedfunc == '2'
                                      ? ColorUtils.blueColor
                                      : ColorUtils.ogfont,
                                  fontWeight: FWT.semiBold),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 20.0),

                    scrollDirection: Axis.vertical,
                    itemCount: Counter,
                    itemBuilder: (BuildContext context, int index) {

                      voucher_list.add(new TextEditingController());
                      cash_bank_controller.add(selectedValue_cash_bank);
                      cash_bank_controller_id
                          .add(selectedValue_cash_bank_id);
                      transaction_type_controller
                          .add(selectedValue_transaction);
                      transaction_type_controller_id
                          .add(selectedValue_transaction_id);

                      opening_bal_controller.add(new TextEditingController());
                      ref_no_controller.add(new TextEditingController());
                      payment_ammount_controller
                          .add(new TextEditingController());

                      note_controller.add(new TextEditingController());
                      // notes = jsonEncode(note_controller);

                      return Container(
                        margin: EdgeInsets.only(left: 20 ,right: 20,top: 10),
                        decoration: BoxDecoration(
                          color: ColorUtils.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTileTheme(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          horizontalTitleGap: 0.0,
                          minLeadingWidth: 0,
                          minVerticalPadding:0,
                          child: ExpansionTile(
                            title: GestureDetector(
                              onTap: () {
                                (_selectedfunc == '0'
                                    ? select_Customer()
                                    : (_selectedfunc == '1'
                                    ? select_vendor()
                                    : (_selectedfunc == '2'
                                    ? select_others()
                                    : select_Customer())));
                                // select_Customer();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 15, bottom: 15,left: 15),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ledger",
                                          // (selected_customer == true ? Text(customer_name!) : Text(customer_name!)),
                                          style: FontStyleUtility.h11(
                                            fontColor:
                                            ColorUtils.ogfont_light,
                                            fontWeight: FWT.medium,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                          (_selectedfunc == '0'
                                              ? (cust_name.length == Counter
                                              ? cust_name[index]
                                              : "select name")
                                              : (_selectedfunc == '1'
                                              ? (ledger_name.length ==
                                              Counter
                                              ? ledger_name[index]
                                              : "select name")
                                              : (_selectedfunc == '2'
                                              ? (other_name_list
                                              .length ==
                                              Counter
                                              ? other_name_list[
                                          index]
                                              : "select name")
                                              : (cust_name.length ==
                                              Counter
                                              ? cust_name[index]
                                              : "select name")))),
                                          style: FontStyleUtility.h15(
                                            fontColor:
                                            ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Balance',
                                          // (selected_customer == true ? Text(customer_name!) : Text(customer_name!)),
                                          style: FontStyleUtility.h11(
                                            fontColor:
                                            ColorUtils.ogfont_light,
                                            fontWeight: FWT.medium,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                            (_selectedfunc == '0'
                                                ? (cust_balance.length ==
                                                Counter
                                                ? cust_balance[index]
                                                : "Balance")
                                                : (_selectedfunc == '1'
                                                ? (ledger_balance
                                                .length ==
                                                Counter
                                                ? ledger_balance[
                                            index]
                                                : "Balance")
                                                : (_selectedfunc == '2'
                                                ? (other_balance_list
                                                .length ==
                                                Counter
                                                ? other_balance_list[
                                            index]
                                                : "Balance")
                                                : (cust_balance
                                                .length ==
                                                Counter
                                                ? cust_balance[
                                            index]
                                                : "Balance")))),
                                            style: FontStyleUtility.h15(
                                              fontColor:
                                              ColorUtils.blueColor,
                                              fontWeight: FWT.semiBold,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            trailing: SizedBox.shrink(),
                            children: <Widget>[
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: (voucher_no_validate == false
                                                    ? Border.all(
                                                    color: Colors.red, width: 1)
                                                    : Border.all(
                                                    color: Colors.transparent)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: CustomTextFieldWidget_two(
                                              tap: () {
                                                setState(() {
                                                  voucher_no_validate = true;
                                                });
                                              },
                                              controller: voucher_list[index],
                                              labelText: 'Voucher Number',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xfff3f3f3),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0),
                                              border: (birth_date == false
                                                  ? Border.all(
                                                  color: Colors.red, width: 1)
                                                  : Border.all(
                                                  color: Colors.transparent)),
                                            ),
                                            child: Row(
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: TextFormField(

                                                      onTap: () async {
                                                        setState(() {
                                                          birth_date = true;
                                                        });
                                                        _show_DatePicker(
                                                            context);
                                                      },
                                                      showCursor: true,
                                                      readOnly: true,

                                                      controller:
                                                      dateController,
                                                      decoration:
                                                      InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 11,horizontal: 15),

                                                        labelText: 'Date',
                                                        labelStyle:
                                                        FontStyleUtility.h12(
                                                            fontColor:
                                                            ColorUtils
                                                                .ogfont,
                                                            fontWeight: FWT
                                                                .semiBold),
                                                        border:
                                                        InputBorder.none,
                                                      ),
                                                      style: FontStyleUtility.h14(
                                                          fontColor:
                                                          ColorUtils
                                                              .blackColor,
                                                          fontWeight:
                                                          FWT.semiBold),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: SvgPicture.asset(
                                                    AssetUtils
                                                        .date_picker,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),

                                    height: 50,
                                    width:
                                    MediaQuery.of(context).size.width,
                                    child: FormField<String>(
                                      builder:
                                          (FormFieldState<String> state) {
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
                                                    'Cash / Bank',
                                                    style: FontStyleUtility
                                                        .h12(
                                                        fontColor:
                                                        ColorUtils
                                                            .ogfont,
                                                        fontWeight: FWT
                                                            .semiBold),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: OthersData.map((item) =>
                                                DropdownMenuItem<String>(
                                                  onTap: () {
                                                    tap1 = false;
                                                  },
                                                  value:
                                                  item["id"].toString(),
                                                  child: Text(
                                                    item["billing_name"],
                                                    style: FontStyleUtility.h14(
                                                        fontColor:
                                                        ColorUtils
                                                            .blackColor,
                                                        fontWeight:
                                                        FWT.semiBold),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                )).toList(),
                                            value: (cash_bank_controller
                                                .isNotEmpty
                                                ? cash_bank_controller[
                                            index]
                                                : selectedValue_cash_bank),
                                            onChanged: (value) {
                                              tap1 == true
                                                  ? setState(() {
                                                selectedValue_cash_bank = "hello";
                                                cash_bank_controller[index].text = selectedValue_cash_bank!;
                                              })
                                                  : setState(() {
                                                selectedValue_cash_bank =
                                                value as String;
                                                cash_bank_controller[
                                                index] =
                                                    selectedValue_cash_bank
                                                        .toString();
                                                print(
                                                    cash_bank_controller);
                                                // cash_bank_controller_id[index] = OthersData[index];
                                              });
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(AssetUtils.drop_svg),

                                            iconEnabledColor:
                                            Color(0xff007DEF),
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
                                            itemPadding:
                                            const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownPadding: null,
                                            dropdownDecoration:
                                            BoxDecoration(
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
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),

                                    height: 50,
                                    width:
                                    MediaQuery.of(context).size.width,
                                    child: FormField<String>(
                                      builder:
                                          (FormFieldState<String> state) {
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
                                                    'Transaction Type',
                                                    style: FontStyleUtility.h12(
                                                        fontColor: ColorUtils.ogfont, fontWeight: FWT.semiBold),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: transTypeData
                                                .map((item) =>
                                                DropdownMenuItem<
                                                    String>(
                                                  onTap: () {
                                                    tap = false;
                                                  },
                                                  value: item["id"]
                                                      .toString(),
                                                  child: Text(
                                                    item[
                                                    "transaction_type"],
                                                    style: FontStyleUtility.h14(
                                                        fontColor:
                                                        ColorUtils.blackColor,
                                                        fontWeight: FWT.semiBold),
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ))
                                                .toList(),
                                            value: (transaction_type_controller
                                                .isNotEmpty
                                                ? transaction_type_controller[
                                            index]
                                                : selectedValue_transaction),
                                            onChanged: (value) {
                                              tap == true
                                                  ? setState(() {
                                                selectedValue_transaction =
                                                "hello";
                                                transaction_type_controller[
                                                index]
                                                    .text =
                                                selectedValue_transaction!;
                                              })
                                                  : setState(() {
                                                selectedValue_transaction_id =
                                                value as String?;
                                                print(
                                                    selectedValue_transaction_id);

                                                selectedValue_transaction =
                                                value as String;
                                                transaction_type_controller[
                                                index] =
                                                    selectedValue_transaction
                                                        .toString();
                                                print(
                                                    transaction_type_controller);
                                              });
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(AssetUtils.drop_svg),

                                            iconEnabledColor:
                                            Color(0xff007DEF),
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
                                            itemPadding:
                                            const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownPadding: null,
                                            dropdownDecoration:
                                            BoxDecoration(
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
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),

                                    child: CustomTextFieldWidget_two(
                                      controller:
                                      opening_bal_controller[index],
                                      labelText: 'Opening Balance',
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),

                                    child: CustomTextFieldWidget_two(
                                      controller: ref_no_controller[index],
                                      labelText: 'Ref. No.',
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                        border: (ammount_validate ==
                                            false
                                            ? Border.all(
                                            color: Colors.red, width: 1)
                                            : Border.all(
                                            color: Colors.transparent)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),

                                    child: CustomTextFieldWidget_two(
                                      tap: () {
                                        setState(() {
                                          ammount_validate = true;
                                        });
                                      },
                                      controller:
                                      payment_ammount_controller[index],
                                      labelText: 'Payment Ammount',
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),

                                    child: CustomTextFieldWidget_two(
                                      controller: note_controller[index],
                                      maxLines: 4,
                                      labelText: 'Narration',
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),

                GestureDetector(
                  onTap: () {

                    for (int i = 0; i < Counter; i++){

                          if(voucher_list[i].text.isEmpty ){
                            Fluttertoast.showToast(
                                msg: 'Enter Details',
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                gravity:
                                ToastGravity.BOTTOM,
                                toastLength:
                                Toast.LENGTH_LONG);
                            if(voucher_list[i].text.isEmpty){
                              setState(() {
                                voucher_no_validate = false;
                              });
                            }
                            return;
                          }
                    }
                    setState(() {
                      customer_selected == false;
                      Counter++;
                      // print(Counter);
                      print(transaction_type_controller);
                    });
                    // setState(() {}); // select_product();
                  },
                  child: Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '₹ ${payment_ammount_controller.fold<int>(0, (previousValue, element) {
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
                      Text('Total Amount',
                          style: FontStyleUtility.h14(
                            fontColor: ColorUtils.ogfont,
                            fontWeight: FWT.bold,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: MyLeadingItemCustomButtonWidget(
                      leadingIcon: AssetUtils.locksvg,
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

                        (_selectedfunc == '0'
                            ? receipt_pay_api()
                            : (_selectedfunc == '1'
                                ? Payment_api()
                                : (_selectedfunc == '2'
                                    ? contra_api()
                                    : receipt_pay_api())));

                        // Get.offAllNamed(BindingUtils.companyDetailsScreenRoute);
                      }, // Navigator.push(
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future receipt_pay_api() async {
    // showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);

    List EntityItems = [];
    for (int i = 0; i < Counter; i++) {
      {
        Map entity = {
          "id": i,
          "customer_id": cust_id[i],
          "balance": cust_balance[i],
          "total_amount":
              payment_ammount_controller.fold<int>(0, (previousValue, element) {
            return (previousValue) +
                int.parse(element.value.text != "" ? element.value.text : "0");
          }),
          "entity_id": cust_id[i],
          "other_ledger_id": cash_bank_controller[i],
          "entity_type": "customer",
          "ledger_name": "String",
          "entry_list": [
            {
              "cash_bank_Name": "String",
              "cash_bank_id": cash_bank_controller[i],
              "date": datelist[i],
              "invoice_balance_due": 0,
              "narration": note_controller[i].text,
              "open_balance": opening_bal_controller[i].text,
              "payment_amount": payment_ammount_controller[i].text,
              "ref_number": ref_no_controller[i].text,
              "transaction_type_id": transaction_type_controller[i],
              "voucher_number": voucher_list[i].text,
            }
          ],
        };
        EntityItems.add(entity);
      }
    }
    Map data = {
      "id": 0,
      "receipts": EntityItems,
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.receipt_payment_add_api;
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
      Get.offAllNamed(BindingUtils.cash_bankScreenRoute);
      hideLoader(context);
      print('Seccess');
    } else {
      hideLoader(context);
      print("error");
    }
  }

  Future Payment_api() async {
    // showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);

    List EntityItems = [];
    for (int i = 0; i < Counter; i++) {
      {
        Map entity = {
          "id": i,
          "customer_id": ledger_id[i],
          "balance": ledger_balance[i],
          "balance_type": " Cr",
          "total_amount":
              payment_ammount_controller.fold<int>(0, (previousValue, element) {
            return (previousValue) +
                int.parse(element.value.text != "" ? element.value.text : "0");
          }),
          "entity_id": ledger_id[i],
          "other_ledger_id": cash_bank_controller[i],
          "ledger_name": "Vendors",
          "entity_type": ledger_entity[i],
          "entry_list": [
            {
              "cash_bank_Name": "String",
              "cash_bank_id": cash_bank_controller[i],
              "date": datelist[i],
              "invoice_balance_due": 0,
              "narration": note_controller[i].text,
              "open_balance": opening_bal_controller[i].text,
              "payment_amount": payment_ammount_controller[i].text,
              "ref_number": ref_no_controller[i].text,
              "transaction_type_id": transaction_type_controller[i],
              "voucher_number": voucher_list[i].text,
            }
          ],
        };
        EntityItems.add(entity);
      }
    }
    Map data = {
      "id": 0,
      "payments": EntityItems,
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.payment_add_api;
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
      Get.offAllNamed(BindingUtils.cash_bankScreenRoute);
      hideLoader(context);
      print('Seccess');
    } else {
      hideLoader(context);
      print("error");
    }
  }

  Future contra_api() async {
    // showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);

    List EntityItems = [];
    for (int i = 0; i < Counter; i++) {
      {
        Map entity = {
          "id": i,
          "customer_id": other_id_list[i],
          "balance": other_balance_list[i],
          "total_amount":
              payment_ammount_controller.fold<int>(0, (previousValue, element) {
            return (previousValue) +
                int.parse(element.value.text != "" ? element.value.text : "0");
          }),
          "entity_id": other_id_list[i],
          "other_ledger_id": cash_bank_controller[i],
          "entity_type": "other",
          "ledger_name": "String",
          "entry_list": [
            {
              "cash_bank_Name": "String",
              "cash_bank_id": cash_bank_controller[i],
              "date": datelist[i],
              "invoice_balance_due": 0,
              "narration": note_controller[i].text,
              "open_balance": 0,
              "payment_amount": payment_ammount_controller[i].text,
              "ref_number": ref_no_controller[i].text,
              "transaction_type_id": transaction_type_controller[i],
              "voucher_number": voucher_list[i].text,
            }
          ],
        };
        EntityItems.add(entity);
      }
    }
    Map data = {
      "id": 0,
      "contras": EntityItems,
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.contra_add_api;
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
      Get.offAllNamed(BindingUtils.cash_bankScreenRoute);
      hideLoader(context);
      print('Seccess');
    } else {
      hideLoader(context);
      print("error");
    }
  }
}
