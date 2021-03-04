import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/widgets/timeline_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({
    Key key,
  }) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  
  @override
  Widget build(BuildContext context) {
    context.bloc<DataBloc>().add(FetchPostEvent());
    return Container(
      decoration: BoxDecoration(
          // color: Colors.grey[200],
          ),
      child: BlocConsumer<DataBloc, DataState>(
        buildWhen: (previous, current) => current is PostsFetchedState,
        builder: (context, state) {
          if (state is PostsFetchedState) {
            var posts = state.posts
                .where((post) => post.status == 'completed')
                .toList();
            return posts.isNotEmpty
                ? ListView.builder(
                    addAutomaticKeepAlives: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index == posts.length - 1 ? 0.0 : 0.0),
                        child: TimelineCard(
                          timelineData: posts[index],
                        ),
                      );
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
                            "There's no games available",
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
