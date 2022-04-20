import 'dart:convert';

class Message {
  String text;
  int timeUnix;
  bool byPurchaser;
  Message({
    required this.text,
    required this.timeUnix,
    required this.byPurchaser,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timeUnix': timeUnix,
      'byPurchaser': byPurchaser,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      timeUnix: map['timeUnix']?.toInt() ?? 0,
      byPurchaser: map['byPurchaser'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));
}
