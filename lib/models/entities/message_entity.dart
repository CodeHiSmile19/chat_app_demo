class MessageEntity {
  String? receiverId;
  String? senderId;
  String? messageBody;
  int? createdAt;
  bool? isImage;
  String? imageUrl;

  MessageEntity({
    this.receiverId,
    this.senderId,
    this.messageBody,
    this.createdAt,
    this.isImage,
    this.imageUrl,
  });

  MessageEntity.fromJson(Map<String, dynamic> data)
      : receiverId = data['receiverId'],
        senderId = data['senderId'],
        messageBody = data['messageBody'],
        createdAt = data['createdAt'],
        isImage = data['isImage'],
        imageUrl = data['imageUrl'];

  static MessageEntity fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      messageBody: map['messageBody'],
      createdAt: map['createdAt'],
      isImage: map['isImage'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'messageBody': messageBody,
      'createdAt': createdAt,
      'isImage': isImage,
      'imageUrl': imageUrl,
    };
  }
}
