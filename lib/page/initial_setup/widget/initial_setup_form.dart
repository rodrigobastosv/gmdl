import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../core/cubit/initial_setup/initial_setup_cubit.dart';

class InitialSetupForm extends StatefulWidget {
  InitialSetupForm({Key key}) : super(key: key);

  @override
  _InitialSetupFormState createState() => _InitialSetupFormState();
}

class _InitialSetupFormState extends State<InitialSetupForm> {
  final _formKey = GlobalKey<FormState>();
  String _serverName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/banner_gm.png'),
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Server',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(FontAwesome.server),
                  ),
                  onSaved: (serverName) => _serverName = serverName,
                  validator: (serverName) =>
                      serverName.isEmpty ? 'Required Field' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Language',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(MaterialCommunityIcons.earth),
                  ),
                  initialValue: 'English',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(FontAwesome.mobile_phone),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3AA348),
        onPressed: () {
          final _form = _formKey.currentState;
          if (_form.validate()) {
            _form.save();
            context.read<InitialSetupCubit>().validateServerName(_serverName);
          }
        },
        child: const Icon(Icons.check_outlined),
      ),
    );
  }
}
