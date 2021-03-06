import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/post.dart';
import 'package:friendly_gaming/src/utils/fg_utils.dart';
import 'package:friendly_gaming/src/widgets/timeline_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

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
                ? GroupedListView<Post, String>(
                    physics: BouncingScrollPhysics(),
                    elements: posts,
                    groupBy: (post) {
                      return DateFormat.yMMMMEEEEd().format(post.date);
                    },
                    groupSeparatorBuilder: (post) {
                      // String date = DateFormat('yyyy-MM-dd').format(post.date);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 8.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Text(post,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color))),
                        ],
                      );
                    },
                    itemBuilder: (context, Post post) => TimelineCard(
                      timelineData: post,
                    ),
                    groupComparator: (post1, post2) {
                      return post1.compareTo(post2);
                    },
                    itemComparator: (post1, post2) {
                      // DateTime now = DateTime.now();
                      String d1 = DateFormat('yyyy-MM-dd').format(post1.date);
                      String d2 = DateFormat('yyyy-MM-dd').format(post2.date);
                      return d1.compareTo(d2);
                    },

                    useStickyGroupSeparators: true, // optional
                    floatingHeader: true, // optional
                    order: GroupedListOrder.ASC, // optional
                  )
                // ? ListView.builder(
                //     addAutomaticKeepAlives: true,
                //     physics: BouncingScrollPhysics(),
                //     itemCount: posts.length,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: EdgeInsets.only(
                //             bottom: index == posts.length - 1 ? 0.0 : 0.0),
                //         child: TimelineCard(
                //           timelineData: posts[index],
                //         ),
                //       );
                //     },
                //   )
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
