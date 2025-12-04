import 'package:test_task/data/models/apartment.dart';
import 'package:test_task/data/models/excursion_model.dart';
import 'package:test_task/data/models/vehicle.dart';

enum BookingType { apartment, excursion, vehicle }

abstract class UnifiedBooking {
  final int id;
  final BookingType type;
  final DateTime bookingDate;
  final String status;
  final double totalPrice;
  final String currency;
  final DateTime createdAt;

  UnifiedBooking({
    required this.id,
    required this.type,
    required this.bookingDate,
    required this.status,
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
  });

  String get statusLabel {
    switch (status) {
      case 'confirmed':
        return 'Confirmed';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      case 'completed':
        return 'Completed';
      default:
        return status;
    }
  }

  String get typeLabel {
    switch (type) {
      case BookingType.apartment:
        return 'Apartment';
      case BookingType.excursion:
        return 'Excursion';
      case BookingType.vehicle:
        return 'Vehicle';
    }
  }
}

class ApartmentBooking extends UnifiedBooking {
  final Apartment? apartment;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;

  ApartmentBooking({
    required super.id,
    required super.bookingDate,
    required super.status,
    required super.totalPrice,
    required super.currency,
    required super.createdAt,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    this.apartment,
  }) : super(type: BookingType.apartment);

  factory ApartmentBooking.fromJson(Map<String, dynamic> json) {
    return ApartmentBooking(
      id: json['id'],
      bookingDate: DateTime.parse(json['check_in_date']),
      checkInDate: DateTime.parse(json['check_in_date']),
      checkOutDate: DateTime.parse(json['check_out_date']),
      adults: json['adults'] ?? 1,
      children: json['children'] ?? 0,
      status: json['status'] ?? 'pending',
      totalPrice: double.parse(json['total_price'].toString()),
      currency: json['currency'] ?? 'EUR',
      apartment:
          json['apartment'] != null
              ? Apartment.fromJson(json['apartment'])
              : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  int get nights => checkOutDate.difference(checkInDate).inDays;
}

class ExcursionBooking extends UnifiedBooking {
  final Excursion? excursion;
  final int adults;
  final int children;

  ExcursionBooking({
    required super.id,
    required super.bookingDate,
    required super.status,
    required super.totalPrice,
    required super.currency,
    required super.createdAt,
    required this.adults,
    required this.children,
    this.excursion,
  }) : super(type: BookingType.excursion);

  factory ExcursionBooking.fromJson(Map<String, dynamic> json) {
    return ExcursionBooking(
      id: json['id'],
      bookingDate: DateTime.parse(json['booking_date']),
      adults: json['adults'] ?? 1,
      children: json['children'] ?? 0,
      status: json['status'] ?? 'pending',
      totalPrice: double.parse(json['total_price'].toString()),
      currency: json['currency'] ?? 'EUR',
      excursion:
          json['excursion'] != null
              ? Excursion.fromJson(json['excursion'])
              : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  int get totalPeople => adults + children;
}

class VehicleBooking extends UnifiedBooking {
  final Vehicle? vehicle;
  final DateTime pickupDate;
  final DateTime returnDate;
  final int passengers;

  VehicleBooking({
    required super.id,
    required super.bookingDate,
    required super.status,
    required super.totalPrice,
    required super.currency,
    required super.createdAt,
    required this.pickupDate,
    required this.returnDate,
    required this.passengers,
    this.vehicle,
  }) : super(type: BookingType.vehicle);

  factory VehicleBooking.fromJson(Map<String, dynamic> json) {
    return VehicleBooking(
      id: json['id'],
      bookingDate: DateTime.parse(json['pickup_date']),
      pickupDate: DateTime.parse(json['pickup_date']),
      returnDate: DateTime.parse(json['return_date']),
      passengers: json['passengers'] ?? 1,
      status: json['status'] ?? 'pending',
      totalPrice: double.parse(json['total_price'].toString()),
      currency: json['currency'] ?? 'EUR',
      vehicle:
          json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  int get days => returnDate.difference(pickupDate).inDays;
}
