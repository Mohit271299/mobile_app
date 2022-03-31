import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tring/screens/activity/ui/activity_listing.dart';
import 'package:tring/screens/authentication/login/ui/login.dart';
import 'package:tring/screens/authentication/registration.dart';
import 'package:tring/screens/contact/ui/add_contact.dart';
import 'package:tring/screens/dashboard/ui/dashboard.dart';
import 'package:tring/screens/estimate/ui/estimate_list.dart';
import 'package:tring/screens/estimate/ui/estimate_show_customer_details.dart';
import 'package:tring/screens/estimate/ui/homeLoanScreen.dart';
import 'package:tring/screens/estimate/ui/otherChanges.dart';
import 'package:tring/screens/product/ui/product_add.dart';
import 'package:tring/screens/sales/ui/salesOthercharges/salesothercharges.dart';
import 'package:tring/screens/sales/ui/sales_list.dart';
import 'package:tring/screens/sales/ui/sales_show_customer_details.dart';
import 'package:tring/screens/sales/ui/saleshomeloan/saleshomeloan.dart';

import '../screens/contact_mohit/ui/contactm_listing.dart';
import '../screens/leads/ui/leads_listing.dart';
import '../screens/product/ui/Product_list.dart';
import '../screens/purchase/ui/purchases_list.dart';
import '../screens/purchase/ui/purchases_show_customer_details.dart';
import '../screens/tasks/ui/tasks_listing.dart';

gotoAddContactScreen(BuildContext context) {
  Get.to(const AddContact());
}

gotoContactScreen(BuildContext context) {
  Get.to(const ContactMList());
}

gotoOnChangesScreen(BuildContext context, {required int index}) {
  Get.to(
    OtherChanges(
      index: index,
    ),
  );
}

// gotoHomeLoanChangesScreen(BuildContext context) {
//   Get.to(const OtherChanges());
// }

gotoCustomerShowDetailScreen(
  BuildContext context, {
  required String customerName,
  required String customerMobileNo,
  required String estimateNo,
}) {
  Get.to(
    EstimateSelectCustomerDetails(
      customerName: customerName.toString(),
      customerMobileNo: customerMobileNo.toString(),
      customerEstimateNo: estimateNo.toString(),
    ),
  );
}

gotoSalesShowDetailScreen(BuildContext context,
    {required String name,
    required String mobileNumber,
    required String estimateNo}) {
  Get.to(SalesShowCustomerDetails(
    mobileNumber: mobileNumber,
    name: name,
    estimateNo: estimateNo,
  ));
}

gotoPurchaseShowDetailScreen(
  BuildContext context, {
  required String custNo,
  required String custName,
  required String custMobileNo,
  required String selectCustomerId,
}) {
  Get.to(
    PurchaseShowCustomerDetails(
      customerName: custName.toString(),
      customerMobileNo: custMobileNo.toString(),
      customerPurchaseNo: custNo.toString(),
      customerId: selectCustomerId.toString(),
    ),
  );
}

gotoSplashScreen() {
  Get.offAll(const loginScreen());
}

gotoHomeLoanScreen({required int indexs}) {
  Get.to(HomeLoadCharges(
    index: indexs,
  ));
}

gotoSalesListScreen(BuildContext context) {
  // Get.to( const SalesList());
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SalesList(),
    ),
  );
}

gotoPurcahsesListScreen(BuildContext context) {
  // Get.to( const SalesList());
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PurchasesList(),
    ),
  );
}

gotoProductListScreen(BuildContext context) {
  // Get.to( const SalesList());
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => const ProductsList(),
  //   ),
  // );
  Get.to(const ProductsList());
}

gotoTasksListScreen(BuildContext context) {
  // Get.to( const SalesList());
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => const ProductsList(),
  //   ),
  // );
  Get.to(const TasksList());
}

gotoLeadsListScreen(BuildContext context) {
  // Get.to( const SalesList());
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => const ProductsList(),
  //   ),
  // );
  Get.to(const LeadsList());
}

gotoAcvityListScreen(BuildContext context) {
  // Get.to( const SalesList());
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => const ProductsList(),
  //   ),
  // );
  Get.to(const ActivityList());
}

gotoEstimateListScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EstimateList(),
    ),
  );
}

gotoDashboardScreen(BuildContext context) {
  Get.offAll(const Dashboard());
}

gotoSignUpScreen() {
  Get.to(const registraionScreen());
}

gotoSalesOtherChargesScreen(BuildContext context) {
  Get.to(SalesOtherChanges(
    index: 0,
  ));
}

gotoSalesHomeLoanChargesScreen(BuildContext context) {
  Get.to(SalesHomeLoan(index: 0));
}

gotoAddProductScreen(BuildContext context) {
  Get.to(const AddProduct());
}
