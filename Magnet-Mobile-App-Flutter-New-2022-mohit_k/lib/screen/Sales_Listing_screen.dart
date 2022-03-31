import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/custom_widgets/custom_header.dart';
import 'package:magnet_update/custom_widgets/floating_action_button.dart';
import 'package:magnet_update/custom_widgets/search_widget.dart';
import 'package:magnet_update/model_class/bill_supply_model.dart';
import 'package:magnet_update/model_class/cash_memo_model.dart';
import 'package:magnet_update/model_class/delivery_challan_model.dart';
import 'package:magnet_update/model_class/extimate_invoice_model.dart';
import 'package:magnet_update/model_class/proforma_invoice_model.dart';
import 'package:magnet_update/model_class/tax_invoice_model.dart';
import 'package:magnet_update/screen/Cash_bank_Edit_screen.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/list_shimmer.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import 'Sales_bill_supply_Edit_screen.dart';
import 'Sales_cash_memo_Edit_screen.dart';
import 'Sales_delivery_challan_Edit_screen.dart';
import 'Sales_estimate_Edit_screen.dart';
import 'Sales_proforma_Edit_screen.dart';
import 'Sales_tax_invoice_Edit_screen.dart';

class salesScreen extends StatefulWidget {
  const salesScreen({Key? key}) : super(key: key);

  @override
  _salesScreenState createState() => _salesScreenState();
}

class _salesScreenState extends State<salesScreen> {
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final Sales_Listing_controller _salesscreencontroller = Get.put(
      Sales_Listing_controller(),
      tag: Sales_Listing_controller().toString());
  PageController? _pageController;

  List _viewData = [
    'Tax Invoice',
    'Bill of Supply',
    'Cash Memo',
    'Proforma Invoice',
    'Estimate',
    'Delivery Challan',
  ];

  int _indexData = 0;
  String selectedValue = 'Tax Invoice';
  String Token = '';

  // bool selected_customer= false;
  // String? customer_name;
  late String dateSelected_invoice;
  TextEditingController invoicedateController = new TextEditingController();
  final List<String> invoice_date_list = <String>[];
  TextEditingController duedateController = new TextEditingController();
  final List<String> due_date_list = <String>[];
  TextEditingController invoiceNumberController = new TextEditingController();
  final List<String> invoice_number_list = <String>[];
  TextEditingController termsController = new TextEditingController();

  TextEditingController product_name_controller = new TextEditingController();
  TextEditingController product_quantity_controller =
      new TextEditingController();
  TextEditingController product_rate_controller = new TextEditingController();
  final List<String> product_name_list = <String>[];
  final List<String> product_quantity_list = <String>[];
  final List<String> product_rate_list = <String>[];

