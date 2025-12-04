import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Абстрактный класс CardData
abstract class CardData extends Equatable {
  final int id;
  final String title;
  final List<String> imageUrl;
  final String description;
  final double rating;
  final double price;
  final List<String> iconServices;

  const CardData({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.price,
    required this.iconServices,
  });

  // Общий метод для всех наследников
  List<IconData> get iconDataList {
    return iconServices.map((iconName) => _getIconData(iconName)).toList();
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'wifi':
        return Icons.wifi;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'pool':
        return Icons.pool;
      case 'local_parking':
        return Icons.local_parking;
      case 'restaurant':
        return Icons.restaurant;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'fireplace':
        return Icons.fireplace;
      case 'hot_tub':
        return Icons.hot_tub;
      case 'kitchen':
        return Icons.kitchen;
      case 'snowboarding':
        return Icons.snowboarding;
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
    rating,
    price,
    iconServices,
  ];
}

// Класс Apartment наследует CardData
