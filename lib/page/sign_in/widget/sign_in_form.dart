import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/banner_gm.png'),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Username',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.person_pin),
                          ),
                          onSaved: (username) => _username = username,
                          validator: (username) =>
                              username.isEmpty ? 'Required Field' : null,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/icons/qrcode.svg',
                        height: 26,
                        width: 26,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                          ),
                          onSaved: (password) => _password = password,
                          validator: (password) =>
                              password.isEmpty ? 'Required Field' : null,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/icons/view.svg',
                        color: Colors.white,
                        height: 18,
                        width: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            final _form = _formKey.currentState;
                            if (_form.validate()) {
                              _form.save();
                              context.read<SignInCubit>().signInUser(
                                    username: _username,
                                    password: _password,
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
