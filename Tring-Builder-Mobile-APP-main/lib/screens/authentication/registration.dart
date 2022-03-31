import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tring/model/oTpcontroller.dart';
import 'package:tring/model/user_model.dart';
import 'package:tring/screens/initialization/create_user.dart';

class registraionScreen extends StatefulWidget {
  const registraionScreen({Key? key}) : super(key: key);

  @override
  _registraionScreenState createState() => _registraionScreenState();
}

class _registraionScreenState extends State<registraionScreen> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String dialCodedigits = "+00";

  final fnameController = new TextEditingController();
  final lnameController = new TextEditingController();
  final mobileController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmpasswordController = new TextEditingController();

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = fnameController.text;
    userModel.lastname = lnameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account created');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => createUser()),
        (route) => false);
  }

  sigUp(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: const Text(
                "Let's get Started",
                style: TextStyle(fontSize: 23),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Text(
                'Create an account to tring to get all the features',
                style: TextStyle(fontSize: 13, color: Color(0xff828282)),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 38, right: 38, top: 50),
                    decoration: BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: fnameController,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          hintText: 'First Name ',
                          hintStyle: TextStyle(
                            color: Color(0xff828282),
                            fontSize: 12.0,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: lnameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          hintText: 'Last Name',
                          hintStyle: TextStyle(
                            color: Color(0xff828282),
                            fontSize: 12.0,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ),

                  Container(
                      margin:
                          const EdgeInsets.only(left: 38, right: 38, top: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffE5E5E5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CountryCodePicker(
                            onChanged: (country) {
                              setState(() {
                                dialCodedigits = country.dialCode!;
                              });
                            },
                            initialSelection: "IN",
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            favorite: ["+1", "US", "+91", "IN"],
                          ),
                          Container(
                              height: 25,
                              child: VerticalDivider(color: Colors.black87)),
                          Expanded(
                            child: Container(
                              child: TextField(
                                maxLength: 10,
                                controller: mobileController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    counter: SizedBox.shrink(),
                                  contentPadding: EdgeInsets.all(0.0),
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                    color: Color(0xff828282),
                                    fontSize: 12.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                            color: Color(0xff828282),
                            fontSize: 12.0,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xff828282),
                            fontSize: 12.0,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffE5E5E5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: confirmpasswordController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: Color(0xff828282),
                            fontSize: 12.0,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                sigUp(emailController.text, passwordController.text);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => oTpControllerScreen(
                          phone: mobileController.text,
                          codeDigits: dialCodedigits,
                        )));

                // sigUp(emailController.text, passwordController.text);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 38, right: 38, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xff007DEF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: const Text(
                        'Secure SignUP',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
