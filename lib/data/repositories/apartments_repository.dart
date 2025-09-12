import 'package:flutter/material.dart';
import 'package:test_task/data/models/apartment.dart';

class ApartmentsRepository {
  List<Apartment> apartments = [
    Apartment(
      id: 3,
      title: 'Luxury Sea View Apartment',
      imageUrl: [
        "assets/file/luxury_sea_view_apartment/125935248.jpg",
        "assets/file/luxury_sea_view_apartment/125935497.jpg",
        "assets/file/luxury_sea_view_apartment/272767597.jpg",
        "assets/file/luxury_sea_view_apartment/556573328.jpg",
        "assets/file/luxury_sea_view_apartment/images.jpg",
      ],
      description:
          'Stunning modern apartment with breathtaking ocean views located in the heart of Miami Beach. Enjoy premium amenities and direct access to pristine white sandy beaches. Perfect for travelers seeking luxury and comfort.',
      price: 450,
      iconServices: [
        Icons.wifi,
        Icons.ac_unit,
        Icons.pool,
        Icons.local_parking,
        Icons.restaurant,
        Icons.fitness_center,
      ],
      rating: 9.6,
      numberReviews: 245,
      address: "1500 Ocean Drive, Miami Beach, FL 33139, USA",
    ),
    Apartment(
      id: 4,
      title: 'Cozy Mountain Chalet',
      imageUrl: [
        "assets/file/cozy_mountain_chalet/405257710.jpg",
        "assets/file/cozy_mountain_chalet/Contemporary-Mountain-Home-Dennis-Zirbel-01-1-Kindesign.jpg",
        "assets/file/cozy_mountain_chalet/cozy-mountain-cabin-can-open-to-elements-1a-thumb-970xauto-37977.jpg",
        "assets/file/cozy_mountain_chalet/cozy-mountain-retreat-stockcake.jpg",
        "assets/file/cozy_mountain_chalet/Mountain-Cottage-The-Aran-Valley_1.jpg",
      ],
      description:
          'Charming alpine chalet nestled in the Swiss Alps with panoramic mountain views. Experience ultimate relaxation with a private hot tub and fireplace. Ideal for winter sports enthusiasts and nature lovers.',
      price: 350,
      iconServices: [
        Icons.wifi,
        Icons.fireplace,
        Icons.hot_tub,
        Icons.local_parking,
        Icons.kitchen,
        Icons.snowboarding,
      ],
      rating: 9.2,
      numberReviews: 178,
      address: "Zermatt, Switzerland",
    ),
  ];
}
