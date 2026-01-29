import 'package:get/get.dart';

class SubcategoryServiceListController extends GetxController {
  // Observable for the subcategory title
  var subcategoryTitle = ''.obs;

  // Observable for the service count
  var serviceCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the parameters passed from the previous screen
    if (Get.arguments != null) {
      subcategoryTitle.value = Get.arguments['title'] ?? 'Subcategory Services';
      // Extract the number from the count string (e.g., "05 Services" -> 5)
      String countString = Get.arguments['count'] ?? '0 Services';
      serviceCount.value = _extractCountFromString(countString);
    }
  }

  // Helper method to extract the numeric count from the string
  int _extractCountFromString(String countString) {
    // Extract numbers from string like "05 Services" or "5 Services"
    final RegExp regExp = RegExp(r'\d+');
    final match = regExp.firstMatch(countString);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return 0;
  }
}
