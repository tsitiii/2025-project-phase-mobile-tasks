import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  
  @override
  List<Object?> get props => [];
}

class LoadChats extends ChatEvent {
  const LoadChats();
}

class RefreshChats extends ChatEvent {
  const RefreshChats();
}

class SelectChat extends ChatEvent {
  final String chatId;
  final String userName;
  final String userInitials;
  
  const SelectChat({
    required this.chatId,
    required this.userName,
    required this.userInitials,
  });
  
  @override
  List<Object?> get props => [chatId, userName, userInitials];
}

class SearchChats extends ChatEvent {
  final String query;
  
  const SearchChats(this.query);
  
  @override
  List<Object?> get props => [query];
}

class MarkChatAsRead extends ChatEvent {
  final String chatId;
  
  const MarkChatAsRead(this.chatId);
  
  @override
  List<Object?> get props => [chatId];
}

class DeleteChat extends ChatEvent {
  final String chatId;
  
  const DeleteChat(this.chatId);
  
  @override
  List<Object?> get props => [chatId];
}

class ArchiveChat extends ChatEvent {
  final String chatId;
  
  const ArchiveChat(this.chatId);
  
  @override
  List<Object?> get props => [chatId];
}

class ChatUpdated extends ChatEvent {
  final String chatId;
  final String lastMessage;
  final DateTime timestamp;
  
  const ChatUpdated({
    required this.chatId,
    required this.lastMessage,
    required this.timestamp,
  });
  
  @override
  List<Object?> get props => [chatId, lastMessage, timestamp];
}

class NewMessageReceived extends ChatEvent {
  final String chatId;
  final String message;
  final String senderId;
  final DateTime timestamp;
  
  const NewMessageReceived({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.timestamp,
  });
  
  @override
  List<Object?> get props => [chatId, message, senderId, timestamp];
}