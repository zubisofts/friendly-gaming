import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/widgets/user_row_widget.dart';

class PlayerSelectionScreen extends StatefulWidget {
  final Function(User) onSelectPlayer;

  const PlayerSelectionScreen(this.onSelectPlayer);

  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<DataBloc>().add(FetchUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              onChanged: (value) =>
                  context.read<DataBloc>().add(SearchUserEvent(query: value)),
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline6.color),
              decoration: InputDecoration(
                  hintText: 'Search Player',
                  hintStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.7)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          ),
          Expanded(
            child: BlocBuilder<DataBloc, DataState>(
              buildWhen: (previous, current) =>
                  current is UsersFetchedState || current is UsersLoadingState,
              builder: (context, state) {
                List<User> users = [];
                if (state is UsersFetchedState) {
                  users = state.users;
                }

                if (state is UsersLoadingState) {
                  return Center(
                    child: SpinKitDualRing(
                      color: Colors.blueGrey,
                      size: 36,
                      lineWidth: 2,
                    ),
                  );
                }

                return users.isNotEmpty
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return UserRowWidget(
                            user: users[index],
                            onTap: (user) {
                              widget.onSelectPlayer(user);
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No users found',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
