import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/payment_controller.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<PaymentController>();

    debugPrint('PaymentWebViewScreen initState called');
    debugPrint('Gateway URL: ${controller.gatewayUrl.value}');

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('WebView page started loading: $url');
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            debugPrint('WebView page finished loading: $url');
            setState(() {
              _isLoading = false;
            });

            // Check if payment was successful by URL
            _checkPaymentSuccess(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
            debugPrint('WebView error URL: ${error.url}');
            debugPrint('WebView error code: ${error.errorCode}');
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(controller.gatewayUrl.value));
  }

  void _checkPaymentSuccess(String url) {
    debugPrint('Current URL: $url');

    // Only show success when redirected to the backend success endpoint
    // Not on intermediate SSL Commerz redirects
    if (url.contains('protiva-backend') && url.contains('/payment/success')) {
      debugPrint('Payment success detected from backend endpoint');
      final controller = Get.find<PaymentController>();
      if (mounted) {
        controller.handlePaymentSuccess();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Get.back(),
      //   ),
      //   title: Text(
      //     'Payment Gateway',
      //     style: getTextStyle(
      //       fontSize: 16.sp,
      //       fontWeight: FontWeight.w600,
      //       color: Colors.black,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(title: 'Payment Gateway'),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading)
            Container(
              color: Colors.white.withValues(alpha: 0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
