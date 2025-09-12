import 'package:flutter/material.dart';
import 'package:test_task/data/models/excursion_model.dart';

class ExcursionsRepository {
  List<Excursion> excursions = [
    Excursion(
      id: 1,
      title: 'Grand Canyon Adventure',
      imageUrl: [
        "assets/file/grand_canyon/AmericaRoadHorseshoeBendSunset.jpg",
        "assets/file/grand_canyon/Best-Time-to-Visit-the-Grand-Canyon-Mohave-Sunset-DETOURS-LP.jpg",
        "assets/file/grand_canyon/Grand_Canyon_header_1800x900_c_RickGoldwasser.jpg",
        "assets/file/grand_canyon/grand-canyon-toroweap-sunrise.jpg",
        "assets/file/grand_canyon/Kirkjufell-volcano.jpg",
      ],
      description:
          'Embark on an unforgettable journey through the breathtaking landscapes of the Grand Canyon National Park. This comprehensive tour offers a deep dive into one of the world\'s most spectacular natural wonders, featuring stunning geological formations and panoramic vistas that will leave you in awe. Experienced guides will provide fascinating insights into the canyon\'s geological history and ecosystem.',
      price: 45,
      rating: 7.6,
      iconServices: [
        Icons.wifi,
        Icons.luggage,
        Icons.camera_alt,
        Icons.wb_sunny,
        Icons.local_drink,
        Icons.smoke_free,
      ],
      numberReviews: 156,
      address: "Grand Canyon Village, Arizona 86023, United States",
      duration: 6,
      startingTime: DateTime(2025, 9, 15, 8),
      sights: <String>[
        "Explore South Rim viewpoints",
        "Hike scenic trails",
        "Learn about canyon geology",
        "Wildlife observation",
      ],
      notIncluded: <String>["Personal equipment", "Travel insurance", "Lunch"],
      transfer: 'Hotel pickup - Grand Canyon - Visitor Center - Return',
      takeWithYou: 'Hiking boots, water bottle, sunscreen, camera',
    ),
    Excursion(
      id: 2,
      title: 'Machu Picchu Cultural Expedition',
      imageUrl: [
        "assets/file/machu_picchu/67.jpg",
        "assets/file/machu_picchu/1309.jpg",
        "assets/file/machu_picchu/d4.jpg",
        "assets/file/machu_picchu/Hero-peru-machu-picchu-inn-to-inn.jpg",
        "assets/file/machu_picchu/machupicchu-sunrise mid.jpg",
      ],
      description:
          'Discover the mystical world of the Inca civilization in this comprehensive tour of Machu Picchu. Journey through the stunning Andean landscape, exploring ancient ruins and learning about the rich cultural heritage of the Inca people. Our expert guides will provide in-depth historical context and fascinating stories about this UNESCO World Heritage site.',
      price: 50,
      rating: 8.3,
      iconServices: [
        Icons.wifi,
        Icons.translate,
        Icons.directions_walk,
        Icons.wb_cloudy,
        Icons.local_dining,
        Icons.camera_alt,
      ],
      numberReviews: 204,
      address: "Aguas Calientes, Cusco Region, Peru",
      duration: 8,
      startingTime: DateTime(2025, 9, 20, 6),
      sights: <String>[
        "Explore Inca citadel",
        "Guided archaeological tour",
        "Panoramic mountain views",
        "Traditional Peruvian lunch",
      ],
      notIncluded: <String>["Personal gear", "Extra snacks", "Souvenirs"],
      transfer: 'Cusco - Train to Aguas Calientes - Machu Picchu - Return',
      takeWithYou: 'Comfortable walking shoes, rain jacket, hat, water',
    ),
    // Add more excursions as needed
  ];
}
