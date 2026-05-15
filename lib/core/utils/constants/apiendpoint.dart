class ApiEndpoints {
  ApiEndpoints._();

  // static const String baseUrl =
  //     'https://x3081msx-3000.asse.devtunnels.ms/api/v1';
  // static const String baseUrl = 'https://protiva-backend-ukw2.onrender.com/api/v1';
  // static const String baseUrl = 'http://13.60.247.63/api/v1';
    static const String baseUrl = 'https://api.kaajbd.com.bd/api/v1';
  // static const String baseUrl =
  //     'https://g7g2ld85-3000.inc1.devtunnels.ms/api/v1';

  /// Socket.IO Server URL (same host as API)
  static const String socketMessageUrl =
      'https://api.kaajbd.com.bd/messaging';
  static const String socketTrackingUrl =
      'https://api.kaajbd.com.bd/tracking';

  //authentication
  static const String register = '/auth/register';
  static const String clientRegistration = '/auth/client-registration';
  static const String login = '/auth/login';
  static const String verifyOTP = '/auth/verify-otp';
  static const String resendOTP = '/auth/resend-otp';
  static const String changePassword = '/auth/change-password';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  //Profile
  static const String authMe = '/auth/me';
  static const String authProfile = '/auth/profile';
  static const String updateUserProfile = '/auth/updateUserProfile';
  static String providerDetails(String providerId) => '/user/$providerId';

  //banner
  static const String userBanners = '/marketing/user/banners';

  //jobs
  static const String homeJobs = '/job/home-jobs';
  static const String createJob = '/job/create-job';
  static const String getJobs = '/job/my-job';
  static String updateJob(String jobId) => '/job/$jobId/update-jon-content';
  static String deleteJob(String jobId) => '/job/delete-jon/$jobId';
  static String updateThumbnail(String jobId) => '/job/$jobId/update/thumbnail';
  static String getSingleJob(String jobId) =>
      '/job/$jobId/single-job-with-review';

  //bookings
  static const String myAllBookings = '/bookings/my-all-booking';
  static const String makeBooking = '/bookings/make-booking';
  static const String myActiveJob = '/job/my-active-job';
  static String updateBookingStatus(String bookingId, String status) =>
      '/bookings/$bookingId/status/$status';

  //withdraw
  static const String providerWallet = '/withdraw/provider-wallet';
  static const String cartWithdrawRequest = '/withdraw/cart-withdraw-request';
  static const String withdrawCard = '/withdraw/card';
  static const String withdrawMobileBanking = '/withdraw/mobile-banking';

  //recent bookings
  static const String recentBookings = '/bookings/recent-bookings';

  //recommendations
  static const String getRecommendedExperts =
      '/expart-recommendation/expert-recommendations';

  //categories
  static const String categories = '/category/all-categoris-for-user';
  static String subCategories(String categoryId) =>
      '/category/sub-categories/$categoryId';
  static String subCategoryServices(String subCategoryId) =>
      '/sub-category/sub-category/$subCategoryId';

  //payment via checkout url
  static const String makePayment = '/payment/make-payment';

  //payment via sdk (in app payment)
  static const String initialSDK = '/payment/initiate-sdk';
  static const String paymentConfirm = '/payment/confirm';
  static const String paymentFail = '/payment/payment-fail';

  //coupons
  static String useCoupon(String couponCode) => '/cupon/use/$couponCode';

  //notifications
  static const String getNotifications = '/notification/get-my-ntg';
  static String markAsRead(String notificationId) =>
      '/notification/$notificationId/read';
  static String deleteNotification = '/notification/notification-delete';
  static String toggleNotification = '/notification/notification-on-off';

  //messages
  static String fetchMessage() => '/messages/history';
  static const String uploadImage = '/messages/upload/image';

  //search
  static const String homeSearch = '/job/home-search';

  //privacy policy
  static const String privacyPolicy = '/policy';

  //terms and conditions
  static const String termsAndConditions = '/policy/terms-condition';

  //reviews
  static String postReview = '/review/give-review';
}
