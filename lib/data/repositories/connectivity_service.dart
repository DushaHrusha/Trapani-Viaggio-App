// services/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  StreamController<bool>? _connectionStatusController;

  /// Проверить, есть ли подключение к интернету
  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      final hasConnection = result.first != ConnectivityResult.none;
      print(
        hasConnection ? '🌐 Internet connected' : '📵 No internet connection',
      );
      return hasConnection;
    } catch (e) {
      print('❌ Error checking connectivity: $e');
      return false;
    }
  }

  /// Получить поток изменений подключения
  Stream<bool> get onConnectivityChanged {
    _connectionStatusController ??= StreamController<bool>.broadcast();

    _connectivity.onConnectivityChanged.listen((results) {
      final hasConnection = results.first != ConnectivityResult.none;
      _connectionStatusController?.add(hasConnection);
      print(
        hasConnection ? '🌐 Internet reconnected' : '📵 Internet disconnected',
      );
    });

    return _connectionStatusController!.stream;
  }

  /// Закрыть stream
  void dispose() {
    _connectionStatusController?.close();
  }
}
