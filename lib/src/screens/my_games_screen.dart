import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendly_gaming/src/blocs/app/app_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/utils/constants.dart';
import 'package:friendly_gaming/src/widgets/edit_game_timeline.dart';
import 'package:friendly_gaming/src/widgets/timeline_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyGamesScreen extends StatefulWidget {
  @override
  _MyGamesScreenState createState() => _MyGamesScreenState();
}

class _MyGamesScreenState extends State<MyGamesScreen> {
  bool showGameInfo = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      var preferences = await StreamingSharedPreferences.instance;
      var showInfo = preferences
          .getBool(Constants.SHOW_GAME_INFO_KEY_1, defaultValue: true)
          .getValue();
      if (showInfo) {
        _showInfo(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DataBloc>().add(FetchPostEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Games',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            // color: Colors.grey[200],
            ),
        child: BlocConsumer<DataBloc, DataState>(
          buildWhen: (previous, current) => current is PostsFetchedState,
          builder: (context, state) {
            if (state is PostsFetchedState) {
              var result = state.posts;
              List<Post> posts = result
                  .where((post) =>
                      (post.firstPlayerId == AuthBloc.uid ||
                          post.secondPlayerId == AuthBloc.uid) &&
                      post.status == 'active')
                  .toList();

              return posts.isNotEmpty
                  ? ListView.builder(
                      // addAutomaticKeepAlives: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index == posts.length - 1 ? 0.0 : 0.0),
                          child: EditGameCard(
                            timelineData: posts[index],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/empty_request.svg',
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "You don't have any active games at the moment.",
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
            } else {
              print('----Other State---$state-------');
              return Center(
                child: SpinKitDualRing(
                  color: Colors.blueGrey,
                  size: 36,
                  lineWidth: 2,
                ),
              );
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  void _showInfo(BuildContext context) {
    AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'You and your opponent can only modify the games scores only once each, if both score do not tally the games will be canceled.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color,
                    fontSize: 16.0,
                    height: 1.5),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  InfoCheckBox(showGameInfo: showGameInfo),
                  SizedBox(width: 16.0),
                  Text(
                    "Don't show again",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontSize: 16.0,
                        height: 1.5),
                  ),
                ],
              )
            ],
          ),
        ),
        headerAnimationLoop: false,
        btnOk: FlatButton(
          onPressed: () async {
            saveInfoPrefrences(showGameInfo);
            Navigator.of(context).pop();
          },
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Text(
            'GOT IT',
            style: TextStyle(color: Colors.white),
          ),
        ))
      ..show();
  }

  void saveInfoPrefrences(bool val) async {
    var pref = await StreamingSharedPreferences.instance;
    pref.setBool(Constants.SHOW_GAME_INFO_KEY_1, val);
  }
}

class InfoCheckBox extends StatefulWidget {
  InfoCheckBox({
    Key key,
    @required this.showGameInfo,
  }) : super(key: key);

  bool showGameInfo;

  @override
  _InfoCheckBoxState createState() => _InfoCheckBoxState();
}

class _InfoCheckBoxState extends State<InfoCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      onChanged: (bool value) {
        setState(() {
          widget.showGameInfo = value;
        });
      },
      value: widget.showGameInfo,
    );
  }
}
