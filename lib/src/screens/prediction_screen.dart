import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/select_player_screen.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';
import 'package:friendly_gaming/src/widgets/statistics_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  User firstPlayer;
  User secondPlayer;

  @override
  void initState() {
    firstPlayer = User.empty;
    secondPlayer = User.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prediction',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 32.0,
                                  backgroundImage: firstPlayer == User.empty
                                      ? AssetImage(
                                          'assets/images/img4.png',
                                        )
                                      : CachedNetworkImageProvider(
                                          firstPlayer?.photo)),
                              SizedBox(height: 8.0),
                              Text(
                                firstPlayer?.name ?? 'Player Name',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blueGrey,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: () => showBarModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          PlayerSelectionScreen((user) {
                                            setState(() {
                                              firstPlayer = user;
                                            });
                                            Navigator.of(context).pop();
                                          })),
                                  child: Text('Select',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'VS',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 32.0,
                                  backgroundImage: secondPlayer == User.empty
                                      ? AssetImage(
                                          'assets/images/img4.png',
                                        )
                                      : CachedNetworkImageProvider(
                                          secondPlayer?.photo)),
                              SizedBox(height: 8.0),
                              Text(
                                secondPlayer?.name ?? 'Player Name',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blueGrey,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: () => showBarModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          PlayerSelectionScreen((user) {
                                            setState(() {
                                              secondPlayer = user;
                                            });
                                            Navigator.of(context).pop();
                                          })),
                                  child: Text('Select',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              onPressed: (firstPlayer != User.empty &&
                      secondPlayer != User.empty)
                  ? () {
                      context.read<DataBloc>().add(FetchMultiPlayerGamesEvent(
                          firstPlayerId: firstPlayer.id,
                          secondPlayerId: secondPlayer.id));
                    }
                  : null,
              minWidth: MediaQuery.of(context).size.width,
              color: Colors.blue,
              disabledColor: Colors.grey,
              child: Text('Compare and Predict',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          BlocBuilder<DataBloc, DataState>(
            // buildWhen: (previous, current) => !(previous is MutilPlayerGamesFetched),
            builder: (context, state) {
              if (state is MultiPlayerGamesFetched) {
                print('MutilPlayerGamesFetched state');
                Map<String, dynamic> gamesData = state.games;
                var playerOneData = FGUtils.getPlayerStatsInfo(
                    gamesData['firstPlayerGames'], firstPlayer.id);
                var secondOneData = FGUtils.getPlayerStatsInfo(
                    gamesData['secondPlayerGames'], secondPlayer.id);

                return Container(
                  margin: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      Text(firstPlayer.name ?? '',
                          style: Theme.of(context).textTheme.headline6),
                      StatisticsItem(
                        data: playerOneData,
                      ),
                      SizedBox(height: 16.0),
                      Text(secondPlayer.name ?? '',
                          style: Theme.of(context).textTheme.headline6),
                      StatisticsItem(
                        data: secondOneData,
                      ),
                    ],
                  ),
                );
              }

              if (state is FetchMultiPlayerGamesLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 120),
                  child: Center(
                      child: SpinKitDualRing(
                    lineWidth: 2,
                    size: 32.0,
                    color: Colors.blueGrey,
                  )),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 120.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 50,
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        "Select two players you want to compare from above and click the button above to compare and predict.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
