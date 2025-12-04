// lib/api_endpoints.dart

class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'http://192.168.0.24:8000/api/v1';

  // =============================================
  // AUTH
  // =============================================
  static const String googleAuth = '/auth/google';
  static const String appleAuth = '/auth/apple';
  static const String sendSms = '/auth/phone/send-code';
  static const String verifySms = '/auth/phone/verify';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String logoutAll = '/auth/logout-all';
  static const String user = '/auth/user';

  // =============================================
  // BOOKMARKS
  // =============================================
  static const String bookmarks = '/bookmarks';
  static const String bookmarkToggle = '/bookmarks/toggle';
  static const String bookmarkCheck = '/bookmarks/check';
  static const String bookmarkIds = '/bookmarks/ids';
  static const String bookmarkSync = '/bookmarks/sync';

  // =============================================
  // APARTMENTS
  // =============================================
  static const String apartments = '/apartments';
  static const String apartmentsFeatured = '/apartments/featured';
  static const String apartmentsSearch = '/apartments/search';
  static String apartmentById(int id) => '/apartments/$id';

  // =============================================
  // VEHICLES
  // =============================================
  static const String vehicles = '/vehicles';
  static const String cars = '/vehicles/cars';
  static const String motorcycles = '/vehicles/motorcycles';
  static const String vespas = '/vehicles/vespas';
  static String vehicleById(int id) => '/vehicles/$id';

  // =============================================
  // EXCURSIONS
  // =============================================
  static const String excursions = '/excursions';
  static const String excursionsFeatured = '/excursions/featured';
  static const String excursionsSearch = '/excursions/search';
  static String excursionById(int id) => '/excursions/$id';

  // =============================================
  // CHAT
  // =============================================
  static const String chatMessages = '/chat/messages';
  static String chatMessageById(int id) => '/chat/messages/$id';
  static const String chatMarkAsRead = '/chat/messages/read';
  static const String chatUnreadCount = '/chat/unread-count';

  // =============================================
  // HEALTH
  // =============================================
  static const String health = '/health';

  static const String bookings = '/bookings';
  static String apartmentBookedDates(int id) => '/apartments/$id/booked-dates';
  static String checkApartmentAvailability(int id) =>
      '/apartments/$id/check-availability';
  static String cancelBooking(int id) => '/bookings/$id/cancel';
}
