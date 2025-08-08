import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final String chatId;
  final DateTime timestamp;
  final String type;

  const MessageEntity({
    required this.id,
    required this.content,
    required this.senderId,
    required this.chatId,
    required this.timestamp,
    required this.type,
  });

  @override
  List<Object> get props => [id, content, senderId, chatId, timestamp, type];
} 