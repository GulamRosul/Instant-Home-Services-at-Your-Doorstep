import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/notification/controller/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : Get.put(NotificationController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.notifications.isEmpty && !controller.isLoading.value) {
        controller.fetchNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: '  Notifications',
        actions: [
          TextButton(
            onPressed: () => controller.clearAll(),
            child: Text(
              "Clear All",
              style: getTextStyle(
                color: AppColors.textPurple,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${controller.error.value}',
                  textAlign: TextAlign.center,
                  style: getTextStyle(fontSize: 14.sp, color: Colors.red),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => controller.fetchNotifications(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.notifications.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshNotifications(),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final item = controller.notifications[index];

              // Logic to show Date Group Header (Today/Yesterday)
              bool showHeader =
                  index == 0 ||
                  item['dateGroup'] !=
                      controller.notifications[index - 1]['dateGroup'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader) _buildDateHeader(item['dateGroup']),
                  _buildNotificationTile(item, index, controller),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildDateHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        title,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(
    Map<String, dynamic> item,
    int index,
    NotificationController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.markAsRead(index);
        _showNotificationDialog(item);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: item['isRead']
              ? Colors.white
              : const Color(0xFFF3F0FF), // Light purple for unread
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: item['isRead']
                ? Colors.grey.shade200
                : AppColors.textPurple.withOpacity(0.1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeadingIcon(item['type']),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'],
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        item['time'],
                        style: getTextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item['message'],
                    style: getTextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                      lineHeight: 15.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDialog(Map<String, dynamic> item) {
    Get.dialog(
      AlertDialog(
        title: Text(
          item['title'],
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['message'],
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  lineHeight: 18.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                item['time'],
                style: getTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: getTextStyle(
                color: AppColors.textPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'booking':
        icon = Icons.calendar_today_rounded;
        color = Colors.blue;
        break;
      case 'payment':
        icon = Icons.account_balance_wallet_rounded;
        color = Colors.green;
        break;
      default:
        icon = Icons.notifications_active_rounded;
        color = AppColors.textPurple;
    }

    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            "No Notifications Yet",
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
