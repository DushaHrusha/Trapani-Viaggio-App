// data/models/excursion_model.dart
import 'package:flutter/material.dart';
import 'package:test_task/data/models/card_data.dart';

class Excursion extends CardData {
  final int numberReviews;
  final String address;
  final DateTime startingTime;
  final int duration;
  final List<String> sights;
  final List<String> notIncluded;
  final String transfer;
  final String takeWithYou;
  final DateTime? cachedAt;

  const Excursion({
    required this.numberReviews,
    required this.address,
    required this.duration,
    required this.startingTime,
    required this.sights,
    required this.notIncluded,
    required this.transfer,
    required this.takeWithYou,
    this.cachedAt,
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.description,
    required super.rating,
    required super.price,
    required super.iconServices,
  });

  factory Excursion.fromJson(Map<String, dynamic> json) {
    // Безопасный парсинг списков
    List<String> parseStringList(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return [];
    }

    // Безопасный парсинг числовых значений
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    // Безопасный парсинг DateTime
    DateTime parseDateTime(dynamic value) {
      if (value == null) return DateTime.now();
      if (value is DateTime) return value;
      if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      }
      return DateTime.now();
    }

    return Excursion(
      id: parseInt(json['id']),
      title: json['title']?.toString() ?? '',
      imageUrl: parseStringList(json['image_url']),
      description: json['description']?.toString() ?? '',
      price: parseDouble(json['price']),
      rating: parseDouble(json['rating']),
      iconServices: parseStringList(json['icon_services']),
      numberReviews: parseInt(json['number_reviews']),
      address: json['address']?.toString() ?? '',
      startingTime: parseDateTime(json['starting_time']),
      duration: parseInt(json['duration']),
      sights: parseStringList(json['sights']),
      notIncluded: parseStringList(json['not_included']),
      transfer: json['transfer']?.toString() ?? '',
      takeWithYou: json['take_with_you']?.toString() ?? '',
      cachedAt:
          json['cached_at'] != null
              ? DateTime.tryParse(json['cached_at'].toString())
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'description': description,
      'price': price,
      'rating': rating,
      'icon_services': iconServices,
      'number_reviews': numberReviews,
      'address': address,
      'starting_time': startingTime.toIso8601String(),
      'duration': duration,
      'sights': sights,
      'not_included': notIncluded,
      'transfer': transfer,
      'take_with_you': takeWithYou,
      'cached_at': cachedAt?.toIso8601String(),
    };
  }

  Excursion copyWith({
    int? id,
    String? title,
    List<String>? imageUrl,
    String? description,
    double? price,
    double? rating,
    List<String>? iconServices,
    int? numberReviews,
    String? address,
    DateTime? startingTime,
    int? duration,
    List<String>? sights,
    List<String>? notIncluded,
    String? transfer,
    String? takeWithYou,
    DateTime? cachedAt,
  }) {
    return Excursion(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      iconServices: iconServices ?? this.iconServices,
      numberReviews: numberReviews ?? this.numberReviews,
      address: address ?? this.address,
      startingTime: startingTime ?? this.startingTime,
      duration: duration ?? this.duration,
      sights: sights ?? this.sights,
      notIncluded: notIncluded ?? this.notIncluded,
      transfer: transfer ?? this.transfer,
      takeWithYou: takeWithYou ?? this.takeWithYou,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  // Преобразование строковых иконок в IconData
  @override
  List<IconData> get iconDataList {
    return iconServices.map((iconName) => _getIconData(iconName)).toList();
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'coffee':
        return Icons.coffee;
      case 'cloud':
        return Icons.cloud;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'credit_card':
        return Icons.credit_card;
      case 'directions_bike_outlined':
        return Icons.directions_bike_outlined;
      case 'wifi':
        return Icons.wifi;
      default:
        return Icons.check_circle;
    }
  }

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    description,
    price,
    rating,
    iconServices,
    numberReviews,
    address,
    startingTime,
    duration,
    sights,
    notIncluded,
    transfer,
    takeWithYou,
    cachedAt,
  ];
}
