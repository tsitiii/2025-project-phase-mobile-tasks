import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

/// Data model - extends domain entity and adds serialization capabilities
/// This is part of the data layer and knows about JSON, APIs, etc.
@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.website,
  });

  /// Factory constructor for creating a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Method for converting UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Factory constructor for creating UserModel from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      website: user.website,
    );
  }

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      website: website,
    );
  }
}