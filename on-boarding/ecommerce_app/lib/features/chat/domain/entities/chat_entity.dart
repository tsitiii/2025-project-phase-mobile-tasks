import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final UserEntity user1;
  final UserEntity user2;

  const ChatEntity({
    required this.id,
    required this.user1,
    required this.user2,
  });

  @override
  List<Object> get props => [id, user1, user2];
}

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object> get props => [id, name, email];
}