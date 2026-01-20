import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';
import 'package:protiva502/features/user/authentication/screen/login_screen.dart';
import 'package:protiva502/features/user/splasho_screen/screen/splasho_screen.dart';

class AppRoute {
  // User sections
  static String loginScreen = "/loginScreen";
  static String splashoScreen = "/splashoScreen";
  // Service prover sections
  static String providerRegistration = "/providerRegistration";

  // User Sections
  static String getLoginScreen() => loginScreen;
  static String getSplashoScreen() => splashoScreen;
  // Service prover sections
  static String getProviderRegistration() => providerRegistration;

  static List<GetPage> routes = [
    // User Sections
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: splashoScreen, page: () => const SplashoScreen()),
    // Service prover sections
    GetPage(
      name: providerRegistration,
      page: () => const ProviderRegistration(),
    ),
  ];
}
