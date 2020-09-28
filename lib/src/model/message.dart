
class Message {
  int id;
  int userId;
  String time;
  String message;

  Message({this.id, this.userId, this.time, this.message});

  static List<Message> getMessages() {
    List<Message> msg = List();
    msg.add(Message(id: 23, userId: 1, time: "11:23 PM", message: "Hi dear"));
    msg.add(
        Message(id: 23, userId: 2, time: "11:24 PM", message: "Hello dear"));
    msg.add(Message(
        id: 23, userId: 1, time: "11:28 PM", message: "How are you doing"));
    msg.add(Message(
        id: 23, userId: 2, time: "11:30 PM", message: "I'm doing good."));
    msg.add(Message(
        id: 23, userId: 2, time: "11:36 PM", message: "What about you?"));
    msg.add(Message(
        id: 23,
        userId: 1,
        time: "11:37 PM",
        message:
            "How did you go about that stuff we discussed the other day?"));
    msg.add(Message(
        id: 23,
        userId: 2,
        time: "11:38 PM",
        message:
            "My dear, it wen fine by God's grace. It was a success and more than expected..."));
    msg.add(Message(
        id: 23,
        userId: 1,
        time: "11:40 PM",
        message: "Wow! that's so cool..."));
    msg.add(Message(
        id: 23, userId: 2, time: "11:42 PM", message: "To God be the glory."));
    msg.add(Message(id: 23, userId: 2, time: "11:44 PM", message: "Yes dear"));
    msg.add(Message(
        id: 23, userId: 1, time: "11:46 PM", message: "You are doing well."));

    return msg;
  }
}
