import 'package:equatable/equatable.dart';

class HomeCategory extends Equatable {
  const HomeCategory({
    required this.id,
    required this.name,
    required this.iconKey,
    this.isMore = false,
  });

  final String id;
  final String name;
  final String iconKey;
  final bool isMore;

  @override
  List<Object?> get props => [id, name, iconKey, isMore];
}
