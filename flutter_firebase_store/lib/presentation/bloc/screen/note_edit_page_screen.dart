import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/presentation/bloc/note_add_page/note_add_page_cubit.dart';
import 'package:flutter_firebase_store/presentation/bloc/note_edit_page/note_edit_page_cubit.dart';
import 'package:flutter_firebase_store/presentation/bloc/screen/note_add_screen.dart';

import '../../../domain/model/model_response.dart';
import '../../../domain/model/note.dart' as Note;
import '../../../domain/validators/note_validator.dart';
import '../../elements/dynamic_input_widget.dart';
import '../home_page/home_page_cubit.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key, required this.title, required this.noteName});

  final String title;
  final String noteName;
  @override
  State<NoteEditPage> createState() => _NoteEditStatePage();
}

class _NoteEditStatePage extends State<NoteEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocProvider(
          create: (context) => NoteEditPageCubit(NoteEditState(initial: true))
            ..init(widget.noteName),
          child: NoteEditPageWidget(noteName: widget.noteName),
        ));
  }
}

class NoteEditPageWidget extends StatefulWidget {
  final String? noteName;

  NoteEditPageWidget({this.noteName});

  @override
  _NoteEditWidgetStatePage createState() => _NoteEditWidgetStatePage();
}

class _NoteEditWidgetStatePage extends State<NoteEditPageWidget> {
  final nameFocusNode = FocusNode();
  final contentFocusNode = FocusNode();
  final categoryFocusNode = FocusNode();

  final NoteValidator noteValidator = NoteValidator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(actions: [
        //   IconButton(onPressed: (){
        //     showSearch(context: context, delegate: CustomSearchDelegate(allPosts: _allNotes, token: widget.token!));
        //   },icon: const Icon(Icons.search))
        // ]),

        body: BlocConsumer<NoteEditPageCubit, NoteEditState>(
            listener: (context, state) {
      // if (state == HomeActionState(refresh: true)) {
      //   context.read<HomePageCubit>().init();
      // }

      if (state.successUpdated == true) {
        AlertDialog alert = AlertDialog(
          title: const Text('Note update: '),
          content: Text("Note was successfully updated"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
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
      return Center(child: BlocBuilder<NoteEditPageCubit, NoteEditState>(
          builder: (context, state) {
        if (state.note != null) {
          final nameController = TextEditingController(text: state.note!.name);
          final contentController =
              TextEditingController(text: state.note!.content);
          final categoryController =
              TextEditingController(text: state.note!.category);

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
                  child: Icon(Icons.note, size: 100.0),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Note",
                        style: Theme.of(context).textTheme.headline2))
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: Container(
                  color: Colors.grey, width: double.infinity, height: 1),
            ),
            DynamicInputWidget(
              controller: nameController,
              obscureText: false,
              focusNode: nameFocusNode,
              toggleObscureText: null,
              validator: noteValidator.nameValidator,
              prefIcon: const Icon(Icons.abc),
              labelText: "Enter note name",
              // initialValue: state.note!.name,
              textInputAction: TextInputAction.next,
              isNonPasswordField: true,
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            ),
            SizedBox(
              height: 100,
              child: DynamicInputWidget(
                  controller: contentController,
                  obscureText: false,
                  focusNode: contentFocusNode,
                  toggleObscureText: null,
                  validator: noteValidator.contentValidator,
                  prefIcon: const Icon(Icons.drive_file_rename_outline_sharp),
                  labelText: "Enter content",
                  textInputAction: TextInputAction.next,
                  isNonPasswordField: true,
                  // initialValue: state.note!.content,
                  maxLines: 5,
                  minLines: 2),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            ),
            SizedBox(
              height: 100,
              child: DynamicInputWidget(
                  controller: categoryController,
                  obscureText: false,
                  focusNode: categoryFocusNode,
                  toggleObscureText: null,
                  validator: noteValidator.nameValidator,
                  prefIcon: const Icon(Icons.drive_file_rename_outline_sharp),
                  labelText: "Enter category",
                  textInputAction: TextInputAction.next,
                  // initialValue: state.note!.category,
                  isNonPasswordField: true),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => context
                              .read<NoteEditPageCubit>()
                              .updateNote(
                                  Note.Note(
                                      category: categoryController.text,
                                      name: nameController.text,
                                      content: contentController.text,
                                      authorId: "",
                                      status: true,
                                      creationDate: "",
                                      lastUpdating: "",
                                      image: new Note.Image(
                                          url: "123", name: "123", size: 123)),
                                  widget.noteName!),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(3, 158, 162, 1),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(42, 42),
                          ),
                          child: Text("Update Note",
                              style: Theme.of(context).textTheme.bodyText1)),
                    )))
          ]);
        }

        return CircularProgressIndicator();
      }));
    }));
  }
}
