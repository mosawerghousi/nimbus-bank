import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.address,
    required this.dateOfBirth,
  });

  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String address;
  final String dateOfBirth;

  @override
  List<Object?> get props => [name, email, phone, address, dateOfBirth];
}
