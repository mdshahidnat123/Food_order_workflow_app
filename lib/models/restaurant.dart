import 'package:equatable/equatable.dart';
import 'menu_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String cuisine;
  final List<MenuItem> menu;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.menu,
  });

  @override
  List<Object?> get props => [id, name, cuisine, menu];
}
