import 'package:get/get.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';
import 'package:protiva502/features/notification/screen/notification_screen.dart';
import 'package:protiva502/features/onboarding/screen/second_onboarding_screen.dart';
import 'package:protiva502/features/privacy_policy/screen/privacy_policy_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_logo_bio_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration_screen_01.dart';
import 'package:protiva502/features/service_provider/payment_system/screen/provider_pricing_screen.dart';
import 'package:protiva502/features/service_provider/home/screen/active_jobs_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_login_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';
import 'package:protiva502/features/service_provider/provider_navber/screen/provider_navbar_screen.dart';
import 'package:protiva502/features/service_provider/payment_system/screen/payment_method.dart';
import 'package:protiva502/features/service_provider/home/screen/recent_bookings_screen.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/my_job_list_screen.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/post_job_screen.dart';
import 'package:protiva502/features/service_provider/booking/screen/booking_screen.dart';
import 'package:protiva502/features/splash_screen/controller/splash_controller.dart';
import 'package:protiva502/features/splash_screen/screen/splash_screen.dart';
import 'package:protiva502/features/user/all_bookings/screen/all_booking_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_login_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_otp_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_profile_pic_screen.dart';
import 'package:protiva502/features/user/authentication/screen/user_reg_screen.dart';
import 'package:protiva502/features/user/home/screen/available_category_screen.dart';
import 'package:protiva502/features/user/home/screen/category_service_details_screen.dart';
import 'package:protiva502/features/user/home/screen/subcategory_service_list_screen.dart';
import 'package:protiva502/features/user/home/screen/user_home_screen.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';
import 'package:protiva502/features/tracking/screen/tracking_screen.dart';

import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

import 'package:protiva502/features/service_provider/language_settings/screen/language_settings_screen.dart';
import 'package:protiva502/features/service_provider/settings/screen/settings_screen.dart';
import 'package:protiva502/features/service_provider/wallet/screen/wallet_screen.dart';
import 'package:protiva502/features/profile/screen/profile_screen.dart';
import 'package:protiva502/features/service_provider/booking/screen/provider_booking_details_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/model/booking_confirmation_data.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/confirm_booking_screen.dart';
import 'package:protiva502/features/service_provider/social_media/screen/social_media_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String mainNavigationScreen = "/mainNavigationScreen";
  static String notificationScreen = "/notificationScreen";
  static String singleChatScreen = "/singleChatScreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";
  static String secondOnboardingScreen = "/secondOnboardingScreen";

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
  static String allBookingScreen() => "/allBookingScreen";
  static String bookingDetailsScreen() => "/bookingDetailsScreen";
  static String confirmBookingScreen() => "/confirmBookingScreen";
  static String trackProviderScreen() => "/trackProviderScreen";

  // Service provider sections
  static String providerRegistration = "/providerRegistration";
  static String providerRegistration01 = "/providerRegistration01";
  static String providerLogoBio = "/providerLogoBio";
  static String providerPricing = "/providerPricing";
  static String providerLogin = "/providerLogin";
  static String providerNavbar = "/providerNavbar";
  static String paymentMethod = "/paymentMethod";
  static String activeJobs = "/activeJobs";
  static String recentBookings = "/recentBookings";
  static String myJobList = "/myJobList";
  static String postJob = "/postJob";
  static String booking = "/booking";
  static String providerBookingDetails = "/providerBookingDetails";
  static String languageSettings = "/languageSettings";
  static String settings = "/settings";
  static String profile = "/profile";
  static String myWallet = "/myWallet";
  static String socialMedia = "/socialMedia";

  static String getSplashScreen() => splashScreen;
  static String getMainNavigationScreen() => mainNavigationScreen;
  static String getNotificationScreen() => notificationScreen;
  static String getSingleChatScreen() => singleChatScreen;
  static String getPrivacyPolicyScreen() => privacyPolicyScreen;
  static String getSecondOnboardingScreen() => secondOnboardingScreen;

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
  static String getAllBookingScreen() => allBookingScreen();
  static String getBookingDetailsScreen() => bookingDetailsScreen();
  static String getConfirmBookingScreen() => confirmBookingScreen();
  static String getTrackProviderScreen() => trackProviderScreen();

  // Service provider sections
  static String getProviderRegistration() => providerRegistration;
  static String getProviderRegistration01() => providerRegistration01;
  static String getProviderLogoBio() => providerLogoBio;
  static String getProviderPricing() => providerPricing;
  static String getProviderLogin() => providerLogin;
  static String getProviderNavbar() => providerNavbar;
  static String getPaymentMethod() => paymentMethod;
  static String getActiveJobs() => activeJobs;
  static String getRecentBookings() => recentBookings;
  static String getMyJobList() => myJobList;
  static String getPostJob() => postJob;
  static String getBooking() => booking;
  static String getProviderBookingDetails() => providerBookingDetails;
  static String getLanguageSettings() => languageSettings;
  static String getSettings() => settings;
  static String getProfile() => profile;
  static String getMyWallet() => myWallet;
  static String getSocialMedia() => socialMedia;

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
    GetPage(
      name: mainNavigationScreen,
      page: () => const MainNavigationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: notificationScreen,
      page: () => const NotificationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: singleChatScreen,
      page: () => const SingleChatScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: secondOnboardingScreen,
      page: () => SecondOnboardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),

    // User Sections
    // GetPage(
    //   name: onboardingScreen,
    //   page: () => const OnboardingPageView(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 800),
    // ),
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
    GetPage(
      name: allBookingScreen(),
      page: () => AllBookingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: bookingDetailsScreen(),
      page: () => BookingDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: confirmBookingScreen(),
      page: () {
        final bookingData = Get.arguments;

        if (bookingData is BookingConfirmationData) {
          return ConfirmBookingScreen(bookingData: bookingData);
        }

        return const BookingDetailsScreen();
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: trackProviderScreen(),
      page: () => const TrackProviderScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    // Provider Sections
    GetPage(
      name: providerRegistration,
      page: () => const ProviderRegistration(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerRegistration01,
      page: () => const ProviderRegistrationScreen01(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerLogoBio,
      page: () => const ProviderLogoBioScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerPricing,
      page: () => const ProviderPricingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: paymentMethod,
      page: () => const PaymentMethodScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerLogin,
      page: () => const ProviderLoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerNavbar,
      page: () => const ProviderNavbarScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: activeJobs,
      page: () => const ActiveJobsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: recentBookings,
      page: () => const RecentBookingsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: myJobList,
      page: () => const MyJobListScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: postJob,
      page: () => const PostJobScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: booking,
      page: () => const BookingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: providerBookingDetails,
      page: () => const ProviderBookingDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: languageSettings,
      page: () => const LanguageSettingsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: myWallet,
      page: () => const WalletScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: socialMedia,
      page: () => const SocialMediaScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
