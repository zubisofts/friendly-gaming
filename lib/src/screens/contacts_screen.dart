import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/data/data_bloc.dart';
import 'package:friendly_gaming/src/model/user.dart';
import 'package:friendly_gaming/src/screens/message_screen.dart';
import 'package:friendly_gaming/src/widgets/user_row_widget.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<DataBloc>().add(FetchUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Select Contact',
            style:
                TextStyle(color: Theme.of(context).textTheme.headline6.color)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              onChanged: (value) =>
                  context.read<DataBloc>().add(SearchUserEvent(query: value)),
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline6.color),
              decoration: InputDecoration(
                  hintText: 'Search contacts',
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
        ),
      ),
      body: BlocBuilder<DataBloc, DataState>(
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
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return UserRowWidget(
                      user: users[index],
                      onTap: (user) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MessageScreen(user: user),
                        ));
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
    );
  }
}
