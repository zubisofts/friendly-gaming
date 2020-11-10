import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/notification.dart';
import 'package:friendly_gaming/src/screens/game_requests_screen.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';
import 'package:page_transition/page_transition.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<DataBloc>().add(FetchNotificationEvent());
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<DataBloc, DataState>(
          buildWhen: (prev,curr)=>curr is NotificationsFetchedState,
          builder: (context, state) {
            int notifsCount = 0;
            if (state is NotificationsFetchedState) {
              notifsCount = state.notifications.length;
            }
            return Text(
              'Notifications ($notifsCount)',
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline6.color),
            );
          },
        ),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 1,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Navigator.of(context).pop()),
        actions: [
          IconButton(
              icon: Icon(
                Icons.clear_all,
                color: Colors.blueGrey,
              ),
              onPressed: () {
              })
        ],
      ),
      body: BlocBuilder<DataBloc, DataState>(
        buildWhen: (prev,curr)=>curr is NotificationsFetchedState,
        builder: (context, state) {
          if (state is NotificationsFetchedState) {
            var notifications = state.notifications;
            return notifications.length > 0
                ? ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      FGNotification notification = notifications[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: notification.read
                                ? Colors.transparent
                                : Theme.of(context).cardTheme.color),
                        child: ListTile(
                          onTap: (){

                            String type=notification.type;
                            if(type==NotificationType.Challenge.toString().split('.').last){
                              Navigator.push(context, PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:GameRequestsScreen(notification: notification,)));
                            }
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 8.0),
                          leading: Image.asset(
                            'assets/images/fifa.png',
                            width: 32,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  notification.title,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${FGUtils.displayTimeAgoFromTimestamp(notification.time, numericDates: true)}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.blue),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // StreamBuilder(
                                  //   stream: Stream.periodic(Duration(minutes: 1)),
                                  //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  //         return Text(
                                  //           '${FGUtils.displayTimeAgoFromTimestamp(notification.time, numericDates: true)}',
                                  //           textAlign: TextAlign.end,
                                  //           style: TextStyle(
                                  //               fontSize: 11, color: Colors.blue),
                                  //           maxLines: 2,
                                  //           overflow: TextOverflow.ellipsis,
                                  //         );
                                  //   },
                                  // ),
                              )
                            ],
                          ),
                          subtitle: Text('${notification.description}',style: TextStyle(
                            color: Theme.of(context).textTheme.subtitle2.color
                          ),),
                        ),
                      );
                    })
                : Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/empty.svg',
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "You don't have any notifications",
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
          return Center(child: Text('All notifications cleared up'));
        },
      ),
    );
  }
}
