import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message_entity.dart';
import '../repository/message_repository.dart';

class GetChatMessages {
  final MessageRepository repository;

  GetChatMessages(this.repository);
  
  Future<Either<Failure, List<MessageEntity>>> call(String chatId) async {
    return await repository.getChatMessages(chatId);
  }
} 