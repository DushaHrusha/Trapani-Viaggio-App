import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/chat_state.dart';
import 'package:test_task/data/models/chat_message.dart';
import 'package:test_task/data/repositories/chat_repository.dart';
import 'package:test_task/data/repositories/chat_repository_impl.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    final ChatRepository repository = ChatRepositoryImpl();
    final List<ChatMessage> messages = repository.getMessages();
    emit(ChatLoaded(messages));
  }

  Future<void> loadMessages() async {
    emit(ChatLoading());
    try {} catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
