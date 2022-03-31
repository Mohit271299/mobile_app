import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:vaishnav_parivar/AppDetails.dart';
import 'package:vaishnav_parivar/language/lacaleString.dart';
import 'package:vaishnav_parivar/pagination/page_routes.dart';
import 'package:vaishnav_parivar/screen/Auth/controller/forceupdateController.dart';
import 'package:vaishnav_parivar/screen/Auth/login.dart';
import 'package:vaishnav_parivar/screen/dashboard/dashboard_screen.dart';
import 'package:vaishnav_parivar/screen/homepage/homepage_screen.dart';
import 'package:vaishnav_parivar/screen/homepage/homepage_testimg.dart';
import 'package:vaishnav_parivar/services/service.dart';
import 'package:vaishnav_parivar/splash/splashscreen.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';


// Notifications ************************************************************ Start
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

// Notifications ************************************************************ End

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;
  int _counter = 0;
  String userUid = '_';

  Future<String?> getId() async {
    setState(() {
      userUid = Service().getData(key: 'userUid');
    });
    // debugPrint('00-00-00-00-00- user Uid ${userUid.toString()}');
    // var deviceInfo = DeviceInfoPlugin();
    // if (Platform.isIOS) {
    //   // import 'dart:io'
    //   var iosDeviceInfo = await deviceInfo.iosInfo;
    //   setState(() {
    //     deviceID = iosDeviceInfo.toString();
    //   });
    //   return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    // } else {
    //   await deviceInfo.androidInfo.then((value) {
    //     debugPrint('Device Id ${value.device.toString()}');
    //     setState(() {
    //       deviceID = value.device.toString();
    //     });
    //   });

    try {
      deviceID = (await PlatformDeviceId.getDeviceId)!;
    } on PlatformException {
      deviceID = 'Failed to get deviceId.';
    }

    return 'tester'; // Unique ID on Android
  }

  static String getToken = '';
  static String deviceID = '';

  getCurrentToken() async {
    // debugPrint('0-0-0-0-0 Inside GetCurrentToken');

    await FirebaseMessaging.instance.getToken().then((value) {
      // debugPrint('1-1-1-1-1-1 Inside GetCurrentToken ${value.toString()}');

      setState(() {
        getToken = value.toString();
      });
    });
    // debugPrint('11-11-11-11 Token ${getToken.toString()}');
    // debugPrint('0-0-0-0-0 Inside the Token ${getToken.}');
  }

  @override
  void initState() {
    setupRemoteConfig();
    getId();
    getCurrentToken();
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage? message) {
        RemoteNotification notification = message!.notification!;
        AndroidNotification? android = message.notification!.android;

        if (notification != null && android != null) {

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage? message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message!.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.body.toString(),
                      ),
                      AnalyticsEventExample(),
                      ProgrammaticTriggersExample(),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title.toString()),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.body.toString(),
                    ),
                    AnalyticsEventExample(),
                    ProgrammaticTriggersExample(),
                  ],
                ),
              ),
            );
          },
        );
      }
    });

    super.initState();
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
      0,
      "Testing $_counter",
      "How you doin ?",
      NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id, channel.name, channel.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher'),
      ),
    );
  }

  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    debugPrint('1-1-1-1- Inside setupRemoteConfig ');
    await Firebase.initializeApp();

    // await FirebaseRemoteConfig.instance.fetchAndActivate();
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.ensureInitialized();
    await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval:  const Duration(seconds: 0),
        )
    );
    await remoteConfig.fetchAndActivate();
    await remoteConfig.fetch();
    // await remoteConfig.setConfigSettings(RemoteConfigSettings(
    //   fetchTimeout: const Duration(seconds: 10),
    //   minimumFetchInterval: const Duration(hours: 1),
    // ));
    // debugPrint(' Android ${await remoteConfig.getBool('is_app_update_android')}');
    forceUpdateController.forceUpdateTitle(await remoteConfig.getString('update_title'));
    forceUpdateController.forceUpdateMessage(await remoteConfig.getString('update_message'));
    forceUpdateController.isAndroidForceUpdate(await remoteConfig.getBool('is_app_update_android'));
    forceUpdateController.isIosForceUpdate(await remoteConfig.getBool('is_app_update_ios'));

    // debugPrint(
    //     '****** Force Update Value ${forceUpdateController.forceUpdateTitle.value}');
    // debugPrint(
    //     '****** Force Update Value ${forceUpdateController.forceUpdateMessage.value}');
    // debugPrint(
    //     '****** Force Update Value ${forceUpdateController.isAndroidForceUpdate.value}');
    // debugPrint(
    //     '****** Force Update Value ${forceUpdateController.isIosForceUpdate.value}');
    // debugPrint('2-2-2-2-2 Test ${test.toString()}');
    // RemoteConfigValue(null, ValueSource.valueStatic);
    return remoteConfig;
  }

  final forceUpdateController = Get.put(ForceUpdateController());

  @override
  Widget build(BuildContext context) {
    setupRemoteConfig();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final botToastBuilder = BotToastInit();
    return FutureBuilder<FirebaseRemoteConfig>(
      future: setupRemoteConfig(),
      builder:
          (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
        if (snapshot.hasData) {
          forceUpdateController.forceUpdateMessage(
              snapshot.data!.getString('update_message').toString());
          forceUpdateController.forceUpdateTitle(
              snapshot.data!.getString('update_title').toString());
          forceUpdateController.isAndroidForceUpdate(
              snapshot.data!.getBool('is_app_update_android'));
          forceUpdateController
              .isIosForceUpdate(snapshot.data!.getBool('is_app_update_ios'));
          // debugPrint(
          //     '************* Main Screen ${snapshot.data!.getString('update_message').toString()}');
          // debugPrint(
          //     '************* Main Screen ${snapshot.data!.getBool('is_app_update_android')}');
          // debugPrint(
          //     '************* Main Screen ${snapshot.data!.getBool('is_app_update_ios')}');
          // debugPrint(
          //     '************* Main Screen ${snapshot.data!.getString('ios_version')}');
          // debugPrint(
          //     '************* Main Screen ${snapshot.data!.getString('android_version')}');
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppDetails.appName,
            translations: LocaleString(),
            locale: Locale('en','US'),
            // initialRoute: BindingUtils.initialRoute,
            // initialBinding: Login_Binding(),
            getPages: AppPages.getPageList,
            builder: (context, child) {
              child =
                  botToastBuilder(context, FlutterEasyLoading(child: child));
              return child;
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            home: (userUid.toString() == '_' || userUid.toString() == 'null')
                ?  SplashScreen()
                : const dashBoard_screen(),
            // home: SplashScreen(),
            theme: ThemeData(
              primaryColor: Colors.yellow,
              dividerColor: Colors.transparent,
              scaffoldBackgroundColor: ColorUtils.scffoldBgColor,
              backgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: ColorUtils.scffoldBgColor,
                elevation: 0,
              ),
            ),
          );
        } else {
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
            locale: Locale('en','US'),
            home: Scaffold(),
          );
        }
      },
    );
  }
}

