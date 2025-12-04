// data/models/vehicle.dart
import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final int id;
  final String type;
  final String model;
  final int year;
  final int maxSpeed;
  final int pricePerHour;
  final String image;
  final String typeTransmission;
  final int numberSeats;
  final String typeFuel;
  final String insurance;
  final DateTime? cachedAt;

  const Vehicle({
    required this.id,
    required this.type,
    required this.model,
    required this.year,
    required this.maxSpeed,
    required this.pricePerHour,
    required this.image,
    required this.typeTransmission,
    required this.numberSeats,
    required this.typeFuel,
    required this.insurance,
    this.cachedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing Vehicle from JSON: ${json.keys}');

    // Безопасный парсинг числовых значений
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    // Пытаемся получить изображение из разных полей
    String? imageUrl;

    if (json.containsKey('image_url') && json['image_url'] != null) {
      final imgUrl = json['image_url'];
      if (imgUrl is String) {
        imageUrl = imgUrl;
      } else if (imgUrl is List && imgUrl.isNotEmpty) {
        imageUrl = imgUrl[0].toString();
      }
      print('✅ Found image_url: $imageUrl');
    } else if (json.containsKey('image_urls') && json['image_urls'] != null) {
      final imageUrls = json['image_urls'];
      if (imageUrls is List && imageUrls.isNotEmpty) {
        imageUrl = imageUrls[0].toString();
        print('✅ Found image_urls[0]: $imageUrl');
      }
    } else if (json.containsKey('image') && json['image'] != null) {
      imageUrl = json['image'].toString();
      print('✅ Found image: $imageUrl');
    }

    if (imageUrl == null || imageUrl.isEmpty) {
      print('⚠️ No valid image found in JSON!');
      imageUrl = '';
    }

    return Vehicle(
      id: parseInt(json['id']),
      type: json['type']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
      year: parseInt(json['year']),
      maxSpeed: parseInt(json['max_speed']),
      pricePerHour: parseInt(json['price_per_hour']),
      image: imageUrl,
      typeTransmission: json['type_transmission']?.toString() ?? '',
      numberSeats: parseInt(json['number_seats']),
      typeFuel: json['type_fuel']?.toString() ?? '',
      insurance: json['insurance']?.toString() ?? '',
      cachedAt:
          json['cached_at'] != null
              ? DateTime.tryParse(json['cached_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'model': model,
      'year': year,
      'max_speed': maxSpeed,
      'price_per_hour': pricePerHour,
      'image': image,
      'type_transmission': typeTransmission,
      'number_seats': numberSeats,
      'type_fuel': typeFuel,
      'insurance': insurance,
      'cached_at': cachedAt?.toIso8601String(),
    };
  }

  Vehicle copyWith({
    int? id,
    String? type,
    String? model,
    int? year,
    int? maxSpeed,
    int? pricePerHour,
    String? image,
    String? typeTransmission,
    int? numberSeats,
    String? typeFuel,
    String? insurance,
    DateTime? cachedAt,
  }) {
    return Vehicle(
      id: id ?? this.id,
      type: type ?? this.type,
      model: model ?? this.model,
      year: year ?? this.year,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      image: image ?? this.image,
      typeTransmission: typeTransmission ?? this.typeTransmission,
      numberSeats: numberSeats ?? this.numberSeats,
      typeFuel: typeFuel ?? this.typeFuel,
      insurance: insurance ?? this.insurance,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    model,
    year,
    maxSpeed,
    pricePerHour,
    image,
    typeTransmission,
    numberSeats,
    typeFuel,
    insurance,
    cachedAt,
  ];
}