  @override
  void initState() {
    tax_invoice_list_API();
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
  }
// init(){
//   bill_supply_list_API();
//   cash_memo_list_API();
//   proforma_invoice_list_API();
//   Estimate_invoice_list_API();
//   Delivery_challan_list_API();
// }
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      drawer: DrawerScreen(),
      body: custom_header(
        labelText: "Sales",
        burger: AssetUtils.burger,
        data: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: GetBuilder<Sales_Listing_controller>(
              init: _salesscreencontroller,
              builder: (_) {
                return Container(
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                      child: Text(
                        'Sales',
                        style: FontStyleUtility.h20B(
                          fontColor: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.065,
                      margin: EdgeInsets.only(top: 20, left: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _viewData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _indexData = index;
                                  });
                                  print(_indexData);
                                  (_indexData == 0 ?tax_invoice_list_API() :
                                  (_indexData == 1) ? bill_supply_list_API():
                                  (_indexData == 2) ? cash_memo_list_API() :
                                  (_indexData == 3) ? proforma_invoice_list_API():
                                  (_indexData == 4) ? Estimate_invoice_list_API():
                                  (_indexData == 5)? Delivery_challan_list_API() :
                                  tax_invoice_list_API() );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0, bottom: 0),
                                  height:30,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x17000000),
                                        blurRadius: 10.0,
                                        offset: Offset(
                                          0.0,
                                          0.75,
                                        ),
                                      ),
                                    ],
                                    color: ColorUtils.whiteColor,
                                    border: Border.all(
                                      color: _indexData == index
                                          ? HexColor("#3B7AF1")
                                          : Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 6),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _viewData[index],
                                      style: TextStyle(
                                          fontFamily: "GR",
                                          color: _indexData == index
                                              ? ColorUtils.blueColor
                                              : ColorUtils.ogfont,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: (_indexData == 0
                          ? tax_invoice_list()
                          : (_indexData == 1
                              ? bill_supply_list()
                              : (_indexData == 2
                                  ? cash_memo_list()
                                  : (_indexData == 3
                                      ? proforma_invoice_list()
                                      : (_indexData == 4
                                          ? Estimate_invoice_list()
                                          : (_indexData == 5
                                              ? Delivery_challan_list()
                                              : tax_invoice_list())))))),
                    )
                  ],
                ));
              }),
        ),
      ),
      floatingActionButton: GetBuilder<Sales_Listing_controller>(
          init: _salesscreencontroller,
          builder: (_) {
            return floating_button(
              Open: () {
                _salesscreencontroller.isFloatingActionUpdate(true);
              },
              Close: () {
                _salesscreencontroller.isFloatingActionUpdate(false);
              },
              labelText_1: 'Tax Invoice',
              labelText_2: 'Bill of Suppy',
              labelText_3: 'Cash Memo',
              labelText_4: 'Performa Invoice',
              labelText_5: 'Estimate',
              labelText_6: 'Delivery Challan',
              onTap_1: () {
                Get.toNamed(BindingUtils.tax_invoice_setup_ScreenRoute);
              },
              onTap_2: () {
                Get.toNamed(BindingUtils.bill_supply_setup_ScreenRoute);
              },
              onTap_3: () {
                Get.toNamed(BindingUtils.cash_memo_setup_ScreenRoute);
              },
              onTap_4: () {
                Get.toNamed(BindingUtils.proforma_invoice_ScreenRoute);
              },
              onTap_5: () {
                Get.toNamed(BindingUtils.estimate_ScreenRoute);
              },
              onTap_6: () {
                Get.toNamed(BindingUtils.delivery_challan_ScreenRoute);
              },
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String query_tax_invoice = '';
  List<Data_tax_invoice> TaxInvoiceData = [];
  int? selected_tax_invoice;

  String query_bill_supply = '';
  List<Data_bill_supply> BillSupplyData = [];
  int? selected_billSupply;

  String query_cash_memo = '';
  List<Data_cash_memo> Cash_memo_Data = [];
  int? selected_cash_memo;

  String query_proforma_invoice = '';
  List<Data_proforma_invoice> ProformaInvoice_Data = [];
  int? selected_proforma_invoice;

  String query_estimate_invoice = '';
  List<Data_estimate> EstimateInvoice_Data = [];
  int? selected_estimate_invoice;

  String query_delivery_challan = '';
  List<Data_delivery_challan> Delivery_challan_Data = [];
  int? selected_delivery_challan;

  bool isLoading = false;

//==Tax Invoice.........................................
  Future tax_invoice_list_API() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    final books = await call_api.getTax_invoiceList(query_tax_invoice);

    setState(() => this.TaxInvoiceData = books);
    setState(() {
      isLoading = false;
    });
    // print(VendorsData);
  }

  Future tax_invoice_list_search_API(String query) async {
    final books_vendors = await call_api.getTax_invoiceList(query);

    if (!mounted) return;

    setState(() {
      this.query_tax_invoice = query;
      this.TaxInvoiceData = books_vendors;
    });
  }

  Widget build_tax_invoice_Search() {
    return SearchWidget(
      text: query_tax_invoice,
      hintText: 'Search Here',
      onChanged: tax_invoice_list_search_API,
    );
  }

  Future tax_invoice_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/taxinvoice/$selected_tax_invoice/null/null';

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      tax_invoice_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  // Future<void> _openPdf() async{
  //    PdfDocument document = PdfDocument();
  //    final page = document.pages.add();
  //
  //    page.graphics.drawString('My PDF generated',
  //    PdfStandardFont(PdfFontFamily.helvetica, 30));
  //    List<int> bytes = document.save();
  //    document.dispose();
  //
  //    saveAndLunchFile(bytes, 'output.pdf');
  //  }

  Widget tax_invoice_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_tax_invoice_Search()),
              Container(
                margin: EdgeInsets.only(right: 12.0, left: 12.0),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AssetUtils.sort_Icons,
                      height: 17.0,
                      width: 19.83,
                    )),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(right: 51),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AssetUtils.filter_Icons,
                    height: 17,
                    width: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 80.0),
          scrollDirection: Axis.vertical,
          itemCount: isLoading ? 10 : TaxInvoiceData.length,
          itemBuilder: (BuildContext context, int index) {
            if (isLoading) {
              return shimmer_list();
            } else {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity:
                          VisualDensity(vertical: -4.0, horizontal: -4.0),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${TaxInvoiceData[index].customer!.billingName}",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Gilroy-Bold",
                          fontSize: 15.0,

                          color: HexColor("#0B0D16"),
                        ),
                        softWrap: true,

                      ),
                      trailing: InkWell(
                        child: Container(
                          width: 20,
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: HexColor("#0B0D16"),
                          ),
                        ),
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        color: Color(0xff737373),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_tax_invoice =
                                                            TaxInvoiceData[
                                                                    index]
                                                                .id;
                                                      });
                                                      print(
                                                          selected_tax_invoice);
                                                      Get.to(taxInvoiceEditScreen(
                                                          tax_invoice_id:
                                                              selected_tax_invoice));
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.only(
                                                                right: 38,
                                                                left: 38,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_tax_invoice =
                                                            TaxInvoiceData[
                                                                    index]
                                                                .customer!
                                                                .id;
                                                      });
                                                      print(
                                                          selected_tax_invoice);
                                                      Get.to(
                                                          cash_bank_EditScreen(
                                                        customer_id:
                                                            selected_tax_invoice,
                                                      ));
                                                      // Get.to(taxInvoiceEditScreen(
                                                      //     tax_invoice_id:
                                                      //     selected_tax_invoice));
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.only(
                                                                right: 38,
                                                                left: 38,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Receive Payment',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  // ElevatedButton(onPressed: _openPdf, child: Text('child')),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('tap');
                                                      // _openPdf;
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.only(
                                                                right: 38,
                                                                left: 38,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Preview/Download/Print',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Mark as complete',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: const Text(
                                                            'Change due date',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_tax_invoice =
                                                            TaxInvoiceData[
                                                                    index]
                                                                .id;
                                                      });
                                                      tax_invoice_delete();
                                                      print(
                                                          selected_tax_invoice);
                                                    },
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xffE74B3B),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                          setState(() {});
                        },
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${TaxInvoiceData[index].invoiceDate}",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-SemiBold",
                              fontWeight: FontWeight.w400,
                              color: HexColor("#BBBBC5"),
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 5.0, top: 0.0, bottom: 0.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(TaxInvoiceData[index].totalAmt!.toDouble().toString()))}',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(TaxInvoiceData[index].balanceDue!.toDouble().toString()))}',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 4.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    ));
  }

