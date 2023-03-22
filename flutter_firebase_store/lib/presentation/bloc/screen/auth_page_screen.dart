import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/use_cases/impl/auth_case_impl.dart';

import '../../../domain/model/user.dart';
import '../auth_page/auth_page_cubit.dart';
import '../auth_page/auth_page_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;
  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<AuthPageCubit, AuthPageState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                '${state.response!.message}',
                style: Theme.of(context).textTheme.headline4,
              ),
               IconButton(
        onPressed: () => context.read<AuthPageCubit>().registerUser(User(
            email: "sas@mail.ru",
            userName: "Lev",
            password: "1234",
            isActive: true,
            id: 1)),
        tooltip: 'Increment',
        icon: Icon(Icons.add),
      ),
            ],
          );
        },
      )),
      
    );
  }
}
