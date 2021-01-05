// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
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
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onSaved: (serverName) => _serverName = serverName,
              validator: (serverName) =>
                  serverName.isEmpty ? 'Required Field' : null,
            ),
            RaisedButton(
              onPressed: () {
                final _form = _formKey.currentState;
                if (_form.validate()) {
                  _form.save();
                  context
                      .read<InitialSetupCubit>()
                      .validateServerName(_serverName);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
