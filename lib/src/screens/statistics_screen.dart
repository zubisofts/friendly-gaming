import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/message_screen.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';
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
        actions: [
          widget.user.id == AuthBloc.uid
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MessageScreen(
                            user: widget.user,
                          ))),
                  icon: Icon(Icons.chat, color: Colors.blueGrey),
                )
        ],
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
                        backgroundImage:
                            CachedNetworkImageProvider('${widget.user.photo}'),
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
                buildWhen: (prev, curr) =>
                    (curr is UserGamesFetched) ||
                    (curr is FetchUserGamesLoading),
                builder: (context, state) {
                  if (state is UserGamesFetched) {
                    Map data =
                        FGUtils.getPlayerStatsInfo(state.games, widget.user.id);
                    return state.games.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Game Chart Summary',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    fontSize: 16.0),
                              ),
                              PieChartWidget(data: data),
                              Text(
                                'Game Table',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    fontSize: 16.0),
                              ),
                              StatisticsItem(data: data),
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          )
                        : Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 32.0),
                                  SvgPicture.asset(
                                    'assets/icons/empty.svg',
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    AuthBloc.uid == widget.user.id
                                        ? 'You have not played any game yet, once you play your statistics will appear here.'
                                        : 'This user have not completed any game yet, once he plays, his game statistics will appear here.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color
                                            .withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  )
                                ],
                              ),
                            ),
                          );
                  }
                  return Center(
                      child: Container(
                    margin: EdgeInsets.only(top: 45.0),
                    child: SpinKitCircle(
                      color: Colors.blueGrey,
                      size: 32.0,
                    ),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
