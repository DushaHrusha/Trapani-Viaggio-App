import 'package:dio/dio.dart';
import 'package:test_task/booking.dart';
import '../api_client.dart';
import '../api_endpoints.dart';

class BookingService {
  final ApiClient _apiClient;

  BookingService(this._apiClient);

  // Получить занятые даты
  Future<List<Map<String, String>>> getBookedDates(int apartmentId) async {
    final response = await _apiClient.get(
      ApiEndpoints.apartmentBookedDates(apartmentId),
    );

    final List<dynamic> dates = response.data['data']['booked_dates'];
    return dates
        .map(
          (e) => {
            'check_in': e['check_in'] as String,
            'check_out': e['check_out'] as String,
          },
        )
        .toList();
  }

  // Проверить доступность
  Future<bool> checkAvailability({
    required int apartmentId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.checkApartmentAvailability(apartmentId),
      data: {
        'check_in_date': checkIn.toIso8601String().split('T')[0],
        'check_out_date': checkOut.toIso8601String().split('T')[0],
      },
    );

    return response.data['data']['available'] as bool;
  }

  // Получить все бронирования пользователя
  Future<List<Booking>> getUserBookings() async {
    final response = await _apiClient.get(ApiEndpoints.bookings);

    final List<dynamic> bookingsData = response.data['data']['bookings'];
    return bookingsData.map((json) => Booking.fromJson(json)).toList();
  }

  // Отменить бронирование
  Future<void> cancelBooking(int bookingId) async {
    await _apiClient.post(ApiEndpoints.cancelBooking(bookingId));
  }

  // Создать бронирование
  Future<Booking> createBooking({
    required int apartmentId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int adults,
    required int children,
    String? notes,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.bookings,
      data: {
        'apartment_id': apartmentId,
        'check_in_date': checkIn.toIso8601String().split('T')[0],
        'check_out_date': checkOut.toIso8601String().split('T')[0],
        'adults': adults,
        'children': children,
        if (notes != null) 'notes': notes,
      },
    );

    return Booking.fromJson(response.data['data']['booking']);
  }
}
