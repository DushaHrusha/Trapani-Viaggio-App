import 'package:test_task/data/models/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getMessages();
  Future<ChatMessage> addMessage(ChatMessage message);
  Future<ChatMessage> getMessageById(int id);
}
