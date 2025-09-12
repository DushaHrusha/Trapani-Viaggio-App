import 'package:test_task/data/models/motorcycle.dart';

class MotorcycleRepository {
  List<Motorcycle> fetchMotorcycles() {
    return [
      Motorcycle(
        id: 1,
        brand: 'Harley-Davidson',
        model: 'Sportster',
        year: 2022,
        maxSpeed: 180,
        pricePerHour: 25.5,
        image: 'assets/file/e794cd9815a50fa28db7dab37a734397.png',
        type_transmission: 'Manual',
        number_seats: 2,
        type_fuel: 'Gasoline',
        insurance: 'Full Cover',
      ),
      Motorcycle(
        id: 2,
        brand: 'Kawasaki',
        model: 'Ninja',
        year: 2023,
        maxSpeed: 250,
        pricePerHour: 30,
        image: 'assets/file/e794cd9815a50fa28db7dab37a734397.png',
        type_transmission: 'Manual',
        number_seats: 2,
        type_fuel: 'Gasoline',
        insurance: 'Basic Cover',
      ),
    ];
  }
}
