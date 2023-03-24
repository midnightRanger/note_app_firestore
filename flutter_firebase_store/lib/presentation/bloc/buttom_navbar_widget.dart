
import 'package:flutter/material.dart';
import 'package:flutter_firebase_store/presentation/bloc/screen/auth_page_screen.dart';
import 'package:flutter_firebase_store/presentation/bloc/screen/home_page_screen.dart';
import 'package:go_router/go_router.dart';

import '../../domain/globals/router/router_utils.dart';

class CustomBottomNavBar extends StatefulWidget {
  // create index to select from the list of route paths
  int navItemIndex = 0;

  CustomBottomNavBar(
      {required this.navItemIndex, Key? key})
      : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<Widget> pages = [
    AuthPage(title: "Auth page"),
    HomePage(title: "Home")
  ];

  // Make a list of routes that you'll want to go to
  static final List<String> _widgetOptions = [
    APP_PAGE.auth.routeName,
    APP_PAGE.home.routeName,
    APP_PAGE.profile.routeName,
  ];

  @override
  void initState() {
    // pages[2] = ProfilePage(token: widget.token);
    pages[1] = HomePage(title: "Home");
    super.initState();
  }

// Function that handles navigation based of index received
  void _onItemTapped(int index) {
    if (index == 0) {
      //  GoRouter.of(context).goNamed(_widgetOptions[0], queryParams: {'token': widget.token});

      Navigator.of(context).pop(MaterialPageRoute(
        builder: (BuildContext context) {
          return AuthPage(title: "Auth");
        },
      ));
    }
    setState(() {
      widget.navItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // List of icons that represent screen.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log out',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Profile',
          ),
        ],

        currentIndex: widget.navItemIndex, // current selected index

        onTap: _onItemTapped,
      ),
      body: pages[widget.navItemIndex],
    );
  }
}
