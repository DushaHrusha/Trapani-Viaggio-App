import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/chat_state.dart';
import 'package:test_task/data/models/chat_message.dart';
import 'package:test_task/data/repositories/chat_repository.dart';
import 'package:test_task/data/repositories/chat_repository_impl.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository = ChatRepositoryImpl();

  ChatCubit() : super(ChatInitial());

  Future<void> loadMessages() async {
    emit(ChatLoading());
    try {
      final messages = await repository.getMessages();
      emit(ChatLoaded(messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void sendMessage(String text) {
    final message = ChatMessage(
      text: text,
      timestamp: DateTime.now(),
      isSentByUser: true,
    );

    final state = this.state;
    if (state is ChatLoaded) {
      repository.addMessage(message);
      emit(ChatLoaded([...state.messages, message]));
    }
  }

  void receiveMessage(ChatMessage message) {
    final state = this.state;
    if (state is ChatLoaded) {
      repository.addMessage(message);
      emit(ChatLoaded([...state.messages, message]));
    }
  }
}
