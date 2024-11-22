class Message {
  final int id;
  final int userId;
  final String content;
  final String timestamp;
  final int? channelId;
  final bool isForumMessage;
  final int? dmUserId;

  Message({
    required this.id,
    required this.userId,
    required this.content,
    required this.timestamp,
    this.channelId,
    required this.isForumMessage,
    this.dmUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'timestamp': timestamp,
      'channel_id': channelId,
      'is_forum_message': isForumMessage ? 1 : 0,
      'dm_user_id': dmUserId,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      userId: map['user_id'],
      content: map['content'],
      timestamp: map['timestamp'],
      channelId: map['channel_id'],
      isForumMessage: map['is_forum_message'] == 1,
      dmUserId: map['dm_user_id'],
    );
  }
}
