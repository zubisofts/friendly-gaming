import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/add_post_screen.dart';
import 'package:friendly_gaming/src/screens/chat_screen.dart';
import 'package:friendly_gaming/src/screens/profile_screen.dart';
import 'package:friendly_gaming/src/screens/timeline_screen.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        elevation: 0.5,
        toolbarHeight: 90,
        leading: Container(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Text('Friendly',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  Text(
                    'Gaming',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '|',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    context.bloc<AuthBloc>().add(LogoutEvent());
                    // Navigator.pop(context, ModalRoute.withName('/login'));
                  });
            },
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: pages,
        controller: pageController,
      ),
      floatingActionButton: activePage == 0
          ? FloatingActionButton(
              key: fabKey,
              tooltip: 'Add Post',
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddPostScreen())))
          : SizedBox.shrink(),
      bottomNavigationBar: ConvexAppBar(
        key: navKey,
        curve: Curves.easeInOut,
        backgroundColor: Colors.white,
        color: Colors.blue,
        activeColor: Colors.blue,
        height: 50,
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
}
