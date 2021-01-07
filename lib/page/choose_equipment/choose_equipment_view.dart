import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../core/cubit/cubits.dart';
import '../pages.dart';

class ChooseEquipmentView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      appBar: AppBar(
        title: const Text(
          'LOAD ROUTE',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ChooseEquipmentCubit, ChooseEquipmentState>(
        listener: (_, state) {
          if (state is EquipmentFound) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const LoadRoutePage(),
              ),
            );
          }
        },
        builder: (_, state) => Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 48, right: 18, left: 18),
            child: Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Equipment',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(MaterialCommunityIcons.truck),
                      ),
                      onSaved: (equipmentKey) => context
                          .read<ChooseEquipmentCubit>()
                          .getEquipmentInfo(equipmentKey),
                      validator: (equipmentKey) =>
                          equipmentKey.isEmpty ? 'Required Field' : null,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    AntDesign.qrcode,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final _form = _formKey.currentState;
          if (_form.validate()) {
            _form.save();
          }
        },
        child: const Icon(
          MaterialCommunityIcons.map_search,
        ),
        backgroundColor: const Color(0xFFB0D25A),
      ),
    );
  }
}
