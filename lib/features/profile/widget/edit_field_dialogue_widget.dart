import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

/// Call this function to show the edit field bottom sheet.
void showEditFieldBottomSheet({
  required BuildContext context,
  required String label,
  required String currentValue,
  required Future<bool> Function(String value) onSave,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0xFF0F172A).withValues(alpha: 0.45),
    builder: (_) => EditFieldBottomSheet(
      label: label,
      currentValue: currentValue,
      onSave: onSave,
      keyboardType: keyboardType,
      maxLines: maxLines,
    ),
  );
}

class EditFieldBottomSheet extends StatefulWidget {
  final String label;
  final String currentValue;
  final Future<bool> Function(String value) onSave;
  final TextInputType keyboardType;
  final int maxLines;

  const EditFieldBottomSheet({
    super.key,
    required this.label,
    required this.currentValue,
    required this.onSave,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  State<EditFieldBottomSheet> createState() => _EditFieldBottomSheetState();
}

class _EditFieldBottomSheetState extends State<EditFieldBottomSheet> {
  late final TextEditingController _textController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // ✅ Controller created here — owned and disposed safely by this State
    _textController = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    // ✅ Disposed only when the widget is truly removed from the tree,
    //    AFTER the bottom sheet animation finishes — no premature disposal.
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final updatedValue = _textController.text.trim();

    if (updatedValue.isEmpty) {
      Get.snackbar(
        'Required field',
        '${widget.label} cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0F172A),
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    // No change — just close
    if (updatedValue == widget.currentValue.trim()) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = true);

    final didSave = await widget.onSave(updatedValue);

    if (!mounted) return;

    if (didSave) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      // ✅ This single padding pushes the whole sheet above the keyboard
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.14),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        // ✅ SingleChildScrollView prevents overflow when keyboard is open
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Handle bar ──────────────────────────────────────────
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // ── Icon ─────────────────────────────────────────────────
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E293B), Color(0xFF475569)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(Icons.edit_outlined, color: Colors.white, size: 24.sp),
              ),
              SizedBox(height: 18.h),

              // ── Title ────────────────────────────────────────────────
              Text(
                '${'edit'.tr} ${widget.label}',
                style: getTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 6.h),
              // Text(
              //   'Update your ${widget.label} details below and save when you are ready.',
              //   style: getTextStyle(
              //     fontSize: 13.sp,
              //     fontWeight: FontWeight.w400,
              //     color: const Color(0xFF64748B),
              //   ),
              // ),
              // SizedBox(height: 20.h),

              // ── Label badge ──────────────────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.badge_outlined, size: 18.sp, color: const Color(0xFF475569)),
                    SizedBox(width: 8.w),
                    Text(
                      widget.label,
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // ── Text field ───────────────────────────────────────────
              CustomTextField(
                controller: _textController,
                hintText: 'Enter ${widget.label}',
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                minLines: widget.maxLines > 1 ? widget.maxLines : null,
                backgroundColor: const Color(0xFFF8FAFC),
                borderColor: const Color(0xFFCBD5E1),
                borderRadius: 16.r,
                autofocus: true,
                enabled: !_isSaving,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: widget.maxLines > 1 ? 16.h : 14.h,
                ),
              ),
              SizedBox(height: 22.h),

              // ── Buttons ──────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(48.h),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr,
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: Size.fromHeight(48.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        side: WidgetStateProperty.all(BorderSide.none),
                      ),
                      child: _isSaving
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'save_changes'.tr,
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              30.h.verticalSpace, // Extra space to ensure content is above keyboard
            ],
          ),
        ),
      ),
    );
  }
}