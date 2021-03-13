import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/game_requests_screen.dart';
import 'package:friendly_gaming/src/screens/my_games_screen.dart';
import 'package:friendly_gaming/src/screens/notification_screen.dart';
import 'package:friendly_gaming/src/screens/prediction_screen.dart';
import 'package:friendly_gaming/src/screens/settings_screen.dart';
import 'package:friendly_gaming/src/screens/statistics_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    context.bloc<DataBloc>().add(UserDataEvent(uid: widget.user.id));
    return BlocConsumer<DataBloc, DataState>(
        buildWhen: (previous, current) => current is UserDataState,
        listener: (context, state) {},
        builder: (context, state) {
          User user;
          if (state is UserDataState) {
            user = state.user;
            print(
                'Users profile called here ******************************************');
          }
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    padding: EdgeInsets.all(1),
                    // width: 100,
                    // height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: user?.photo != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: '${user.photo}',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                        : ClipOval(
                            child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: state is UserDataState
                                ? Container(
                                    width: 100,
                                    height: 100,
                                  )
                                : Image.asset(
                                    'assets/images/profile_icon.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  user?.name != null
                      ? Column(
                          children: [
                            Text(
                              '${user?.name ?? ''}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '${user?.email ?? ''}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 20,
                            color: Colors.blueGrey,
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.timeline,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Statistics',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StatisticsScreen(user: user))),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.gamepad,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'My Games',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: MyGamesScreen()));
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.checkroom_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Game Requests',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: GameRequestsScreen()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.sports_soccer_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Prediction',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: PredictionScreen()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6
                                .color
                                .withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AppSettingsScreen()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .color
                                  .withOpacity(0.5),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          context.bloc<AuthBloc>().add(LogoutEvent());
                          // Navigator.popUntil(context, ModalRoute.withName('/login'));
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