//==Bill of Supply.........................................
  Future bill_supply_list_API() async {
    final books = await call_api.getBill_supply_List(query_bill_supply);

    setState(() => this.BillSupplyData = books);
    // print(VendorsData);
  }

  Future bill_supply_list_search_API(String query) async {
    final books = await call_api.getBill_supply_List(query);

    if (!mounted) return;

    setState(() {
      this.query_bill_supply = query;
      this.BillSupplyData = books;
    });
  }

  Widget build_bill_supply_Search() {
    return SearchWidget(
      text: query_bill_supply,
      hintText: 'Search Here',
      onChanged: bill_supply_list_search_API,
    );
  }

  Future build_bill_supply_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/bill-of-supply/$selected_billSupply/null/null';

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      bill_supply_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget bill_supply_list() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_Delivery_challan_Search()),
                Container(
                  margin: EdgeInsets.only(right: 12.0, left: 12.0),
                  child: Container(
                      margin: EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        AssetUtils.sort_Icons,
                        height: 17.0,
                        width: 19.83,
                      )),
                ),
                Container(
                  height: 34.0,
                  width: 34.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x17000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(right: 51),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AssetUtils.filter_Icons,
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(bottom: 80.0),
            itemCount: BillSupplyData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity:
                          VisualDensity(vertical: -4.0, horizontal: -4.0),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${BillSupplyData[index].billOfSupplyNumber}",
                        maxLines: 9,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Gilroy-Bold",
                          fontSize: 15.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      trailing: InkWell(
                        child: Container(
                          width: 20,
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: HexColor("#0B0D16"),
                          ),
                        ),
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        color: Color(0xff737373),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_billSupply =
                                                            BillSupplyData[
                                                                    index]
                                                                .id;
                                                      });
                                                      print(
                                                          selected_billSupply);
                                                      Get.to(
                                                          BillSupplyEditScreen(
                                                        bill_supply_id:
                                                            selected_billSupply,
                                                      ));
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.only(
                                                                right: 38,
                                                                left: 38,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_billSupply =
                                                            BillSupplyData[
                                                                    index]
                                                                .customer!
                                                                .id;
                                                      });
                                                      print(
                                                          selected_billSupply);
                                                      Get.to(
                                                          cash_bank_EditScreen(
                                                        customer_id:
                                                            selected_billSupply,
                                                      ));
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.only(
                                                                right: 38,
                                                                left: 38,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: Text(
                                                              'Receive Payment',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Change Priority',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Mark as complete',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: const Text(
                                                            'Change due date',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selected_billSupply =
                                                            BillSupplyData[
                                                                    index]
                                                                .id;
                                                      });
                                                      build_bill_supply_delete();
                                                      print(
                                                          selected_billSupply);
                                                    },
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            margin: EdgeInsets
                                                                .only(
                                                              top: 13,
                                                              bottom: 13,
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xffE74B3B),
                                                                  fontFamily:
                                                                      'GR'),
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                          setState(() {});
                        },
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${BillSupplyData[index].invoiceDate}",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-SemiBold",
                              fontWeight: FontWeight.w400,
                              color: HexColor("#BBBBC5"),
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 5.0, top: 0.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(BillSupplyData[index].totalAmt!.toDouble().toString()))}',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(BillSupplyData[index].balanceDue!.toDouble().toString()))}',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 5.0, top: 4.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Total Ammount',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
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

