import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/widgets/timeline_card.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({
    Key key,
  }) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen>
    with AutomaticKeepAliveClientMixin<TimelineScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.bloc<DataBloc>().add(FetchPostEvent());
    return Container(
      decoration: BoxDecoration(
        // color: Colors.grey[200],
      ),
      child: BlocConsumer<DataBloc, DataState>(
        buildWhen: (previous, current) => current is PostsFetchedState,
        builder: (context, state) {
          if (state is PostsFetchedState) {
            print('--------------------***------------------**');
            return ListView.builder(
              addAutomaticKeepAlives: true,
              physics: BouncingScrollPhysics(),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                var posts = state.posts;
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index == posts.length - 1 ? 0.0 : 0.0),
                  child: TimelineCard(
                    timelineData: posts[index],
                  ),
                );
              },
            );
          } else {
            print('----Other State---$state-------');
            return Center(
              child: SpinKitDualRing(
                color: Colors.blueGrey,
                size: 36,
                lineWidth: 2,
              ),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