class AnalyticsEventExample extends StatelessWidget {
  Future<void> _sendAnalyticsEvent() async {
    await MyAppState.analytics.logEvent(
      name: 'awesome_event',
      parameters: <String, dynamic>{
        //'id': 1, // not required?
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const Text(
              'Log an analytics event',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Trigger an analytics event'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _sendAnalyticsEvent();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Firing analytics event: awesome_event'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text(
                'Log event'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgrammaticTriggersExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const Text(
              'Programmatic Trigger',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Manually trigger events programmatically '),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await MyAppState.fiam.triggerEvent('awesome_event');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Triggering event: awesome_event'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text(
                'Programmatic Triggers'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}




class HomePage extends StatelessWidget {

  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'ಕನ್ನಡ','locale': Locale('kn','IN')},
    {'name':'हिंदी','locale': Locale('hi','IN')},
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('title'.tr),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello'.tr,style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('message'.tr,style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text('subscribe'.tr,style: TextStyle(fontSize: 20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  var locale = Locale('en','US');
                  Get.updateLocale(locale);
                }, child: Text('English')),
                ElevatedButton(onPressed: (){
                  var locale = Locale('kn','IN');
                  Get.updateLocale(locale);
                }, child: Text('Kannada')),
                ElevatedButton(onPressed: (){
                  var locale = Locale('hi','IN');
                  Get.updateLocale(locale);
                }, child: Text('Hindi')),

              ],
            ),
            ElevatedButton(onPressed: (){
              buildLanguageDialog(context);
            }, child: Text('changelang'.tr)),
          ],
        )
    );
  }
}
