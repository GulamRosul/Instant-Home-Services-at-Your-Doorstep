import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/wallet_screen.dart';
import 'package:protiva502/routes/app_routes.dart';

class ProviderHomeController extends GetxController {
  // Logic for application limit
  var isLimitReached = true.obs; // Toggle this for testing the UI
  var applicationsCount = 1.obs;
  final int maxApplications = 2;

  // Mock data for the UI
  var totalEarnings = "12,450.50".obs;
  var pendingAmount = "850.00".obs;
  var bookingsServed = "8/10".obs;
  var averageRating = "4.8".obs;
  var reviewCount = 100.obs;
  var submittedProposals = 10.obs;

  void toggleLimit() {
    isLimitReached.value = !isLimitReached.value;
  }

  void handleUpgrade() {
    // Logic to navigate to pricing or upgrade screen
    Get.snackbar("Upgrade", "Navigating to Upgrade screen...");
  }

  void handleViewAllActiveJobs() {
    Get.toNamed(AppRoute.activeJobs);
  }

  void handleViewAllRecentBookings() {
    Get.toNamed(AppRoute.recentBookings);
  }

  void handleViewWallet() {
    Get.find<ProviderNavbarController>().showHomeSubPage(const WalletScreen());
  }
}
