import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/ModelResponse.dart';
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
      create: (context) => HomePageCubit(HomeActionState.initial),
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
      body: Center(
        child: FutureBuilder<ModelResponse?>(
            future: context.read<HomePageCubit>().retrievedNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.data.length + 1,
                    itemBuilder: (context, index) {
                      if (index < snapshot.data!.data!.length!) {
                        return ListTile(
                          title: 
                          Row(children: [
                            Expanded(flex:1, child: 
                            Text(
                              snapshot.data!.data![index].name!,
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
                                                snapshot.data!.data![index].content!,
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
                                              primary:
                                                  Color.fromRGBO(10, 86, 88, 1),
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
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
                                                primary: Color.fromRGBO(
                                                    10, 86, 88, 1),
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          10.0),
                                                ),
                                                minimumSize: Size(42, 42),
                                              ),
                                              child: Text("Update",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1))),
                                      Row(children: [
                                        Text(
                                          "Created: ${snapshot.data!.data[index].creationDate.toLocal().toString().substring(0, 19)}",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black45),
                                          overflow: TextOverflow.fade,
                                        ),
                                        Expanded(flex: 1, child: SizedBox()),
                                        Text(
                                          "Updated: ${snapshot.data!.data[index].lastUpdating.toLocal().toString().substring(0, 19)}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black45),
                                        ),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                      Text(
                                          "Category: ${snapshot.data!.data[index].category.categoryName}",
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black45),
                                        ),
                                        Expanded(flex: 1, child: SizedBox()),]
                          )]))),

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
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
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
            })));
  }
  
}