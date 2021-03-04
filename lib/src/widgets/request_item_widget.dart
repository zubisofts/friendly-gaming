import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/repository/data_repository.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';

class RequestItemWidget extends StatefulWidget {
  final Request request;
  final bool highlight;

  const RequestItemWidget({this.request, this.highlight});

  @override
  _RequestItemWidgetState createState() => _RequestItemWidgetState();
}

class _RequestItemWidgetState extends State<RequestItemWidget> {
  var userStream;

  @override
  void initState() {
    userStream = DataRepository().userDetails(widget.request.senderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
          color: widget.highlight
              ? Colors.deepOrangeAccent.withOpacity(0.3)
              : Theme.of(context).cardTheme.color),
      child: ListTile(
        onTap: null,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        leading: StreamBuilder<User>(
            stream: DataRepository().userDetails(widget.request.senderId),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return CircleAvatar(
                  radius: 24.0,
                  backgroundImage:
                      CachedNetworkImageProvider(snapshot.data.photo),
                );
              }
              return CircleAvatar(
                radius: 24.0,
                backgroundImage: AssetImage('assets/images/profile_icon.png'),
              );
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: StreamBuilder<User>(
                stream: userStream,
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.name,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).textTheme.headline6.color,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                  return Text('');
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: StreamBuilder(
                stream: Stream.periodic(Duration(minutes: 1)),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Text(
                    '${FGUtils.displayTimeAgoFromTimestamp(widget.request.date, numericDates: true)}',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 11, color: Colors.blue),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            )
          ],
        ),
        subtitle: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    BlocProvider.of<DataBloc>(context).add(RequestResponseEvent(
                        accept: true, request: widget.request));
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color),
                  )),
              FlatButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    BlocProvider.of<DataBloc>(context).add(RequestResponseEvent(
                        accept: false, request: widget.request));
                  },
                  child: Text(
                    'Decline',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
