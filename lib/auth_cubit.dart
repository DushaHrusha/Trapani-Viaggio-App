// lib/presentation/cubit/auth/auth_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task/auth_service.dart';
import 'package:test_task/user_model.dart';

// lib/bloc/cubits/auth_cubit.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:test_task/user_model.dart';
import '../../api_client.dart';
import '../../api_endpoints.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiClient _apiClient;
  final FlutterSecureStorage _storage;
  final GoogleSignIn _googleSignIn;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  UserModel? _currentUser;
  String? _token;

  AuthCubit({required ApiClient apiClient})
    : _apiClient = apiClient,
      _storage = const FlutterSecureStorage(),
      _googleSignIn = GoogleSignIn.instance /*(scopes: ['email', 'profile'])*/,
      super(AuthInitial()) {
    // Добавляем interceptor для токена
    _setupInterceptor();
  }

  void _setupInterceptor() {
    _apiClient.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            logout();
          }
          handler.next(error);
        },
      ),
    );
  }

  /// Текущий пользователь
  UserModel? get currentUser => _currentUser;

  /// Авторизован?
  bool get isAuthenticated => _token != null && _currentUser != null;

  /// Получить токен
  Future<String?> getToken() async {
    _token ??= await _storage.read(key: _tokenKey);
    return _token;
  }

  /// Инициализация - проверяем сохранённую сессию
  Future<void> initialize() async {
    emit(AuthLoading());

    try {
      _token = await _storage.read(key: _tokenKey);
      final userData = await _storage.read(key: _userKey);

      if (_token != null && userData != null) {
        _currentUser = UserModel.fromJson(jsonDecode(userData));

        // Проверяем валидность токена
        final isValid = await _validateToken();
        if (isValid) {
          emit(AuthAuthenticated(user: _currentUser!));
          return;
        }
      }

      emit(AuthUnauthenticated());
    } catch (e) {
      debugPrint('Auth initialization error: $e');
      emit(AuthUnauthenticated());
    }
  }

  /// Проверка валидности токена
  Future<bool> _validateToken() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.user);

      if (response.statusCode == 200 && response.data['success'] == true) {
        _currentUser = UserModel.fromJson(response.data['data']['user']);
        await _storage.write(
          key: _userKey,
          value: jsonEncode(_currentUser!.toJson()),
        );
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Token validation error: $e');
      return false;
    }
  }

  // =============================================
  // GOOGLE SIGN IN
  // =============================================

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // if (googleUser == null) {
      //   emit(AuthUnauthenticated());
      //   return;
      // }

      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;

      // if (googleAuth.accessToken == null) {
      //   emit(AuthError(message: 'Failed to get Google access token'));
      //   return;
      // }

      final deviceName = await _getDeviceName();

      final response = await _apiClient.post(
        ApiEndpoints.googleAuth,
        data: {
          //  'access_token': googleAuth.accessToken,
          'device_name': deviceName,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        await _handleAuthSuccess(response.data);
      } else {
        emit(
          AuthError(
            message: response.data['message'] ?? 'Google sign in failed',
          ),
        );
      }
    } on DioException catch (e) {
      emit(AuthError(message: _handleDioError(e)));
    } catch (e) {
      debugPrint('Google sign in error: $e');
      emit(AuthError(message: 'Google sign in failed'));
    }
  }

  // =============================================
  // APPLE SIGN IN
  // =============================================

  Future<void> signInWithApple() async {
    emit(AuthLoading());

    try {
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        emit(AuthError(message: 'Apple Sign In is not available'));
        return;
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        emit(AuthError(message: 'Failed to get Apple identity token'));
        return;
      }

      String? fullName;
      if (credential.givenName != null || credential.familyName != null) {
        fullName = [
          credential.givenName,
          credential.familyName,
        ].where((s) => s != null && s.isNotEmpty).join(' ');
      }

      final deviceName = await _getDeviceName();

      final response = await _apiClient.post(
        ApiEndpoints.appleAuth,
        data: {
          'identity_token': credential.identityToken,
          'authorization_code': credential.authorizationCode,
          'user_identifier': credential.userIdentifier,
          'email': credential.email,
          'full_name': fullName,
          'device_name': deviceName,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        await _handleAuthSuccess(response.data);
      } else {
        emit(
          AuthError(
            message: response.data['message'] ?? 'Apple sign in failed',
          ),
        );
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        emit(AuthUnauthenticated());
        return;
      }
      emit(AuthError(message: 'Apple sign in failed'));
    } on DioException catch (e) {
      emit(AuthError(message: _handleDioError(e)));
    } catch (e) {
      debugPrint('Apple sign in error: $e');
      emit(AuthError(message: 'Apple sign in failed'));
    }
  }

  // =============================================
  // PHONE AUTH - STEP 1: SEND SMS
  // =============================================

  Future<void> sendSmsCode(String phone) async {
    emit(AuthLoading());

    try {
      final response = await _apiClient.post(
        ApiEndpoints.sendSms,
        data: {'phone': phone},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(
          AuthSmsSent(
            phone: phone,
            message: response.data['message'] ?? 'SMS code sent',
          ),
        );
      } else {
        emit(
          AuthError(message: response.data['message'] ?? 'Failed to send SMS'),
        );
      }
    } on DioException catch (e) {
      emit(AuthError(message: _handleDioError(e)));
    } catch (e) {
      debugPrint('Send SMS error: $e');
      emit(AuthError(message: 'Failed to send SMS code'));
    }
  }

  // =============================================
  // PHONE AUTH - STEP 2: VERIFY SMS CODE
  // =============================================

  Future<void> verifySmsCode(String phone, String code) async {
    emit(AuthLoading());

    try {
      final deviceName = await _getDeviceName();

      final response = await _apiClient.post(
        ApiEndpoints.verifySms,
        data: {'phone': phone, 'code': code, 'device_name': deviceName},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        await _handleAuthSuccess(response.data);
      } else {
        emit(AuthError(message: response.data['message'] ?? 'Invalid code'));
      }
    } on DioException catch (e) {
      emit(AuthError(message: _handleDioError(e)));
    } catch (e) {
      debugPrint('Verify SMS error: $e');
      emit(AuthError(message: 'Failed to verify code'));
    }
  }

  // =============================================
  // PHONE + PASSWORD AUTH (альтернатива SMS)
  // =============================================

  /// Регистрация с телефоном и паролем
  Future<void> registerWithPhone({
    required String phone,
    required String password,
    required String name,
    required String email,
  }) async {
    emit(AuthLoading());

    try {
      final deviceName = await _getDeviceName();

      final response = await _apiClient.post(
        ApiEndpoints.register,
        data: {
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': password,
          'name': name,
          'device_name': deviceName,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['success'] == true) {
          await _handleAuthSuccess(response.data);
        } else {
          emit(
            AuthError(
              message: response.data['message'] ?? 'Registration failed',
            ),
          );
        }
      } else {
        emit(
          AuthError(message: response.data['message'] ?? 'Registration failed'),
        );
      }
    } on DioException catch (e) {
      emit(AuthError(message: _handleDioError(e)));
    } catch (e) {
      debugPrint('Register error: $e');
      emit(AuthError(message: 'Registration failed'));
    }
  }

  /// Вход с телефоном и паролем
  Future<void> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final deviceName = await _getDeviceName();

      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {'phone': phone, 'password': password, 'device_name': deviceName},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        await _handleAuthSuccess(response.data);
      } else {
        emit(
          AuthError(message: response.data['message'] ?? 'Invalid credentials'),
        );
      }
    } on DioException catch (e) {
      emit(AuthError(message: _handleDioError(e)));
    } catch (e) {
      debugPrint('Login error: $e');
      emit(AuthError(message: 'Login failed'));
    }
  }

  // =============================================
  // LOGOUT
  // =============================================

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      if (_token != null) {
        try {
          await _apiClient.post(ApiEndpoints.logout);
        } catch (e) {
          debugPrint('Logout API error (ignored): $e');
        }
      }

      try {
        await _googleSignIn.signOut();
      } catch (e) {
        debugPrint('Google sign out error (ignored): $e');
      }

      _token = null;
      _currentUser = null;
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _userKey);

      emit(AuthUnauthenticated());
    } catch (e) {
      debugPrint('Logout error: $e');
      emit(AuthUnauthenticated());
    }
  }

  // =============================================
  // HELPERS
  // =============================================

  Future<void> _handleAuthSuccess(Map<String, dynamic> data) async {
    try {
      final userData = data['data']['user'];
      final token = data['data']['token'];

      _currentUser = UserModel.fromJson(userData);
      _token = token;

      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(key: _userKey, value: jsonEncode(userData));

      emit(AuthAuthenticated(user: _currentUser!));
    } catch (e) {
      debugPrint('Handle auth success error: $e');
      emit(AuthError(message: 'Failed to process authentication'));
    }
  }

  Future<String> _getDeviceName() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        return '${android.brand} ${android.model}';
      } else if (Platform.isIOS) {
        final ios = await deviceInfo.iosInfo;
        return ios.name;
      }

      return 'Unknown Device';
    } catch (e) {
      return 'Mobile App';
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please try again.';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    }

    if (e.response?.data != null && e.response?.data['message'] != null) {
      return e.response?.data['message'];
    }

    return 'Authentication failed. Please try again.';
  }
}
// lib/bloc/cubits/auth_state.dart

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class AuthInitial extends AuthState {}

/// Загрузка
class AuthLoading extends AuthState {}

/// Пользователь авторизован
class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Пользователь не авторизован
class AuthUnauthenticated extends AuthState {}

/// SMS код отправлен (для phone auth)
class AuthSmsSent extends AuthState {
  final String phone;
  final String message;

  const AuthSmsSent({required this.phone, required this.message});

  @override
  List<Object?> get props => [phone, message];
}

/// Ошибка авторизации
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
