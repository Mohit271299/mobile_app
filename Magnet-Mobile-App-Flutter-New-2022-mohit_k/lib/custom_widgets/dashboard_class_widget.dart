
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/custom_widgets/Drawer_class_widget.dart';
import 'package:magnet_update/screen/Sales_Listing_screen.dart';
import 'package:magnet_update/screen/homapage/home_page_screen.dart';
import 'package:magnet_update/model_class/dashboard_view_model.dart.dart';
import 'package:magnet_update/screen/Ledger_Listing_screen.dart';
import 'package:magnet_update/screen/Purchase_Listing_screen.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';

class DashboardPage extends StatefulWidget {
  @override
  int index;

  DashboardPage(this.index);

  int menuIndex = 0;

  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  DashBoardPageViewModel? model;

  Color _textColor = ColorUtils.black_light_Color;
  Color _textColor2 = ColorUtils.black_light_Color;
  String selectDrawerItem = 'Dashnoard';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    model ?? (model = DashBoardPageViewModel(this));
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      drawer: DrawerScreen(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.yellow,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(color: Colors.yellow),
                ),
            backgroundColor: Colors.yellow,
            shadowColor: Colors.yellow,
            dialogBackgroundColor: Colors.yellow,
          ),
          child: bottomNavigationBar(changeIndex)),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: getPage!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget? get getPage {
    if (model!.menuIndex == 0) {
      return DashBoardScreen();
    } else if (model!.menuIndex == 1) {
      return ledgerScreen();
      // return StoreDetailPage(changeIndex);
    } else if (model!.menuIndex == 2) {
      return salesScreen();
      // return StoreDetailPage(changeIndex);
    } else if (model!.menuIndex == 3) {
      return purchaseScreen();
      //return ProfilePage(changeIndex);
    } else if (model!.menuIndex == 4) {
      return DashBoardScreen();
    } else if (model!.menuIndex == 5) {
      return DashBoardScreen();
    }
  }

  changeIndex(int index) {
    setState(() {
      model!.menuIndex = index;
    });
  }

  Widget bottomNavigationBar(changeIndex) {
    return Container(
      color: HexColor("#F3F3F3"),
      child: Container(
        height: 70,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                changeIndex.call(0);
                setState(() {
                  model!.menuIndex = 0;
                });
              },
              child: Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 0)
                            ? AssetUtils.selectHome
                            : AssetUtils.unselectHome,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 0)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeIndex.call(1);
                setState(() {
                  model!.menuIndex = 1;
                });
              },
              child: Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 1)
                            ? AssetUtils.selectLedger
                            : AssetUtils.unselectLedger,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Ledger",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 1)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeIndex.call(2);
                setState(() {
                  model!.menuIndex = 2;
                });
              },
              child: Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 2)
                            ? AssetUtils.selectSales
                            : AssetUtils.unselectSales,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Sales",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 2)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeIndex.call(3);
                setState(() {
                  model!.menuIndex = 3;
                });
              },
              child: Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 3)
                            ? AssetUtils.selectPurchase
                            : AssetUtils.unselectPurchase,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Purchase",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 3)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                changeIndex.call(4);
                setState(() {
                  model!.menuIndex = 4;
                });
              },
              child: Container(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        (model!.menuIndex == 4)
                            ? AssetUtils.selectMore
                            : AssetUtils.unselectMore,
                        height: 35.0,
                        width: 35.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "More",
                      style: TextStyle(
                        fontFamily: "GB",
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: (model!.menuIndex == 4)
                            ? HexColor("#3B7AF1")
                            : HexColor("#BBBBC5"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        //
      ),
    );
  }
}
