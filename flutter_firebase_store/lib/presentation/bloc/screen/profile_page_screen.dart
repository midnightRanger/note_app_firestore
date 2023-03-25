import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';
import '../home_page/home_page_cubit.dart';

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

        body: BlocConsumer<HomePageCubit, HomeActionState>(
            listener: (context, state) {
      if (state == HomeActionState(successRetrieved: true)) {
        AlertDialog alert = AlertDialog(
          title: const Text('Auth: '),
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
      return Center(child: BlocBuilder<HomePageCubit, HomeActionState>(
          builder: (context, state) {
        if (state.myNotes != null) {
          return ListView.builder(
              itemCount: state.myNotes!.length + 1,
              itemBuilder: (context, index) {
                if (index < state.myNotes!.length) {
                  return ListTile(
                    title: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            state.myNotes![index].name!,
                            textAlign: TextAlign.center,
                          )),
                      Icon(Icons.notes_outlined)
                    ]),
                    subtitle: ConstrainedBox(
                      constraints: new BoxConstraints(minHeight: 100.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(116, 154, 155, 1),
                            border: Border.all(
                              color: Color.fromRGBO(3, 158, 162, 1),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(children: [
                                Row(children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          state.myNotes![index].content!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)),
                                  // Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
                                  ElevatedButton(
                                      onPressed: () {
                                        // deleteNote(id: snapshot.data![index].id!, context);
                                        // // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(10, 86, 88, 1),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                        ),
                                        minimumSize: Size(30, 30),
                                      ),
                                      child: const Icon(Icons.delete))
                                ]),
                                SizedBox(height: 10.0),
                                Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.of(context)
                                          //     .push(MaterialPageRoute(
                                          //   builder:
                                          //       (BuildContext context) {
                                          //     return NoteEditPage(
                                          //         token: widget.token!,
                                          //         id: snapshot
                                          //             .data![index].id!);
                                          //   },
                                          // ));
                                          // // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromRGBO(10, 86, 88, 1),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          minimumSize: Size(42, 42),
                                        ),
                                        child: Text("Update",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1))),
                                Row(children: [
                                  Text(
                                    // "Created: ${snapshot.data![index].creationDate.toLocal().toString().substring(0, 19)}",
                                    "ss",
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black45),
                                    overflow: TextOverflow.fade,
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Text(
                                    // "Updated: ${snapshot.data![index].lastUpdating.toLocal().toString().substring(0, 19)}",
                                    "ss",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black45),
                                  ),
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Text(
                                    "Category: ${state.myNotes![index].category.categoryName}",
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black45),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                ])
                              ]))),
                    ),
                  );
                } else {
                  return Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(
                                //   builder: (BuildContext context) {
                                //     return NoteAddPage(
                                //         token: widget.token!);
                                //   },
                                // )).then(onGoBack);
                                // // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(10, 86, 88, 1),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                minimumSize: Size(42, 42),
                              ),
                              child: Text("Create new",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white)))));
                }
              });
        }

        return CircularProgressIndicator();
      }));
    }));
  }
}
