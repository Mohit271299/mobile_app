import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/drawer/ui/drawerscreen.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late double screenHeight, screenWidth;
  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor(CommonColor.appActiveColor),
        onPressed: () => gotoAddContactScreen(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      key: _globalKey,
      drawer: DrawerScreen(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor(CommonColor.appBackColor),
        leading: InkWell(
          onTap: () => _globalKey!.currentState!.openDrawer(),
          child: CommonWidget().appBarLeading(appTitle: '', context: context),
        ),
        actions: [
          CommonWidget().appBarAction(),
        ],
      ),
      backgroundColor: HexColor(CommonColor.appBackColor),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                splashColor: HexColor(CommonColor.appBackColor),
                focusColor: HexColor(CommonColor.appBackColor),
                highlightColor: HexColor(CommonColor.appBackColor),
                hoverColor: HexColor(CommonColor.appBackColor),
                onTap: () => CommonWidget().hideFocusKeyBoard(context),
                child: Container(
                  width: screenWidth,
                  child: Text(Texts.contact, style: screenHeader()),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (screenHeight * 0.29).ceilToDouble(),
                    child: CommonTextFieldSearch(
                      controller: searchController,
                      validator: (value) {},
                      icon: CommonImage.search_icon,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      hintText: Texts.search_hint,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  CommonWidget().filterAndSortCard(
                    context: context,
                    onTap: () {},
                    itemIcon: CommonImage.sort_icons,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  CommonWidget().filterAndSortCard(
                    context: context,
                    onTap: () {},
                    itemIcon: CommonImage.filter_icons,
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              CommonWidget().ListviewListing(
                context: context,
                getItemCount: 5,
                getWidets: CommonWidget().listingCardDesign(
                  context: context,
                  getWidget: Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 12.0, right: 12.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('#112', style: cartIdDateStyle()),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child:
                                  Text('20/02/2022', style: cartIdDateStyle()),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Devang Vadaliya',
                                maxLines: 1,
                                style: cartNameStyle(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '₹12112123',
                                  maxLines: 1,
                                  style: cartNameStyle(),
                                ),
                                const SizedBox(
                                  width: 18.0,
                                ),
                                const InkWell(
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: screenWidth / 3,
                              child: Text(
                                '9998979695',
                                style: cartMobileNumberStyle(),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 2,
                              child: CommonWidget().GridViewBlockListing(
                                crossAxisSpacingSize: 4,
                                context: context,
                                getCrossCount: 3,
                                getItemCount: 3,
                                mainAxisExtentSize: 33,
                                mainAxisSpacingSize: 5,
                                getWidets: Container(
                                  alignment: Alignment.center,
                                  height: 16.0,
                                  width: 38.0,
                                  decoration: BoxDecoration(
                                    color: HexColor(CommonColor.blockBackColor),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    '1002',
                                    style: cartBlockStyle(),
                                  ),
                                ),
                              ),
                              // child: GridView.builder(
                              //   shrinkWrap: true,
                              //   itemCount: 5,
                              //   physics:  const NeverScrollableScrollPhysics(),
                              //   scrollDirection: Axis.vertical,
                              //   gridDelegate: const
                              //       SliverGridDelegateWithFixedCrossAxisCount(
                              //       crossAxisCount: 3,
                              //       mainAxisExtent: 33,
                              //       crossAxisSpacing: 4,
                              //       mainAxisSpacing: 5,
                              //   ),
                              //   itemBuilder: (context, index) {
                              //     return Text('2');
                              //   },
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
