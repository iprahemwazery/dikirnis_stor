import 'package:equatable/equatable.dart';

class ServiceCategory extends Equatable {
  const ServiceCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.iconKey,
    required this.providersCount,
    this.subcategoriesCount = 0,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final String iconKey;
  final int providersCount;
  final int subcategoriesCount;

  String localizedName(String languageCode) {
    return languageCode.startsWith('ar') ? nameAr : nameEn;
  }

  @override
  List<Object?> get props => [
    id,
    nameAr,
    nameEn,
    iconKey,
    providersCount,
    subcategoriesCount,
  ];
}
