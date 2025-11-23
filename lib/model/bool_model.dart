import 'package:equatable/equatable.dart';

class BoolModel extends Equatable {
  final String id;
  final String name;
  final String value;

  const BoolModel({required this.id, required this.name, required this.value});

  @override
  List<Object?> get props => [
        id,
        name,
        value,
      ];

  String boolModelName() => name;
}
