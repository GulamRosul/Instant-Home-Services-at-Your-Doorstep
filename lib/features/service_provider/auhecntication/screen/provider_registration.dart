import 'package:flutter/material.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';

class ProviderRegistration extends StatelessWidget {
  const ProviderRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 40, right: 5, top: 14, bottom: 20),
          child: Image.asset(IconPath.leftbutton, height: 24, width: 24),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Provider Registration',
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.zero,
            child: Divider(color: Color(0xFFCBD5E1)),
          ),
          SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Started as a Provider',
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF09090B),
                  ),
                ),
                Divider(color: Color(0xFF09090B), thickness: 2, endIndent: 100),
                SizedBox(height: 24),
                Row(
                  children: [
                    Image.asset(IconPath.bag, height: 20, width: 20),
                    SizedBox(width: 8),
                    Text(
                      'Business Information',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Service Category',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
