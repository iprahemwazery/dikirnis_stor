import 'package:equatable/equatable.dart';

class HomeBanner extends Equatable {
  const HomeBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String id;
  final String title;
  final String subtitle;
  final String image;

  @override
  List<Object?> get props => [id, title, subtitle, image];
}
