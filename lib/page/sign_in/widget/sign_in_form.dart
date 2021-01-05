import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/sign_in/sign_in_cubit.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onSaved: (username) => _username = username,
            validator: (username) => username.isEmpty ? 'Required Field' : null,
          ),
          TextFormField(
            onSaved: (password) => _password = password,
            validator: (password) => password.isEmpty ? 'Required Field' : null,
          ),
          RaisedButton(
            onPressed: () async {
              final _form = _formKey.currentState;
              if (_form.validate()) {
                _form.save();
                context.read<SignInCubit>().signInUser(
                      username: _username,
                      password: _password,
                    );
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
