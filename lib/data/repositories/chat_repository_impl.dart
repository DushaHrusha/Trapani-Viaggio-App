import 'package:test_task/api_client.dart';
import 'package:test_task/api_endpoints.dart';
import 'package:test_task/data/models/chat_message.dart';
import 'package:test_task/data/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ApiClient _apiClient;

  ChatRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<ChatMessage>> getMessages() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.chatMessages);

      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] as List;
        return data.map((json) => ChatMessage.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load messages');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChatMessage> addMessage(ChatMessage message) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.chatMessages,
        data: message.toJson(),
      );

      if (response.data['success'] == true) {
        return ChatMessage.fromJson(response.data['data']);
      } else {
        throw ServerException('Failed to send message');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChatMessage> getMessageById(int id) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.chatMessageById(id));

      if (response.data['success'] == true) {
        return ChatMessage.fromJson(response.data['data']);
      } else {
        throw ServerException('Message not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}
