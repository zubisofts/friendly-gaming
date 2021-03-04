import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/notification.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/add_post_screen.dart';
import 'package:friendly_gaming/src/screens/chat_screen.dart';
import 'package:friendly_gaming/src/screens/contacts_screen.dart';
import 'package:friendly_gaming/src/screens/incoming_call_screen.dart';
import 'package:friendly_gaming/src/screens/new_challenge.dart';
import 'package:friendly_gaming/src/screens/notification_screen.dart';
import 'package:friendly_gaming/src/screens/profile_screen.dart';
import 'package:friendly_gaming/src/screens/timeline_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages;
  List<String> pageTitles;
  int activePage;
  String title;
  PageController pageController;
  GlobalKey fabKey = GlobalKey();
  GlobalKey navKey = GlobalKey();
  bool isSelected;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pages = [TimelineScreen(), ChatScreen(), ProfileScreen(user: widget.user)];
    pageTitles = ['Timeline', 'Chats', 'Profile'];
    activePage = 0;
    title = pageTitles[0];
    isSelected = false;
    pageController = PageController(
      initialPage: activePage,
    );
    context.read<DataBloc>().add(FetchNotificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        elevation: 0.5,
        toolbarHeight: 90,
        leading: Container(),
        // backgroundColor: Colors.white,
        // centerTitle: true,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Friendly',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 14)),
                  Text(
                    'Gaming',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '|',
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 18),
            ),
          ],
        ),
        actions: [
          BlocBuilder<DataBloc, DataState>(
            buildWhen: (previous, current) =>
                current is NotificationsFetchedState,
            builder: (context, state) {
              List<FGNotification> notifs = [];
              if (state is NotificationsFetchedState) {
                notifs = state.notifications
                    .where((element) => !element.read)
                    .toList();
                print('***********Notiications************${notifs.length}');
              }
              return notifs.isEmpty
                  ? IconButton(
                      icon: Icon(Icons.notifications, color: Colors.blueGrey),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: NotificationScreen()));
                      })
                  : Badge(
                      position: BadgePosition.topEnd(top: 30, end: 12),
                      animationDuration: Duration(milliseconds: 300),
                      animationType: BadgeAnimationType.slide,
                      child: IconButton(
                          icon:
                              Icon(Icons.notifications, color: Colors.blueGrey),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: NotificationScreen()));
                          }),
                    );
            },
          ),
        ],
      ),
      body: BlocListener<DataBloc, DataState>(
        listenWhen: (previous, current) => current is IncomingCallReceivedState,
        listener: (context, state) {
          if (state is IncomingCallReceivedState) {
            if (state.call.incoming && !state.call.isActive) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: IncomingCallScreen(call: state.call)));
            }
          }
        },
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: pages,
          controller: pageController,
        ),
      ),
      floatingActionButton: activePage == 0 || activePage == 1
          ? FloatingActionButton(
              key: fabKey,
              tooltip: 'Add Post',
              child: Icon(activePage == 0 ? Icons.add : Icons.message_outlined, color:Colors.white),
              onPressed: () {
                // scaffoldKey.currentState
                // .showSnackBar(SnackBar(content: Text('heloo')));
                if (activePage == 0) {
                  _showModalBottomSheet(context);
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ContactsScreen()));
                }
              })
          : SizedBox.shrink(),
      bottomNavigationBar: ConvexAppBar(
        // key: navKey,
        curve: Curves.easeInOut,
        backgroundColor: Theme.of(context).appBarTheme.color,
        color: Theme.of(context).textTheme.headline6.color.withOpacity(0.5),
        activeColor: Theme.of(context).accentColor,
        // height: 0,
        // cornerRadius: 16,
        items: [
          TabItem(icon: Icons.av_timer, title: 'Timeline'),
          TabItem(icon: Icons.chat_bubble, title: 'Chat'),
          TabItem(icon: Icons.person_pin, title: 'Profile')
        ],
        initialActiveIndex: activePage, //optional, default as 0
        onTap: (int i) => setState(() {
          activePage = i;
          title = pageTitles[i];
          isSelected = !isSelected;
          pageController.animateToPage(activePage,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic);
        }),
      ),
    );
  }

  void _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.score, color: Colors.blue),
                title: new Text('Add New Scoreboard',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPostScreen(widget.user),
                  ));
                }),
            new ListTile(
              leading: new Icon(Icons.gamepad, color: Colors.blue),
              title: new Text('New Game Challenge',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6.color,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: NewChallenge()));
              },
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
    );
  }
}
