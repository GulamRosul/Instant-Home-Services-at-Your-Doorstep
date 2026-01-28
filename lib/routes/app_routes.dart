import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';
import 'package:protiva502/features/splash_screen/controller/splash_controller.dart';
import 'package:protiva502/features/onboarding/screen/onboarding_page_view.dart';
import 'package:protiva502/features/splash_screen/screen/splash_screen.dart';
import 'package:protiva502/features/user/authentication/screen/login_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  // User sections
  static String onboardingScreen = "/onboardingScreen";
  static String loginScreen = "/loginScreen";
  // static String splashoScreen = "/splashoScreen";
  // Service prover sections
  static String providerRegistration = "/providerRegistration";

  static String getSplashScreen() => splashScreen;
  // User Sections
  static String getOnboardingScreen() => onboardingScreen;
  static String getLoginScreen() => loginScreen;
  // static String getSplashoScreen() => splashoScreen;
  // Service prover sections
  static String getProviderRegistration() => providerRegistration;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // User Sections
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingPageView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: splashoScreen,
    //   page: () => const SplashoScreen(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    // Service prover sections
    GetPage(
      name: providerRegistration,
      page: () => const ProviderRegistration(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
