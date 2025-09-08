import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApartmentsCubit extends Cubit<ApartmentsState> {
  ApartmentsCubit() : super(ApartmentsInitial());
  final ApartmentsRepository _apartmentsRepository = ApartmentsRepository();

  void loadExcursions() {
    List<Apartments> apartments = _apartmentsRepository.apartments;
    emit(ApartmentsLoaded(apartments));
  }
}

@immutable
abstract class ApartmentsState {}

class ApartmentsInitial extends ApartmentsState {}

class ApartmentsLoaded extends ApartmentsState {
  final List<Apartments> apartments;

  ApartmentsLoaded(this.apartments);
}

class ApartmentsRepository {
  List<Apartments> apartments = [
    Apartments(
      title: 'Горы Кaвказа',
      imageUrl: ["assets/file/maraslua.jpg"],
      description:
          'Most popular bicycle tour to Natural Reserve Salt pans in Trapani.',
      price: 3500,
    ),
    Apartments(
      title: 'Горы Кaвказа',
      imageUrl: ["assets/file/maraslua.jpg"],
      description:
          'Most popular bicycle tour to Natural Reserve Salt pans in Trapani. You will visit saline work museum in an old salt mill and enjoy fantastic landscapes. ',
      price: 3500,
    ),
    Apartments(
      title: 'Петwrerергоф',
      imageUrl: ["assets/file/maraslua.jpg"],
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 2500,
    ),
    Apartments(
      title: 'Петерг2434оф',
      imageUrl: ["assets/file/maraslua.jpg"],
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 2500,
    ),
    Apartments(
      title: 'Петергewrweоф',
      imageUrl: ["assets/file/maraslua.jpg"],
      description: 'Экскурсия по дворцам и фонтанам Петергофа.',
      price: 2500,
    ),
    // Add other excursions here...
  ];
}

class Apartments {
  final String title;
  final List<String> imageUrl;
  final String description;
  final double price;

  Apartments({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}
