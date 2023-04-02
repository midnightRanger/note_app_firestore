import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/presentation/bloc/note_add_page/note_add_page_cubit.dart';
import 'package:flutter_firebase_store/presentation/bloc/screen/note_add_screen.dart';
import 'package:flutter_firebase_store/presentation/bloc/screen/note_edit_page_screen.dart';


import '../../../domain/model/model_response.dart';
import 'package:flutter/src/widgets/image.dart' as ImageWidget; 
import '../../../domain/model/note.dart';
import '../home_page/home_page_cubit.dart';

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
      create: (context) =>
          HomePageCubit(HomeActionState(initial: true))..init(),
      child: HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  _HomeWidgetStatePage createState() => _HomeWidgetStatePage();
}

class _HomeWidgetStatePage extends State<HomePageWidget> {
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
 

        if (state == HomeActionState(refresh: true)) {
          context.read<HomePageCubit>().init();
        }

        if (state.successDeleted == true) {
           AlertDialog alert = AlertDialog(
          title: const Text('Note delete: '),
          content: Text("Note was successfully deleted"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 Navigator.of(context, rootNavigator: true).pop();
                 context.read<HomePageCubit>().init();
              },
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
                                        context
                                            .read<HomePageCubit>()
                                            .deleteNote(
                                                state.myNotes![index].name!);
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

                                ImageWidget.Image.network(
                state.myNotes![index].image.url!,
                errorBuilder: (context, error, stackTrace) {
                  return Text('Ошибка');
                },
              ),

                                SizedBox(height: 10.0),
                                Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder:
                                                (BuildContext context) {
                                              return NoteEditPage(title: "Note Edit",
                                                  noteName: state.myNotes![index].name!);
                                            },
                                          )).then((_) {
                                  context.read<HomePageCubit>().init();
                                });
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
                                    "Category: ${state.myNotes![index].category}",
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return NoteAddPage(title: "Note Add");
                                  },
                                )).then((_) {
                                  context.read<HomePageCubit>().init();
                                }
                                    // // GoRouter.of(context).goNamed(APP_PAGE.profile_edit.routeName, queryParams: {'token': widget.token!});
                                    );
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
