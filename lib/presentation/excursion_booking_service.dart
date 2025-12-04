import 'package:dio/dio.dart';
import 'package:test_task/api_client.dart';

class ExcursionBookingService {
  final ApiClient _apiClient;

  ExcursionBookingService(this._apiClient);

  /// Создать бронирование экскурсии
  Future<Map<String, dynamic>> createBooking({
    required int excursionId,
    required DateTime bookingDate,
    required int adults,
    required int children,
    required String currency,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.post(
        '/excursion-bookings',
        data: {
          'excursion_id': excursionId,
          'booking_date': bookingDate.toIso8601String().split('T')[0],
          'adults': adults,
          'children': children,
          'currency': currency,
          if (notes != null) 'notes': notes,
        },
      );

      if (response.data['success'] == true) {
        return response.data['data']['booking'];
      }

      throw Exception('Booking failed');
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('This date is already fully booked');
      }
      throw Exception('Failed to create booking: ${e.message}');
    }
  }

  /// Получить занятые даты
  Future<List<String>> getBookedDates(int excursionId) async {
    try {
      final response = await _apiClient.get(
        '/excursions/$excursionId/booked-dates',
      );

      if (response.data['success'] == true) {
        final List<dynamic> dates = response.data['data']['booked_dates'];
        return dates.map((e) => e.toString()).toList();
      }

      return [];
    } catch (e) {
      print('Error fetching booked dates: $e');
      return [];
    }
  }
}
