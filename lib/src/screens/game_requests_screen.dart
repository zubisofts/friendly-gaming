import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/notification.dart';
import 'package:friendly_gaming/src/model/request.dart';
import 'package:friendly_gaming/src/widgets/request_item_widget.dart';

class GameRequestsScreen extends StatefulWidget {
  final FGNotification notification;

  GameRequestsScreen({this.notification});

  @override
  _GameRequestsScreenState createState() => _GameRequestsScreenState();
}

class _GameRequestsScreenState extends State<GameRequestsScreen> {
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<DataBloc>().add(FetchRequestsEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Game Requests',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline6.color,
            )),
      ),
      body: BlocBuilder<DataBloc, DataState>(
          buildWhen: (previous, current) => current is RequestsFetchedState,
          builder: (context, state) {
            if (state is RequestsFetchedState) {
              List<Request> requests = state.requests;
              return requests.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        var request = requests[index];
                        if (index==requests.length-1) {
                          print('Last');
                          Future.delayed(Duration(milliseconds: 1000)).then((value){
                            print('Scrolled');
                          if (request.requestId ==
                          widget.notification.actionIntentId) {
                              scrollController.animateTo(5.0,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.decelerate);
                        }
                          });
                        }
                        return RequestItemWidget(
                            request: request,
                            highlight: widget.notification.actionIntentId ==
                                request.requestId);
                      },
                    )
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

            if (state is DataLoadingState) {
              return SpinKitDualRing(
                color: Colors.blueGrey,
                size: 32.0,
                lineWidth: 3,
              );
            }

            if (state is DataErrorState) {
              return Center(
                child: Text(
                  'An error occurred!',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color),
                ),
              );
            }

            return SizedBox.shrink();
          }),
    );
  }
}
