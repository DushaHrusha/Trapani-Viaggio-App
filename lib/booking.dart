import 'package:test_task/data/models/apartment.dart';

class Booking {
  final int id;
  final int apartmentId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalPrice;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final Apartment? apartment; // Добавили

  Booking({
    required this.id,
    required this.apartmentId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalPrice,
    required this.status,
    this.notes,
    required this.createdAt,
    this.apartment, // Добавили
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      apartmentId: json['apartment_id'],
      checkInDate: DateTime.parse(json['check_in_date']),
      checkOutDate: DateTime.parse(json['check_out_date']),
      adults: json['adults'],
      children: json['children'] ?? 0,
      totalPrice: double.parse(json['total_price'].toString()),
      status: json['status'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      apartment:
          json['apartment'] != null
              ? Apartment.fromJson(json['apartment'])
              : null,
    );
  }
}
