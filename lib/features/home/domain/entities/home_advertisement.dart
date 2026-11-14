import 'package:equatable/equatable.dart';

class HomeAdvertisement extends Equatable {
  const HomeAdvertisement({
    required this.id,
    required this.advertiserName,
    required this.description,
    required this.logoIconKey,
  });

  final String id;
  final String advertiserName;
  final String description;
  final String logoIconKey;

  @override
  List<Object?> get props => [id, advertiserName, description, logoIconKey];
}
