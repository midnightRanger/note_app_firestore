import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_page/auth_page_cubit.dart';
import '../auth_page/auth_page_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title; 
  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  final AuthPageCubit cubit = AuthPageCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Center(
        child: BlocBuilder<AuthPageCubit, AuthPageState>(
          builder:(context, state) {
                return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          );
          },
        )) ,

            floatingActionButton: FloatingActionButton(
        onPressed: cubit.incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}