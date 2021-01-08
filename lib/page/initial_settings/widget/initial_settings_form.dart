import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/cubit/cubits.dart';

class InitialSettingsForm extends StatefulWidget {
  InitialSettingsForm({Key key}) : super(key: key);

  @override
  _InitialSettingsFormState createState() => _InitialSettingsFormState();
}

class _InitialSettingsFormState extends State<InitialSettingsForm> {
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
                    prefixIcon: Icon(MdiIcons.server),
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
                    prefixIcon: Icon(MdiIcons.earth),
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
                    prefixIcon: Icon(MdiIcons.phone),
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
            context
                .read<InitialSettingsCubit>()
                .validateServerName(_serverName);
          }
        },
        child: const Icon(Icons.check_outlined),
      ),
    );
  }
}
