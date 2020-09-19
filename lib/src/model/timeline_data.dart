import 'package:friendly_gaming/src/datasource/timeline_data_provider.dart';

class TimelineData {
  String firstPlayer;
  String secondPlayer;
  String firstPlayerImageUrl;
  String secondPlayerImageUrl;
  int firstPlayerScore;
  int secondPlayerScore;
  int comments;
  int likes;

  TimelineData(
      {this.firstPlayer,
      this.secondPlayer,
      this.firstPlayerImageUrl,
      this.secondPlayerImageUrl,
      this.firstPlayerScore,
      this.secondPlayerScore,
      this.comments,
      this.likes});

  static List<TimelineData> getTimelines() {
    List<TimelineData> data = timelines.map((e) => TimelineData(
        firstPlayer: e['firstPlayer'],
        secondPlayer: e['secondPlayer'],
        firstPlayerImageUrl: e['firstPlayerImageUrl'],
        secondPlayerImageUrl: e['secondPlayerImageUrl'],
        firstPlayerScore: e['firstPlayerScore'],
        secondPlayerScore: e['secondPlayerScore'],
        comments: e['comments'],
        likes: e['likes'])).toList();

    print(data);

    return data;
  }
}
