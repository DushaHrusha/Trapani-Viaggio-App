// lib/data/models/user_model.dart

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? provider; // google, apple, phone
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.avatar,
    this.provider,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.createdAt,
  });

  /// Авторизован через соцсеть?
  bool get isSocialAuth => provider == 'google' || provider == 'apple';

  /// Авторизован через телефон?
  bool get isPhoneAuth => provider == 'phone';

  /// Email подтверждён?
  bool get isEmailVerified => emailVerifiedAt != null;

  /// Телефон подтверждён?
  bool get isPhoneVerified => phoneVerifiedAt != null;

  /// Есть аватар?
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  /// Отформатированный телефон
  String get formattedPhone {
    if (phone == null) return '';
    // Простое форматирование: +7 (999) 123-45-67
    final digits = phone!.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length == 11) {
      return '+${digits[0]} (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7, 9)}-${digits.substring(9)}';
    }
    return phone!;
  }

  /// Первая буква имени (для placeholder аватара)
  String get initials {
    if (name.isEmpty) return '?';

    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  /// Основной идентификатор (email или телефон)
  String get displayIdentifier {
    if (email != null && email!.isNotEmpty) {
      return email!;
    }
    if (phone != null && phone!.isNotEmpty) {
      return formattedPhone;
    }
    return 'No contact info';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'User',
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      provider: json['provider'] as String?,
      emailVerifiedAt:
          json['email_verified_at'] != null
              ? DateTime.tryParse(json['email_verified_at'].toString())
              : null,
      phoneVerifiedAt:
          json['phone_verified_at'] != null
              ? DateTime.tryParse(json['phone_verified_at'].toString())
              : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'].toString())
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'provider': provider,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'phone_verified_at': phoneVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? provider,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      provider: provider ?? this.provider,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    avatar,
    provider,
    emailVerifiedAt,
    phoneVerifiedAt,
    createdAt,
  ];

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, provider: $provider)';
  }
}
