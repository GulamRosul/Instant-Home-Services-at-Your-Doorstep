import 'package:get/get.dart';
import 'package:protiva502/features/user/authentication/screen/login_screen.dart';
import 'package:protiva502/features/user/splasho_screen/screen/splasho_screen.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String splashoScreen = "/splashoScreen";

  static String getLoginScreen() => loginScreen;
  static String getSplashoScreen() => splashoScreen;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: splashoScreen, page: () => const SplashoScreen()),
  ];
}
