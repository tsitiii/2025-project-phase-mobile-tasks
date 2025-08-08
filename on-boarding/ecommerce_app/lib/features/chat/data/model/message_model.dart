import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.content,
    required super.senderId,
    required super.chatId,
    required super.timestamp,
    required super.type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      senderId: json['senderId'] ?? '',
      chatId: json['chatId'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      type: json['type'] ?? 'text',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'senderId': senderId,
      'chatId': chatId,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
    };
  }
} 