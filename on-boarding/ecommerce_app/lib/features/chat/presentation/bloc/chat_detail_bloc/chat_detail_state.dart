

import 'package:equatable/equatable.dart';

abstract class ChatDetailState extends Equatable{
  const ChatDetailState();
  @override
  List<Object>get props => [];
}

class ChatDetailInitial extends ChatDetailState{}