//==Cash Memo.........................................
  Future cash_memo_list_API() async {
    final books = await call_api.getCash_memo_List(query_cash_memo);

    setState(() => this.Cash_memo_Data = books);
    // print(Cash_memo_Data);
  }

  Future cash_memo_list_search_API(String query) async {
    final books = await call_api.getCash_memo_List(query);

    if (!mounted) return;

    setState(() {
      this.query_cash_memo = query;
      this.Cash_memo_Data = books;
    });
  }

  Widget build_cash_memo_Search() {
    return SearchWidget(
      text: query_cash_memo,
      hintText: 'Search Here',
      onChanged: cash_memo_list_search_API,
    );
  }

  Future cash_memo_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/cashmemo/$selected_cash_memo/null/null';

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      cash_memo_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget cash_memo_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_Delivery_challan_Search()),
              Container(
                margin: EdgeInsets.only(right: 12.0, left: 12.0),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AssetUtils.sort_Icons,
                      height: 17.0,
                      width: 19.83,
                    )),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(right: 51),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AssetUtils.filter_Icons,
                    height: 17,
                    width: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(bottom: 80.0),
          itemCount: Cash_memo_Data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ListTile(
                    visualDensity:
                        VisualDensity(vertical: -4.0, horizontal: -4.0),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "${Cash_memo_Data[index].srNumber}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Gilroy-Bold",
                        fontSize: 15.0,
                        color: HexColor("#0B0D16"),
                      ),
                    ),
                    trailing: InkWell(
                      child: Container(
                        width: 20,

                        child: Icon(
                          Icons.more_vert,
                          size: 30.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      onTap: () async {
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding:
                                        MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      color: Color(0xff737373),
                                      child: Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight:
                                                    Radius.circular(30)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected_cash_memo =
                                                        Cash_memo_Data[index]
                                                            .id;
                                                  });
                                                  print(selected_cash_memo);
                                                  Get.to(cash_memoEditScreen(
                                                    cash_memo_id:
                                                        selected_cash_memo,
                                                  ));
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 38,
                                                        left: 38,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff000000),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: Text(
                                                        'Change Priority',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: Text(
                                                        'Mark as complete',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: const EdgeInsets
                                                          .only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: const Text(
                                                        'Change due date',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected_cash_memo =
                                                        Cash_memo_Data[index]
                                                            .id;
                                                  });
                                                  cash_memo_delete();
                                                  print(selected_cash_memo);
                                                },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: const Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xffE74B3B),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                        setState(() {});
                      },
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "${Cash_memo_Data[index].invoiceDate}",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "Gilroy-SemiBold",
                            fontWeight: FontWeight.w400,
                            color: HexColor("#BBBBC5"),
                            fontSize: 12.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '₹ ${oCcy.format(double.parse(Cash_memo_Data[index].totalAmt!.toDouble().toString()))}',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13.0,
                              color: HexColor("#000000"),
                              fontFamily: "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Paid',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13.0,
                              color: HexColor("#000000"),
                              fontFamily: "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 4.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Total Ammount',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#BBBBC5"),
                              fontFamily: "GR",
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
    ));
  }

