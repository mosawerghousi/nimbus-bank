import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  const Contact({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.accountNumberMasked,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String accountNumberMasked;

  @override
  List<Object?> get props => [id, name];
}
