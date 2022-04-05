import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common/Texts.dart';
import '../../../common/common_color.dart';
import '../../../common/common_image.dart';
import '../../../common/common_style.dart';
import '../../../common/common_textformfield.dart';
import '../../../common/common_widget.dart';
import '../../contact_mohit/ui/contact_add_screen.dart';
import '../../sales/ui/sales_select_customer.dart';
import '../controller/ActivityController.dart';
import 'activity_add.dart';
import 'activity_select_customer.dart';

class Select_activityTaskType extends StatefulWidget {
  const Select_activityTaskType({Key? key}) : super(key: key);

  @override
  _Select_activityTaskTypeState createState() => _Select_activityTaskTypeState();
}

class _Select_activityTaskTypeState extends State<Select_activityTaskType> {

  final TextEditingController searchController = TextEditingController();
  final activityController = Get.put(ActivityController());

  @override
  void initState() {
    activityController.getAllActivityType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                    "Select Task Type",
                    style: dialogTitleStyle(),
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
            Obx(() => (activityController.isactivityTaskLoading.value != true)
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 15.0, right: 15.0),
                    itemCount:
                        (activityController.isactivityTaskLoading.value == true
                            ? 5
                            : activityController
                                .getAllActivityTypeModel!.data!.length),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 4/3,
                      mainAxisExtent: 63,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0))),
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, state) {
                                  return ActivityselectCustomer(
                                    taskType_name:
                                        '${activityController.getAllActivityTypeModel!.data![index].type}',
                                    taskType_id: activityController.getAllActivityTypeModel!.data![index].id.toString(),
                                  );
                                },
                              );
                            },
                          );

                          // Get.to(AddActivity(
                          //   taskType_name:
                          //   '${activityController.getAllActivityTypeModel!
                          //       .data![index].type}',
                          // ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: HexColor(CommonColor.blockBackColor),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                CommonImage.date_icon,
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${activityController.getAllActivityTypeModel!.data![index].type}',
                                style: estimateLabelStyle(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : CommonWidget().ListviewListingBuilder(
                    context: context,
                    getItemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return CommonWidget().showShimmer(
                          leftM: 10,
                          rightM: 10,
                          bottomM: 15.0,
                          shimmerHeight: 100);
                    },
                  )),
            // CommonWidget().ListviewListingBuilder(
            //   context: context,
            //   getItemCount: type.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return InkWell(
            //       onTap: () {
            //         Navigator.pop(context);
            //         print(type[index].name);
            //         Get.to(ContactAddScreen(contact_type: type[index].name,));
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         margin: const EdgeInsets.only(bottom: 15.0),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border.all(
            //               color: HexColor(
            //                 CommonColor.dialogBorderColor,
            //               ),
            //               width: 2.0),
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //         width: screenWidth,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             Flexible(
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                     left: 18.0, top: 18.0, bottom: 18.0),
            //                 child: Text(
            //                   type[index].name,
            //                   maxLines: 2,
            //                   style: cartNameStyle(),
            //                 ),
            //               ),
            //             ),
            //
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
