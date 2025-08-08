import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_entity.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<RefreshChats>(_onRefreshChats);
  }
    // dummy chats for testing how the bloc handles socket and UI
  final List<ChatEntity> _mockChats = [
    ChatEntity(
      id: '1',
      user1: UserEntity(id: '1', name: 'John Doe', email: 'john@gmail.com'),
      user2: UserEntity(id: '2', name: 'Me', email: 'me@gmail.com'),
    ),
    ChatEntity(
      id: '2',
      user1: UserEntity(id: '3', name: 'Alice Smith', email: 'alice@gmail.com'),
      user2: UserEntity(id: '2', name: 'Me', email: 'me@gmail.com'),
    ),
    ChatEntity(
      id: '3',
      user1: UserEntity(id: '4', name: 'Mike Johnson', email: 'mike@gmail.com'),
      user2: UserEntity(id: '2', name: 'Me', email: 'me@gmail.com'),
    ),
  ];

  void _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    emit(const ChatLoading());

    await Future.delayed(const Duration(seconds: 5));
    try {
      emit(ChatLoaded(_mockChats));
    } catch (e) {
      emit(const ChatError('Failed to load chats'));
    }
  }

  void _onRefreshChats(RefreshChats event, Emitter<ChatState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ChatLoaded(_mockChats));
  }
}
