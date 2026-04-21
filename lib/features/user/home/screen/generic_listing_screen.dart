import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/user/home/controller/generic_listing_controller.dart';

class GenericListingScreen<T> extends StatelessWidget {
  final String title;
  final ListingType type;
  final List<T> initialItems;
  final Future<List<T>> Function(int page, int limit) fetchFunction;
  final Widget Function(T item) itemBuilder;

  const GenericListingScreen({
    super.key,
    required this.title,
    required this.type,
    required this.initialItems,
    required this.fetchFunction,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      GenericListingController<T>(
        title: title,
        type: type,
        initialItems: initialItems,
        fetchFunction: fetchFunction,
      ),
      tag: title, // Use title as tag to allow multiple instances
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(title: title),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textPurple),
          );
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: Text('Retry', style: getTextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
          );
        }

        if (controller.items.isEmpty) {
          return Center(
            child: Text(
              'No items found',
              style: getTextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        // Determine layout based on type
        if (type == ListingType.recommendedExperts) {
          return _buildExpertList(controller);
        } else {
          return _buildServiceGrid(controller);
        }
      }),
    );
  }

  Widget _buildServiceGrid(GenericListingController<T> controller) {
    return GridView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        mainAxisExtent: 260.h,
      ),
      itemCount:
          controller.items.length + (controller.isLoadingMore.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= controller.items.length) {
          return Center(
            child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: const CircularProgressIndicator(),
            ),
          );
        }

        return itemBuilder(controller.items[index]);
      },
    );
  }

  Widget _buildExpertList(GenericListingController<T> controller) {
    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      itemCount:
          controller.items.length + (controller.isLoadingMore.value ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= controller.items.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: SizedBox(
                height: 40.h,
                width: 40.w,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: itemBuilder(controller.items[index]),
        );
      },
    );
  }
}
