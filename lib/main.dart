import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => GetMaterialApp(
              title: "ChatApp",
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.white,
                accentColor: Colors.black,
                buttonColor: Colors.red[900],
              ),
              initialRoute: authC.isSkipIntro.isTrue
                  ? authC.isAuth.isTrue
                      ? Routes.HOME
              getPages: AppPages.routes,
            ),
          );
        }
        return FutureBuilder(
          future: authC.firstInitialized(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );
  }
}