//==Proforma Invoice........................................
  Future proforma_invoice_list_API() async {
    final books =
        await call_api.getProforma_invoice_List(query_proforma_invoice);

    setState(() => this.ProformaInvoice_Data = books);
    print(ProformaInvoice_Data);
  }

  Future proforma_invoice_search_API(String query) async {
    final books = await call_api.getProforma_invoice_List(query);

    if (!mounted) return;

    setState(() {
      this.query_proforma_invoice = query;
      this.ProformaInvoice_Data = books;
    });
  }

  Widget build_proforma_invoice_Search() {
    return SearchWidget(
      text: query_proforma_invoice,
      hintText: 'Search Here',
      onChanged: proforma_invoice_search_API,
    );
  }

  Future proforma_invoice_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/proforma-invoice/$selected_proforma_invoice';

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      proforma_invoice_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget proforma_invoice_list() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(child: build_Delivery_challan_Search()),
                Container(
                  margin: EdgeInsets.only(right: 12.0, left: 12.0),
                  child: Container(
                      margin: EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        AssetUtils.sort_Icons,
                        height: 17.0,
                        width: 19.83,
                      )),
                ),
                Container(
                  height: 34.0,
                  width: 34.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x17000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.only(right: 51),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AssetUtils.filter_Icons,
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 80.0),
            scrollDirection: Axis.vertical,
            itemCount: ProformaInvoice_Data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity:
                          VisualDensity(vertical: -4.0, horizontal: -4.0),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${ProformaInvoice_Data[index].invoiceNumber}",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Gilroy-Bold",
                          fontSize: 15.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      trailing: InkWell(
                        child: Container(
                          width: 20,
                          child: Icon(
                            Icons.more_vert,
                            size: 30.0,
                            color: HexColor("#0B0D16"),
                          ),
                        ),
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        color: Color(0xff737373),
                                        child: Container(
                                          height: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selected_proforma_invoice =
                                                          ProformaInvoice_Data[
                                                                  index]
                                                              .id;
                                                    });
                                                    Get.to(proformaEditScreen(
                                                      proforma_id:
                                                          selected_proforma_invoice,
                                                    ));
                                                    print(
                                                        selected_proforma_invoice);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 38,
                                                        left: 38,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: Text(
                                                          'Change Priority',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff000000),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 38,
                                                        left: 38,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: Text(
                                                          'Mark as complete',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff000000),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 38,
                                                        left: 38,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: const Text(
                                                          'Change due date',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff000000),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selected_proforma_invoice =
                                                          ProformaInvoice_Data[
                                                                  index]
                                                              .id;
                                                    });
                                                    proforma_invoice_delete();
                                                    print(
                                                        selected_proforma_invoice);
                                                  },
                                                  child: Container(
                                                      margin: const EdgeInsets
                                                              .only(
                                                          right: 38,
                                                          left: 38,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff3f3f3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 13,
                                                            bottom: 13,
                                                          ),
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xffE74B3B),
                                                                fontFamily:
                                                                    'GR'),
                                                          ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                          setState(() {});
                        },
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${ProformaInvoice_Data[index].invoiceDate}",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy-SemiBold",
                              fontWeight: FontWeight.w400,
                              color: HexColor("#BBBBC5"),
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 5.0, top: 0.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '₹ ${oCcy.format(double.parse(ProformaInvoice_Data[index].totalAmt!.toDouble().toString()))}',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Paid',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13.0,
                                color: HexColor("#000000"),
                                fontFamily: "Gilroy-SemiBold",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 5.0, top: 4.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Total Ammount',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#BBBBC5"),
                                fontFamily: "GR",
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

