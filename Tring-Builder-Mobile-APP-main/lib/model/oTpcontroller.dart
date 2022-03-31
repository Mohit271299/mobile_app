import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:tring/screens/initialization/create_user.dart';

class oTpControllerScreen extends StatefulWidget {
  late final String phone;
  late final String codeDigits;

  oTpControllerScreen({required this.phone, required this.codeDigits});

  @override
  _oTpControllerScreenState createState() => _oTpControllerScreenState();
}

class _oTpControllerScreenState extends State<oTpControllerScreen> {

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();
  String? varification;

  final BoxDecoration pinOTPDecoration = BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey,

      )
  );

  @override
  void initState() {
    super.initState();
    verifyPhonenumber();
  }

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => createUser()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()),
            duration: Duration(seconds: 3),)
      );
    },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            varification= verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            varification = verificationId;
          });
        },
        timeout: Duration(seconds: 60)

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('OTP verification'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhonenumber();
                },
                child: Text(
                  "Verifying : ${widget.codeDigits}-${widget.phone}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),

                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(40),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25, color: Colors.white),
              eachFieldHeight: 55,
              eachFieldWidth: 40,
              focusNode: _pinOTPFocus,
              controller: _pinOTPController,
              submittedFieldDecoration: pinOTPDecoration,
              selectedFieldDecoration: pinOTPDecoration,
              followingFieldDecoration: pinOTPDecoration,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance.signInWithCredential(
                      PhoneAuthProvider.credential(
                          verificationId: varification!, smsCode: pin))
                      .then((value) {
                    if (value.user != null) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => createUser()));
                    }
                  });
                }
                catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('invalid otp'),
                        duration: Duration(seconds: 3),)
                  );
                }
              },

            ),)
        ],

      ),
    );
  }
}
