import 'package:equatable/equatable.dart';
import '../../../domain/entities/message_entity.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  const MessageInitial();
}

class MessageLoading extends MessageState {
  const MessageLoading();
}

class MessageLoaded extends MessageState {
  final List<MessageEntity> messages;

  const MessageLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageError extends MessageState {
  final String message;

  const MessageError({required this.message});

  @override
  List<Object> get props => [message];
} 