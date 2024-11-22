import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../models/message.dart';
import '../providers/message_provider.dart';

class WebSocketService {
  final WebSocketChannel channel;
  final MessageProvider messageProvider;

  WebSocketService(this.channel, this.messageProvider) {
    _listenForMessages();
  }

  void _listenForMessages() {
    channel.stream.listen((messageContent) {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch, // Simple ID generation
        userId: 1, // Example user_id, should be dynamic
        content: messageContent,
        timestamp: DateTime.now().toIso8601String(),
        isForumMessage: false,
        channelId: 1, // Example channel_id, should be dynamic
        dmUserId: null,
      );

      messageProvider.addMessage(message);
    });
  }

  void sendMessage(String content) {
    channel.sink.add(content);
  }

  void closeConnection() {
    channel.sink.close(status.goingAway);
  }
}
