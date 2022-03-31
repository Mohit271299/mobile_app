import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tring/screens/initialization/create_user.dart';
import 'package:tring/screens/authentication/registration.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  void logIn(String email, String password) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: 'Login succ;'),
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const createUser()))
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: const Text(
                'Welcome back!',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: const Text(
                'Login to your existent account of Tring',
                style: TextStyle(fontSize: 13, color: Color(0xff0828282)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 84),
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets1/img.png'), fit: BoxFit.fill),
                )),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 70),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.person_outline,
                            color: Color(0xff828282),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              hintText: 'Email address or phone number',
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
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.lock_outline,
                            color: Color(0xff828282),
                          ),
                        ),
                        Flexible(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 38, top: 12),
              alignment: Alignment.centerRight,
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff007DEF),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                logIn(emailController.text, passwordController.text);
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
                        'Secure Login',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 46,bottom: 46),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => registraionScreen()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xff007DEF),
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
