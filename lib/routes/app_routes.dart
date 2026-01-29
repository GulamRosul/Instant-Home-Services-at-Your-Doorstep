import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';
import 'package:protiva502/features/splash_screen/controller/splash_controller.dart';
import 'package:protiva502/features/onboarding/screen/onboarding_page_view.dart';
import 'package:protiva502/features/splash_screen/screen/splash_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_otp_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_profile_pic_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_reg_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  // User sections
  static String onboardingScreen = "/onboardingScreen";
  static String userLoginScreen = "/userLoginScreen";
  static String userRegScreen = "/userRegScreen";
  static String userProfilePicScreen = "/userProfilePicScreen";
  static String userOtpScreen = "/userOtpScreen";

  // Service prover sections
  static String providerRegistration = "/providerRegistration";

  static String getSplashScreen() => splashScreen;
  // User Sections
  static String getOnboardingScreen() => onboardingScreen;
  static String getUserLoginScreen() => userLoginScreen;
  static String getUserRegScreen() => userRegScreen;
  static String getUserProfilePicScreen() => userProfilePicScreen;
  static String getUserOtpScreen() => userOtpScreen;

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
      name: userLoginScreen,
      page: () => const UserLoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: userRegScreen,
      page: () => UserRegScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: userProfilePicScreen,
      page: () => UserProfilePicScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: userOtpScreen,
      page: () => UserOtpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    //Provider Sections
    GetPage(
      name: providerRegistration,
      page: () => const ProviderRegistration(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
