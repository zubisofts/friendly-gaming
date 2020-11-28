import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/chat.dart';
import 'package:friendly_gaming/src/screens/message_screen.dart';
import 'package:friendly_gaming/src/widgets/chat_list_row.dart';
import 'package:page_transition/page_transition.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    context.bloc<DataBloc>().add(FetchChatsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DataBloc, DataState>(
        buildWhen: (previous, current) => current is ChatsFetchedState,
        builder: (context, state) {
          if (state is ChatsFetchedState) {
            List<Chat> chats = [];
            chats = state.chats;

            return chats.isEmpty
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/empty_chat.svg',
                            // color: Theme.of(context).accentColor,
                            // colorBlendMode: BlendMode.dst,
                            // allowDrawingOutsideViewBox: true,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "No recent chat yet, click the below button to get started.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .color
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          // RaisedButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     'New chat',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          //   color: Theme.of(context).accentColor,
                          // )
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatListRow(chat: chats[index]);
                    },
                  );
          }

          return Center(
            child: SpinKitDualRing(
              color: Colors.blueGrey,
              size: 36,
              lineWidth: 2,
            ),
          );
        },
      ),
    );
  }
}
