import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/globals/router/router_utils.dart';
import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';
import '../home_page/home_page_cubit.dart';
import '../profile_page/profile_page_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;
  @override
  State<ProfilePage> createState() => _ProfileStatePage();
}

class _ProfileStatePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfilePageCubit(ProfileState(initial: true))..init(),
      child: ProfilePageWidget(),
    );
  }
}

class ProfilePageWidget extends StatefulWidget {
  @override
  _ProfileWidgetStatePage createState() => _ProfileWidgetStatePage();
}

class _ProfileWidgetStatePage extends State<ProfilePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(actions: [
        //   IconButton(onPressed: (){
        //     showSearch(context: context, delegate: CustomSearchDelegate(allPosts: _allNotes, token: widget.token!));
        //   },icon: const Icon(Icons.search))
        // ]),

        body: BlocConsumer<ProfilePageCubit, ProfileState>(
            listener: (context, state) {
      if (state == ProfileState(successRetrieved: true)) {
        AlertDialog alert = AlertDialog(
          title: const Text('Profile: '),
          content: Text("Получение данных"),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('OK'),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }, builder: (context, state) {
      return Center(child: BlocBuilder<ProfilePageCubit, ProfileState>(
          builder: (context, state) {
        if (state.user != null) {
          return Column(children: [
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(156, 152, 140, 1),
                      border: Border.all(
                        color: Color.fromRGBO(156, 152, 140, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Expanded(
                      child: Icon(Icons.account_box, size: 100.0),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("User profile",
                        style: Theme.of(context).textTheme.headline2))
              ],
            ),

            Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: Container(
                  color: Colors.grey, width: double.infinity, height: 1),
            ),

            Container(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(3, 158, 162, 1),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(42, 42),
                      ),
                      child: Icon(
                        Icons.email,
                        size: 20,
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 13, right: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.user!.email}",
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 17.0,
                                color: Colors.black,
                              )),
                          const Text("E-mail",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: Colors.grey,
                              ))
                        ],
                      )),
                ],
              ),
            ),

            Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
              child: Container(
                  color: Colors.grey, width: double.infinity, height: 1),
            ),

            Container(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(3, 158, 162, 1),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(42, 42),
                      ),
                      child: Icon(
                        Icons.man,
                        size: 20,
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 13, right: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.user!.userName}",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 17.0,
                                color: Colors.black,
                              )),
                          Text("User name",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: Colors.grey,
                              ))
                        ],
                      )),
                ],
              ),
            ),

            Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: Container(
                  color: Colors.grey, width: double.infinity, height: 1),
            ),

            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(
                            //   builder: (BuildContext context) {
                            //     return ProfilePageEdit(
                            //         token: widget.token!);
                            //   },
                            // ));
                            GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(3, 158, 162, 1),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(42, 42),
                          ),
                          child: Text("Update profile",
                              style: Theme.of(context).textTheme.bodyText1)),
                    )))
            // SizedBox(height: 8.0),
            // Text(
            //   '${userInfo.userName} ${userInfo.email}',
            //   style: TextStyle(fontSize: 16.0),
            // )
          ]);
        }

        return CircularProgressIndicator();
      }));
    }));
  }
}
