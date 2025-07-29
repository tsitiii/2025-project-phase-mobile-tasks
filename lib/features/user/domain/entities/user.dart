import 'package:equatable/equatable.dart';

/// Domain entity - should be completely independent of external frameworks
/// This represents the core business object in our domain
class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  @override
  List<Object?> get props => [id, name, email, phone, website];
}