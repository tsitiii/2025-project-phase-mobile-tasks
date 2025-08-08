

import 'package:equatable/equatable.dart';

abstract class ChatDetailEvent extends Equatable{
  const ChatDetailEvent();
  @override
  List<Object> get props=> [];
}

class ChatDetailMessageSent extends ChatDetailEvent{}