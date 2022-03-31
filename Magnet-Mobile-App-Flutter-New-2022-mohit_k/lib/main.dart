import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:magnet_update/Pagination/page_route.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/bindings/Bindings_class.dart';
import 'package:magnet_update/screen/global_class.dart';
import 'package:magnet_update/screen/log_in_screen.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pagination/binding_utils.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyCmOC4dUAznvebLDs7KS8Ao95vQD_4cbZc",
      //     authDomain: "webtesting-b062b.firebaseapp.com",
      //     projectId: "webtesting-b062b",
      //     storageBucket: "webtesting-b062b.appspot.com",
      //     messagingSenderId: "461157598549",
      //     appId: "1:461157598549:web:ef49da3553106782cddbdc",
      //     measurementId: "G-HBQZTRHTVF"
      // )
  );
  // await SentryFlutter.init(
  //       (options) {
  //         options.enableAutoSessionTracking = true;
  //     options.dsn = 'https://3ca79ade8aa148ab983bdc09c88277c4@o1126086.ingest.sentry.io/6166721';
  //     // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //     // We recommend adjusting this value in production.
  //     options.tracesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp( const MyApp()),
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await getData();
  }

  String Token = "_";
  String roles = '_';

  getData() async {
    Token = await sharedPreferences.getString(Api_url.token).toString();
    roles = await sharedPreferences.getString(Api_url.user_role).toString();
    debugPrint('Token ${Token}');
    debugPrint('Role ${roles}');
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Magnet',
      initialRoute: BindingUtils.initialRoute,
      initialBinding: Login_Binding(),
      getPages: AppPages.getPageList,
      // home: (Token == '_' ||
      //         Token.toString() == 'null' ||
      //         Token.toString().isEmpty ||
      //         roles == '_' ||
      //         roles == 'null' ||
      //         roles.toString().isEmpty)
      //     ? loginScreen()
      //     : (roles == "company")
      //         ? addCompanyScreen()
      //         : (roles == "plan")
      //             ? subscription_Screen()
      //             : DashBoardScreen(),
      home: loginScreen(),
      navigatorObservers: [SentryNavigatorObserver()],
      theme: ThemeData(
        primaryColor: Colors.yellow,
        dividerColor: Colors.transparent,
        scaffoldBackgroundColor: ColorUtils.whiteColor_2,
        backgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorUtils.whiteColor,


          elevation: 0,
        ),
      ),
    );
  }
}
