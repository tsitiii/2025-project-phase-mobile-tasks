import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/message_entity.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<MessageEntity>>> getChatMessages(String chatId);
} 