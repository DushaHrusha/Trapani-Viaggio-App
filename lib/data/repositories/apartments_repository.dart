import 'package:flutter/material.dart';
import 'package:test_task/data/models/apartment.dart';

class ApartmentsRepository {
  List<Apartment> apartments = [
    Apartment(
      title: 'Горы Кaвказа',
      imageUrl: [
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
      ],
      description:
          'Most popular bicycle tour to Natural Reserve Salt pans in Trapani.',
      price: 350,
      iconServices: [
        Icons.wifi,
        Icons.luggage,
        Icons.edit,
        Icons.wb_sunny,
        Icons.pets,
        Icons.smoke_free,
      ],
      rating: 8.9,
      numberReviews: 123,
      address: "Via Pantalica, 26, 91100, Trapani, Italy.",
    ),
    Apartment(
      title: 'Горы Кaвказа',
      imageUrl: [
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
      ],
      description:
          'Most popular bicycle tour to Natural Reserve Salt pans in Trapani. You will visit saline work museum in an old salt mill and enjoy fantastic landscapes. ',
      price: 30,
      iconServices: [
        Icons.wifi,
        Icons.luggage,
        Icons.edit,
        Icons.wb_sunny,
        Icons.pets,
        Icons.smoke_free,
      ],
      rating: 3.3,
      numberReviews: 123,
      address: "Via Pantalica, 26, 91100, Trapani, Italy.",
    ),
    Apartment(
      title: 'Петwrerергоф',
      imageUrl: [
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
      ],
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 500,
      iconServices: [
        Icons.wifi,
        Icons.luggage,
        Icons.edit,
        Icons.wb_sunny,
        Icons.pets,
        Icons.smoke_free,
      ],
      rating: 5.9,
      numberReviews: 123,
      address: "Via Pantalica, 26, 91100, Trapani, Italy.",
    ),
    Apartment(
      title: 'Петерг2434оф',
      imageUrl: [
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
      ],
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 200,
      iconServices: [
        Icons.wifi,
        Icons.luggage,
        Icons.edit,
        Icons.wb_sunny,
        Icons.pets,
        Icons.smoke_free,
      ],
      rating: 8.1,
      numberReviews: 123,
      address: "Via Pantalica, 26, 91100, Trapani, Italy.",
    ),
    Apartment(
      title: 'Петергewrweоф',
      imageUrl: [
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
        "assets/file/maraslua.jpg",
      ],
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 200,
      iconServices: [
        Icons.wifi,
        Icons.luggage,
        Icons.edit,
        Icons.wb_sunny,
        Icons.pets,
        Icons.smoke_free,
      ],
      rating: 6.3,
      numberReviews: 123,
      address: "Via Pantalica, 26, 91100, Trapani, Italy.",
    ),
    // Add other excursions here...
  ];
}
