import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io' as io;
import 'package:flutter_firebase_store/domain/validators/note_validator.dart';

import '../../../domain/model/model_response.dart';
import '../../../domain/model/note.dart' as Note;
import '../../../domain/model/user.dart';
import '../../../domain/validators/auth_validator.dart';
import '../../elements/dynamic_input_widget.dart';
import '../home_page/home_page_cubit.dart';
import '../note_add_page/note_add_page_cubit.dart';
import '../profile_page_edit/profile_page_edit_cubit.dart';

class NoteAddPage extends StatefulWidget {
  const NoteAddPage({super.key, required this.title});

  final String title;
  @override
  State<NoteAddPage> createState() => _NoteAddStatePage();
}

class _NoteAddStatePage extends State<NoteAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocProvider(
          create: (context) => NoteAddPageCubit(NoteAddState(initial: true)),
          child: NoteAddPageWidget(),
        ));
  }
}

class NoteAddPageWidget extends StatefulWidget {
  @override
  _NoteAddStatePageWidget createState() => _NoteAddStatePageWidget();
}

class _NoteAddStatePageWidget extends State<NoteAddPageWidget> {
  final nameController = TextEditingController();
  final contentController = TextEditingController();
  final categoryController = TextEditingController();

  final nameFocusNode = FocusNode();
  final contentFocusNode = FocusNode();
  final categoryFocusNode = FocusNode();

  // Instantiate validator
  final NoteValidator noteValidator = NoteValidator();

  late String url;
  late String name;
  late int sizeG; 

  late dynamic fileG; 


    Future<void> _addImage() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Выбор изображения'
    );

    if (result != null) {

      final size = result.files.first.size;
      final file = io.File(result.files.single.path!);
      final fileExtensions = result.files.first.extension!;
      print("размер:$size file:${file.path} fileExtensions:${fileExtensions}");

      // FirebaseStorage.instance.ref().child("images").putFile(file);
      name = result.files.single.name; 
      sizeG = result.files.single.size;

      fileG = file; 
       

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteAddPageCubit, NoteAddState>(
        listener: (context, state) {
      if (state.successCreated == true) {
        AlertDialog alert = AlertDialog(
          title: const Text('Note Add: '),
          content: Text("Заметка успешно добавлена!"),
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
      return Center(child: BlocBuilder<NoteAddPageCubit, NoteAddState>(
          builder: (context, state) {
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
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
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
            textInputAction: TextInputAction.next,
            isNonPasswordField: true,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
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
                maxLines: 5,
                minLines: 2),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
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
                isNonPasswordField: true),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: double.infinity,
                      child: Column(children: [
                        ElevatedButton(
                            onPressed: () => context
                                .read<NoteAddPageCubit>()
                                .addNote(Note.Note(
                                    category: categoryController.text,
                                    status: true,
                                    lastUpdating: DateTime.now().toString(),
                                    creationDate: DateTime.now().toString(),
                                    content: contentController.text,
                                    name: nameController.text,
                                    authorId: "",
                                    image: Note.Image(
                                        url: "123", name: name, size: sizeG)), fileG),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(3, 158, 162, 1),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(42, 42),
                            ),
                            child: Text("Create Note",
                                style: Theme.of(context).textTheme.bodyText1)),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: _addImage,
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(3, 158, 162, 1),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(42, 42),
                            ),
                            child: Text("Add Image",
                                style: Theme.of(context).textTheme.bodyText1)),
                      ]))))
        ]);
      }));
    });
  }
}
