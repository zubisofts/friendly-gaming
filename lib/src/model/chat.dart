import 'package:friendly_gaming/src/datasource/chat_data.dart';

class Chat {
  int userId;
  String name;
  String lastMessage;
  String date;
  String image;

  Chat({this.userId, this.name, this.lastMessage, this.date, this.image});

  static List<Chat> getChats() => chats.map((e) => Chat(
      userId: e["user_id"],
      name: e["name"],
      lastMessage: e["last_message"],
      date: e["date"],
      image: e["image"])).toList();
}
