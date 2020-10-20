import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/widgets/user_row_widget.dart';

class NewChallenge extends StatefulWidget {
  @override
  _NewChallengeState createState() => _NewChallengeState();
}

class _NewChallengeState extends State<NewChallenge> {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.bloc<DataBloc>().add(FetchUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text('Select Opponent', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              onChanged: (value) =>
                  context.bloc<DataBloc>().add(SearchUserEvent(query: value)),
              decoration: InputDecoration(
                  hintText: 'Search opponent',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          ),
        ),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          List<User> users = [];
          if (state is UsersFetchedState) {
            users = state.users;
          }

          if (state is UsersLoadingState) {
            return Center(
              child: SpinKitDualRing(
                color: Colors.blueGrey,
                size: 36,
                lineWidth: 2,
              ),
            );
          }

          return users.isNotEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return UserRowWidget(
                      user: users[index],
                      onTap: (user) =>
                          _settingModalBottomSheet(context, user),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No users found',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
        },
      ),
    );
  }

  void _settingModalBottomSheet(BuildContext context, User user) {
    scafoldKey.currentState.showBottomSheet(
        (context) => Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  top: -40,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.blue),
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              CachedNetworkImageProvider(user.photo),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 16.0, top: 50.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Text(
                            user.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: Colors.orangeAccent,
                                    )),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total games played:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '56',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.0,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Games won:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '35',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.0,
                                      color: Colors.green),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Games Lost:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '15',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.0,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Games drawn:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '6',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.0,
                                      color: Colors.blueAccent),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            width: MediaQuery.of(context).size.width,
                            child: FlatButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                color: Colors.blue,
                                child: Text(
                                  'Send Challenge',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
        elevation: 8.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0))));
  }
}
