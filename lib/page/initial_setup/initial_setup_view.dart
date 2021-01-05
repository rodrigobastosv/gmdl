import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/initial_setup/initial_setup_cubit.dart';
import 'package:gm_driver_lite/core/provider/global_info_provider.dart';

class InitialSetupView extends StatefulWidget {
  InitialSetupView({Key key}) : super(key: key);

  @override
  _InitialSetupViewState createState() => _InitialSetupViewState();
}

class _InitialSetupViewState extends State<InitialSetupView> {
  final _formKey = GlobalKey<FormState>();
  String _serverName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InitialSetupCubit, InitialSetupState>(
        listener: (_, state) {
          if (state is ServerValidationSuccess) {
            context.read<GlobalInfoProvider>().changeServerName(state.serverName);
          }
        },
        builder: (_, state) => Form(
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
                  child: Text('Confirm'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
