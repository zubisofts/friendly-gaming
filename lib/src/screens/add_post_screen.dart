import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/widgets/avatar.dart';
import 'package:friendly_gaming/src/widgets/game_selector.dart';
import 'package:friendly_gaming/src/widgets/score_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class AddPostScreen extends StatefulWidget {
  final User user;

  AddPostScreen(this.user);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  User firstPlayer;
  User secondPlayer;
  Map<String, Widget> games;
  String selectedGameKey;
  List<String> images = [null, null, null];
  Map<String, int> scores = {'firstPlayerScore': 0, 'secondPlayerScore': 0};

  @override
  void initState() {
    selectedGameKey = "FIFA";
    User user = User(
        email: '',
        id: '',
        photo: 'https://www.valiance.gg/images/089e0ea.png',
        name: null);
    firstPlayer = widget.user;
    secondPlayer = user;
    context.read<DataBloc>().add(FetchUsersEvent());
    games = {
      "FIFA": FIFAScoreSelector(
        onSelected: (score) {
          setState(() {
            scores = score;
          });
        },
      ),
      "CRICKET": CricketScoreSelector(
        onSelected: (score) {
          setState(() {
            scores = score;
          });
        },
      )
    };
    super.initState();
  }

  Future<String> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      print('No image selected.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        backgroundColor: Theme.of(context).cardTheme.color,
        elevation: 0,
        centerTitle: true,
        title: Text('New Score',
            style:
                TextStyle(color: Theme.of(context).textTheme.headline6.color)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              // margin: EdgeInsets.all(16.0),
              // padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0),
                  PlayerSelectionWidget((user) {
                    setState(() {
                      secondPlayer = user;
                      print('Second Player:$secondPlayer');
                    });
                  }),
                  SizedBox(height: 24.0),
                  Text(
                    'Above Selected',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Avatar(
                          size: 120,
                          image: '${firstPlayer?.photo}',
                          name: '${firstPlayer?.name ?? 'Player 1'}'),
                      Text(
                        'VS',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Avatar(
                          size: 120,
                          image: '${secondPlayer?.photo}',
                          name: '${secondPlayer?.name ?? 'Player 2'}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Score',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'Score',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  // games[selectedGameKey],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('0',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                      Text('0',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 32,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'Select Game',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        // Expanded(
                        //   child: Form(
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(24.0),
                        //       ),
                        //       child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(24.0),
                        //         child: TextField(
                        //             decoration: InputDecoration(
                        //                 filled: true,
                        //                 hintText: 'Search Game',
                        //                 border: InputBorder.none,
                        //                 // focusedBorder: InputBorder.none,
                        //                 prefixIcon: Icon(Icons.search),
                        //                 fillColor: Colors.grey[100])),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: MediaQuery.of(context).size.width,
                      child: GameSelector(
                        onGameSelected: (game) {
                          setState(() {
                            selectedGameKey = game;
                          });
                        },
                      )),
                  SizedBox(
                    height: 16.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Align(
                  //       alignment: Alignment.topLeft,
                  //       child: Text('Add Images',
                  //           style: TextStyle(
                  //               color:
                  //                   Theme.of(context).textTheme.headline6.color,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 18))),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //         onTap: () async {
                  //           images[0] = await getImage();
                  //           setState(() {});
                  //         },
                  //         child: Stack(
                  //           children: [
                  //             Container(
                  //               width: 70,
                  //               height: 70,
                  //               padding: EdgeInsets.all(8.0),
                  //               child: DottedBorder(
                  //                 // padding: EdgeInsets.all(16.0),
                  //                 color: Colors.grey,
                  //                 child: Stack(
                  //                   children: [
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child: images[0] != null
                  //                           ? Image.file(
                  //                               File(images[0]),
                  //                               width: 40,
                  //                               height: 40,
                  //                               fit: BoxFit.cover,
                  //                             )
                  //                           : SizedBox.shrink(),
                  //                     ),
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child: Icon(
                  //                         Icons.add,
                  //                         color: Colors.grey,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //             images[0] != null
                  //                 ? Positioned(
                  //                     right: 0,
                  //                     child: InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           images[0] = null;
                  //                         });
                  //                       },
                  //                       child: Container(
                  //                           decoration: BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             color: Colors.red,
                  //                           ),
                  //                           child: Icon(Icons.close,
                  //                               color: Colors.white)),
                  //                     ))
                  //                 : SizedBox.shrink()
                  //           ],
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () async {
                  //           images[1] = await getImage();
                  //           setState(() {});
                  //         },
                  //         child: Stack(
                  //           children: [
                  //             Container(
                  //               width: 70,
                  //               height: 70,
                  //               padding: EdgeInsets.all(8.0),
                  //               child: DottedBorder(
                  //                 // padding: EdgeInsets.all(16.0),
                  //                 color: Colors.grey,
                  //                 child: Stack(
                  //                   children: [
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child: images[1] != null
                  //                           ? Image.file(
                  //                               File(images[1]),
                  //                               width: 40,
                  //                               height: 40,
                  //                               fit: BoxFit.cover,
                  //                             )
                  //                           : SizedBox.shrink(),
                  //                     ),
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child: Icon(
                  //                         Icons.add,
                  //                         color: Colors.grey,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //             images[1] != null
                  //                 ? Positioned(
                  //                     right: 0,
                  //                     child: InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           images[1] = null;
                  //                         });
                  //                       },
                  //                       child: Container(
                  //                           decoration: BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             color: Colors.red,
                  //                           ),
                  //                           child: Icon(Icons.close,
                  //                               color: Colors.white)),
                  //                     ))
                  //                 : SizedBox.shrink()
                  //           ],
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () async {
                  //           images[2] = await getImage();
                  //           setState(() {});
                  //         },
                  //         child: Stack(
                  //           children: [
                  //             Container(
                  //               width: 70,
                  //               height: 70,
                  //               padding: EdgeInsets.all(8.0),
                  //               child: DottedBorder(
                  //                 // padding: EdgeInsets.all(16.0),
                  //                 color: Colors.grey,
                  //                 child: Stack(
                  //                   children: [
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child: images[2] != null
                  //                           ? Image.file(
                  //                               File(images[2]),
                  //                               width: 40,
                  //                               height: 40,
                  //                               fit: BoxFit.cover,
                  //                             )
                  //                           : SizedBox.shrink(),
                  //                     ),
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child: Icon(
                  //                         Icons.add,
                  //                         color: Colors.grey,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //             images[2] != null
                  //                 ? Positioned(
                  //                     right: 0,
                  //                     child: InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           images[2] = null;
                  //                         });
                  //                       },
                  //                       child: Container(
                  //                           decoration: BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             color: Colors.red,
                  //                           ),
                  //                           child: Icon(Icons.close,
                  //                               color: Colors.white)),
                  //                     ))
                  //                 : SizedBox.shrink()
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 16.0),
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      onPressed: () {
                        context.read<DataBloc>().add(AddPostEvent(
                            Post(
                                firstPlayerId: firstPlayer.id,
                                secondPlayerId: secondPlayer.id,
                                scores: scores,
                                status: 'inactive',
                                updates: [],
                                gameType: selectedGameKey,
                                date: DateTime.now()),
                            request: Request(
                              senderId: firstPlayer.id,
                              receiverId: secondPlayer.id,
                              gameId: '',
                              requestType: selectedGameKey,
                              status: 'pending',
                              date: DateTime.now().millisecondsSinceEpoch,
                            )));
                      },
                      child: Text(
                        'POST',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          BlocConsumer<DataBloc, DataState>(
            listener: (context, state) {
              if (state is PostSavedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Post saved with ID:${state.postId}'),
                ));
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is PostSavingState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Saving Post...')
                      ],
                    ),
                  ),
                );
              }

              return SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}

class FIFAScoreSelector extends StatelessWidget {
  FIFAScoreSelector({Key key, this.onSelected}) : super(key: key);

  final Function(Map) onSelected;

  final Map<String, int> scores = {};

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            width: 130,
            decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12.0)),
            child: ScoreSelector(
              onSelect: (int s) {
                scores['firstPlayerScore'] = s;
                onSelected(scores);
              },
            )),
        SizedBox.shrink(),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            width: 130,
            decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12.0)),
            child: ScoreSelector(
              onSelect: (int s) {
                scores['secondPlayerScore'] = s;
                onSelected(scores);
              },
            )),
      ],
    );
  }
}