//==Estimate.........................................
  Future Estimate_invoice_list_API() async {
    final books =
        await call_api.getEstimate_invoice_List(query_estimate_invoice);

    setState(() => this.EstimateInvoice_Data = books);
    print(ProformaInvoice_Data);
  }

  Future Estimate_invoice_search_API(String query) async {
    final books = await call_api.getEstimate_invoice_List(query);

    if (!mounted) return;

    setState(() {
      this.query_estimate_invoice = query;
      this.EstimateInvoice_Data = books;
    });
  }

  Widget build_Estimate_invoice_Search() {
    return SearchWidget(
      text: query_estimate_invoice,
      hintText: 'Search Here',
      onChanged: Estimate_invoice_search_API,
    );
  }

  Future estimate_invoice_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/estimate-invoice/$selected_estimate_invoice';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Estimate_invoice_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget Estimate_invoice_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_Delivery_challan_Search()),
              Container(
                margin: EdgeInsets.only(right: 12.0, left: 12.0),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AssetUtils.sort_Icons,
                      height: 17.0,
                      width: 19.83,
                    )),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(right: 51),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AssetUtils.filter_Icons,
                    height: 17,
                    width: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 80.0),
          scrollDirection: Axis.vertical,
          itemCount: EstimateInvoice_Data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ListTile(
                    visualDensity:
                        VisualDensity(vertical: -4.0, horizontal: -4.0),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "${EstimateInvoice_Data[index].invoiceNumber}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Gilroy-Bold",
                        fontSize: 15.0,
                        color: HexColor("#0B0D16"),
                      ),
                    ),
                    trailing: InkWell(
                      child: Container(
                        width: 20,
                        child: Icon(
                          Icons.more_vert,
                          size: 30.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      onTap: () async {
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding:
                                        MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      color: Color(0xff737373),
                                      child: Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight:
                                                    Radius.circular(30)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected_estimate_invoice =
                                                        EstimateInvoice_Data[
                                                                index]
                                                            .id;
                                                  });
                                                  Get.to(estimateEditScreen(
                                                    estimate_id:
                                                        selected_estimate_invoice,
                                                  ));
                                                  print(
                                                      selected_estimate_invoice);
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 38,
                                                        left: 38,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff000000),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: Text(
                                                        'Change Priority',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: Text(
                                                        'Mark as complete',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: const EdgeInsets
                                                          .only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: const Text(
                                                        'Change due date',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected_estimate_invoice =
                                                        EstimateInvoice_Data[
                                                                index]
                                                            .id;
                                                  });
                                                  estimate_invoice_delete();
                                                  print(
                                                      selected_estimate_invoice);
                                                },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: const Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xffE74B3B),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                        setState(() {});
                      },
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "${EstimateInvoice_Data[index].invoiceDate}",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "Gilroy-SemiBold",
                            fontWeight: FontWeight.w400,
                            color: HexColor("#BBBBC5"),
                            fontSize: 12.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '₹ ${oCcy.format(double.parse(EstimateInvoice_Data[index].totalAmt!.toDouble().toString()))}',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13.0,
                              color: HexColor("#000000"),
                              fontFamily: "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Paid',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: HexColor("#000000"),
                              fontFamily: "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 4.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Total Ammount',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#BBBBC5"),
                              fontFamily: "GR",
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
    ));
  }

