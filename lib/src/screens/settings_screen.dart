import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendly_gaming/src/blocs/app/app_bloc.dart';

class AppSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: Theme.of(context).textTheme.headline6,),
      ),
      body: ListView(
        children: [
          BlocBuilder<AppBloc, AppState>(
            buildWhen: (prev,curr)=>curr is GetThemeValueState,
            builder: (context, state) {
              print("Called AppBloc");
              bool val = false;
              if (state is GetThemeValueState) {
                val = state.value;
                print('*********Theme value is:$val************');
              }

              return ListTile(
                leading: Icon(Icons.brightness_6,
                    color: Theme.of(context).iconTheme.color),
                title: Text('Theme Mode',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text('${val?'Dark':'Light'}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 16)),
                trailing: Switch(
                    value: val,
                    onChanged: (value) {
                      context.bloc<AppBloc>().add(ChangeThemeEvent());
                    }),
                onTap: () {},
              );
            },
          )
        ],
      ),
    );
  }
}
