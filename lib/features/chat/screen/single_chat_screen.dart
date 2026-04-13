import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/chat/controller/single_chat_controller.dart';

class SingleChatScreen extends StatelessWidget {
  const SingleChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingleChatController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      resizeToAvoidBottomInset: true,
      // 1. Remove the appBar property entirely
      body: Column(
        children: [
          // 2. Place your custom header here as the first element
          _buildChatHeader(context, controller),

          // Message List (Takes up remaining space)
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final chat = controller.messages[index];
                  return _buildChatBubble(
                    chat['message'],
                    chat['isMe'],
                    chat['time'],
                  );
                },
              ),
            ),
          ),

          // Message Input Field (Stays at the bottom)
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildChatHeader(BuildContext context, SingleChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Back Button
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),

            // Avatar with Online Indicator
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: AssetImage(ImagePath.profile),
                  backgroundColor: Colors.grey.shade200,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 14.h,
                    width: 14.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),

            // Name and Status
            Expanded(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.otherUserName.value,
                      style: getTextStyle(
                        color: const Color(0xFF1E293B),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      controller.isOtherUserTyping.value
                          ? "typing..."
                          : controller.connectionStatus.value,
                      style: getTextStyle(
                        color: controller.isOtherUserTyping.value
                            ? const Color(0xFF0891B2)
                            : const Color(0xFF64748B),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Info Button
            GestureDetector(
              onTap: () {
                // Handle info tap
              },
              child: Icon(
                Icons.info_outline_rounded,
                color: AppColors.textBlue,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            constraints: BoxConstraints(maxWidth: Get.width * 0.70),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isMe ? AppColors.textPurple : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message,
              style: getTextStyle(
                color: isMe ? Colors.white : const Color(0xFF1E293B),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 16.h,
              left: isMe ? 0 : 4.w,
              right: isMe ? 4.w : 0,
            ),
            child: Text(
              time,
              style: getTextStyle(
                color: AppColors.textSecondary,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(SingleChatController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.grey.shade400,
              size: 26.sp,
            ),
          ),
          Expanded(
            child: CustomTextField(
              controller: controller.messageController,
              hintText: "Type a message...",
              backgroundColor: Colors.white,
              onChanged: (value) {
                // Emit typing start when user starts typing
                if (value.isNotEmpty) {
                  controller.emitTypingStart();
                } else {
                  controller.emitTypingStop();
                }
              },
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              height: 45.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: AppColors.textPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