//==Delivery-Challan.........................................
  Future Delivery_challan_list_API() async {
    final books =
        await call_api.getDelivery_challan_List(query_delivery_challan);

    setState(() => this.Delivery_challan_Data = books);
    print(Delivery_challan_Data);
  }

  Future Delivery_challan_search_API(String query) async {
    final books = await call_api.getDelivery_challan_List(query);

    if (!mounted) return;

    setState(() {
      this.query_delivery_challan = query;
      this.Delivery_challan_Data = books;
    });
  }

  Widget build_Delivery_challan_Search() {
    return SearchWidget(
      text: query_delivery_challan,
      hintText: 'Search Here',
      onChanged: Delivery_challan_search_API,
    );
  }

  Future delivery_challan_delete() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url =
        'https://www.magnetbackend.fsp.media/api/delivery-challan/$selected_delivery_challan';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(json.decode(response.body.replaceAll('}[]', '}')));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Delivery_challan_list_API();
      return json.decode(response.body);
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

  Widget Delivery_challan_list() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(right: 15, top: 0, left: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(child: build_Delivery_challan_Search()),
              Container(
                margin: EdgeInsets.only(right: 12.0, left: 12.0),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AssetUtils.sort_Icons,
                      height: 17.0,
                      width: 19.83,
                    )),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(right: 51),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AssetUtils.filter_Icons,
                    height: 17,
                    width: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 80.0),
          scrollDirection: Axis.vertical,
          itemCount: Delivery_challan_Data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ListTile(
                    visualDensity:
                        VisualDensity(vertical: -4.0, horizontal: -4.0),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "${Delivery_challan_Data[index].challanNumber}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Gilroy-Bold",
                        fontSize: 15.0,
                        color: HexColor("#0B0D16"),
                      ),
                    ),
                    trailing: InkWell(
                      child: Container(
                        width: 20,
                        child: Icon(
                          Icons.more_vert,
                          size: 30.0,
                          color: HexColor("#0B0D16"),
                        ),
                      ),
                      onTap: () async {
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding:
                                        MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      color: Color(0xff737373),
                                      child: Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight:
                                                    Radius.circular(30)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected_delivery_challan =
                                                        Delivery_challan_Data[
                                                                index]
                                                            .id;
                                                  });
                                                  Get.to(deliveryChallanEditScreen(
                                                      delivery_challan_id:
                                                          selected_delivery_challan));
                                                  print(
                                                      selected_delivery_challan);
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 38,
                                                        left: 38,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff000000),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: Text(
                                                        'Change Priority',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: Text(
                                                        'Mark as complete',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xfff3f3f3),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10)),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: const EdgeInsets
                                                          .only(
                                                        top: 13,
                                                        bottom: 13,
                                                      ),
                                                      child: const Text(
                                                        'Change due date',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily: 'GR'),
                                                      ))),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected_delivery_challan =
                                                        Delivery_challan_Data[
                                                                index]
                                                            .id;
                                                  });
                                                  delivery_challan_delete();
                                                  print(
                                                      selected_delivery_challan);
                                                },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 38,
                                                            left: 38,
                                                            bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin:
                                                            EdgeInsets.only(
                                                          top: 13,
                                                          bottom: 13,
                                                        ),
                                                        child: const Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xffE74B3B),
                                                              fontFamily:
                                                                  'GR'),
                                                        ))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                        setState(() {});
                      },
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "${Delivery_challan_Data[index].challanDate}",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "Gilroy-SemiBold",
                            fontWeight: FontWeight.w400,
                            color: HexColor("#BBBBC5"),
                            fontSize: 12.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '₹ ${oCcy.format(double.parse(Delivery_challan_Data[index].totalAmt!.toDouble().toString()))}',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13.0,
                              color: HexColor("#000000"),
                              fontFamily: "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Paid',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: HexColor("#000000"),
                              fontFamily: "Gilroy-SemiBold",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0, top: 4.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Total Ammount',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#BBBBC5"),
                              fontFamily: "GR",
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Text(
                        //     'Due Ammount',
                        //     style: TextStyle(
                        //       fontSize: 11.0,
                        //       fontWeight: FontWeight.w600,
                        //       color: HexColor("#BBBBC5"),
                        //       fontFamily: "GR",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ));
  }
}
