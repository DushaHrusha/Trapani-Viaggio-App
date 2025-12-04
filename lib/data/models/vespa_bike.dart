import 'package:test_task/data/models/vehicle.dart';

class VespaBike extends Vehicle {
  const VespaBike({
    required super.id,
    required super.model,
    required super.year,
    required super.maxSpeed,
    required super.pricePerHour,
    required super.image,
    required super.insurance,
    required super.type,
    required super.typeTransmission,
    required super.numberSeats,
    required super.typeFuel,
  });
}
