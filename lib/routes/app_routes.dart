import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';
import 'package:protiva502/features/splash_screen/controller/splash_controller.dart';
import 'package:protiva502/features/onboarding/screen/onboarding_page_view.dart';
import 'package:protiva502/features/splash_screen/screen/splash_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_otp_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_profile_pic_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_reg_screen.dart';
import 'package:protiva502/features/user/home/screen/available_category_screen.dart';
import 'package:protiva502/features/user/home/screen/category_service_details_screen.dart';
import 'package:protiva502/features/user/home/screen/subcategory_service_list_screen.dart';
import 'package:protiva502/features/user/home/screen/user_home_screen.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  // User sections
  static String onboardingScreen = "/onboardingScreen";
  static String userLoginScreen = "/userLoginScreen";
  static String userRegScreen = "/userRegScreen";
  static String userProfilePicScreen = "/userProfilePicScreen";
  static String userOtpScreen = "/userOtpScreen";
  static String userHomeScreen() => "/userHomeScreen";
  static String availableCategoryScreen() => "/availableCategoryScreen";
  static String subcategoryServiceListScreen() =>
      "/subcategoryServiceListScreen";
  static String categoryServiceDetailsScreen() =>
      "/categoryServiceDetailsScreen";
  static String providerDetailsScreen() => "/providerDetailsScreen";

  // Service prover sections
  static String providerRegistration = "/providerRegistration";

  static String getSplashScreen() => splashScreen;
  // User Sections
  static String getOnboardingScreen() => onboardingScreen;
  static String getUserLoginScreen() => userLoginScreen;
  static String getUserRegScreen() => userRegScreen;
  static String getUserProfilePicScreen() => userProfilePicScreen;
  static String getUserOtpScreen() => userOtpScreen;
  static String getUserHomeScreen() => userHomeScreen();
  static String getAvailableCategoryScreen() => availableCategoryScreen();
  static String getSubcategoryServiceListScreen() =>
      subcategoryServiceListScreen();
  static String getCategoryServiceDetailsScreen() =>
      categoryServiceDetailsScreen();
  static String getProviderDetailsScreen() => providerDetailsScreen();

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
    GetPage(
      name: userHomeScreen(),
      page: () => UserHomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: availableCategoryScreen(),
      page: () => AvailableCategoryScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: subcategoryServiceListScreen(),
      page: () => SubcategoryServiceListScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: categoryServiceDetailsScreen(),
      page: () => CategoryServiceDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerDetailsScreen(),
      page: () => ProviderDetailsScreen(),
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
