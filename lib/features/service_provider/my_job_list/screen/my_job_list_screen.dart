import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/my_job_list_controller.dart';

class MyJobListScreen extends StatelessWidget {
  const MyJobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyJobListController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My listing',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3F3F3F),
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Color(0xFFCBD5E1), height: 1),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Jobs',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'View all your currently\nactive job postings',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFF334155),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: controller.handleNewListing,
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: Text(
                    'New listing',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFFFAFAFA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF787BEB),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        side: WidgetStateProperty.all(BorderSide.none),
                      ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.listings.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final item = controller.listings[index];
                    return _buildJobCard(context, controller, item, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(
    BuildContext context,
    MyJobListController controller,
    Map<String, String> item,
    int index,
  ) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Color(0xFFCBD5E1)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Image.asset(
                      ImagePath.servicecard,
                      width: 60.w,
                      height: 40.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconPath.star, height: 14.h),
                      Text(
                        ' ${item['rating']} ',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item['title']!,
                            style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F172A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                            onSelected: (value) {
                              if (value == 'edit') {
                                controller.handleEditListing(index);
                              } else if (value == 'delete') {
                                controller.handleDeleteListing(index);
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(
                                  'Edit',
                                  style: getTextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  'Delete',
                                  style: getTextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12.sp,
                          color: Color(0xFF1D4ED8),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            item['location']!,
                            style: getTextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    RichText(
                      text: TextSpan(
                        text: 'Start From ',
                        style: getTextStyle(
                          fontSize: 10.sp,
                          color: Color(0xFF475569),
                        ),
                        children: [
                          TextSpan(
                            text: item['price'],
                            style: getTextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildJobStat(
                  Icons.visibility_outlined,
                  "${item['views']} views",
                ),
              ),
              Flexible(
                child: _buildJobStat(
                  Icons.description_outlined,
                  "${item['applications']} applications",
                ),
              ),
              Flexible(
                child: _buildJobStat(
                  Icons.calendar_month_outlined,
                  "${item['bookings']} bookings",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobStat(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            text,
            style: getTextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
