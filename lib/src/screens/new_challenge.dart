import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/widgets/user_row_widget.dart';

class NewChallenge extends StatefulWidget {
  @override
  _NewChallengeState createState() => _NewChallengeState();
}

class _NewChallengeState extends State<NewChallenge> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.bloc<DataBloc>().add(FetchUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Select Opponent', style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              onChanged: (value) =>
                  context.bloc<DataBloc>().add(SearchUserEvent(query: value)),
              style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
              decoration: InputDecoration(
                  hintText: 'Search opponent',
                  hintStyle: TextStyle(color: Theme.of(context).textTheme.headline6.color.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search,color: Theme.of(context).textTheme.headline6.color,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          ),
        ),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        buildWhen: (previous, current) =>
            current is UsersFetchedState || current is UsersLoadingState,
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
                      onTap: (user) {
                        _showActionModalBottomSheet(context, user);
                      },
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

  void _showActionModalBottomSheet(BuildContext context, User user) {
    context.bloc<DataBloc>().add(RefreshEvent());
    showModalBottomSheet(
        context: context,
        builder: (context)=>Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -40,
              left: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
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
                          color: Theme.of(context).textTheme.headline6.color,
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
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline6.color,
                                  fontWeight: FontWeight.w500),
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
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline6.color,
                                  fontWeight: FontWeight.w500),
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
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.headline6.color,
                                  fontWeight: FontWeight.w500),
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
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.headline6.color,
                                  fontWeight: FontWeight.w500),
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
                      BlocBuilder<DataBloc, DataState>(
                        buildWhen: (previous, current)=>
                        current is SendingRequestState ||
                        current is RequestSentState,
                        builder: (context, state) {
                          if (state is SendingRequestState) {
                            // print('********${user.id}*******');
                            return SendButton(
                              isSent: false,
                              isLoading: true,
                              text: 'Sending...',
                              receiverId: user.id,
                            );
                          }
                          if (state is RequestSentState) {
                            return SendButton(
                              isSent: true,
                              isLoading: false,
                              text: 'Request Sent',
                              receiverId: user.id,
                            );
                          }
                          return SendButton(
                            isSent: false,
                            isLoading: false,
                            text: 'Send Challenge',
                            receiverId: user.id,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 8.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0)))
    );
  }
}

class SendButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final bool isSent;
  final String receiverId;

  const SendButton(
      {Key key, this.isLoading, this.text, this.isSent, this.receiverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
          disabledColor: Colors.grey,
          onPressed: isLoading || isSent
              ? null
              : () {
                  print('*******$receiverId******');
                  context.bloc<DataBloc>().add(SendRequestEvent(
                      requestType: 'SOCCER CHALLENGE', receiverId: receiverId));
                },
          padding: EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          color: isLoading || isSent ? Colors.grey : Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? SpinKitDualRing(
                      color: Colors.white,
                      size: 32.0,
                      lineWidth: 1,
                    )
                  : Icon(
                      Icons.group_add,
                      color: Colors.white,
                      size: 32,
                    ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
