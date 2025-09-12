import 'package:test_task/data/models/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getMessages();
  Future<void> addMessage(ChatMessage message);
}
