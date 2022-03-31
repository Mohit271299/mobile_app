import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tring/model/user_model.dart';
import 'package:tring/screens/authentication/login/ui/login.dart';
import 'package:tring/screens/initialization/project_preview.dart';
import 'package:tring/utils/styling.dart';

class createUser extends StatefulWidget {
  const createUser({Key? key}) : super(key: key);

  @override
  _createUserState createState() => _createUserState();
}

class _createUserState extends State<createUser> {
  final _formkey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // var unitcontroller = [];

  List<String> images = [
    "assets1/house.png",
    "assets1/shop_selected.png",
    "assets1/office_selected.png",
    "assets1/Appartment_selected.png",
  ];

  bool appartment = false;
  bool shop = false;
  bool office = false;

  TextEditingController totaltowercontroller = new TextEditingController();

  List<int> tower_items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];


  // TextEditingController controller = new TextEditingController();

  List<TextEditingController> _unit_controllers = [];
  List<TextEditingController> _floor_controllers = [];
  List<TextField> unit_fields = [];
  List<TextField> floor_fields = [];

  String dropdownValue = 'One';

  List<int> list_items = [1, 2, 3, 4, 5];
  List items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List tempitems = [];
  String _selectedGender = '0';
  String _selectedvalue = '0';

  int _startPoint = 0;
  int _endPoint = 0;

  List<String> list_alphabet = [
    "#",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  String _startalpha = 'A';
  int _counter = 1;

  unitSeries() {
    return Container(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.7 - 20,
            margin: EdgeInsets.only(top: 25, left: 18),
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // DropdownButton(
                  //   value: _startTower,
                  //   selectedItemBuilder: (BuildContext context) {
                  //     return list_items.map<Widget>((int item) {
                  //       return Container(
                  //           alignment: Alignment.center, child: Text('$item'));
                  //     }).toList();
                  //   },
                  //   items: list_items.map((int item) {
                  //     return DropdownMenuItem<int>(
                  //       child: Text('$item'),
                  //       value: item,
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _startTower = value as int;
                  //     });
                  //   },
                  //   hint: Text(
                  //     "End",
                  //     style: const TextStyle(fontSize: 10),
                  //   ),
                  //   elevation: 8,
                  // ),
                  NumberPicker(
                    value: _startPoint,
                    itemHeight: 16,
                    itemWidth: 20,
                    minValue: 0,
                    maxValue: 10,
                    step: 1,
                    haptics: true,
                    onChanged: (value) {
                      setState(() {
                        _startPoint = value;
                      });
                    },
                    textStyle: const TextStyle(
                      color: Color(0xff9d9d9d),
                      fontSize: 14.0,
                    ),
                    selectedTextStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff007DEF),
                      fontSize: 16.5,
                    ),
                  ),
                  // DropdownButton(
                  //   value: _endTower,
                  //   selectedItemBuilder: (BuildContext context) {
                  //     return list_items.map<Widget>((int item) {
                  //       return Container(
                  //           alignment: Alignment.center, child: Text('$item'));
                  //     }).toList();
                  //   },
                  //   items: list_items.map((int item) {
                  //     return DropdownMenuItem<int>(
                  //       child: Text('$item'),
                  //       value: item,
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _endTower = value as int;
                  //     });
                  //   },
                  //   hint: Text(
                  //     "End",
                  //     style: const TextStyle(fontSize: 10),
                  //   ),
                  //   elevation: 8,
                  // ),
                  Container(
                    child: NumberPicker(
                      value: _endPoint,
                      itemHeight: 15,
                      itemWidth: 20,
                      minValue: 0,
                      maxValue: 10,
                      step: 1,
                      haptics: true,
                      onChanged: (int value) {
                        setState(() {
                          _endPoint = value;
                        });
                      },
                      textStyle: const TextStyle(
                        color: Color(0xff9d9d9d),
                        fontSize: 12.0,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff007DEF),
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.7 - 20,
            margin: EdgeInsets.only(top: 25, left: 18),
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              alignment: Alignment.center,
              child: DropdownButton(
                value: _startalpha,
                selectedItemBuilder: (BuildContext context) {
                  return list_alphabet.map<Widget>((String item) {
                    return Container(
                        alignment: Alignment.center, child: Text('$item'));
                  }).toList();
                },
                items: list_alphabet.map((item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startalpha = value as String;
                  });
                },
                hint: Text(
                  "Start",
                  style: const TextStyle(fontSize: 10),
                ),
                elevation: 8,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 16, right: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0), color: Colors.red),
            child: Container(
              margin: EdgeInsets.all(6.33),
              child: Icon(
                Icons.clear,
                color: Color(0xffFFFFFF),
                size: 10.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  unitCustom() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 25, left: 18),
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: TextFormField(
                // controller: totaltowercontroller1,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Building/Tower - 1',
                  labelStyle: TextStyle(
                    color: Color(0xff828282),
                    fontSize: 12.0,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xff485056),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, left: 16, right: 18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0), color: Colors.red),
          child: Container(
            margin: EdgeInsets.all(6.33),
            child: Icon(
              Icons.clear,
              color: Color(0xffFFFFFF),
              size: 10.0,
            ),
          ),
        )
      ],
    );
  }

  int floor_count = 0;
  int flat_count = 0;

  floorSeries_setup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  _unit_controllers.add(new TextEditingController());
                  return Container(
                      margin: EdgeInsets.only(top: 25, left: 18),
                      decoration: BoxDecoration(
                        color: Color(0xffE5E5E5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            focusedBorder: textfeild.box_focus_style,
                            contentPadding: EdgeInsets.only(top: 0,left: 15),
                            labelText: 'Unit ${items[index]}',
                            labelStyle: textfeild.lable_style,
                            border: InputBorder.none,
                          ),
                          style: textfeild.text_style,
                          textAlign: TextAlign.start,
                          controller: _unit_controllers[index],
                          autofocus: false,
                          keyboardType: TextInputType.number,
                        ),
                      ));
                },
              ),
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      _floor_controllers.add(new TextEditingController());
                      return Container(
                          margin: EdgeInsets.only(top: 25, left: 18,right:18),
                          decoration: BoxDecoration(
                            color: Color(0xffE5E5E5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  floor_count = int.parse(value);
                                });
                              },
                              decoration: InputDecoration(
                                focusedBorder: textfeild.box_focus_style,
                                contentPadding: EdgeInsets.only(top: 0,left: 15),
                                labelText: 'Floor',
                                labelStyle: textfeild.lable_style,
                                border: InputBorder.none,
                              ),
                              style: textfeild.text_style,
                              textAlign: TextAlign.start,
                              controller: _floor_controllers[index],
                              autofocus: false,
                              keyboardType: TextInputType.number,
                            ),
                          ));
                    }))
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            String flatTower = _unit_controllers
                .where((element) => element.text != "")
                .fold("", (acc, element) => acc += "${element.text}\n");

            String flatFloor = _floor_controllers
                .where((element) => element.text != "")
                .fold("", (acc, element) => acc += "${element.text}\n");

            final alert = AlertDialog(
              title: Text(
                  "Countunit: ${_unit_controllers.length}\n  Countfloor: ${_floor_controllers.length}"),
              content: Row(
                children: [
                  Text("${flatTower.trim()} -- "),
                  Text(flatFloor.trim()),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
            await showDialog(
              context: context,
              builder: (BuildContext context) => alert,
            );
            setState(() {});
          },
          child: Text("OK"),
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     String textunit = _unit_controllers
        //         .where((element) => element.text != "")
        //         .fold("", (acc, element) => acc += "${element.text}\n");
        //
        //     String textfloor = _floor_controllers
        //         .where((element) => element.text != "")
        //         .fold("",
        //             (acc, element) => acc += "${int.parse(element.text)}\n");
        //
        //     final alert = AlertDialog(
        //       title: Text(
        //           "Countunit: ${_unit_controllers.length}\n  Countfloor: ${_floor_controllers.length}"),
        //       content: Row(
        //         children: [
        //           Text("${textunit.trim()} -- "),
        //           Text(textfloor.trim()),
        //         ],
        //       ),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: Text("OK"),
        //         ),
        //       ],
        //     );
        //     await showDialog(
        //       context: context,
        //       builder: (BuildContext context) => alert,
        //     );
        //     setState(() {});
        //   },
        //   child: Text("OK"),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     final controller1 = TextEditingController();
        //     final field1 = TextField(
        //       controller: controller1,
        //       decoration: InputDecoration(
        //         contentPadding: EdgeInsets.all(0.0),
        //         labelText: 'Unit${_unit_controllers.length + 1}',
        //         labelStyle: TextStyle(
        //           color: Color(0xff828282),
        //           fontSize: 12.0,
        //         ),
        //         border: InputBorder.none,
        //       ),
        //       style: const TextStyle(
        //         color: Color(0xff485056),
        //         fontSize: 16.0,
        //       ),
        //     );
        //     final controller2 = TextEditingController();
        //     final field2 = TextField(
        //       controller: controller2,
        //       keyboardType: TextInputType.number,
        //       decoration: InputDecoration(
        //         contentPadding: EdgeInsets.all(0.0),
        //         labelText: 'Floor${_floor_controllers.length + 1}',
        //         labelStyle: TextStyle(
        //           color: Color(0xff828282),
        //           fontSize: 12.0,
        //         ),
        //         border: InputBorder.none,
        //       ),
        //       style: const TextStyle(
        //         color: Color(0xff485056),
        //         fontSize: 16.0,
        //       ),
        //     );
        //
        //     setState(() {
        //       _unit_controllers.add(controller1);
        //       unit_fields.add(field1);
        //
        //       _floor_controllers.add(controller2);
        //       floor_fields.add(field2);
        //     });
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 15, left: 20, right: 18),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50.0),
        //         color: Color(0xff007DEF)),
        //     child: Container(
        //       margin: const EdgeInsets.all(6),
        //       child: const Icon(
        //         Icons.add,
        //         color: Color(0xffFFFFFF),
        //         size: 10,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
    //   Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //         margin: EdgeInsets.only(top: 25, left: 18),
    //         decoration: BoxDecoration(
    //           color: Color(0xffE5E5E5),
    //           borderRadius: BorderRadius.circular(10.0),
    //         ),
    //         child: Container(
    //           margin: const EdgeInsets.only(left: 15),
    //           child: TextFormField(
    //             controller: controller[k],
    //             keyboardType: TextInputType.number,
    //             decoration: const InputDecoration(
    //               contentPadding: EdgeInsets.all(0.0),
    //               labelText: 'Unit',
    //               labelStyle: TextStyle(
    //                 color: Color(0xff828282),
    //                 fontSize: 12.0,
    //               ),
    //               border: InputBorder.none,
    //             ),
    //             style: const TextStyle(
    //               color: Color(0xff485056),
    //               fontSize: 16.0,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: Container(
    //         margin: EdgeInsets.only(top: 25, left: 18),
    //         decoration: BoxDecoration(
    //           color: Color(0xffE5E5E5),
    //           borderRadius: BorderRadius.circular(10.0),
    //         ),
    //         child: Container(
    //           margin: const EdgeInsets.only(left: 15),
    //           child: TextFormField(
    //             // controller: totaltowercontroller1,
    //             keyboardType: TextInputType.number,
    //             decoration: const InputDecoration(
    //               contentPadding: EdgeInsets.all(0.0),
    //               labelText: 'Floor',
    //               labelStyle: TextStyle(
    //                 color: Color(0xff828282),
    //                 fontSize: 12.0,
    //               ),
    //               border: InputBorder.none,
    //             ),
    //             style: const TextStyle(
    //               color: Color(0xff485056),
    //               fontSize: 16.0,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       margin: const EdgeInsets.only(top: 25, left: 16, right: 18),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(50.0), color: Colors.red),
    //       child: Container(
    //         margin: EdgeInsets.all(6.33),
    //         child: Icon(
    //           Icons.clear,
    //           color: Color(0xffFFFFFF),
    //           size: 10.0,
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }

  List<TextEditingController> flat_tower_controller = [];
  List<TextEditingController> flat_floor_controller = [];
  List<TextEditingController> flat_flat_controller = [];
  List<TextField> flat_tower_feild = [];
  List<TextField> flat_floor_feild = [];

  flatseris_setup() {
    for (var i = 0; i <= items.length; i++) {
      flat_floor_controller = _floor_controllers;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext, int index) {
                    flat_tower_controller.add(new TextEditingController());
                    flat_flat_controller.add(new TextEditingController());
                    // flat_floor_controller.a

                    return Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: 18, right: 18, top: 7.5, bottom: 7.5),
                            decoration: BoxDecoration(
                              color: Color(0xffE5E5E5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  focusedBorder: textfeild.box_focus_style,
                                  contentPadding: EdgeInsets.only(top: 0,left: 15),
                                  labelText: 'Tower ${items[index]}',
                                  labelStyle: textfeild.lable_style,
                                  border: InputBorder.none,
                                ),
                                style: textfeild.text_style,
                                textAlign: TextAlign.start,
                                controller: flat_tower_controller[index],
                                autofocus: false,
                                keyboardType: TextInputType.number,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                left: 18, right: 18, top: 7.5, bottom: 7.5),
                            decoration: BoxDecoration(
                              color: Color(0xffE5E5E5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              child: TextField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 0,left: 15),
                                  labelText: 'Floor',
                                  labelStyle: textfeild.lable_style,
                                  border: InputBorder.none,
                                ),
                                style: textfeild.text_style,
                                textAlign: TextAlign.start,
                                controller: flat_floor_controller[index],
                                autofocus: false,
                                keyboardType: TextInputType.number,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                left: 18, right: 18, top: 7.5, bottom: 7.5),
                            decoration: BoxDecoration(
                              color: Color(0xffE5E5E5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              child: TextField(
                                onTap: () {
                                  int flats = int.parse(
                                      flat_flat_controller[index].text);
                                  int floors = int.parse(
                                      flat_floor_controller[index].text);
                                  int floors_flats = (flats * floors);
                                  print(floors_flats);
                                },
                                decoration: InputDecoration(
                                  focusedBorder: textfeild.box_focus_style,
                                  contentPadding: EdgeInsets.only(top: 0,left: 15),
                                  labelText: 'Flat / Floor',
                                  labelStyle: textfeild.lable_style,
                                  border: InputBorder.none,
                                ),
                                style: textfeild.text_style,
                                textAlign: TextAlign.start,
                                controller: flat_flat_controller[index],
                                autofocus: false,
                                keyboardType: TextInputType.number,
                              ),
                            )),
                        const Divider(color: Colors.black)
                      ],
                    );
                  }),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //       itemCount: items.length,
            //       itemBuilder: (BuildContext, int index) {
            //         flat_floor_controller.add(new TextEditingController());
            //         return Container(
            //             margin: EdgeInsets.only(top: 25, left: 18),
            //             decoration: BoxDecoration(
            //               color: Color(0xffE5E5E5),
            //               borderRadius: BorderRadius.circular(10.0),
            //             ),
            //             child: Container(
            //               margin: const EdgeInsets.only(left: 15),
            //               child: TextField(
            //                 decoration: InputDecoration(
            //                   contentPadding: EdgeInsets.all(0.0),
            //                   labelText: 'Floor ${flatFloor11.trim()}',
            //                   labelStyle: TextStyle(
            //                     color: Color(0xff828282),
            //                     fontSize: 12.0,
            //                   ),
            //                   border: InputBorder.none,
            //                 ),
            //                 style: const TextStyle(
            //                   color: Color(0xff485056),
            //                   fontSize: 16.0,
            //                 ),
            //                 textAlign: TextAlign.start,
            //                 controller: flat_floor_controller[index],
            //                 autofocus: false,
            //                 keyboardType: TextInputType.number,
            //               ),
            //             )
            //         );
            //       }
            //   ),
            // )
          ],
        ),
      ],
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Column(
    //       children: [
    //         Expanded(
    //           child: ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: flat_tower_feild.length,
    //             itemBuilder: (context, index) {
    //               return Container(
    //                 margin: EdgeInsets.only(top: 10, left: 18),
    //                 decoration: BoxDecoration(
    //                   color: Color(0xffE5E5E5),
    //                   borderRadius: BorderRadius.circular(10.0),
    //                 ),
    //                 child: Container(
    //                   margin: const EdgeInsets.only(left: 15),
    //                   child: flat_tower_feild[index],
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //         Expanded(
    //           child: ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: flat_floor_feild.length,
    //             itemBuilder: (context, index) {
    //               return Container(
    //                 margin: EdgeInsets.only(top: 10, left: 18),
    //                 decoration: BoxDecoration(
    //                   color: Color(0xffE5E5E5),
    //                   borderRadius: BorderRadius.circular(10.0),
    //                 ),
    //                 child: Container(
    //                   margin: const EdgeInsets.only(left: 15),
    //                   child: flat_floor_feild[index],
    //                 ),
    //               );
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //     ElevatedButton(
    //       onPressed: () async {
    //         String flatTower = flat_tower_controller
    //             .where((element) => element.text != "")
    //             .fold("", (acc, element) => acc += "${element.text}\n");
    //
    //         String flatFloor = flat_floor_controller
    //             .where((element) => element.text != "")
    //             .fold("",
    //                 (acc, element) => acc += "${int.parse(element.text)}\n");
    //
    //         final alert = AlertDialog(
    //           title: Text(
    //               "Countunit: ${_unit_controllers.length}\n  Countfloor: ${_floor_controllers.length}"),
    //           content: Row(
    //             children: [
    //               Text("${flatTower.trim()} -- "),
    //               Text(flatFloor.trim()),
    //             ],
    //           ),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text("OK"),
    //             ),
    //           ],
    //         );
    //         await showDialog(
    //           context: context,
    //           builder: (BuildContext context) => alert,
    //         );
    //         setState(() {});
    //       },
    //       child: Text("OK"),
    //     ),
    //     // GestureDetector(
    //     //   onTap: () {
    //     //     final controller1 = TextEditingController();
    //     //     final field1 = TextField(
    //     //       controller: controller1,
    //     //       decoration: InputDecoration(
    //     //         contentPadding: EdgeInsets.all(0.0),
    //     //         labelText: 'Tower${flat_tower_controller.length + 1}',
    //     //         labelStyle: TextStyle(
    //     //           color: Color(0xff828282),
    //     //           fontSize: 12.0,
    //     //         ),
    //     //         border: InputBorder.none,
    //     //       ),
    //     //       style: const TextStyle(
    //     //         color: Color(0xff485056),
    //     //         fontSize: 16.0,
    //     //       ),
    //     //     );
    //     //     final controller2 = TextEditingController();
    //     //     final field2 = TextField(
    //     //       controller: controller2,
    //     //       keyboardType: TextInputType.number,
    //     //       decoration: InputDecoration(
    //     //         contentPadding: EdgeInsets.all(0.0),
    //     //         labelText: 'Floor${flat_floor_controller.length + 1}',
    //     //         labelStyle: TextStyle(
    //     //           color: Color(0xff828282),
    //     //           fontSize: 12.0,
    //     //         ),
    //     //         border: InputBorder.none,
    //     //       ),
    //     //       style: const TextStyle(
    //     //         color: Color(0xff485056),
    //     //         fontSize: 16.0,
    //     //       ),
    //     //     );
    //     //
    //     //     setState(() {
    //     //       _unit_controllers.add(controller1);
    //     //       unit_fields.add(field1);
    //     //
    //     //       _floor_controllers.add(controller2);
    //     //       floor_fields.add(field2);
    //     //     });
    //     //   },
    //     //   child: Container(
    //     //     margin: const EdgeInsets.only(top: 15, left: 20, right: 18),
    //     //     decoration: BoxDecoration(
    //     //         borderRadius: BorderRadius.circular(50.0),
    //     //         color: Color(0xff007DEF)),
    //     //     child: Container(
    //     //       margin: const EdgeInsets.all(6),
    //     //       child: const Icon(
    //     //         Icons.add,
    //     //         color: Color(0xffFFFFFF),
    //     //         size: 10,
    //     //       ),
    //     //     ),
    //     //   ),
    //     // ),
    //   ],
    // );
  }

  void _increamentCounter() {
    setState(() {
      _counter++;
    });
  }

  void _increamentCounter2() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // as TextEditingController;
    totaltowercontroller.text = "10";
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value) {
    //   this.loggedInUser = UserModel.fromMap(value.data());
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    for (final controller in _unit_controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // String _selectedGender = '1';

  bool series = false;
  bool custom = false;

  bool userpage = true;
  bool addimage = false;
  bool typeproject = false;
  bool towerseries = false;
  bool towercustom = false;
  bool floorsetup = false;
  bool flatsetup = false;

  Widget user_entry() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            color: Color(0xffCCE5FC),
                            borderRadius: BorderRadius.circular(50)),
                        height: 51,
                        width: 51,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'Project Logo',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 18, right: 18, top: 30),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: TextFormField(
                            // controller: fnameController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              focusedBorder: textfeild.box_focus_style,
                              contentPadding: EdgeInsets.only(top: 0,left: 15),
                              labelText: 'Project Name ',
                              labelStyle: textfeild.lable_style,
                              border: InputBorder.none,
                            ),
                            style: textfeild.text_style,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 18, right: 18, top: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: TextFormField(
                            // controller: lnameController,
                            decoration: InputDecoration(
                              focusedBorder: textfeild.box_focus_style,
                              contentPadding: EdgeInsets.only(top: 0,left: 15),
                              labelText: 'Mobile number',
                              labelStyle: textfeild.lable_style,
                              border: InputBorder.none,
                            ),
                            style: textfeild.text_style,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 18, right: 18, top: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: TextFormField(
                            // controller: emailController,
                            decoration:  InputDecoration(
                              focusedBorder: textfeild.box_focus_style,
                              contentPadding: EdgeInsets.only(top: 0,left: 15),
                              labelText: 'Email Address',
                              labelStyle: textfeild.lable_style,
                              border: InputBorder.none,
                            ),
                            style: textfeild.text_style,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 18, right: 18, top: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: TextFormField(
                            // controller: passwordController,
                            decoration: InputDecoration(
                              focusedBorder: textfeild.box_focus_style,
                              contentPadding: EdgeInsets.only(top: 0,left: 15),
                              labelText: 'RERE number',
                              labelStyle: textfeild.lable_style,
                              border: InputBorder.none,
                            ),
                            style: textfeild.text_style
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 18, right: 18, top: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: TextFormField(
                            // controller: confirmpasswordController,
                            decoration:  InputDecoration(
                              focusedBorder: textfeild.box_focus_style,
                              contentPadding: EdgeInsets.only(top: 0,left: 15),
                              labelText: 'Confirm Password',
                              labelStyle: textfeild.lable_style,
                              border: InputBorder.none,
                            ),
                            style: textfeild.text_style
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                    height: 32,
                    decoration: BoxDecoration(
                        color: const Color(0xfff3f3f3),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 1, color: Color(0xff007DEF))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 9),
                      alignment: Alignment.center,
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff9d9d9d)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        userpage = false;
                        addimage = true;
                        typeproject = false;
                        towerseries = false;
                        towercustom = false;
                        floorsetup = false;
                        flatsetup = false;
                      });
                      addImage_page();
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xff007DEF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                        alignment: Alignment.center,
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 10, left: 10, top: 0, bottom: 30),
                  height: 32,
                  decoration: BoxDecoration(
                      color: const Color(0xfff3f3f3),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1, color: Color(0xff007DEF))),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'logout',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9d9d9d)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget addImage_page() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Project Images',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff007DEF), width: 1),
                borderRadius: BorderRadius.circular(6),
                color: Color(0xffCCE5FC)),
            margin: EdgeInsets.only(top: 32, left: 50),
            child: Container(
              margin: EdgeInsets.all(12),
              child: const Icon(
                Icons.add,
                color: Color(0xff007DEF),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Brochure',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff007DEF), width: 1),
                borderRadius: BorderRadius.circular(6),
                color: Color(0xffCCE5FC)),
            margin: EdgeInsets.only(top: 32, left: 50),
            child: Container(
              margin: EdgeInsets.all(12),
              child: const Icon(
                Icons.file_upload,
                color: Color(0xff007DEF),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xfff3f3f3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1, color: Color(0xff007DEF))),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  alignment: Alignment.center,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9d9d9d)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    userpage = false;
                    addimage = false;
                    typeproject = true;
                    towerseries = false;
                    towercustom = false;
                    floorsetup = false;
                    flatsetup = false;
                  });
                  type_project();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff007DEF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget type_project() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Select Project Type',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 64),
            child: const Text(
              'Please your project type to proccessed',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff007DEF),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 0, left: 72, right: 72),
              child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  children: [
                    Card(
                      elevation: 0,
                      child: GestureDetector(
                        child: Container(
                            decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets1/house.png'),
                          ),
                        )),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              appartment = true;
                              office = false;
                              shop = false;
                            });
                          },
                          child: (appartment == true)
                              ? Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets1/Appartment_selected.png'),
                                  ),
                                ))
                              : Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets1/Appartent_unselected.png'),
                                  ),
                                ))),
                    ),
                    Card(
                      elevation: 0,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              appartment = false;
                              office = true;
                              shop = false;
                            });
                          },
                          child: (office == true)
                              ? Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets1/office_selected.png'),
                                  ),
                                ))
                              : Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets1/office_unselected.png'),
                                  ),
                                ))),
                    ),
                    Card(
                      elevation: 0,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              appartment = false;
                              office = false;
                              shop = true;
                            });
                          },
                          child: (shop == true)
                              ? Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets1/shop_selected.png'),
                                  ),
                                ))
                              : Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets1/shop_unselected.png'),
                                  ),
                                ))),
                    ),
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xfff3f3f3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1, color: Color(0xff007DEF))),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  alignment: Alignment.center,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9d9d9d)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    userpage = false;
                    addimage = false;
                    typeproject = false;
                    towerseries = true;
                    towercustom = false;
                    floorsetup = false;
                    flatsetup = false;
                  });
                  series_tower();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff007DEF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget series_tower() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Tower Setup',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(left: 15),
              // child: SpinBox(
              //     value: 10,
              //     min: 1,
              //     max: 100,
              //     decoration: const InputDecoration(
              //       labelText: 'No. of Building/Tower',
              //       labelStyle: TextStyle(
              //         color: Color(0xff828282),
              //         fontSize: 14.0,
              //       ),
              //       focusedBorder: InputBorder.none,
              //       enabledBorder: InputBorder.none,
              //     ),
              //     textStyle: const TextStyle(
              //       color: Color(0xff485056),
              //       fontSize: 16.0,
              //     ),
              //     onChanged: (double value) {
              //       setState(() {
              //         onvalue <= value;
              //       });
              //     }),

              child: TextField(
                enabled: false,
                controller: totaltowercontroller,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  // labelText: 'Number of Building/Tower',
                  labelStyle: TextStyle(
                    color: Color(0xff828282),
                    fontSize: 12.0,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xff485056),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            child: const Text(
              'Select nameing series',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  groupValue: _selectedGender,
                  title: const Text('series'),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value as String;
                    });
                    series_tower();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => towerSetup_series_class()));
                  },
                  value: '0',
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  groupValue: _selectedGender,
                  title: const Text('custom'),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value as String;
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => towerSetup_custom_class()));
                    custom_tower();
                  },
                  value: '1',
                ),
              )
            ],
          ),
          for (var index = 1; index < _counter; index++) ...{unitSeries()},
          GestureDetector(
            onTap: () {
              _increamentCounter();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15, left: 20, right: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xff007DEF)),
              child: Container(
                margin: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.add,
                  color: Color(0xffFFFFFF),
                  size: 10,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xfff3f3f3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1, color: Color(0xff007DEF))),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  alignment: Alignment.center,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9d9d9d)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  userpage = false;
                  addimage = false;
                  typeproject = false;
                  towerseries = false;
                  towercustom = false;
                  floorsetup = true;
                  flatsetup = false;
                  setup_floor();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff007DEF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget custom_tower() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Tower Setup',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(left: 15),
              child: TextFormField(
                // controller: totaltowercontroller1,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Number of Building/Tower',
                  labelStyle: TextStyle(
                    color: Color(0xff828282),
                    fontSize: 12.0,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xff485056),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            child: const Text(
              'Select nameing series',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff485056)),
            ),
          ),
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  groupValue: _selectedvalue,
                  title: const Text('series'),
                  onChanged: (value) {
                    setState(() {
                      _selectedvalue = value as String;
                    });
                    series_tower();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => towerSetup_series_class()));
                  },
                  value: '0',
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  groupValue: _selectedvalue,
                  title: const Text('custom'),
                  onChanged: (value) {
                    setState(() {
                      _selectedvalue = value as String;
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => towerSetup_custom_class()));
                  },
                  value: '1',
                ),
              )
            ],
          ),
          for (var index = 1; index < _counter; index++) ...{unitCustom()},
          GestureDetector(
            onTap: () {
              _increamentCounter2();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15, left: 20, right: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xff007DEF)),
              child: Container(
                margin: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.add,
                  color: Color(0xffFFFFFF),
                  size: 10,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xfff3f3f3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1, color: Color(0xff007DEF))),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  alignment: Alignment.center,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9d9d9d)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setup_floor();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => floor_setup()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff007DEF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget setup_floor() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Floor Setup',
              style: TextStyle(
                  fontSize: 17, fontFamily: 'GB', color: Color(0xff485056)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, top: 25, right: 51),
            child: const Text(
              'Select/Create Floor count for one building/tower and the app will apply these count for all the buildings/towers',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GSB',
                  color: Color(0xff485056)),
            ),
          ),
          // for (int k = 1; k < _counter; k++) ...{
          //   floorSeries(),
          // },
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          floorSeries_setup(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xfff3f3f3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1, color: Color(0xff007DEF))),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  alignment: Alignment.center,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9d9d9d)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  userpage = false;
                  addimage = false;
                  typeproject = false;
                  towerseries = false;
                  towercustom = false;
                  floorsetup = false;
                  flatsetup = true;

                  setup_flat();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff007DEF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget setup_flat() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              'Flat Setup',
              style: TextStyle(
                  fontSize: 17, fontFamily: 'GB', color: Color(0xff485056)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, top: 25, right: 51),
            child: const Text(
              'Select/Create Floor count for one building/tower and the app will apply these count for all the buildings/towers',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'GSB',
                  color: Color(0xff485056)),
            ),
          ),
          flatseris_setup(),
          // Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Form(
          //         key: _formkey,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Column(
          //               children: [
          //                 Container(
          //                   margin:
          //                       EdgeInsets.only(left: 18, right: 18, top: 30),
          //                   decoration: BoxDecoration(
          //                     color: Color(0xffE5E5E5),
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: Container(
          //                     margin: const EdgeInsets.only(left: 20),
          //                     child: TextFormField(
          //                       // controller: fnameController,
          //                       textAlign: TextAlign.start,
          //                       decoration: const InputDecoration(
          //                         contentPadding: EdgeInsets.all(0.0),
          //                         hintText: 'Tower',
          //                         hintStyle: TextStyle(
          //                           color: Color(0xff828282),
          //                           fontSize: 12.0,
          //                         ),
          //                         border: InputBorder.none,
          //                       ),
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontSize: 12.0,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(
          //                       left: 18, right: 18, top: 20),
          //                   decoration: BoxDecoration(
          //                     color: Color(0xffE5E5E5),
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: Container(
          //                     margin: const EdgeInsets.only(left: 20),
          //                     child: TextFormField(
          //                       // controller: lnameController,
          //                       decoration: const InputDecoration(
          //                         contentPadding: EdgeInsets.all(0.0),
          //                         hintText: 'Floor',
          //                         hintStyle: TextStyle(
          //                           color: Color(0xff828282),
          //                           fontSize: 12.0,
          //                         ),
          //                         border: InputBorder.none,
          //                       ),
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontSize: 11.0,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(
          //                       left: 18, right: 18, top: 20),
          //                   decoration: BoxDecoration(
          //                     color: Color(0xffE5E5E5),
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: Container(
          //                     margin: const EdgeInsets.only(left: 20),
          //                     child: TextFormField(
          //                       // controller: emailController,
          //                       decoration: const InputDecoration(
          //                         contentPadding: EdgeInsets.all(0.0),
          //                         hintText: 'Flat',
          //                         hintStyle: TextStyle(
          //                           color: Color(0xff828282),
          //                           fontSize: 12.0,
          //                         ),
          //                         border: InputBorder.none,
          //                       ),
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontSize: 11.0,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(
          //                       left: 18, right: 18, top: 20),
          //                   decoration: BoxDecoration(
          //                     color: Color(0xffE5E5E5),
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: Container(
          //                     margin: const EdgeInsets.only(left: 20),
          //                     child: TextFormField(
          //                       // controller: passwordController,
          //                       decoration: const InputDecoration(
          //                         contentPadding: EdgeInsets.all(0.0),
          //                         hintText: 'BHK',
          //                         hintStyle: TextStyle(
          //                           color: Color(0xff828282),
          //                           fontSize: 12.0,
          //                         ),
          //                         border: InputBorder.none,
          //                       ),
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontSize: 11.0,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(
          //                       left: 18, right: 18, top: 20),
          //                   decoration: BoxDecoration(
          //                     color: Color(0xffE5E5E5),
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: Container(
          //                     margin: const EdgeInsets.only(left: 20),
          //                     child: TextFormField(
          //                       // controller: confirmpasswordController,
          //                       decoration: const InputDecoration(
          //                         contentPadding: EdgeInsets.all(0.0),
          //                         hintText: 'Square feet',
          //                         hintStyle: TextStyle(
          //                           color: Color(0xff828282),
          //                           fontSize: 12.0,
          //                         ),
          //                         border: InputBorder.none,
          //                       ),
          //                       style: const TextStyle(
          //                         color: Colors.black,
          //                         fontSize: 11.0,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Container(
          //               margin:
          //                   const EdgeInsets.only(top: 15, left: 20, right: 18),
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(50.0),
          //                   color: Color(0xff007DEF)),
          //               child: Container(
          //                 margin: const EdgeInsets.all(6),
          //                 child: const Icon(
          //                   Icons.add,
          //                   color: Color(0xffFFFFFF),
          //                   size: 10,
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // for (int k = 1; k < _counter; k++) ...{
          //   floorSeries(),
          // },
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 30, bottom: 30),
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xfff3f3f3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1, color: Color(0xff007DEF))),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  alignment: Alignment.center,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9d9d9d)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> projectpreview()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xff007DEF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget preview_project() {
    return Container(
      color: Color(0xff007DEF),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xfff3f3f3),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                margin: EdgeInsets.only(top: 97),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 40),
                      child: const Text(
                        'Project preview',
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'GB',
                            color: Color(0xff485056)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 38, right: 38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Total flats:${flat_count + flat_count}'),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 13),
                              child: Text('150'))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 38),
                      child: Text('Tower',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'GSB',
                              color: Color(0xff485056))),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                            margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                            child: Wrap(direction: Axis.horizontal, children: [
                              for (var index = 0; index < 7; index++) ...{
                                GestureDetector(
                                  onTap: () {
                                    print(index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 38, top: 15, right: 38),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      38, 9, 19, 9),
                                                  child: Text(
                                                    'A:',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      19, 9, 33, 9),
                                                  child: Text(
                                                    '25',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      38, 9, 19, 9),
                                                  child: Text(
                                                    'A:',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      19, 9, 33, 9),
                                                  child: Text(
                                                    '25',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              }
                            ]))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              right: 10, top: 30, bottom: 30),
                          height: 32,
                          decoration: BoxDecoration(
                              color: const Color(0xfff3f3f3),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1, color: Color(0xff007DEF))),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 9),
                            alignment: Alignment.center,
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9d9d9d)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginScreen()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 30, bottom: 30, left: 10),
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xff007DEF),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 9),
                              alignment: Alignment.center,
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff007DEF),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15))),
                    margin: EdgeInsets.only(top: 97),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 47, left: 20, right: 91),
                            child: const Text(
                              'Lets begin with project initialization',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          (userpage)
                              ? user_entry()
                              : (addimage
                                  ? addImage_page()
                                  : (typeproject
                                      ? type_project()
                                      : (towerseries
                                          ? series_tower()
                                          : (floorsetup
                                              ? setup_floor()
                                              : setup_flat()))))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(39.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                    height: 35,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffE5E5E5),
                        borderRadius: BorderRadius.all(Radius.circular(39.0)),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                      height: 7,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
                        margin: EdgeInsets.only(
                            right: (userpage)
                                ? 206
                                : (addimage
                                    ? 167
                                    : (typeproject
                                        ? 128
                                        : (towerseries
                                            ? 89
                                            : (towercustom
                                                ? 50
                                                : (floorsetup
                                                    ? 11
                                                    : (flatsetup ? 0 : 0))))))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const loginScreen()));
  }
}
