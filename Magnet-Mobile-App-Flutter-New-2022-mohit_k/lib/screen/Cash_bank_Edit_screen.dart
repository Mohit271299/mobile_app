import 'dart:convert';
import 'dart:core';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/listing/api_listing.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
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

class cash_bank_EditScreen extends StatefulWidget {
  final int? receipt_id;
  final int? payment_id;
  final int? contra_id;
  final int? customer_id;
  final int? vendore_id;

  const cash_bank_EditScreen(
      {Key? key, this.receipt_id, this.payment_id, this.contra_id, this.customer_id, this.vendore_id})
      : super(key: key);

  @override
  _cash_bank_EditScreenState createState() => _cash_bank_EditScreenState();
}

class _cash_bank_EditScreenState extends State<cash_bank_EditScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Cash_Bank_Edit_controller _cash_bank_edit_controller = Get.put(
      Cash_Bank_Edit_controller(),
      tag: Cash_Bank_Edit_controller().toString());
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

  TextEditingController voucher_no = new TextEditingController();
  TextEditingController datelist = new TextEditingController();
  TextEditingController cash_bank_controller = TextEditingController();
  List cash_bank_controller_id = [];
  TextEditingController transaction_type_controller = TextEditingController();
  List transaction_type_controller_id = [];

  TextEditingController opening_bal_controller = new TextEditingController();
  TextEditingController ref_no_controller = new TextEditingController();
  TextEditingController payment_ammount_controller =
      new TextEditingController();
  TextEditingController note_controller = new TextEditingController();
  String? notes;

  String? cust_name;
  String? cust_id;
  String? cust_balance;
  String? vendor_name;
  String? vendor_id;
  String? vendor_balance;
  String? other_name;
  String? other_id;
  String? other_balance;
  String? entity_type_pay;
  int? entity_id_pay;

  String? ledger_id;

  String? ledger_name;

  String? ledger_balance;

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
        print(dateController);
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  void initState() {
    print(widget.customer_id);
    setState(() {
      cust_name = widget.customer_id.toString();
      vendor_name = widget.vendore_id.toString();
    });

    (widget.receipt_id != null || widget.customer_id != null
        ?_selectedfunc = '0'
        : (widget.payment_id != null || widget.vendore_id != null
        ? _selectedfunc = '1'
        : (widget.contra_id != null
        ? _selectedfunc= '2'
        : Receipt_edit_get())));
    _init();

    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
  }

  _init() async {
   await Customer_list_API();
   await fetchAdd();
   await Trans_type_api();
   await others_list_API();
    // await Receipt_edit_get();
    (widget.receipt_id != null || widget.customer_id != null
        ? Receipt_edit_get()
        : (widget.payment_id != null || widget.vendore_id != null
            ? Payment_edit_get()
            : (widget.contra_id != null
                ? Contra_edit_get()
                : Receipt_edit_get())));
  }

  var data;
  var customers;
  var cash_bank;

  Future Receipt_edit_get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.receipt_payment_add_api + '/${widget.receipt_id}';

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
        customers = data["customer"];
        cash_bank = data["cash_bank"];

        cust_id = customers["id"].toString();
        cust_name = customers["billing_name"];
        cust_balance = customers["opening_balance"].toString();

        voucher_no.text = data["voucher_number"];
        entity_id_pay = data["entity_id"];
        entity_type_pay = data["entity_type"];

        dateController.text = data["date"];
        opening_bal_controller.text = data["open_balance"].toString();
        ref_no_controller.text = data["ref_number"];
        payment_ammount_controller.text = data["payment_amount"].toString();
        selectedValue_cash_bank = data["cash_bank_id"].toString();
        selectedValue_transaction = data["transaction_type_id"].toString();
        note_controller.text = data["narration"];
        print(cust_id);
        print(cust_name);
        print(cust_balance);
        print(voucher_no);
        print(dateController);

        print(opening_bal_controller);
        print(ref_no_controller);
        print(ref_no_controller);
        print("payment_ammount_controller.text");
        print(payment_ammount_controller.text);
      });

      print("Receipt_edit_details");
      print(data);
      print(customers);
      print(cust_id);
      print(cust_name);
      print(cust_balance);
      print(voucher_no);
      print(datelist);
      print(datelist);
      print(opening_bal_controller);
      print(ref_no_controller);
      print(ref_no_controller);
      print(payment_ammount_controller);
      // print(address);

      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future Payment_edit_get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.payment_add_api + '/${widget.payment_id}';

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
        customers = data["entity"];
        cash_bank = data["cash_bank"];

        entity_type_pay = data["entity_type"];
        print("entity_type_pay");
        print(entity_type_pay);
        entity_id_pay = data["entity_id"];
        print("entity_type_pay");
        print(entity_type_pay);

        (data["entity_type"] == "vendor"
            ? vendor_id = data["entity_id"].toString()
            : (data["entity_type"] == "other"
                ? other_id = data["entity_id"].toString()
                : vendor_id = data["entity_id"].toString()));

        (data["entity_type"] == "vendor"
            ? vendor_name = customers["billing_name"].toString()
            : (data["entity_type"] == "other"
                ? other_name = customers["billing_name"].toString()
                : vendor_name = customers["billing_name"].toString()));

        (data["entity_type"] == "vendor"
            ? vendor_balance = customers["opening_balance"].toString()
            : (data["entity_type"] == "other"
                ? other_balance = customers["opening_balance"].toString()
                : vendor_balance = customers["opening_balance"].toString()));

        // vendor_name = customers["billing_name"];
        // cust_balance = customers["opening_balance"].toString();

        voucher_no.text = data["voucher_number"];
        note_controller.text = data["narration"];

        dateController.text = data["date"];
        opening_bal_controller.text = data["open_balance"].toString();
        ref_no_controller.text = data["ref_number"];
        ref_no_controller.text = data["ref_number"];
        payment_ammount_controller.text = data["payment_amount"].toString();
        selectedValue_cash_bank = data["cash_bank_id"].toString();
        selectedValue_transaction = data["transaction_type_id"].toString();

        print(cust_id);
        print(cust_name);
        print(cust_balance);
        print(voucher_no);
        print(dateController);

        print(opening_bal_controller);
        print(ref_no_controller);
        print(ref_no_controller);
        print("payment_ammount_controller.text");
        print(payment_ammount_controller.text);
      });

      print("Receipt_edit_details");
      print(data);
      print(customers);
      print(cust_id);
      print(cust_name);
      print(cust_balance);
      print(voucher_no);
      print(datelist);
      print(datelist);
      print(opening_bal_controller);
      print(ref_no_controller);
      print(ref_no_controller);
      print(payment_ammount_controller);
      // print(address);

      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Future Contra_edit_get() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.contra_add_api + '/${widget.contra_id}';

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
        customers = data["other"];
        cash_bank = data["cash_bank"];

        other_id = customers["id"].toString();
        other_name = customers["billing_name"];
        other_balance = customers["opening_balance"].toString();
        entity_id_pay = data["entity_id"];
        voucher_no.text = data["voucher_number"];
        note_controller.text = data["narration"];

        dateController.text = data["date"];
        opening_bal_controller.text = data["open_balance"].toString();
        ref_no_controller.text = data["ref_number"];
        payment_ammount_controller.text = data["payment_amount"].toString();
        selectedValue_cash_bank = data["cash_bank_id"].toString();
        selectedValue_transaction = data["transaction_type_id"].toString();

        print(cust_id);
        print(cust_name);
        print(cust_balance);
        print(voucher_no);
        print(dateController);

        print(opening_bal_controller);
        print(ref_no_controller);
        print(ref_no_controller);
        print("payment_ammount_controller.text");
        print(payment_ammount_controller.text);
      });

      print("Receipt_edit_details");
      print(data);
      print(customers);
      print(cust_id);
      print(cust_name);
      print(cust_balance);
      print(voucher_no);
      print(datelist);
      print(datelist);
      print(opening_bal_controller);
      print(ref_no_controller);
      print(ref_no_controller);
      print(payment_ammount_controller);
      // print(address);

      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  String query_customer = '';
  List<Data_customers> CustomersData = [];

  List<dynamic> Final_customer = [];
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
        Final_customer = responseBody["data"]["customers"];
        newList = [Final_vendor, Final_others].expand((x) => x).toList();
        print(newList);
        print(newList.length);
        print("Final_customer");
        print(Final_customer);
      });
    } else {
      throw Exception('Failed to load');
    }
  }

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

  void select_Customer() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 500,
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
                              cust_id = Final_customer[index]["id"].toString();
                              cust_name = Final_customer[index]["billing_name"];
                              cust_balance = Final_customer[index]
                                      ["opening_balance"]
                                  .toString();

                              setState(() {
                                customer_selected = true;
                              });
                              print("cust_name");
                              print(cust_name);
                              print("cust_name.length");
                              Navigator.pop(context);
                            });
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
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 500,
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
                              other_id = Final_others[index]["id"];
                              other_name = Final_others[index]["billing_name"];
                              other_balance =
                                  Final_others[index]["opening_balance"];
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
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 500,
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
                    vendor_id = Final_vendor[index]["id"];
                    vendor_name = Final_vendor[index]["billing_name"];
                    vendor_balance = Final_vendor[index]["opening_balance"];
                  });

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
                    other_id = Final_others[index]["id"];
                    other_name = Final_others[index]["billing_name"];
                    other_balance = Final_others[index]["opening_balance"];
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
            child: Container(
              // margin: EdgeInsets.only(top: 0),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(10),
              //       topRight: Radius.circular(10)),
              //   color: ColorUtils.ogback,
              // ),
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
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75),
                            ),
                          ]
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ledger",
                                          // (selected_customer == true ? Text(customer_name!) : Text(customer_name!)),
                                          style: FontStyleUtility.h11(
                                            fontColor: ColorUtils.greyTextColor,
                                            fontWeight: FWT.medium,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                          (widget.receipt_id != null
                                              ? '$cust_name'
                                              : (widget.payment_id != null
                                              ? (data["entity_type"] ==
                                              "vendor"
                                              ? '$vendor_name'
                                              : (data["entity_type"] ==
                                              "other"
                                              ? '$other_name'
                                              : '$vendor_name'))
                                              : (widget.contra_id != null
                                              ? '$other_name' : (widget.customer_id!=null ? '$cust_name' : 'Select Ledger')
                                          ))),
                                          style: FontStyleUtility.h15(
                                            fontColor: ColorUtils.blackColor,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Balance',
                                          // (selected_customer == true ? Text(customer_name!) : Text(customer_name!)),
                                          style: FontStyleUtility.h11(
                                            fontColor: ColorUtils.greyTextColor,
                                            fontWeight: FWT.medium,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                            (widget.receipt_id != null
                                                ? '$cust_balance'
                                                : (widget.payment_id != null
                                                ? (data["entity_type"] ==
                                                "vendor"
                                                ? '$vendor_balance'
                                                : (data["entity_type"] ==
                                                "other"
                                                ? '$other_name'
                                                : '$other_balance'))
                                                : (widget.contra_id != null
                                                ? '$other_balance'
                                                : 'Select Ledger'))),
                                            style: FontStyleUtility.h15(
                                              fontColor: ColorUtils.blueColor,
                                              fontWeight: FWT.bold,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFieldWidget_two(
                                            controller: voucher_no,
                                            labelText: 'Voucher Number',
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
                                                    controller: dateController,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: 11,horizontal: 15),
                                                      labelText: 'Date',
                                                      labelStyle:
                                                      FontStyleUtility.h12(
                                                          fontColor:
                                                          ColorUtils
                                                              .ogfont,
                                                          fontWeight:
                                                          FWT.semiBold),
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
                                                    _show_DatePicker(context);
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
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),
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
                                                    'Cash / Bank',
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
                                            items: OthersData.map((item) =>
                                                DropdownMenuItem<String>(
                                                  onTap: () {
                                                    tap1 = false;
                                                  },
                                                  value: item["id"].toString(),
                                                  child: Text(
                                                    item["billing_name"],
                                                    style: FontStyleUtility.h14(
                                                        fontColor:
                                                        ColorUtils.blackColor,
                                                        fontWeight: FWT.semiBold),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                )).toList(),
                                            value: selectedValue_cash_bank,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue_cash_bank =
                                                value as String;
                                                cash_bank_controller.text =
                                                    selectedValue_cash_bank
                                                        .toString();
                                                print(cash_bank_controller);
                                                // cash_bank_controller_id[index] = OthersData[index];
                                              });
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(AssetUtils.drop_svg),

                                            iconEnabledColor: Color(0xff007DEF),
                                            iconDisabledColor: Color(0xff007DEF),
                                            buttonHeight: 50,
                                            buttonWidth: 160,
                                            buttonPadding: const EdgeInsets.only(
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

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),
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
                                                    'Transaction Type',
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
                                            items: transTypeData
                                                .map((item) =>
                                                DropdownMenuItem<String>(
                                                  onTap: () {
                                                    tap = false;
                                                  },
                                                  value:
                                                  item["id"].toString(),
                                                  child: Text(
                                                    item["transaction_type"],
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
                                            value: selectedValue_transaction,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue_transaction =
                                                value as String;
                                                transaction_type_controller.text =
                                                    selectedValue_transaction
                                                        .toString();
                                                print(
                                                    transaction_type_controller);
                                              });
                                            },
                                            iconSize: 25,
                                            icon: SvgPicture.asset(AssetUtils.drop_svg),

                                            iconEnabledColor: Color(0xff007DEF),
                                            iconDisabledColor: Color(0xff007DEF),
                                            buttonHeight: 50,
                                            buttonWidth: 160,
                                            buttonPadding: const EdgeInsets.only(
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

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),
                                    child: CustomTextFieldWidget_two(
                                      controller: opening_bal_controller,
                                      labelText: 'Opening Balance',
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),
                                    child: CustomTextFieldWidget_two(
                                      controller: ref_no_controller,
                                      labelText: 'Ref. No.',
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),
                                    child: CustomTextFieldWidget_two(
                                      controller: payment_ammount_controller,
                                      labelText: 'Payment Ammount',
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 18 , right: 18,top: 15),
                                    child: CustomTextFieldWidget_two(
                                      controller: note_controller,
                                      maxLines: 4,
                                      labelText: 'Note',
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
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                  ],
                ),
              ),
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
                color: Colors.black,
                blurRadius: 10, // soften the shadow
                spreadRadius: -5, //extend the shadow
                offset: Offset(
                  0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
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
                      Text('${payment_ammount_controller.text}',
                          style: FontStyleUtility.h17(
                            fontColor: ColorUtils.blackColor,
                            fontWeight: FWT.bold,
                          )),
                      SizedBox(
                        height: 9,
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
                        (widget.receipt_id != null
                            ? receipt_pay_api()
                            : (widget.payment_id != null
                                ? Payment_api()
                                : (widget.contra_id != null
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

    Map data = {
      "customer_id": int.parse(cust_id!),
      "total_amount": int.parse(payment_ammount_controller.text),
      "cash_bank_id": int.parse(selectedValue_cash_bank!),
      "voucher_number": int.parse(voucher_no.text),
      "transaction_type_id": int.parse(selectedValue_transaction!),
      "ref_number": ref_no_controller.text,
      "date": dateController.text,
      "invoice_type": null,
      "invoice_id": null,
      "invoice_balance_due": null,
      "payment_amount": int.parse(payment_ammount_controller.text),
      "narration": note_controller.text
    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.receipt_payment_add_api + '/${widget.receipt_id}';
    var response = await http_service.put(url, data);
    if (response["success"]) {
      Get.offAllNamed(BindingUtils.cash_bankScreenRoute);
      hideLoader(context);
    }
  }

  Future Payment_api() async {
    // showLoader(context);
    Map data = {
    "entity_id": entity_id_pay,
    "entity_type": entity_type_pay,
    "total_amount": int.parse(payment_ammount_controller.text),
    "cash_bank_id": int.parse(selectedValue_cash_bank!),
    "voucher_number": int.parse(voucher_no.text),
    "transaction_type_id": int.parse(selectedValue_transaction!),
    "ref_number": ref_no_controller.text,
    "date": dateController.text,
    "invoice_type": null,
    "invoice_id": null,
    "invoice_balance_due": null,
    "payment_amount": int.parse(payment_ammount_controller.text),
    "narration": note_controller.text

    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.payment_add_api + '/${widget.payment_id}';
    var response = await http_service.put(url, data);
    // print(response.body);
    // print(response.statusCode);
    if (response["success"]) {
      Get.offAllNamed(BindingUtils.cash_bankScreenRoute);
      hideLoader(context);
      print('Seccess');
    }
  }

  Future contra_api() async {
    // showLoader(context);
    Token = await PreferenceManager().getPref(Api_url.token);

    Map data = {
    "cash_bank_id": int.parse(selectedValue_cash_bank!),
    "date": dateController.text,
    "entity_id": entity_id_pay,
    "entity_type": "other",
    "narration": note_controller.text,
    "other_ledger_id": int.parse(other_id!),
    "payment_amount": int.parse(payment_ammount_controller.text),
    "ref_number": ref_no_controller.text,
    "total_amount": int.parse(payment_ammount_controller.text),
    "transaction_type_id": int.parse(selectedValue_transaction!),
    "voucher_number": int.parse(voucher_no.text),

    };

    print(data);

    String body = json.encode(data);
    var url = Api_url.contra_add_api +'/${widget.contra_id}';
    var response = await http_service.put(url, data);
    // print(response.body);
    // print(response.statusCode);
    if (response["success"]) {
      Get.offAllNamed(BindingUtils.cash_bankScreenRoute);
      hideLoader(context);
      print('Seccess');
    }
  }
}