class CricketScoreSelector extends StatelessWidget {
  final Function(Map) onSelected;

  final Map<String, int> scores = {};

  CricketScoreSelector({Key key, this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              width: 130,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  ScoreSelector(
                    onSelect: (int s) {
                      scores['run1'] = s;
                      onSelected(scores);
                    },
                  ),
                  SizedBox(height: 8.0),
                  ScoreSelector(
                    onSelect: (int s) {
                      scores['out1'] = s;
                      onSelected(scores);
                    },
                  ),
                ],
              ),
            ),
            Text('Run/Out',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color)),
          ],
        ),
        SizedBox.shrink(),
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              width: 130,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  ScoreSelector(
                    onSelect: (int s) {
                      scores['run2'] = s;
                      onSelected(scores);
                    },
                  ),
                  SizedBox(height: 8.0),
                  ScoreSelector(
                    onSelect: (int s) {
                      scores['out2'] = s;
                      onSelected(scores);
                    },
                  ),
                ],
              ),
            ),
            Text('Run/Out',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color))
          ],
        ),
      ],
    );
  }
}

class PlayerSelectionWidget extends StatefulWidget {
  final Function(User) onSelectPlayer;

  PlayerSelectionWidget(this.onSelectPlayer);

  @override
  _PlayerSelectionWidgetState createState() => _PlayerSelectionWidgetState();
}

class _PlayerSelectionWidgetState extends State<PlayerSelectionWidget> {
  int selectedIndex;

  @override
  void initState() {
    selectedIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Text(
                'Select Opponent',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline6.color),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Form(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: TextField(
                          onChanged: (value) => context
                              .read<DataBloc>()
                              .add(SearchUserEvent(query: value)),
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Search Opponent',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color),
                              border: InputBorder.none,
                              // focusedBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              fillColor: Theme.of(context).cardTheme.color)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 24.0),
        BlocBuilder<DataBloc, DataState>(builder: (context, state) {
          if (state is UsersLoadingState) {
            return LoadingWidget();
          }

          if (state is UsersFetchedState) {
            List<User> users = state.users;
            return users != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectedIndex = index;
                                widget.onSelectPlayer(users[index]);
                              });
                            },
                            child: Avatar(
                                size: 50,
                                image: users[index].photo,
                                name: users[index].name),
                          );
                        }),
                  )
                : Container(
                    child: Text('Nothing found'),
                  );
          }
          return SizedBox.shrink();
        })
      ],
    );
  }

  Widget buildListViewPlaceHolder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) => ClipOval(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: 50,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24.0,
                            backgroundImage:
                                AssetImage('assets/images/profile_icon.png'),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: 50,
                            height: 20,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100]);
              }),
        ],
      ),
    );
  }
}
