import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/comment.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/repository/messaging_repo.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;

  CommentsScreen(this.post);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _textInputController = TextEditingController();
  ValueNotifier<bool> showEmojiNotifier = ValueNotifier(false);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    context.read<DataBloc>().add(FetchCommentsEvent(widget.post.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Comment>>(
                stream: MessagingRepository().comments(widget.post.id),
                builder: (context, snapshot) {
                  // print('Comments loaded*****************');

                  if (snapshot.hasData) {
                    List<Comment> comments = snapshot.data;
                    return comments.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              primary: false,
                              physics: BouncingScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  CommentWidget(comments[index]),
                            ),
                          )
                        : Center(
                            child: Text('Be the first write a comment',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color
                                        .withOpacity(0.5),
                                    fontSize: 18.0)),
                          );
                  }

                    return Center(
                        child: Column(
                      children: [
                        Text('Error fetching comments for this scoreboard'),
                        FlatButton(
                          onPressed: () {},
                          color: Colors.blueGrey,
                          child: Text('Reload'),
                        )
                      ],
                    ));

                  // return Center(
                  //     child: SpinKitCircle(
                  //   color: Colors.blueGrey,
                  //   size: 32.0,
                  // ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Theme.of(context).cardColor),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _textInputController,
                        // keyboardType: TextInputType.multiline,
                        // textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        minLines: 1,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          hintText: 'Write something...',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .color
                                  .withOpacity(0.5)),
                          border: InputBorder.none,
                        ),
                        autofocus: false,
                        // controller: _newMediaLinkAddressController,
                      ),
                    ),
                    // IconButton(
                    //   iconSize: 28.0,
                    //   color: Colors.orange,
                    //   icon: Icon(Icons.emoji_emotions),
                    //   onPressed: () => showBottomSheet(
                    //       builder: (BuildContext context) => Container(
                    //             child: Text('Nothing'),
                    //           ),
                    //       context: context),
                    // ),
                    IconButton(
                      iconSize: 28.0,
                      color: Colors.blueGrey,
                      splashColor: Colors.blue,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        Comment comment = Comment(
                          comment: _textInputController.text,
                          userId: AuthBloc.uid,
                          postId: widget.post.id,
                          time: DateTime.now().millisecondsSinceEpoch,
                        );
                        if (_textInputController.text.isNotEmpty)
                          context
                              .read<DataBloc>()
                              .add(AddCommentEvent(comment));
                        _textInputController.clear();
                      },
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  final Comment comment;

  CommentWidget(this.comment);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<User>(
                  stream: DataRepository().userDetails(widget.comment.userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User user = snapshot.data;
                      return CircleAvatar(
                        radius: 18.0,
                        backgroundImage:
                            CachedNetworkImageProvider('${user.photo}'),
                      );
                    }

                    return CircleAvatar(
                      radius: 18.0,
                      backgroundImage:
                          AssetImage('assets/images/profile_icon.png'),
                    );
                  }),
              SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  // decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<User>(
                          stream: DataRepository()
                              .userDetails(widget.comment.userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              User user = snapshot.data;
                              return Text('${user?.name}',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color));
                            }
                            return SizedBox.shrink();
                          }),
                      SizedBox(height: 8.0),
                      Text('${widget.comment.comment}',
                          softWrap: true,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color)),
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Text(
                            '${FGUtils.displayTimeAgoFromTimestamp(widget.comment.time)}',
                            softWrap: true,
                            style: TextStyle(fontSize: 12, color: Colors.blue)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
