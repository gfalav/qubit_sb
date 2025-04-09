import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_sb/sb.dart';
import 'package:qubit_sb/shared/controllers/user_controller.dart';
import 'package:qubit_sb/shared/ui/home/home.dart';
import 'package:qubit_sb/shared/ui/theme/theme.dart';
import 'package:qubit_sb/shared/ui/theme/util.dart';
import 'package:qubit_sb/shared/ui/unknown_page/unknown_page.dart';
import 'package:qubit_sb/shared/ui/users/change_password.dart';
import 'package:qubit_sb/shared/ui/users/change_photo_usr.dart';
import 'package:qubit_sb/shared/ui/users/change_usr_name.dart';
import 'package:qubit_sb/shared/ui/users/reset_password.dart';
import 'package:qubit_sb/shared/ui/users/sign_in.dart';
import 'package:qubit_sb/shared/ui/users/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(anonKey: Sb().anonKey, url: Sb().url);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(
      context,
      "Roboto",
      "Roboto Condensed",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'Qubit SB',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      onReady: () => userController.initRouteIsLogged(),
      home: Home(),
      initialRoute: '/home',
      unknownRoute: GetPage(name: "/notfound", page: () => UnknownPage()),
      getPages: [
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/signin", page: () => SignIn()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/pwdreset", page: () => ResetPassword()),
        GetPage(name: "/changepwd", page: () => ChangePassword()),
        GetPage(name: "/updateuser", page: () => ChangeUsrName()),
        GetPage(name: "/changephoto", page: () => ChangePhotoUsr()),
      ],
    );
  }
}
