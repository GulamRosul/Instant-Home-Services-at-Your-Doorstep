import 'package:get/get.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';

class AvailableCategoryController extends GetxController {
  // Observable for selected category index
  var selectedIndex = 0.obs;

  final List<Map<String, String>> categories = [
    {'name': 'Electrician', 'icon': IconPath.electrician},
    {'name': 'Mechanic', 'icon': IconPath.mechanic},
    {'name': 'Plumber', 'icon': IconPath.plumber},
    {'name': 'Carpenter', 'icon': IconPath.carpenter},
    {'name': 'Automotive', 'icon': IconPath.automotive},
    {'name': 'Cleaner', 'icon': IconPath.cleaner},
    {'name': 'Painter', 'icon': IconPath.painter},
    {'name': 'Technician', 'icon': IconPath.technician},
  ];

  // Sub-categories data for each category
  final Map<String, List<Map<String, String>>> categorySubCategories = {
    'Electrician': [
      {
        'title': 'Electrical Wiring',
        'desc': 'Professional wiring installation and repair services',
        'count': '05 Services',
      },
      {
        'title': 'Circuit Breaker',
        'desc': 'Expert circuit breaker installation and maintenance',
        'count': '03 Services',
      },
      {
        'title': 'Lighting Installation',
        'desc': 'Complete lighting solutions for your space',
        'count': '04 Services',
      },
      {
        'title': 'Electrical Inspection',
        'desc': 'Thorough electrical safety inspections',
        'count': '02 Services',
      },
    ],
    'Mechanic': [
      {
        'title': 'Engine Repair',
        'desc': 'Complete engine diagnostics and repair services',
        'count': '06 Services',
      },
      {
        'title': 'Brake Service',
        'desc': 'Professional brake inspection and replacement',
        'count': '04 Services',
      },
      {
        'title': 'Oil Change',
        'desc': 'Quick and efficient oil change services',
        'count': '02 Services',
      },
      {
        'title': 'Transmission Repair',
        'desc': 'Expert transmission maintenance and repair',
        'count': '03 Services',
      },
    ],
    'Plumber': [
      {
        'title': 'Pipe Installation',
        'desc': 'Professional pipe fitting and installation',
        'count': '05 Services',
      },
      {
        'title': 'Leak Repair',
        'desc': 'Fast and reliable leak detection and repair',
        'count': '04 Services',
      },
      {
        'title': 'Drain Cleaning',
        'desc': 'Complete drain cleaning and unclogging services',
        'count': '03 Services',
      },
      {
        'title': 'Water Heater Service',
        'desc': 'Water heater installation and maintenance',
        'count': '02 Services',
      },
    ],
    'Carpenter': [
      {
        'title': 'Furniture Making',
        'desc': 'Custom furniture design and creation',
        'count': '07 Services',
      },
      {
        'title': 'Cabinet Installation',
        'desc': 'Professional cabinet fitting and installation',
        'count': '05 Services',
      },
      {
        'title': 'Door & Window Repair',
        'desc': 'Expert door and window repair services',
        'count': '04 Services',
      },
      {
        'title': 'Flooring',
        'desc': 'Hardwood flooring installation and repair',
        'count': '03 Services',
      },
    ],
    'Automotive': [
      {
        'title': 'Car Servicing',
        'desc': 'Complete car maintenance and servicing',
        'count': '08 Services',
      },
      {
        'title': 'Tire Replacement',
        'desc': 'Professional tire change and balancing',
        'count': '03 Services',
      },
      {
        'title': 'AC Repair',
        'desc': 'Car air conditioning repair and recharge',
        'count': '02 Services',
      },
      {
        'title': 'Battery Service',
        'desc': 'Battery testing and replacement services',
        'count': '02 Services',
      },
    ],
    'Cleaner': [
      {
        'title': 'House Cleaning',
        'desc': 'Complete home cleaning and sanitization',
        'count': '06 Services',
      },
      {
        'title': 'Carpet Cleaning',
        'desc': 'Deep carpet cleaning and stain removal',
        'count': '03 Services',
      },
      {
        'title': 'Window Cleaning',
        'desc': 'Professional window cleaning services',
        'count': '02 Services',
      },
      {
        'title': 'Office Cleaning',
        'desc': 'Commercial office cleaning solutions',
        'count': '04 Services',
      },
    ],
    'Painter': [
      {
        'title': 'Interior Painting',
        'desc': 'Professional interior painting services',
        'count': '05 Services',
      },
      {
        'title': 'Exterior Painting',
        'desc': 'Expert exterior painting and finishing',
        'count': '04 Services',
      },
      {
        'title': 'Wall Texturing',
        'desc': 'Decorative wall texturing and designs',
        'count': '03 Services',
      },
      {
        'title': 'Wallpaper Installation',
        'desc': 'Professional wallpaper application',
        'count': '02 Services',
      },
    ],
    'Technician': [
      {
        'title': 'AC Repair',
        'desc': 'Air conditioning repair and maintenance',
        'count': '05 Services',
      },
      {
        'title': 'Refrigerator Service',
        'desc': 'Refrigerator repair and servicing',
        'count': '04 Services',
      },
      {
        'title': 'Washing Machine Repair',
        'desc': 'Washing machine diagnostics and repair',
        'count': '03 Services',
      },
      {
        'title': 'Microwave Repair',
        'desc': 'Microwave oven repair services',
        'count': '02 Services',
      },
    ],
  };

  // Observable list for current sub-categories
  RxList<Map<String, String>> subCategories = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with first category's sub-categories
    subCategories.value = categorySubCategories['Electrician'] ?? [];
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
    // Update sub-categories based on selected category
    String categoryName = categories[index]['name']!;
    subCategories.value = categorySubCategories[categoryName] ?? [];
  }
}
