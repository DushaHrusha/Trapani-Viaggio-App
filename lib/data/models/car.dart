import 'package:test_task/data/models/vehicle.dart';

class Car extends Vehicle {
  const Car({
    required super.pricePerHour,
    required super.maxSpeed,
    required super.image,
    required super.year,
    required super.insurance,
    required super.model,
    required super.id,
    required super.type,
    required super.typeTransmission,
    required super.numberSeats,
    required super.typeFuel,
  });
}
