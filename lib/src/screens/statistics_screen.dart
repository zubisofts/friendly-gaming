import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/widgets/chart_stat.dart';
import 'package:friendly_gaming/src/widgets/statistics_item.dart';

class StatisticsScreen extends StatefulWidget {
  final User user;
  StatisticsScreen({this.user});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    context.read<DataBloc>().add(FetchUserGamesEvent(uid: widget.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Statistics',
            style:
                TextStyle(color: Theme.of(context).textTheme.headline6.color)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.headline6.color,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    ClipOval(
                      child: CircleAvatar(
                        radius: 45,
                        child: CachedNetworkImage(
                            imageUrl: '${widget.user.photo}'),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      '${widget.user?.name ?? ''}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${widget.user?.email ?? ''}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  if (state is UserGamesFetched) {
                    var data = getData(state.games);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Game Chart Summary',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 16.0),
                        ),
                        PieChartWidget(data: data),
                        Text(
                          'Game Table',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 16.0),
                        ),
                        StatisticsItem(data: data),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    );
                  }
                  return Text('Please wait');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData(List<Post> games) {
    int total = games.length;
    var fifaGames = games.where((game) => game.gameType == 'FIFA');
    var pesGames = games.where((game) => game.gameType == 'PES');
    var fifaWins1 = fifaGames
        .where((g) => g.firstPlayerId == widget.user.id)
        .where(
            (g) => g.scores['firstPlayerScore'] > g.scores['secondPlayerScore'])
        .toList();

    var fifaWins2 = fifaGames
        .where((g) => g.secondPlayerId == widget.user.id)
        .where(
            (g) => g.scores['secondPlayerScore'] > g.scores['firstPlayerScore'])
        .toList();

    var fifaLose1 = fifaGames
        .where((g) => g.firstPlayerId == widget.user.id)
        .where(
            (g) => g.scores['firstPlayerScore'] < g.scores['secondPlayerScore'])
        .toList();

    var fifaLose2 = fifaGames
        .where((g) => g.secondPlayerId == widget.user.id)
        .where(
            (g) => g.scores['secondPlayerScore'] < g.scores['firstPlayerScore'])
        .toList();

    var pesWins1 = fifaGames
        .where((g) => g.firstPlayerId == widget.user.id)
        .where(
            (g) => g.scores['firstPlayerScore'] > g.scores['secondPlayerScore'])
        .toList();

    var pesWins2 = fifaGames
        .where((g) => g.secondPlayerId == widget.user.id)
        .where(
            (g) => g.scores['secondPlayerScore'] > g.scores['firstPlayerScore'])
        .toList();

    var pesLose1 = fifaGames
        .where((g) => g.firstPlayerId == widget.user.id)
        .where(
            (g) => g.scores['firstPlayerScore'] < g.scores['secondPlayerScore'])
        .toList();

    var pesLose2 = fifaGames
        .where((g) => g.secondPlayerId == widget.user.id)
        .where(
            (g) => g.scores['secondPlayerScore'] < g.scores['firstPlayerScore'])
        .toList();

    var data = {
      'total': total,
      'pesWins': List.from(pesWins1)..addAll(pesWins2),
      'fifaWins': List.from(fifaWins1)..addAll(fifaWins2),
      'pesLoses': List.from(pesLose1)..addAll(pesLose2),
      'fifaLoses': List.from(fifaLose1)..addAll(fifaLose2),
    };

    return data;
  }
}
