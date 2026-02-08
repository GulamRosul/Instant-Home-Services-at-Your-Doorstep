// import 'package:flutter/material.dart';
// import 'package:protiva502/features/onboarding/screen/onboarding_screen.dart';
// import 'package:protiva502/features/onboarding/screen/second_onboarding_screen.dart';

// class OnboardingPageView extends StatefulWidget {
//   const OnboardingPageView({super.key});

//   @override
//   State<OnboardingPageView> createState() => _OnboardingPageViewState();
// }

// class _OnboardingPageViewState extends State<OnboardingPageView> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//               children: const [OnboardingScreen(), SecondOnboardingScreen()],
//             ),
//           ),
//           // Page Indicator
//           // Padding(
//           //   padding: EdgeInsets.symmetric(vertical: 20.h),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: List.generate(
//           //       2,
//           //       (index) => AnimatedContainer(
//           //         duration: const Duration(milliseconds: 300),
//           //         margin: EdgeInsets.symmetric(horizontal: 4.w),
//           //         height: 8.h,
//           //         width: _currentPage == index ? 24.w : 8.w,
//           //         decoration: BoxDecoration(
//           //           color: _currentPage == index
//           //               ? const Color(0xFF4CAF50)
//           //               : Colors.grey.shade300,
//           //           borderRadius: BorderRadius.circular(4.r),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           // Navigation Button
//           // if (_currentPage == 0)
//           //   Padding(
//           //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//           //     child: ElevatedButton(
//           //       onPressed: () {
//           //         _pageController.nextPage(
//           //           duration: const Duration(milliseconds: 300),
//           //           curve: Curves.easeInOut,
//           //         );
//           //       },
//           //       style: ElevatedButton.styleFrom(
//           //         backgroundColor: const Color(0xFF4CAF50),
//           //         minimumSize: Size(double.infinity, 50.h),
//           //         shape: RoundedRectangleBorder(
//           //           borderRadius: BorderRadius.circular(8.r),
//           //         ),
//           //       ),
//           //       child: Text(
//           //         'Next',
//           //         style: TextStyle(
//           //           fontSize: 16.sp,
//           //           fontWeight: FontWeight.w600,
//           //           color: Colors.white,
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // if (_currentPage == 0) SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }
// }
