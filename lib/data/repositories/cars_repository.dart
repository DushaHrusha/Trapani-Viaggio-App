import 'package:test_task/api_client.dart';
import 'package:test_task/api_endpoints.dart';
import 'package:test_task/data/models/vehicle.dart';
import 'package:test_task/data/repositories/connectivity_service.dart';
import 'package:test_task/data/repositories/vehicle_repository.dart'
    hide ServerException;
import 'package:test_task/data/repositories/vehicles_local_datasource.dart';

class CarRepository extends VehicleRepository {
  CarRepository({
    required ApiClient apiClient,
    required VehiclesLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
  }) : super(
         apiClient: apiClient,
         localDataSource: localDataSource,
         connectivityService: connectivityService,
       );

  @override
  String get vehicleType => 'car';

  @override
  Future<List<Vehicle>> fetchFromServer() async {
    final response = await apiClient.get(ApiEndpoints.cars);

    if (response.data['success'] == true) {
      final Map<String, dynamic> data =
          response.data['data'] as Map<String, dynamic>;
      final List<dynamic> items = data['items'] as List;

      return items
          .map((json) => Vehicle.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException('Failed to load cars');
    }
  }

  @override
  Future<Vehicle> fetchByIdFromServer(int id) async {
    final response = await apiClient.get(ApiEndpoints.vehicleById(id));

    if (response.data['success'] == true) {
      final Map<String, dynamic> vehicleData =
          response.data['data'] as Map<String, dynamic>;
      final vehicle = Vehicle.fromJson(vehicleData);

      if (vehicle.type.toLowerCase() == 'car') {
        return vehicle;
      } else {
        throw ServerException('Vehicle is not a car');
      }
    } else {
      throw ServerException('Car not found');
    }
  }
}
