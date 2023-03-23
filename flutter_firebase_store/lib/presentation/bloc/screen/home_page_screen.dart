import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
  @override
  State<HomePage> createState() => _HomeStatePage();
}

class _HomeStatePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(HomePageState.initial),
      child: HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  _HomeWidgetStatePage createState() => _HomeWidgetStatePage();
}

class _HomeWidgetStatePage extends State<_HomeStatePage> {
  
}