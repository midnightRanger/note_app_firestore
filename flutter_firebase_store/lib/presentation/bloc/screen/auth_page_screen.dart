import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/use_cases/impl/auth_case_impl.dart';

import '../../../domain/model/user.dart';
import '../../../domain/validators/auth_validator.dart';
import '../../elements/dynamic_input_widget.dart';
import '../auth_page/auth_page_cubit.dart';
import '../auth_page/auth_page_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;
  @override
  State<AuthPage> createState() => _AuthStatePage();
}

class _AuthStatePage extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthPageCubit(RegisterUserState.initial),
      child: AuthPageWidget(),
    );
  }
}

class AuthPageWidget extends StatefulWidget {
  @override
  _AuthWidgetStatePage createState() => _AuthWidgetStatePage();
}

class _AuthWidgetStatePage extends State<AuthPageWidget> {
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
    return BlocConsumer<AuthPageCubit, RegisterUserState>(
      listener: (context, state) {
        switch (state) {
          case RegisterUserState.success:
            AlertDialog alert = AlertDialog(
              title: const Text('Register: '),
              content: Text("User was registered!"),
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

            break;
          case RegisterUserState.user_exists:
            // TODO: Handle this case.
            break;
          case RegisterUserState.weak_password:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please use a stronger password'),
              ),
            );
            break;
          case RegisterUserState.failed:
            // TODO: Handle this case.
            break;
          case RegisterUserState.initial:
            // TODO: Handle this case.
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email
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
              const SizedBox(
                height: 20,
              ),
              // Username
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: registerAuthMode ? 65 : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: registerAuthMode ? 1 : 0,
                  child: DynamicInputWidget(
                    controller: _usernameController,
                    obscureText: false,
                    focusNode: usernameFocusNode,
                    toggleObscureText: null,
                    validator: null,
                    prefIcon: const Icon(Icons.person),
                    labelText: "Enter Username(Optional)",
                    textInputAction: TextInputAction.next,
                    isNonPasswordField: true,
                  ),
                ),
              ),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: registerAuthMode ? 1 : 0,
                child: const SizedBox(
                  height: 20,
                ),
              ),

              DynamicInputWidget(
                controller: _passwordController,
                labelText: "Enter Password",
                obscureText: obscureText,
                focusNode: passwordFocusNode,
                toggleObscureText: toggleObscureText,
                validator: authValidator.passwordVlidator,
                prefIcon: const Icon(Icons.password),
                textInputAction: registerAuthMode
                    ? TextInputAction.next
                    : TextInputAction.done,
                isNonPasswordField: false,
              ),

              const SizedBox(
                height: 20,
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: registerAuthMode ? 65 : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: registerAuthMode ? 1 : 0,
                  child: DynamicInputWidget(
                    controller: _confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    isNonPasswordField: false,
                    labelText: "Confirm Password",
                    obscureText: obscureText,
                    prefIcon: const Icon(Icons.password),
                    textInputAction: TextInputAction.done,
                    toggleObscureText: toggleObscureText,
                    validator: (val) => authValidator.confirmPasswordValidator(
                        val, _passwordController.text),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (registerAuthMode) {
                        context.read<AuthPageCubit>().registerUser(new User(email: _emailController.text, userName: _usernameController.text,
                        password: _passwordController.text, isActive: true, id:1 )); 
                      }
                    },
                    child: Text(registerAuthMode ? 'Register' : 'Sign In'),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8.0),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(registerAuthMode
                      ? "Already Have an account?"
                      : "Don't have an account yet?"),
                  TextButton(
                    onPressed: () {
                      setState(() => registerAuthMode = !registerAuthMode);
                    },
                    child: Text(registerAuthMode ? "Sign In" : "Regsiter"),
                  )
                ],
              ),
              
            ],
          )),
            )
          ),
        ));
      },
    );
  }
}
