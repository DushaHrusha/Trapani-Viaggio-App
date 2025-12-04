import 'package:dio/dio.dart';
import 'package:test_task/api_client.dart';

class VehicleBookingService {
  final ApiClient _apiClient;

  VehicleBookingService(this._apiClient);

  /// Создать бронирование транспорта
  Future<Map<String, dynamic>> createBooking({
    required int vehicleId,
    required DateTime pickupDate,
    required DateTime returnDate,
    required int passengers,
    required bool airConditioning,
    required bool insurance,
    required bool depositRequired,
    required String currency,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.post(
        '/vehicle-bookings',
        data: {
          'vehicle_id': vehicleId,
          'pickup_date': pickupDate.toIso8601String().split('T')[0],
          'return_date': returnDate.toIso8601String().split('T')[0],
          'passengers': passengers,
          'air_conditioning': airConditioning,
          'insurance': insurance,
          'deposit_required': depositRequired,
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
        throw Exception('These dates are already booked');
      }
      throw Exception('Failed to create booking: ${e.message}');
    }
  }

  /// Проверить доступность
  Future<bool> checkAvailability({
    required int vehicleId,
    required DateTime pickupDate,
    required DateTime returnDate,
  }) async {
    try {
      final response = await _apiClient.post(
        '/vehicles/$vehicleId/check-availability',
        data: {
          'pickup_date': pickupDate.toIso8601String().split('T')[0],
          'return_date': returnDate.toIso8601String().split('T')[0],
        },
      );

      if (response.data['success'] == true) {
        return response.data['data']['available'] as bool;
      }

      return false;
    } catch (e) {
      print('Error checking availability: $e');
      return false;
    }
  }
}
