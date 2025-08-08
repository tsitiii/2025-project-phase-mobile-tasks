import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_chat_messages_usecase.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetChatMessages getChatMessages;

  MessageBloc({
    required this.getChatMessages,
  }) : super(const MessageInitial()) {
    on<GetChatMessagesEvent>(_onGetChatMessages);
    on<RefreshMessagesEvent>(_onRefreshMessages);
  }

  void _onGetChatMessages(GetChatMessagesEvent event, Emitter<MessageState> emit) async {
    print('MessageBloc: GetChatMessagesEvent received for chatId: ${event.chatId}');
    emit(const MessageLoading());

    final result = await getChatMessages(event.chatId);

    result.fold(
      (failure) {
        print('MessageBloc: Failure - ${failure.message}');
        emit(MessageError(message: failure.message));
      },
      (messages) {
        print('MessageBloc: Success - ${messages.length} messages loaded');
        emit(MessageLoaded(messages: messages));
      },
    );
  }

  void _onRefreshMessages(RefreshMessagesEvent event, Emitter<MessageState> emit) async {
    print('MessageBloc: RefreshMessagesEvent received for chatId: ${event.chatId}');
    
    final result = await getChatMessages(event.chatId);

    result.fold(
      (failure) {
        print('MessageBloc: Refresh Failure - ${failure.message}');
        emit(MessageError(message: failure.message));
      },
      (messages) {
        print('MessageBloc: Refresh Success - ${messages.length} messages loaded');
        emit(MessageLoaded(messages: messages));
      },
    );
  }
} 