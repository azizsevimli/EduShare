class MessageModel {
  final String senderId;
  final String materialId;
  final String text;
  final DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.materialId,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'materialId': materialId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      materialId: map['materialId'],
      text: map['text'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
