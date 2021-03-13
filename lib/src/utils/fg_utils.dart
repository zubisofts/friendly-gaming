import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:intl/intl.dart';

class FGUtils {
  static String displayTimeAgoFromTimestamp(int millisecondsSinceEpoch,
      {bool numericDates = true}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String getTimeFromTimestamp(int millisecondsSinceEpoch) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String time = DateFormat.jm().format(date);
    return time;
  }

  static Future<void> shareScore(String title, imageData, String text) async {
    try {
      Share.file(title, 'Image.png', imageData, "image/png", text: text);
    } catch (ex) {
      print(ex);
    }
    // Share.text(title,"hdfjhil","text");
  }

  static Map<String,dynamic> getPlayerStatsInfo(List<Post> games, String userId){
    int total = games.length;
    var fifaGames = games.where((game) => game.gameType == 'FIFA');
    var pesGames = games.where((game) => game.gameType == 'PES');
    var fifaWins1 = fifaGames
        .where((g) => g.firstPlayerId == userId)
        .where(
            (g) => g.scores['firstPlayerScore'] > g.scores['secondPlayerScore'])
        .toList();

    var fifaWins2 = fifaGames
        .where((g) => g.secondPlayerId == userId)
        .where(
            (g) => g.scores['secondPlayerScore'] > g.scores['firstPlayerScore'])
        .toList();

    var fifaLose1 = fifaGames
        .where((g) => g.firstPlayerId == userId)
        .where(
            (g) => g.scores['firstPlayerScore'] < g.scores['secondPlayerScore'])
        .toList();

    var fifaLose2 = fifaGames
        .where((g) => g.secondPlayerId == userId)
        .where(
            (g) => g.scores['secondPlayerScore'] < g.scores['firstPlayerScore'])
        .toList();

    var pesWins1 = pesGames
        .where((g) => g.firstPlayerId == userId)
        .where(
            (g) => g.scores['firstPlayerScore'] > g.scores['secondPlayerScore'])
        .toList();

    var pesWins2 = pesGames
        .where((g) => g.secondPlayerId == userId)
        .where(
            (g) => g.scores['secondPlayerScore'] > g.scores['firstPlayerScore'])
        .toList();

    var pesLose1 = pesGames
        .where((g) => g.firstPlayerId == userId)
        .where(
            (g) => g.scores['firstPlayerScore'] < g.scores['secondPlayerScore'])
        .toList();

    var pesLose2 = pesGames
        .where((g) => g.secondPlayerId == userId)
        .where(
            (g) => g.scores['secondPlayerScore'] < g.scores['firstPlayerScore'])
        .toList();

    var data = {
      'total': total,
      'pesWins': List.from(pesWins1)..addAll(pesWins2),
      'fifaWins': List.from(fifaWins1)..addAll(fifaWins2),
      'pesLoses': List.from(pesLose1)..addAll(pesLose2),
      'fifaLoses': List.from(fifaLose1)..addAll(fifaLose2),
      'pesTotal': pesGames.length,
      'fifaTotal': fifaGames.length
    };

    return data;
  }
}
