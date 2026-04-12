class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://protiva-backend.onrender.com/api/v1';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String authMe = '/auth/me';
  static const String authProfile = '/auth/profile';
  static const String userBanners = '/marketing/user/banners';
  static const String homeJobs = '/job/home-jobs';
  static const String myAllBookings = '/bookings/my-all-booking';
  static const String makeBooking = '/bookings/make-booking';
  static const String myActiveJob = '/job/my-active-job';
  static const String providerWallet = '/withdraw/provider-wallet';
  static const String recentBookings = '/bookings/recent-bookings';
  static const String cartWithdrawRequest = '/withdraw/cart-withdraw-request';
  static const String withdrawCard = '/withdraw/card';
  static const String withdrawMobileBanking = '/withdraw/mobile-banking';

  static const String categories = '/category/all-categoris-for-user';
  static String subCategories(String categoryId) =>
      '/category/sub-categories/$categoryId';
}
