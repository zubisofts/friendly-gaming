import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/call.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/dial_screen.dart';
import 'package:page_transition/page_transition.dart';

class IncomingCallScreen extends StatefulWidget {
  final Call call;

  IncomingCallScreen({this.call});

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  void initState() {
    context.bloc<DataBloc>().add(UserDataEvent(uid: widget.call.callerId));
    _playSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Video Call',
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.headline6.color)),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Theme.of(context).iconTheme.color),
        ),
      ),
      body: BlocConsumer<DataBloc, DataState>(
        listenWhen: (previous, current) => current is IncomingCallReceivedState,
        listener: (context, state) {
          if (state is IncomingCallReceivedState) {
            if (!state.call.isActive) {
              _stopSound();
              Navigator.of(context).pop();
            }
          }
        },
        buildWhen: (previous, current) => current is UserDataState,
        builder: (context, state) {
          if (state is UserDataState) {
            return Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blueGrey,
                            backgroundImage:
                                CachedNetworkImageProvider(state.user.photo),
                          ),
                          SizedBox(height: 16),
                          Text('${state.user.name}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Calling',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<DataBloc>()
                                .add(EndCallEvent(call: widget.call));
                            _stopSound();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(Icons.call_end, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 32.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    child: DialScreen(call: widget.call)));
                          },
                          child: Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(Icons.call, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  void _playSound() {
    try {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.ringtone,
        ios: IosSounds.glass,
        looping: true, // Android only - API >= 28
        volume: 1.0, // Android only - API >= 28
        asAlarm: false, // Android only - all APIs
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  void _stopSound() {
    FlutterRingtonePlayer.stop();
  }
}
