import 'package:equatable/equatable.dart';

enum MessageStatus { sent, delivered, read }

class ChatMessage extends Equatable {
  final int? id;
  final String text;
  final DateTime timestamp;
  final bool isSentByUser;
  final MessageStatus status;

  const ChatMessage({
    this.id,
    required this.text,
    required this.timestamp,
    required this.isSentByUser,
    this.status = MessageStatus.sent,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as int?,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isSentByUser: json['is_sent_by_user'] as bool,
      status: _statusFromString(json['status'] as String? ?? 'sent'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'is_sent_by_user': isSentByUser,
      'status': _statusToString(status),
    };
  }

  static MessageStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return MessageStatus.delivered;
      case 'read':
        return MessageStatus.read;
      default:
        return MessageStatus.sent;
    }
  }

  static String _statusToString(MessageStatus status) {
    switch (status) {
      case MessageStatus.delivered:
        return 'delivered';
      case MessageStatus.read:
        return 'read';
      default:
        return 'sent';
    }
  }

  @override
  List<Object?> get props => [id, text, timestamp, isSentByUser, status];
}
