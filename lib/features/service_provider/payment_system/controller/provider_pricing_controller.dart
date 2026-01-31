import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/payment_system/screen/payment_method.dart';

enum PricingPlan { basic, unlimited }

class ProviderPricingController extends GetxController {
  final selectedPlan = PricingPlan.basic.obs;

  void selectBasic() => selectedPlan.value = PricingPlan.basic;
  void selectUnlimited() => selectedPlan.value = PricingPlan.unlimited;

  void handleSkip() => Get.back();

  void handleNext() {
    Get.to(() => const PaymentMethodScreen());
  }
}
