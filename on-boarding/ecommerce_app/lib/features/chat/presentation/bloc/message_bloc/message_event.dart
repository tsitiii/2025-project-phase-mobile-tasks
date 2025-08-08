import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetChatMessagesEvent extends MessageEvent {
  final String chatId;

  const GetChatMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class RefreshMessagesEvent extends MessageEvent {
  final String chatId;

  const RefreshMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
} 