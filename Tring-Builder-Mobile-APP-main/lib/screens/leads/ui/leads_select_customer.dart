import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common/Texts.dart';
import '../../../common/common_color.dart';
import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../../common/common_style.dart';
import '../../../common/common_textformfield.dart';
import '../../../common/common_widget.dart';
import '../controller/LeadsController.dart';
import 'leads_add_screen.dart';

class LeadsSelectCustomer extends StatefulWidget {
  const LeadsSelectCustomer({Key? key}) : super(key: key);

  @override
  _LeadsSelectCustomerState createState() => _LeadsSelectCustomerState();
}

class _LeadsSelectCustomerState extends State<LeadsSelectCustomer> {
  LeadsController leadsController = Get.put(
    LeadsController(),
    tag: LeadsController().toString(),
  );

  void initState() {
    super.initState();
    leadsController.getAllCustomerFromAPI();
  }

  late double screenHeight, screenWidth;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.757,
      width: screenWidth,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    Texts.SelectCustomer,
                    style: dialogTitleStyle(),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () => gotoAddContactScreen(context),
                    child: Text(
                      Texts.AddNewCustomer,
                      style: linkTextStyle(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            CommonTextFieldSearch(
              controller: searchController,
              validator: (value) {},
              icon: CommonImage.search_icon,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.search,
              hintText: Texts.search_hint,
            ),
            const SizedBox(
              height: 21.0,
            ),
            Obx(() => (leadsController.isCustomerLoading.value == false &&
                leadsController.getAllCustomerDetails
                    .toString()
                    .isNotEmpty &&
                leadsController.getAllCustomerDetails.toString() !=
                    'null' &&
                int.parse(leadsController
                    .getAllCustomerDetails!.data!.length
                    .toString()) !=
                    0 &&
                int.parse(leadsController
                    .getAllCustomerDetails!.data!.length
                    .toString()) >=
                    0)
                ? CommonWidget().ListviewListingBuilder(
              context: context,
              getItemCount:
              leadsController.getAllCustomerDetails!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(LeadsAddScreen());
                    // gotoSalesShowDetailScreen(
                    //   context,
                    //   estimateNo: '00',
                    //   mobileNumber: leadsController
                    //       .getAllCustomerDetails!.data![index].mobileNo
                    //       .toString(),
                    //   name: leadsController
                    //       .getAllCustomerDetails!.data![index].name
                    //       .toString(),
                    // );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: HexColor(
                            CommonColor.dialogBorderColor,
                          ),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 18.0, bottom: 18.0),
                            child: Text(
                              leadsController.getAllCustomerDetails!
                                  .data![index].name
                                  .toString(),
                              maxLines: 2,
                              style: cartNameStyle(),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, bottom: 18.0, right: 18.0),
                            child: Text(
                              leadsController.getAllCustomerDetails!
                                  .data![index].mobileNo
                                  .toString(),
                              style: cartMobileNumberStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : CommonWidget().ListviewListing(
              context: context,
              getItemCount: 16,
              getWidets: CommonWidget().showShimmer(
                shimmerHeight: 50,
                leftM: 0.0,
                rightM: 0.0,
                bottomM: 20.0,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
