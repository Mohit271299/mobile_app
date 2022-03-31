import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/screens/authentication/login/ui/login.dart';
import 'package:tring/screens/dashboard/ui/dashboard.dart';
import 'package:tring/service/commonservice.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String getToken = '_';

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    setState(() {
      getToken = (CommonService()
                  .getStoreValue(keys: 'token')
                  .toString()
                  .isNotEmpty &&
              CommonService().getStoreValue(keys: 'token').toString() != "null")
          ? CommonService().getStoreValue(keys: 'token').toString()
          : '_';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppDetails.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (getToken.toString() != '_')
          ? const Dashboard()
          : const loginScreen(),
      // home: const Test(),
    );
  }
}
