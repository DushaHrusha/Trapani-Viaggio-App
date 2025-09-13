import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_task/bloc/cubits/chat_cubit.dart';
import 'package:test_task/bloc/state/chat_state.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/data/models/chat_message.dart';
import 'package:test_task/data/repositories/chat_repository.dart';
import 'package:test_task/data/repositories/chat_repository_impl.dart';
import 'package:test_task/presentation/main_menu_screen.dart';

enum MessageStatus { sent, delivered, read }

class ChatScreen extends StatelessWidget {
  final ChatRepository repository = ChatRepositoryImpl();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(repository)..loadMessages(),
      child: Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ChatLoaded) {
              return CustomBackgroundWithGradient(
                child: Column(
                  children: [
                    CustomAppBar(
                      label: "online assistance",
                      returnPage: MainMenuScreen(),
                    ),
                    GreyLine(),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        reverse: false,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          final previousMessage =
                              index + 1 < state.messages.length
                                  ? state.messages[index + 1]
                                  : null;
                          return ChatBubble(
                            message: message,
                            isMe: message.isSentByUser,
                            time: DateFormat('HH:mm').format(message.timestamp),
                            previousMessage: previousMessage,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is ChatError) {
              return Center(child: Text('Ошибка: ${state.message}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: BottomBar(currentScreen: context.widget),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  final String time;
  final ChatMessage? previousMessage;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
    this.previousMessage,
  });

  bool _isDifferentDay(DateTime? date1, DateTime date2) {
    if (date1 == null) return true;
    return date1.year != date2.year ||
        date1.month != date2.month ||
        date1.day != date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (previousMessage == null ||
            _isDifferentDay(previousMessage?.timestamp, message.timestamp))
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.adaptiveSize(8.0)),
            child: Text(
              DateFormat('dd.MM.yyyy \'at\' HH.mm').format(message.timestamp),
              style: context.adaptiveTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(151, 151, 151, 1),
              ),
            ),
          ),

        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(bottom: context.adaptiveSize(28)),
              child: Stack(
                alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: context.adaptiveSize(250),
                    margin:
                        isMe
                            ? EdgeInsets.only(
                              top: context.adaptiveSize(22),
                              right: context.adaptiveSize(22),
                            )
                            : EdgeInsets.only(
                              top: context.adaptiveSize(22),
                              left: context.adaptiveSize(22),
                            ),
                    padding: EdgeInsets.all(context.adaptiveSize(30)),
                    decoration: BoxDecoration(
                      color:
                          isMe
                              ? BaseColors.secondary
                              : BaseColors.backgroundCircles,
                      borderRadius: BorderRadius.all(
                        Radius.circular(context.adaptiveSize(32)),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: context.adaptiveTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isMe ? BaseColors.background : BaseColors.text,
                      ),
                    ),
                  ),
                  if (!isMe)
                    CircleAvatar(
                      radius: context.adaptiveSize(22),
                      backgroundImage: AssetImage(
                        'assets/file/avatars/another.jpg',
                      ),
                    ),
                  if (isMe)
                    CircleAvatar(
                      radius: context.adaptiveSize(22),
                      backgroundImage: AssetImage('assets/file/avatars/me.jpg'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
