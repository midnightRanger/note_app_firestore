import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';
import '../../../domain/model/user.dart';
import '../../../domain/validators/auth_validator.dart';
import '../../elements/dynamic_input_widget.dart';
import '../home_page/home_page_cubit.dart';
import '../profile_page_edit/profile_page_edit_cubit.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key, required this.title});

  final String title;
  @override
  State<ProfileEditPage> createState() => _ProfileEditStatePage();
}

class _ProfileEditStatePage extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileEditPageCubit(ProfileEditState(initial: true))..init(),
      child: ProfileEditPageWidget(),
    );
  }
}

class ProfileEditPageWidget extends StatefulWidget {
  @override
  _ProfileEditStatePageWidget createState() => _ProfileEditStatePageWidget();
}

class _ProfileEditStatePageWidget extends State<ProfileEditPageWidget> {

   final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // to obscure text default value is false
  bool obscureText = true;
  // This will require to toggle between register and sigin in mode
  bool registerAuthMode = false;

  FocusNode emailFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  // Define Form key
  final _formKey = GlobalKey<FormState>();

  // Instantiate validator
  final AuthValidators authValidator = AuthValidators();

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(actions: [
        //   IconButton(onPressed: (){
        //     showSearch(context: context, delegate: CustomSearchDelegate(allPosts: _allNotes, token: widget.token!));
        //   },icon: const Icon(Icons.search))
        // ]),

        body: BlocConsumer<ProfileEditPageCubit, ProfileEditState>(
            listener: (context, state) {
      if (state.successUpdated == true) {
        AlertDialog alert = AlertDialog(
          title: const Text('Profile Edit: '),
          content: Text("Профиль пользователя успешно обновлен"),
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
      return Center(child: BlocBuilder<ProfileEditPageCubit, ProfileEditState>(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
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
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        child: Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 1),
                      ),

                      DynamicInputWidget(
                        controller: _emailController,
                        obscureText: false,
                        focusNode: emailFocusNode,
                        toggleObscureText: null,
                        validator: authValidator.emailValidator,
                        prefIcon: const Icon(Icons.mail),
                        labelText: "Enter Email Address",
                        textInputAction: TextInputAction.next,
                        isNonPasswordField: true,
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                      ),

                      DynamicInputWidget(
                        controller: _usernameController,
                        obscureText: false,
                        focusNode: usernameFocusNode,
                        toggleObscureText: null,
                        validator: authValidator.emailValidator,
                        prefIcon: const Icon(Icons.account_circle_outlined),
                        labelText: "Enter username",
                        textInputAction: TextInputAction.next,
                        isNonPasswordField: true,
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                      ),

                      DynamicInputWidget(
                        controller: _passwordController,
                        obscureText: false,
                        focusNode: passwordFocusNode,
                        toggleObscureText: null,
                        validator: authValidator.passwordVlidator,
                        prefIcon: const Icon(Icons.password),
                        labelText: "Old Password",
                        textInputAction: TextInputAction.next,
                        isNonPasswordField: true,
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                      ),


                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () => context.read<ProfileEditPageCubit>().updateUser(User(userName: _usernameController.text,
                                    email: _emailController.text, password: _passwordController.text, id: 0, isActive: true)),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(3, 158, 162, 1),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                      minimumSize: Size(42, 42),
                                    ),
                                    child: Text("Update profile",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)),
                              )))
                 
                    ]);
        }

        return CircularProgressIndicator();
      }));
    }));
  }
}
