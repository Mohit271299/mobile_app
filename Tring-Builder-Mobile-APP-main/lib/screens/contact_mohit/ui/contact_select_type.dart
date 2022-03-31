import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common/Texts.dart';
import '../../../common/common_color.dart';
import '../../../common/common_image.dart';
import '../../../common/common_style.dart';
import '../../../common/common_textformfield.dart';
import '../../../common/common_widget.dart';
import 'contact_add_screen.dart';

class SelectcontactType extends StatefulWidget {
  const SelectcontactType({Key? key}) : super(key: key);

  @override
  _SelectcontactTypeState createState() => _SelectcontactTypeState();
}

class _SelectcontactTypeState extends State<SelectcontactType> {
  List<contact_type> type = <contact_type>[
    const contact_type('Customer', 'CUSTOMER'),
    const contact_type('Vendor', 'VENDOR'),
    const contact_type('Contractor', 'CONTRACTOR'),
    const contact_type('Broker', 'BROKER'),
    const contact_type('Lead', 'LEAD'),
    const contact_type('Buyer', 'BUYER'),
    const contact_type('Seller', 'SELLER'),
    const contact_type('Buyer/Seller', 'BUYER_SALLER'),
    const contact_type('Investor', 'INVESTOR'),
    const contact_type('Agent', 'AGENT'),
    const contact_type('Other', 'OTHER'),
  ];

  final TextEditingController searchController = TextEditingController();

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
                   "Select Contact Type",
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
            CommonWidget().ListviewListingBuilder(
              context: context,
              getItemCount: type.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    print( type[index].name);
                    Get.to(ContactAddScreen(contact_type: type[index].name,));
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
                              type[index].name,
                              maxLines: 2,
                              style: cartNameStyle(),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class contact_type {
  const contact_type(this.name, this.value);

  final String name;
  final String value;
}
